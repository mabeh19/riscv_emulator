with Ada.Text_IO;
with AUnit.Assertions; use AUnit.Assertions;
with RISCV_Base_Instruction_Format;   use RISCV_Base_Instruction_Format;

package body RISCV_Base_Instruction_Format_Test is

   function Name (T: Test) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Test RISCV Base Instruction Format");
   end Name;

   procedure Register_Tests (T : in out Test) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Create_I_Immediate'Access, "Test Create_I_Immediate");
      Register_Routine (T, Test_Create_S_Immediate'Access, "Test Create_S_Immediate");
      Register_Routine (T, Test_Create_U_Immediate'Access, "Test Create_U_Immediate");
      Register_Routine (T, Test_Create_B_Immediate'Access, "Test Create_B_Immediate");
      Register_Routine (T, Test_Create_J_Immediate'Access, "Test Create_J_Immediate");
   end Register_Tests;

   procedure Test_Create_I_Immediate (T : in out Test_Cases.Test_Case'Class) is
      I_F1 : I_Format := (
         Opcode   => 16#00#,
         Rd       => 16#00#,
         Funct3   => 16#00#,
         Rs1      => 16#00#,
         Imm      => 16#FFF#);
      I_F2 : I_Format := (
         Opcode   => 16#00#,
         Rd       => 16#00#,
         Funct3   => 16#00#,
         Rs1      => 16#00#,
         Imm      => 16#3FF#);
      Imm1: Immediate := Create_I_Immediate (I_F1);
      Imm2: Immediate := Create_I_Immediate (I_F2);
   begin
      Assert (Imm1 = 16#FFFFFFFF#, "I Immediate sign not extended");
      Assert (Imm2 = Immediate (I_F2.Imm), "I Immediate sign extended");
   end Test_Create_I_Immediate;

   procedure Test_Create_S_Immediate (T : in out Test_Cases.Test_Case'Class) is
      S_F1 : S_Format := (
         Opcode   => 16#00#,
         Imm_L    => 16#1F#,
         Funct3   => 16#00#,
         Rs1      => 16#00#,
         Rs2      => 16#00#,
         Imm_H    => 16#7F#);
      S_F2 : S_Format := (
         Opcode   => 16#00#,
         Imm_L    => 16#1F#,
         Funct3   => 16#00#,
         Rs1      => 16#00#,
         Rs2      => 16#00#,
         Imm_H    => 16#3F#);
      Imm1 : Immediate := Create_S_Immediate (S_F1);
      Imm2 : Immediate := Create_S_Immediate (S_F2);
      Imm2_Expected : Immediate := 16#0000_07FF#;
   begin
      Assert (Imm1 = 16#FFFFFFFF#, "S Immediate sign not extended");
      Assert (Imm2 = Imm2_Expected, Imm2'Image & " =" & Imm2_Expected'Image);
   end Test_Create_S_Immediate;

   procedure Test_Create_U_Immediate (T : in out Test_Cases.Test_Case'Class) is
      U_F1 : U_Format := (
         Opcode   => 16#0#,
         Rd       => 16#0#,
         Imm      => Imm_31_12'Last);
      Imm1 : Immediate := Create_U_Immediate (U_F1);
      Imm1_Expected : Immediate := Immediate (Imm_31_12'Last) * (2 ** 12);
   begin
      Assert (Imm1 = Imm1_Expected, Imm1'Image & " =" & Imm1_Expected'Image);
   end Test_Create_U_Immediate;

   procedure Test_Create_B_Immediate (T : in out Test_Cases.Test_Case'Class) is
      B_F1 : B_Format := (
         Opcode   => 16#0#,
         Imm11    => 16#1#,
         Imm41    => 16#F#,
         Funct3   => 16#0#,
         Rs1      => 16#0#,
         Rs2      => 16#0#,
         Imm105   => 16#3F#,
         Imm12    => 16#1#);
      Imm1 : Immediate := Create_B_Immediate (B_F1);
      Imm1_Expected : Immediate := 16#FFFF_FFFE#;
   begin
      Assert (Imm1 = Imm1_Expected, Imm1'Image & " =" & Imm1_Expected'Image);
   end Test_Create_B_Immediate;

   procedure Test_Create_J_Immediate (T : in out Test_Cases.Test_Case'Class) is
      J_F1 : J_Format := (
         Opcode   => 16#0#,
         Rd       => 16#0#,
         Imm1912  => 16#FF#,
         Imm11    => 16#1#,
         Imm101   => 16#3FF#,
         Imm20    => 16#1#);
      Imm1 : Immediate := Create_J_Immediate (J_F1);
      Imm1_Expected : Immediate := 16#FFFF_FFFE#;
   begin
      Assert (Imm1 = Imm1_Expected, Imm1'Image & " =" & Imm1_Expected'Image);
   end Test_Create_J_Immediate;

end RISCV_Base_Instruction_Format_Test;
