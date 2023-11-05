with RISCV_Memory;
with RISCV_Registers;
with RISCV_Base_Instruction_Format;

package RISCV_CPU is

   type CPU_Context is record
      ROM            : RISCV_Memory.Flash_Memory;
      RAM            : RISCV_Memory.RAM_Memory;
      Core_Registers : RISCV_Registers.Core_Registers;

      ROM_Offset     : RISCV_Memory.Address;
      RAM_Offset     : RISCV_Memory.Address;
      ROM_Size       : RISCV_Memory.Address;
      RAM_Size       : RISCV_Memory.Address;

      Should_Quit    : Boolean;
   end record;

   procedure Run (CPU : out CPU_Context);

   function Address_To_Emulated_Address (CPU   : CPU_Context;
                                         Addr  : RISCV_Memory.Address) return RISCV_Memory.Address;
   procedure Mem_Region_RW (CPU  : in out CPU_Context;
                            Addr : RISCV_Memory.Address;
                            Func : access procedure (Memory : in out RISCV_Memory.Memory));

private

   procedure Start (CPU : out CPU_Context);
   function Load (CPU   : CPU_Context;
                  Addr  : RISCV_Memory.Address)
                  return RISCV_Base_Instruction_Format.Instruction;
   procedure Execute (CPU  : in out CPU_Context;
                      Inst : RISCV_Base_Instruction_Format.Instruction); 
end RISCV_CPU;
