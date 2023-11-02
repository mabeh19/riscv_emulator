with AUnit; use AUnit;
with AUnit.Test_Cases;  use AUnit.Test_Cases;
with RISCV_Base_Instruction_Set;

package RISCV_Base_Instruction_Set_Test is
   
   type Test is new Test_Cases.Test_Case with null record;

   function Name (T : Test) return AUnit.Message_String;

   procedure Register_Tests (T : in out Test);

   -- Test Routines
   procedure Test_Get_Instruction_Executor (T : in out Test_Cases.Test_Case'Class);
   procedure Test_Get_Opcode (T : in out Test_Cases.Test_Case'Class);
   procedure Test_Get_Extended_Opcode  (T : in out Test_Cases.Test_Case'Class);
   procedure Test_Get_R_Type_Opcode    (T : in out Test_Cases.Test_Case'Class);
   procedure Test_Get_Special_Opcode   (T : in out Test_Cases.Test_Case'Class);
 
end RISCV_Base_Instruction_Set_Test;
