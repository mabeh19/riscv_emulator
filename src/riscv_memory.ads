
package RISCV_Memory is

   -- Base types
   type Byte      is mod 2 ** 8 with Size => 8;
   type Half      is mod 2 ** 16 with Size => 16;
   type Word      is mod 2 ** 32 with Size => 32;
   type Address   is range 0 .. 2 ** 32;
   type Memory    is array (Address range <>) of Byte;

   -- Constants
   RAM_SIZE    : constant Address := 2 ** 18;   -- 256 kB
   ROM_SIZE    : constant Address := 2 ** 20;   -- 1 MB
   ROM_START   : constant Address := 0;
   ROM_END     : constant Address := ROM_SIZE;  
   RAM_START   : constant Address := 16#1000_0000#;
   RAM_END     : constant Address := RAM_START + RAM_SIZE;  

   -- Configured types
   subtype RAM_Address     is Address range RAM_START .. RAM_END; -- range 0 .. RAM_SIZE;
   subtype Flash_Address   is Address range ROM_START .. ROM_END;
   subtype RAM_Memory      is Memory (RAM_START .. RAM_END);
   subtype Flash_Memory    is Memory (ROM_START .. ROM_END);

   procedure Write (F_Memory  : out Memory;
                    Addr      : Address;
                    Buffer    : Memory);

   procedure Write_Word (Mem     : out Memory;
                         Addr    : Address;
                         W       : Word);

   procedure Write_Half (Mem     : out Memory;
                         Addr    : Address;
                         H       : Half);
   
   procedure Write_Byte (Mem     : out Memory;
                         Addr    : Address;
                         B       : Byte);

   function Read (F_Memory    : Memory;
                  Addr        : Address;
                  Num_Bytes   : Address) return Memory;

   function Read_Word (Mem    : Memory;
                       Addr   : Address) return Word;

   function Read_Half (Mem    : Memory;
                       Addr   : Address) return Half;
   
   function Read_Byte (Mem    : Memory;
                       Addr   : Address) return Byte;
end RISCV_Memory;
