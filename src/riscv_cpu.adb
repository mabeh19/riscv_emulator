with Ada.Text_IO; use Ada.Text_IO;

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

   procedure Run (CPU : out CPU_Context) is
      Current_Instruction : Instruction;
   begin
      Start (CPU);
      while not CPU.Should_Quit loop
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
 
end RISCV_CPU;
