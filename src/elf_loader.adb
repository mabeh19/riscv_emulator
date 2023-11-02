with Ada.Sequential_IO;
with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;
with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Exceptions;
with Ada.Directories;
with Ada.Unchecked_Conversion;
with Interfaces.C;
with RISCV_Memory;   use RISCV_Memory;

package body ELF_Loader is

   subtype Mem_Instr is Memory (0 .. 3);
   function To_Instruction is new Ada.Unchecked_Conversion (
      Source => Mem_Instr,
      Target => Integer
   );

   function Load_File (Path: String;
                       Text_Section: out Memory;
                       Data_Section: out Memory) return File_Status is
      
      InvalidFile : exception;
      Header      : ELF32_EHeader;
      F_Size      : Ada.Directories.File_Size := Ada.Directories.Size (Path);

      subtype File_Buffer is Memory (0 .. Address (F_Size) - 1);
      Contents    : Memory (0 .. 2 ** 21);
      Index       : Address := 0;

      package Byte_IO is new Ada.Sequential_IO (File_Buffer);
      use Byte_IO;

      F           : Byte_IO.File_Type;
      Result      : File_Status;
   begin
      Result.Success := True;

      Byte_IO.Open (F, In_File, Path);
      
      Byte_IO.Read (F, Item => Contents (0 .. Address (F_Size) - 1));

      Header := Get_File_Header (Contents);
      if not Verify_Header (Header) then
         raise InvalidFile with "Invalid Header";
      end if;

      Load_Program_Sections (Text_Section,
                             Data_Section,
                             Contents,
                             Header,
                             Result.ROM_Offset,
                             Result.ROM_Size,
                             Result.RAM_Offset,
                             Result.RAM_Size);

      Put_Line ("Offsets: { ROM:" & Result.ROM_Offset'Image & " RAM:" & Result.RAM_Offset'Image & "}");
      Byte_IO.Close (F);
      return Result;
   exception
      when E: others =>
         Ada.Text_IO.Put_Line (Ada.Exceptions.Exception_Information (E));
         Byte_IO.Close (F);
         Result.Success := False;
         return Result;
   end Load_File;

   function Verify_Header(Header: ELF32_EHeader) return Boolean is
      InvalidHeader : exception;
   begin
      if Header.E_Ident (Mag0) /= ELF_MAG0 then
         raise InvalidHeader with  "Invalid Mag0";
      end if;

      if Header.E_Ident (Mag1) /= ELF_MAG1 then
         raise InvalidHeader with "Invalid Mag1";
      end if;

      if Header.E_Ident (Mag2) /= ELF_MAG2 then
         raise InvalidHeader with "Invalid Mag2";
      end if;

      if Header.E_Ident (Mag3) /= ELF_MAG3 then
         raise InvalidHeader with "Invalid Mag3";
      end if;

      if Header.E_Ident (Class) /= ELF_CLASS_32 then
         raise InvalidHeader with "Invalid Class";
      end if;

      if Header.E_Ident (Data) /= ELF_DATA_2_LSB then
         raise InvalidHeader with " Invalid endianness";
      end if;

      if Header.E_Machine /= EM_RISCV then
         raise InvalidHeader with "Invalid Target. Expected" & EM_RISCV'Image & " got" & Header.E_Machine'Image;
      end if;

      if Header.E_Ident (Version) /= EV_CURRENT then
         raise InvalidHeader with "Invalid Version";
      end if;

      if Header.E_Type /= ELF_Type_REL and Header.E_Type /= ELF_Type_EXEC then
         raise InvalidHeader with "Executable expected" & ELF_Type_EXEC'Image & " got" & Header.E_TYPE'Image;
      end if;
      
      return True;
   exception
      when E: others =>
         Ada.Text_IO.Put_Line (Ada.Exceptions.Exception_Information (E));
         return False;
   end Verify_Header;

   procedure Load_Text_Section (Text_Section : out Memory;
                                Mem          : Memory;
                                Header       : ELF32_EHeader;
                                Sect_Offset  : out RISCV_Memory.Address;
                                Sect_Size    : out RISCV_Memory.Address) is 
      TextSectionNotFound  : exception;
      TextSectionEmpty     : exception;
      Text_Sect_Header : ELF32_Section_Header;
      Counter : Integer := 1;
   begin 
      Find_Section:
      loop 
         Text_Sect_Header := Get_Section_Header (Mem, Header, Counter);

         declare
            Name : String := Lookup_String (Mem, Header, Integer (Text_Sect_Header.SH_Name));
         begin
            if (Name = "text" or Name = ".text") and ((Text_Sect_Header.SH_Type and SHT_PROGBITS) /= 0) then
               exit Find_Section;
            end if;
         end;
         Counter := Counter + 1;

         if Counter = Integer (Header.E_Shnum) then
            raise TextSectionNotFound;
         end if;
      end loop Find_Section;

      if Text_Sect_Header.SH_Size = 0 then
         raise TextSectionEmpty;
      end if;
      declare
         Size     : Address := Address (Text_Sect_Header.SH_Size) - 1;
         Offset   : Address := Address (Text_Sect_Header.SH_Offset);
      begin
         Text_Section (0 .. Size) := Mem (Offset .. Offset + Size); 
      end;

      Sect_Offset := RISCV_Memory.Address (Text_Sect_Header.SH_Addr);
      Sect_Size   := RISCV_Memory.Address (Text_Sect_Header.SH_Size);
   end Load_Text_Section;

   procedure Load_Data_Section (Data_Section : out Memory;
                                Mem          : Memory;
                                Header       : ELF32_EHeader;
                                Sect_Offset  : out RISCV_Memory.Address;
                                Sect_Size    : out RISCV_Memory.Address) is
      DataSectionNotFound  : exception;
      DataSectionEmpty     : exception;
      Data_Sect_Header     : ELF32_Section_Header;
      Counter              : Integer := 1;
   begin
      Find_Section:
      loop 
         Data_Sect_Header := Get_Section_Header (Mem, Header, Counter);

         declare
            Name : String := Lookup_String (Mem, Header, Integer (Data_Sect_Header.SH_Name));
         begin
            if (Name = "data" or Name = ".data") and ((Data_Sect_Header.SH_Type and SHT_PROGBITS) /= 0) then
               exit Find_Section;
            end if;
         end;
         Counter := Counter + 1;

         if Counter = Integer (Header.E_Shnum) then
            raise DataSectionNotFound;
         end if;
      end loop Find_Section;

      if Data_Sect_Header.SH_Size = 0 then
         raise DataSectionEmpty;
      end if;
      declare
         Size     : Address := Address (Data_Sect_Header.SH_Size) - 1;
         Offset   : Address := Address (Data_Sect_Header.SH_Offset);
      begin
         Data_Section (RAM_START .. RAM_START + Size) := Mem (Offset .. Offset + Size); 
      end;

      Sect_Offset := RISCV_Memory.Address (Data_Sect_Header.SH_Addr);
      Sect_Size   := RISCV_Memory.Address (Data_Sect_Header.SH_Size);   
   end Load_Data_Section;

   procedure Load_Program_Sections (ROM         : out Memory;
                                    RAM         : out Memory;
                                    Mem         : Memory;
                                    Header      : ELF32_EHeader;
                                    ROM_Offset  : out RISCV_Memory.Address;
                                    ROM_Size    : out RISCV_Memory.Address;
                                    RAM_Offset  : out RISCV_Memory.Address;
                                    RAM_Size    : out RISCV_Memory.Address) is
      TextSectionNotFound  : exception;
      TextSectionEmpty     : exception;
      Prog_Header : ELF32_Program_Header;
      Size        : Address;
      Offset      : Address;
   begin 
      for Counter in 0 .. Integer (Header.E_Phnum) loop
         Prog_Header := Get_Program_Header (Mem, Header, Counter);

         Size     := Address (Prog_Header.P_Filesz);
         Offset   := Address (Prog_Header.P_Offset);

         if Size > 0 then
            Size := Size - 1;
            --  If section is non-writable then place in ROM        
            if Prog_Header.P_Type = PT_LOAD and (Prog_Header.P_Flags and PF_W) = 0 then
               ROM (ROM_START .. ROM_START + Size) := Mem (Offset .. Offset + Size);
               ROM_Offset  := Address (Prog_Header.P_Vaddr);
               ROM_Size    := Address (Prog_Header.P_Filesz);
            --  Otherwise place in RAM
            elsif Prog_Header.P_Type = PT_LOAD then  
               RAM (RAM_START .. RAM_START + Size) := Mem (Offset .. Offset + Size);
               RAM_Offset  := Address (Prog_Header.P_Vaddr);
               RAM_Size    := Address (Prog_Header.P_Filesz);
            end if;
         end if;
      end loop; 
   end Load_Program_Sections;

   function Get_File_Header (Mem : Memory) return ELF32_EHeader is
      subtype Memory_Header is Memory (0 .. ELF32_EHeader'Size / 8);
      function To_File_Header is new Ada.Unchecked_Conversion (
         Source => Memory_Header,
         Target => ELF32_EHeader
      );
   begin
      return To_File_Header (Mem (0 .. ELF32_EHeader'Size / 8));
   end Get_File_Header;

   function Get_Section_Header (Mem     : Memory;
                                Header  : ELF32_EHeader;
                                Index   : Integer) return ELF32_Section_Header is
      subtype Memory_Header is Memory (0 .. ELF32_Section_Header'Size / 8);
      function To_Section_Header is new Ada.Unchecked_Conversion (
         Source => Memory_Header,
         Target => ELF32_Section_Header
      );
      Size     : Address := Address (ELF32_Section_Header'Size / 8);
      Offset   : Address := Address (Index) * Size + Address (Header.E_Shoff);
   begin
      return To_Section_Header (Mem (Offset .. Offset + Size));
   end Get_Section_Header;

   function Get_Program_Header (Mem    : Memory;
                                Header : ELF32_EHeader;
                                Index  : Integer) return ELF32_Program_Header is
      subtype Memory_Header is Memory (0 .. ELF32_Program_Header'Size / 8);
      function To_Program_Header is new Ada.Unchecked_Conversion (
         Source => Memory_Header,
         Target => ELF32_Program_Header
      );
      Size     : Address := Address (ELF32_Program_Header'Size / 8);
      Offset   : Address := Address (Index) * Size + Address (Header.E_Phoff);
   begin
      return To_Program_Header (Mem (Offset .. Offset + Size));
   end Get_Program_Header;

   function Lookup_String (Mem      : Memory;
                           Header   : ELF32_EHeader;
                           Offset   : Integer) return String is 
      String_Section_Header : ELF32_Section_Header;
      Mem_Offset     : Address := 0;
      Table_Offset   : Address := 0;
      Str_Length     : Natural := 0;
      Empty_String   : String (1 .. 1);
   begin
      if Header.E_Shstrndx = SHN_UNDEF then
         return Empty_String;
      end if;

      String_Section_Header := Get_Section_Header (Mem, Header, Integer (Header.E_Shstrndx));
      Mem_Offset := Address (String_Section_Header.SH_Offset);
      Table_Offset := Mem_Offset + Address (Offset);

      --  Get string length
      while Mem (Table_Offset + Address (Str_Length)) /= 0 loop
         Str_Length := Str_Length + 1;
      end loop;

      --  Copy string in to Ada string
      declare
         Str : String (1 .. Str_Length);
      begin
         for Index in 1 .. Str_Length loop
            Str (Index) := Character'Val (Mem (Table_Offset + Address(Index - 1)));
         end loop;

         return Str;
      end;
   end Lookup_String;

   function Get_Symval (Mem      : Memory;
                        Header   : ELF32_EHeader;
                        Table    : Integer;
                        Index    : Integer) return ELF32_Word is
      -- function To_Symbol is new Ada.Unchecked_Conversion (
      --    Source => Memory (0 .. ELF32_Symbol'Size),
      --    Target => ELF32_Symbol
      -- );
      -- SymbolOutOfRange : exception;

      -- Symbol_Table   : ELF32_Section_Header;
      -- Symtab_Entries : ELF32_Word;
      -- Symbol_Address : ELF32_Off;
      -- Symbol         : ELF32_Symbol;
   begin
      return 0;
   --   if Table = SHN_UNDEF or Index = SHN_UNDEF then
   --      return 0;
   --   end if; 
   --   
   --   Symbol_Table := Get_Section_Header (Mem, Header, Table);
   --   Symtab_Entries := Symbol_Table.SH_Size / Symbol_Table.SH_EntSize;
   --   if Index >= Symtab_Entries then
   --      raise SymbolOutOfRange with "Index received:" & Index'Image;
   --   end if;

   --   Symbol_Address := ELF32_Off (Index) * Symbol'Size + Symbol_Table.SH_Offset;
   --   Symbol := To_Symbol (Mem (Address (Symbol_Address) .. Address (Symbol_Address) + Symbol'Size));
   --   
   --   if Symbol.ST_Shndx = SHN_UNDEF then
   --      -- External symbol
   --      -- For now just return 0
   --      return 0;
   --   elsif Symbol.ST_Shndx = SHN_ABS then
   --      return Symbol.ST_Value;
   --   else
   --      declare
   --         Target : ELF32_Section_Header := Get_Section_Header (Mem,
   --                                                              Header,
   --                                                              Symbol.Sh_Offset);
   --      begin
   --         return Symbol.ST_Value + Target.SH_Offset;
   --      end;
   --   end if;
   --exception
   --   when E: others=>
   --      Ada.Text_IO.Put_Line (Ada.Exceptions.Exception_Information (E));
   --      return 0;
   end Get_Symval;

end ELF_Loader;
