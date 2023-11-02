with Ada.Text_IO; use Ada.Text_IO;
with RISCV_Registers;
with RISCV_Memory;
with RISCV_Base_Instruction_Format;
with RISCV_CPU;
with ELF_Loader;

procedure Riscv_Emulator is
   CPU      : RISCV_CPU.CPU_Context;
   --  NOP      : RISCV_Memory.Memory := [16#13#, 0, 0, 0];
   --  INC_X1   : RISCV_Memory.Memory := [16#93#, 16#80#, 16#10#, 16#00#];
   --  DEC_X1   : RISCV_Memory.Memory := [16#b3#, 16#80#, 16#10#, 16#40#];
   --  JMP_0    : RISCV_Memory.Memory := [16#6f#, 16#f0#, 16#5f#, 16#ff#];
   --  ADD_NEG_X1 : RISCV_Memory.Memory := [16#93#, 16#80#, 16#f0#, 16#ff#];
   Result : ELF_Loader.File_Status;
begin
   Result := ELF_Loader.Load_File ("/home/mathias/Documents/Assembly/RISC-V/emulator_ref/main",
                                CPU.ROM,
                                CPU.RAM);
   if not Result.Success then
      Put_Line ("Error occurred loading ELF file, exiting");
      return;
   end if;
   CPU.ROM_Offset := Result.ROM_Offset;
   CPU.RAM_Offset := Result.RAM_Offset;
   CPU.ROM_Size   := Result.ROM_Size;
   CPU.RAM_Size   := Result.RAM_Size;
   RISCV_CPU.Run (CPU);
end Riscv_Emulator;
