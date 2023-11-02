with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Conversion;

package body RISCV_Memory is

   procedure Write (F_Memory  : out Memory;
                    Addr      : Address;
                    Buffer    : Memory) is

      Start_Address  : constant Address := Addr;
      End_Address    : constant Address := Addr + Buffer'Length - 1;
   begin
      F_Memory (Start_Address .. End_Address) := Buffer;
   end Write;

   procedure Write_Word (Mem     : out Memory;
                         Addr    : Address;
                         W       : Word) is
      Word_Size : constant Address := Word'Size/8 - 1;
      subtype Word_Mem is Memory (0 .. Word_Size);
      function To_Mem is new Ada.Unchecked_Conversion (
         Source => Word,
         Target => Word_Mem
      );
      Start_Address  : constant Address := Addr;
      End_Address    : constant Address := Start_Address + Word_Size;
   begin
      Mem (Start_Address .. End_Address) := To_Mem (W);
   end Write_Word;

   procedure Write_Half (Mem     : out Memory;
                         Addr    : Address;
                         H       : Half) is
      Half_Size : constant Address := Half'Size/8 - 1;
      subtype Half_Mem is Memory (0 .. Half_Size);
      function To_Mem is new Ada.Unchecked_Conversion (
         Source => Half,
         Target => Half_Mem
      );
      Start_Address  : constant Address := Addr;
      End_Address    : constant Address := Start_Address + Half_Size;
   begin
      Mem (Start_Address .. End_Address) := To_Mem (H);   
   end Write_Half;
   
   procedure Write_Byte (Mem     : out Memory;
                         Addr    : Address;
                         B       : Byte) is
      Byte_Size : constant Address := Byte'Size/8 - 1;
      subtype Byte_Mem is Memory (0 .. Byte_Size);
      function To_Mem is new Ada.Unchecked_Conversion (
         Source => Byte,
         Target => Byte_Mem
      );
      Start_Address  : constant Address := Addr;
      End_Address    : constant Address := Start_Address + Byte_Size;
   begin
      Mem (Start_Address .. End_Address) := To_Mem (B);
   end Write_Byte;

   function Read (F_Memory    : Memory;
                  Addr        : Address;
                  Num_Bytes   : Address) return Memory is
      Start_Address  : constant Address := Addr;
      End_Address    : constant Address := Addr + Num_Bytes - 1;
   begin
      return F_Memory (Start_Address .. End_Address);
   end Read;

   function Read_Word (Mem    : Memory;
                       Addr   : Address) return Word is
      Word_Size : Address := Word'Size/8 - 1;
      subtype Word_Mem is Memory (0 .. Word_Size);
      function To_Word is new Ada.Unchecked_Conversion (
         Source => Word_Mem,
         Target => Word
      );
      Start_Address  : constant Address := Addr;
      End_Address    : constant Address := Start_Address + Word_Size;
   begin
      return To_Word (Mem (Start_Address .. End_Address));
   end Read_Word;

   function Read_Half (Mem    : Memory;
                       Addr   : Address) return Half is
      Half_Size : Address := Half'Size/8 - 1;
      subtype Half_Mem is Memory (0 .. Half_Size);
      function To_Half is new Ada.Unchecked_Conversion (
         Source => Half_Mem,
         Target => Half
      );
      Start_Address  : constant Address := Addr;
      End_Address    : constant Address := Start_Address + Half_Size;
   begin
      return To_Half (Mem (Start_Address .. End_Address));
   end Read_Half;
   
   function Read_Byte (Mem    : Memory;
                       Addr   : Address) return Byte is
      Byte_Size : Address := Byte'Size/8 - 1;
      subtype Byte_Mem is Memory (0 .. Byte_Size);
      function To_Word is new Ada.Unchecked_Conversion (
         Source => Byte_Mem,
         Target => Byte
      );
      Start_Address  : constant Address := Addr;
      End_Address    : constant Address := Start_Address + Byte_Size;
   begin
      return To_Word (Mem (Start_Address .. End_Address));
   end Read_Byte;

end RISCV_Memory;
