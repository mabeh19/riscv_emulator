with Ada.Text_IO;
with AUnit.Assertions;  use AUnit.Assertions;
with RISCV_Base_Instruction_Format; use RISCV_Base_Instruction_Format;
with RISCV_Instruction; use RISCV_Instruction;
with RISCV_Registers;   use RISCV_Registers;
with RISCV_CPU;         use RISCV_CPU;

package body RISCV_Instruction_ADDI_Test is

   function Name (T: Test) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Test RISCV Instruction ADDI");
   end Name;

   procedure Register_Tests (T : in out Test) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_ADDI_x0'Access, "Test Test_ADDI_x0");
      Register_Routine (T, Test_ADDI_x1'Access, "Test Test_ADDI_x1");
      Register_Routine (T, Test_ADDI_x2'Access, "Test Test_ADDI_x2");
   end Register_Tests;

   procedure Test_ADDI_x0(T : in out Test_Cases.Test_Case'Class) is
      CPU : CPU_Context := (
         ROM            => (others => 0),
         RAM            => (others => 0),
         Core_Registers => (
            X     => (others => 0),
            PC    => 0,
            CSR   => (others => 0)
         ),
         Should_Quit => False,
         others => 0
      );
      Inst : Instruction := 16#0000_0013#;
   begin
      ADDI (CPU, Inst);
      Assert (CPU.Core_Registers.X (0) = 0, "incorrect parsing of instruction for NOP");
   end Test_ADDI_x0;

   procedure Test_ADDI_x1(T : in out Test_Cases.Test_Case'Class) is
      CPU : CPU_Context := (
         ROM            => (others => 0),
         RAM            => (others => 0),
         Core_Registers => (
            X     => (others => 0),
            PC    => 0,
            CSR   => (others => 0)
         ),
         Should_Quit => False,
         others => 0

      );
      Inst : Instruction := 16#00108093#;
   begin
      ADDI (CPU, Inst);
      Assert (CPU.Core_Registers.X (1) = 1, "incorrect parsing of instruction for addi x1, x1, 1");
   end Test_ADDI_x1;

   procedure Test_ADDI_x2(T : in out Test_Cases.Test_Case'Class) is
      CPU : CPU_Context := (
         ROM            => (others => 0),
         RAM            => (others => 0),
         Core_Registers => (
            X     => (others => 0),
            PC    => 0,
            CSR   => (others => 0)
         ),
         Should_Quit => False,
         others => 0

      );
      Inst : Instruction := 16#00110113#;
   begin
      ADDI (CPU, Inst);
      Assert (CPU.Core_Registers.X (2) = 1, "incorrect parsing of instruction for addi x2, x2, 1");
   end Test_ADDI_x2;



end RISCV_Instruction_ADDI_Test;
