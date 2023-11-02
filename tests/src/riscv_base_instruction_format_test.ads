with AUnit; use AUnit;
with AUnit.Test_Cases;  use AUnit.Test_Cases;
with RISCV_Base_Instruction_Format;

package RISCV_Base_Instruction_Format_Test is

   type Test is new Test_Cases.Test_Case with null record;

   function Name (T : Test) return AUnit.Message_String;

   procedure Register_Tests (T : in out Test);

   -- Test Routines
   procedure Test_Create_I_Immediate (T : in out Test_Cases.Test_Case'Class);
   procedure Test_Create_S_Immediate (T : in out Test_Cases.Test_Case'Class);
   procedure Test_Create_U_Immediate (T : in out Test_Cases.Test_Case'Class);
   procedure Test_Create_B_Immediate (T : in out Test_Cases.Test_Case'Class);
   procedure Test_Create_J_Immediate (T : in out Test_Cases.Test_Case'Class);

end RISCV_Base_Instruction_Format_Test;
