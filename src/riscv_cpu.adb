with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; 
with Ada.Unchecked_Conversion;

with RISCV_Memory;                     use RISCV_Memory;
with RISCV_Base_Instruction_Format;    use RISCV_Base_Instruction_Format;
with RISCV_Base_Instruction_Set;       use RISCV_Base_Instruction_Set;

package body RISCV_CPU is

   procedure Start (CPU : out CPU_Context) is
   begin
      CPU.Core_Registers.PC   := RISCV_Registers.Register (CPU.ROM_Offset);
      CPU.Core_Registers.X    := [others => 0];
      CPU.Core_Registers.CSR  := [others => 0];
      CPU.Should_Quit         := False;
   end Start;

   procedure Run (CPU : out CPU_Context; Interactive : Boolean) is
      Current_Instruction : Instruction;
   begin
      Start (CPU);
      while not CPU.Should_Quit loop
         if Interactive then
            Dump_CPU_Registers (CPU); 
         end if;
         Current_Instruction := Load (CPU, Address_To_Emulated_Address (CPU, Address (CPU.Core_Registers.PC)));
         exit when Current_Instruction = 0;
         Execute (CPU, Current_Instruction);
         --Put_Line ("General Registers: " & CPU.Core_Registers.X'Image);
         RISCV_Registers.Add_Register (CPU.Core_Registers.PC, 4); 
      end loop;
   end Run;

   function Load (CPU   : CPU_Context;
                  Addr  : Address) return Instruction is
   begin
      if Addr in CPU.ROM'Range then
         return Instruction (Read_Word (CPU.ROM, Addr));
      elsif Addr in CPU.RAM'Range then
         return Instruction (Read_Word (CPU.RAM, Addr));
      end if;

      return 0;
   end Load;

   procedure Execute (CPU  : in out CPU_Context;
                      Inst : Instruction) is
      Executor : Instruction_Executor;
   begin
      Executor := Get_Instruction_Executor (Inst);

      if Executor /= null then
         Executor (CPU, Inst);
      end if;

      CPU.Core_Registers.X (0) := 0; --  Override any value written to x0
   end Execute;

   function Address_To_Emulated_Address (CPU   : CPU_Context;
                                         Addr  : Address) return Address is 
      RAM_Upper_Bound : constant Address := CPU.RAM_Offset + CPU.RAM_Size;
      ROM_Upper_Bound : constant Address := CPU.ROM_Offset + CPU.ROM_Size;
      Offset      : Address := 0;
      Base_Addr   : Address := 0;
   begin
      if Addr >= CPU.RAM_Offset and then Addr <= RAM_Upper_Bound then
         Offset := CPU.RAM_Offset;
         Base_Addr := RAM_START;
      elsif Addr >= CPU.ROM_Offset and then Addr <= ROM_Upper_Bound then
         Offset := CPU.ROM_Offset;
         Base_Addr := ROM_START;
      end if;

      return (Addr - Offset) + Base_Addr;
   end Address_To_Emulated_Address;

   procedure Mem_region_RW (CPU  : in out CPU_Context;
                            Addr : RISCV_Memory.Address;
                            Func : access procedure (Memory : in out RISCV_Memory.Memory)) is
      RAM_Upper_Bound : constant Address := CPU.RAM_Offset + CPU.RAM_Size;
      ROM_Upper_Bound : constant Address := CPU.ROM_Offset + CPU.ROM_Size;
   begin
      if Addr >= CPU.RAM_Offset and then Addr <= RAM_Upper_Bound then
         Func (CPU.RAM);
      elsif Addr >= CPU.ROM_Offset and then Addr <= ROM_Upper_Bound then
         Func (CPU.ROM);
      end if;
   end Mem_Region_RW;

   procedure Dump_CPU_Registers (CPU : in CPU_Context) is
      function To_Int is new Ada.Unchecked_Conversion (
         Source => RISCV_Registers.Register,
         Target => Integer
      );
      Dummy : String := Ada.Text_IO.Get_Line;

      Control_Preamble  : constant Character := Character'Val (8#33#);   --  '\033'
      Clear_Screen      : constant String := "[2J";
      Clear_Seq         : constant String := Control_Preamble & Clear_Screen;
   begin
      Put (Clear_Seq);
      Set_Line (1);
      Put ("PC");
      Set_Col (10);
      Put("=>");
      Ada.Integer_Text_IO.Put (To_Int (CPU.Core_Registers.PC), Base => 16);
      Put_Line ("");
      for Idx in 0 .. CPU.Core_Registers.X'Length - 1 loop
         Put (Register_To_ABI_Name (Idx));
         Set_Col (10);
         Put ("=>");
         Ada.Integer_Text_IO.Put (To_Int (CPU.Core_Registers.X (Idx)), Base => 16);
         Put_Line ("");
      end loop;
   end Dump_CPU_Registers;

   function Register_To_ABI_Name (Register : Integer) return String is
      A_Reg : Integer := Register - 10;
      S_Reg : Integer := Register - 18 + 2;
   begin
      return (case Register is 
         when 0   => "zero",
         when 1   => "ra",
         when 2   => "sp",
         when 3   => "gp",
         when 4   => "tp",
         when 5   => "t0",
         when 6   => "t1",
         when 7   => "t2",
         when 8   => "s0",
         when 9   => "s1",
         when 10 .. 17 => "a" & A_Reg'Image (2 .. 2),
         when 18 .. 27 => "s" & S_Reg'Image (2 .. S_Reg'Image'Last),
         when 28  => "t3",
         when 29  => "t4",
         when 30  => "t5",
         when 31  => "t6",
         when others => "UNKNOWN");
   end Register_To_ABI_Name;

end RISCV_CPU;
