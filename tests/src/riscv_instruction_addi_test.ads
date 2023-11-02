with AUnit; use AUnit;
with AUnit.Test_Cases;  use AUnit.Test_Cases;

package RISCV_Instruction_ADDI_Test is

   type Test is new Test_Cases.Test_Case with null record;

   function Name (T : Test) return AUnit.Message_String;

   procedure Register_Tests (T : in out Test);

   procedure Test_ADDI_x0(T : in out Test_Cases.Test_Case'Class);
   procedure Test_ADDI_x1(T : in out Test_Cases.Test_Case'Class);
   procedure Test_ADDI_x2(T : in out Test_Cases.Test_Case'Class);

   -- Test Routines
end RISCV_Instruction_ADDI_Test;
