with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_Line;
with RISCV_Registers;
with RISCV_Memory;
with RISCV_Base_Instruction_Format;
with RISCV_CPU;
with ELF_Loader;

procedure Riscv_Emulator is
   CPU         : RISCV_CPU.CPU_Context;
   Result      : ELF_Loader.File_Status;
   Interactive : Boolean := False;
begin
   if Ada.Command_Line.Argument_Count = 0 then
      Put_Line ("Missing File to emulate");
      return;
   end if;

   for Idx in 1 .. Ada.Command_Line.Argument_Count loop
      if Ada.Command_Line.Argument (Idx) = "-i" then
         Interactive := True;
         Put_Line ("Running in interactive mode...");
      end if;
   end loop;
   Result := ELF_Loader.Load_File (Ada.Command_Line.Argument (Ada.Command_Line.Argument_Count),
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
   RISCV_CPU.Run (CPU, Interactive);
end Riscv_Emulator;
