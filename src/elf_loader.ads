with RISCV_Memory;
package ELF_Loader is

   type File_Status is record
      Success     : Boolean;
      ROM_Offset  : RISCV_Memory.Address;
      RAM_Offset  : RISCV_Memory.Address;
      ROM_Size    : RISCV_Memory.Address;
      RAM_Size    : RISCV_Memory.Address;
   end record;

   function Load_File (Path         : String;
                       Text_Section : out RISCV_Memory.Memory;
                       Data_Section : out RISCV_Memory.Memory) return File_Status;

private

   type ELF32_Half is mod 2 ** 16 with Size => 16;
   type ELF32_Off is mod 2 ** 32 with Size => 32;
   type ELF32_Addr is mod 2 ** 32 with Size => 32;
   type ELF32_Word is mod 2 ** 32 with Size => 32;
   type ELF32_SWord is new Integer with Size => 32;
   type ELF32_Byte is mod 2 ** 8 with Size => 8;

   type ELF_Ident is (
      Mag0,          --  0x7f
      Mag1,          --  'E'
      Mag2,          --  'L'
      Mag3,          --  'F'
      Class,         --  Architecture
      Data,          --  endianness
      Version,       --  ELF Version
      OS_ABI,        --  OS Specific
      ABI_Version,   --  OS Specific
      Pad,           --  Padding
      
      --  The following aren't used in 32-bit arch
      Res1,
      Res2,
      Res3,
      Res4,
      Res5,
      Res6
   );

   type ELF32_Ident is array (ELF_Ident) of ELF32_Byte;

   --
   --  File Header
   --
   type ELF32_EHeader is record
      E_Ident     : ELF32_Ident;
      E_Type      : ELF32_Half;
      E_Machine   : ELF32_Half;
      E_Version   : ELF32_Word;
      E_Entry     : ELF32_Addr;
      E_Phoff     : ELF32_Off;
      E_Shoff     : ELF32_Off;
      E_Flags     : ELF32_Word;
      E_Ehsize    : ELF32_Half;
      E_Phentsize : ELF32_Half;
      E_Phnum     : ELF32_Half;
      E_Shentsize : ELF32_Half;
      E_Shnum     : ELF32_Half;
      E_Shstrndx  : ELF32_Half;
   end record;

   procedure Load_Text_Section(Text_Section  : out RISCV_Memory.Memory;
                               Mem           : RISCV_Memory.Memory;
                               Header        : ELF32_EHeader;
                               Sect_Offset   : out RISCV_Memory.Address;
                               Sect_Size     : out RISCV_Memory.Address);
   procedure Load_Data_Section(Data_Section  : out RISCV_Memory.Memory;
                               Mem           : RISCV_Memory.Memory;
                               Header        : ELF32_EHeader;
                               Sect_Offset   : out RISCV_Memory.Address;
                               Sect_Size     : out RISCV_Memory.Address);
   procedure Load_Program_Sections (ROM         : out RISCV_Memory.Memory;
                                    RAM         : out RISCV_Memory.Memory;
                                    Mem         : RISCV_Memory.Memory;
                                    Header      : ELF32_EHeader;
                                    ROM_Offset  : out RISCV_Memory.Address;
                                    ROM_Size    : out RISCV_Memory.Address;
                                    RAM_Offset  : out RISCV_Memory.Address;
                                    RAM_Size    : out RISCV_Memory.Address);
   function Verify_Header (Header : ELF32_EHeader) return Boolean;
   function Get_File_Header (Mem : RISCV_Memory.Memory) return ELF32_EHeader;
   function Lookup_String (Mem      : RISCV_Memory.Memory;
                           Header   : ELF32_EHeader;
                           Offset   : Integer) return String; 

   ELF_MAG0       : constant ELF32_Byte := 16#7F#;
   ELF_MAG1       : constant ELF32_Byte := Character'Pos ('E');
   ELF_MAG2       : constant ELF32_Byte := Character'Pos ('L');
   ELF_MAG3       : constant ELF32_Byte := Character'Pos ('F');
   ELF_DATA_2_LSB : constant ELF32_Byte := 1;   --  Little endian
   ELF_CLASS_32   : constant ELF32_Byte := 1;   --  32-bit architecture

   ELF_Type_NONE  : constant ELF32_Half := 0;
   ELF_Type_REL   : constant ELF32_Half := 1;
   ELF_Type_EXEC  : constant ELF32_Half := 2;

   EM_RISCV       : constant ELF32_Half := 243; --  RISC-V arch
   EV_CURRENT     : constant ELF32_Byte := 1;   --  ELF current version


   --
   --  Program header
   --
   type ELF32_Program_Header is record
      P_Type   : ELF32_Word;
      P_Offset : ELF32_Word;
      P_Vaddr  : ELF32_Word;
      P_Paddr  : ELF32_Word;
      P_Filesz : ELF32_Word;
      P_Mesmz  : ELF32_Word;
      P_Flags  : ELF32_Word;
      P_Align  : ELF32_Word;
   end record;

   PT_NULL     : constant ELF32_Word := 0;
   PT_LOAD     : constant ELF32_Word := 1;
   PT_DYNAMIC  : constant ELF32_Word := 2;
   PT_INTERP   : constant ELF32_Word := 3;
   PT_NOTE     : constant ELF32_Word := 4;
   PT_SHLIB    : constant ELF32_Word := 5;
   PT_PHDR     : constant ELF32_Word := 6;
   PT_TLS      : constant ELF32_Word := 7;

   PF_X : constant ELF32_Word := 1;
   PF_W : constant ELF32_Word := 2;
   PF_R : constant ELF32_Word := 4;

   --
   --  Section Header
   --

   type ELF32_Section_Header is record
      SH_Name        : ELF32_Word;
      SH_Type        : ELF32_Word;
      SH_Flags       : ELF32_Word;
      SH_Addr        : ELF32_Addr;
      SH_Offset      : ELF32_Off;
      SH_Size        : ELF32_Word;
      SH_Link        : ELF32_Word;
      SH_Info        : ELF32_Word;
      SH_AddrAlign   : ELF32_Word;
      SH_EntSize     : ELF32_Word;
   end record;

   SHN_UNDEF      : constant ELF32_Half := 0;
   SHN_LORESERVE  : constant ELF32_Half := 16#FF00#;
   SHN_LOPROC     : constant ELF32_Half := 16#FF00#;
   SHN_HIPROC     : constant ELF32_Half := 16#FF1F#;
   SHN_ABS        : constant ELF32_Half := 16#FFF1#;
   SHN_COMMON     : constant ELF32_Half := 16#FFF2#;
   SHN_HIRESERVE  : constant ELF32_Half := 16#FFFF#;

   --  Types
   SHT_NULL       : constant ELF32_Word := 0;   --  NULL section
   SHT_PROGBITS   : constant ELF32_Word := 1;   --  Program Information
   SHT_SYMTAB     : constant ELF32_Word := 2;   --  Symbol table
   SHT_SRTAB      : constant ELF32_Word := 3;   --  String table
   SHT_RELA       : constant ELF32_Word := 4;   --  Relocation (with addend)
   SHT_NOBITS     : constant ELF32_Word := 8;   --  Not present in file
   SHT_REL        : constant ELF32_Word := 9;   --  Relocation (no addend)

   --  Attributes
   SHF_WRITE      : constant ELF32_Word := 1;   --  Writable section
   SHF_ALLOC      : constant ELF32_Word := 2;   --  Exists in memory

   function Get_Section_Header (Mem     : RISCV_Memory.Memory;
                                Header  : ELF32_EHeader;
                                Index   : Integer) return ELF32_Section_Header;
   function Get_Program_Header (Mem    : RISCV_Memory.Memory;
                                Header : ELF32_EHeader;
                                Index  : Integer) return ELF32_Program_Header;
   --
   --  ELF Sections
   --
   
   --  Symbol Table
   function Get_Symval (Mem      : RISCV_Memory.Memory;
                        Header   : ELF32_EHeader;
                        Table    : Integer;
                        Index    : Integer) return ELF32_Word;

   type ELF32_Symbol is record
      ST_Name  :  ELF32_Word;
      ST_Value :  ELF32_Addr;
      ST_Size  :  ELF32_Word;
      ST_Info  :  ELF32_Byte;
      ST_Other :  ELF32_Byte;
      ST_Shndx :  ELF32_Half;
   end record;

   ELF32_ST_BIND_LOCAL  : constant ELF32_Byte := 0;   --  Local Scope
   ELF32_ST_BIND_GLOBAL : constant ELF32_Byte := 1;   --  Global Scope
   ELF32_ST_BIND_WEAK   : constant ELF32_Byte := 2;   --  Weak linkage

   ELF32_ST_TYPE_NOTYPE : constant ELF32_Byte := 0;   --  No type
   ELF32_ST_TYPE_OBJECT : constant ELF32_Byte := 1;   --  Variables, arrays, etc.
   ELF32_ST_TYPE_FUNC   : constant ELF32_Byte := 2;   --  Methods or functions

end ELF_Loader;
