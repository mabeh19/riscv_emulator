
with AUnit.Test_Suites; use AUnit.Test_Suites;
with RISCV_Memory_Test;
with RISCV_Base_Instruction_Format_Test;
with RISCV_Base_Instruction_Set_Test;
with RISCV_Instruction_ADDI_Test;
with RISCV_Instruction_ADD_Test;
with RISCV_Instruction_SUB_Test;
with RISCV_Instruction_JAL_Test;
with RISCV_Instruction_SRA_Test;

function RISCV_Emu_Suite return Access_Test_Suite is
   TS_Ptr : constant Access_Test_Suite := new Test_Suite;
begin
   TS_Ptr.Add_Test (new RISCV_Memory_Test.Test);
   TS_Ptr.Add_Test (new RISCV_Base_Instruction_Format_Test.Test);
   TS_Ptr.Add_Test (new RISCV_Base_Instruction_Set_Test.Test);
   TS_Ptr.Add_Test (new RISCV_Instruction_ADDI_Test.Test);
   TS_Ptr.Add_Test (new RISCV_Instruction_ADD_Test.Test);
   TS_Ptr.Add_Test (new RISCV_Instruction_SUB_Test.Test);
   TS_Ptr.Add_Test (new RISCV_Instruction_JAL_Test.Test);
   TS_Ptr.Add_Test (new RISCV_Instruction_SRA_Test.Test);

   return TS_Ptr;
end RISCV_Emu_Suite;
