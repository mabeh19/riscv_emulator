
with AUnit.Reporter.Text;
with AUnit.Run;
with RISCV_Emu_Suite;

procedure RISCV_Emu_Harness is

   procedure Runner is new AUnit.Run.Test_Runner (RISCV_Emu_Suite);

   Reporter : AUnit.Reporter.Text.Text_Reporter;

begin 
   Runner (Reporter);
end RISCV_Emu_Harness;
