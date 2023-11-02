with Ada.Text_IO;
with AUnit.Assertions; use AUnit.Assertions;
with RISCV_Base_Instruction_Set;   use RISCV_Base_Instruction_Set;
with RISCV_Base_Instruction_Format; use RISCV_Base_Instruction_Format;
with RISCV_Instruction;

package body RISCV_Base_Instruction_Set_Test is

   function Name (T : Test) return AUnit.Message_String is
   begin
      return AUnit.Format ("Test RISC-V base instruction set");
   end Name;

   procedure Register_Tests (T : in out Test) is 
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Get_Opcode'Access, "Test Get_Opcode");
      Register_Routine (T, Test_Get_Extended_Opcode'Access, "Test Get_Extended_Opcode");
      Register_Routine (T, Test_Get_R_Type_Opcode'Access, "Test Get_R_Type_Opcode");
      Register_Routine (T, Test_Get_Special_Opcode'Access, "Test Get_Special_Opcode");
      Register_Routine (T, Test_Get_Instruction_Executor'Access, "Test Get_Instruction_Executor");
   end Register_Tests;

   procedure Test_Get_Instruction_Executor (T : in out Test_Cases.Test_Case'Class) is
      Inst : Instruction := 16#0000_0000#;
      Inst_ADD : Instruction := 16#0000_0033#;
      Inst_SUB : Instruction := 16#4031_0233#;
      Inst_JAL_Pos : Instruction := 16#00c0_006f#;
      Inst_JAL_Neg : Instruction := 16#ff5f_f06f#;
      Inst_ADDI      : Instruction := 16#0010_8093#;
      Inst_AUIPC     : Instruction := 16#0000_1097#;
      Inst_LUI       : Instruction := 16#0000_10b7#;
      Inst_BEQ       : Instruction := 16#fe10_88e3#;
      Inst_JALR      : Instruction := 16#0000_80e7#;
      Inst_SLLI      : Instruction := 16#0010_9093#;
      Inst_SLL       : Instruction := 16#0010_90b3#;
      Inst_BNE       : Instruction := 16#fc10_9ee3#;
      Inst_SLTI      : Instruction := 16#0010_a093#;
      Inst_SLT       : Instruction := 16#0010_a0b3#;
      Inst_SLTIU     : Instruction := 16#0641_3093#;
      Inst_XORI      : Instruction := 16#0010_c093#;
      Inst_INST_XOR  : Instruction := 16#0010_c0b3#;
      Inst_BLT       : Instruction := 16#fc10_c2e3#;
      Inst_SRLI      : Instruction := 16#0010_d093#;
      Inst_SRL       : Instruction := 16#0010_d0b3#;
      Inst_BGE       : Instruction := 16#fa10_dce3#;
      Inst_ORI       : Instruction := 16#0010_e093#;
      Inst_INST_OR   : Instruction := 16#0010_e0b3#;
      Inst_BLTU      : Instruction := 16#fa10_e6e3#;
      Inst_ANDI      : Instruction := 16#0010_f093#;
      Inst_INST_AND  : Instruction := 16#0010_f0b3#;
      Inst_BGEU      : Instruction := 16#fa10_f0e3#;
      Inst_ECALL     : Instruction := 16#0000_0073#;
      Inst_SRAI      : Instruction := 16#4010_d093#;
      Inst_SRA       : Instruction := 16#4010_d0b3#;
      Func : Instruction_Executor;
   begin
      Func := Get_Instruction_Executor (Inst);
      Assert (Func = null, "Instruction returned for garbage value");

      Func := Get_Instruction_Executor (Inst_ADD);
      Assert (Func = RISCV_Instruction.ADD'Access, "ADD instruction not returned");

      Func := Get_Instruction_Executor (Inst_SUB);
      Assert (Func = RISCV_Instruction.SUB'Access, "SUB instruction not returned");

      Func := Get_Instruction_Executor (Inst_JAL_Pos);
      Assert (Func = RISCV_Instruction.JAL'Access, "JAL instruction not returned for positive jump");

      Func := Get_Instruction_Executor (Inst_JAL_Neg);
      Assert (Func = RISCV_Instruction.JAL'Access, "JAL instruction not returned on negative jump");

      Func := Get_Instruction_Executor (Inst_ADDI);
      Assert (Func = RISCV_Instruction.ADDI'Access, "ADDI instruction not returned");
      Func := Get_Instruction_Executor (Inst_AUIPC);
      Assert (Func = RISCV_Instruction.AUIPC'Access, "AUIPC instruction not returned");
      Func := Get_Instruction_Executor (Inst_LUI);
      Assert (Func = RISCV_Instruction.LUI'Access, "LUI instruction not returned");
      Func := Get_Instruction_Executor (Inst_BEQ);
      Assert (Func = RISCV_Instruction.BEQ'Access, "BEQ instruction not returned");
      Func := Get_Instruction_Executor (Inst_JALR);
      Assert (Func = RISCV_Instruction.JALR'Access, "JALR instruction not returned");
      Func := Get_Instruction_Executor (Inst_SLLI);
      Assert (Func = RISCV_Instruction.SLLI'Access, "SLLI instruction not returned:" & Func'Image);
      Func := Get_Instruction_Executor (Inst_SLL);
      Assert (Func = RISCV_Instruction.SLL'Access, "SLL instruction not returned");
      Func := Get_Instruction_Executor (Inst_BNE);
      Assert (Func = RISCV_Instruction.BNE'Access, "BNE instruction not returned");
      Func := Get_Instruction_Executor (Inst_SLTI);
      Assert (Func = RISCV_Instruction.SLTI'Access, "SLTI instruction not returned");
      Func := Get_Instruction_Executor (Inst_SLT);
      Assert (Func = RISCV_Instruction.SLT'Access, "SLT instruction not returned");
      Func := Get_Instruction_Executor (Inst_SLTIU);
      Assert (Func = RISCV_Instruction.SLTIU'Access, "SLTIU instruction not returned");
      Func := Get_Instruction_Executor (Inst_XORI);
      Assert (Func = RISCV_Instruction.XORI'Access, "XORI instruction not returned");
      Func := Get_Instruction_Executor (Inst_INST_XOR);
      Assert (Func = RISCV_Instruction.INST_XOR'Access, "INST_XOR instruction not returned");
      Func := Get_Instruction_Executor (Inst_BLT);
      Assert (Func = RISCV_Instruction.BLT'Access, "BLT instruction not returned");
      Func := Get_Instruction_Executor (Inst_SRLI);
      Assert (Func = RISCV_Instruction.SRLI'Access, "SRLI instruction not returned");
      Func := Get_Instruction_Executor (Inst_SRL);
      Assert (Func = RISCV_Instruction.SRL'Access, "SRL instruction not returned");
      Func := Get_Instruction_Executor (Inst_BGE);
      Assert (Func = RISCV_Instruction.BGE'Access, "BGE instruction not returned");
      Func := Get_Instruction_Executor (Inst_ORI);
      Assert (Func = RISCV_Instruction.ORI'Access, "ORI instruction not returned");
      Func := Get_Instruction_Executor (Inst_INST_OR);
      Assert (Func = RISCV_Instruction.INST_OR'Access, "INST_OR instruction not returned");
      Func := Get_Instruction_Executor (Inst_BLTU);
      Assert (Func = RISCV_Instruction.BLTU'Access, "BLTU instruction not returned");
      Func := Get_Instruction_Executor (Inst_ANDI);
      Assert (Func = RISCV_Instruction.ANDI'Access, "ANDI instruction not returned");
      Func := Get_Instruction_Executor (Inst_INST_AND);
      Assert (Func = RISCV_Instruction.INST_AND'Access, "INST_AND instruction not returned");
      Func := Get_Instruction_Executor (Inst_BGEU);
      Assert (Func = RISCV_Instruction.BGEU'Access, "BGEU instruction not returned");
      Func := Get_Instruction_Executor (Inst_ECALL);
      Assert (Func = RISCV_Instruction.ECALL'Access, "ECALL instruction not returned");
      Func := Get_Instruction_Executor (Inst_SRAI);
      Assert (Func = RISCV_Instruction.SRAI'Access, "SRAI instruction not returned");
      Func := Get_Instruction_Executor (Inst_SRA);
      Assert (Func = RISCV_Instruction.SRA'Access, "SRA instruction not returned");

   end Test_Get_Instruction_Executor;

   -- Test Routines
   procedure Test_Get_Opcode (T : in out Test_Cases.Test_Case'Class) is
      Instr : Instruction := 16#00c0_006f#;
      Opcode : Instruction := Get_Opcode (Instr);
      Expected : Base_Instruction_Set := jal;
   begin
      Assert (Opcode = Expected'Enum_Rep, "Get_Opcode not returning expected value, Expected" & Expected'Enum_Rep'Image & " got" & Opcode'Image);
   end Test_Get_Opcode;

   procedure Test_Get_Extended_Opcode  (T : in out Test_Cases.Test_Case'Class) is
      Instr : Instruction := 16#0010_8093#;
      Opcode : Instruction := Get_Extended_Opcode (Instr);
      Expected : Base_Instruction_Set := addi;
   begin
      Assert (Opcode = Expected'Enum_Rep, "Get_Extended_Opcode not returning expected value, Expected" & Expected'Enum_Rep'Image & " got" & Opcode'Image);
   end Test_Get_Extended_Opcode;

   procedure Test_Get_R_Type_Opcode    (T : in out Test_Cases.Test_Case'Class) is
      Instr_ADD      : Instruction := 16#0010_80b3#;
      Opcode_ADD     : Instruction := Get_R_Type_Opcode (Instr_ADD);
      Expected_ADD   : Base_Instruction_Set := add;
   
      Instr_SUB      : Instruction := 16#4031_0233#;
      Opcode_SUB     : Instruction := Get_R_Type_Opcode (Instr_SUB);
      Expected_SUB   : Base_Instruction_Set := sub;
   begin
      Ada.Text_IO.Put_Line (Base_Instruction_Set'Enum_Val(Get_Opcode (Instr_SUB))'Image);
      Assert (Opcode_ADD = Expected_ADD'Enum_Rep, "Get_Extended_Opcode not returning expected value, Expected" & Expected_ADD'Enum_Rep'Image & " got" & Opcode_ADD'Image);

      Assert (Opcode_SUB = Expected_SUB'Enum_Rep, "Get_Extended_Opcode not returning expected value, Expected" & Expected_SUB'Enum_Rep'Image & " got" & Opcode_SUB'Image);
   end Test_Get_R_Type_Opcode;

   procedure Test_Get_Special_Opcode   (T : in out Test_Cases.Test_Case'Class) is
      Instr : Instruction := 16#0010_0073#;
      Opcode : Instruction := Get_Special_Opcode (Instr);
      Expected : Base_Instruction_Set := ebreak;
   begin  
      Assert (Opcode = Expected'Enum_Rep, "Get_Extended_Opcode not returning expected value, Expected" & Expected'Enum_Rep'Image & " got" & Opcode'Image);
   end Test_Get_Special_Opcode;
 
end RISCV_Base_Instruction_Set_Test;
