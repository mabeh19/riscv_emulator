with Ada.Text_IO;
with AUnit.Assertions;  use AUnit.Assertions;
with RISCV_Base_Instruction_Format; use RISCV_Base_Instruction_Format;
with RISCV_Instruction; use RISCV_Instruction;
with RISCV_Registers;   use RISCV_Registers;
with RISCV_CPU;         use RISCV_CPU;

package body RISCV_Instruction_JAL_Test is

   function Name (T: Test) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Test RISCV Instruction JAL");
   end Name;

   procedure Register_Tests (T : in out Test) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_JAL_Positive'Access, "Test Test_JAL_Positive");
      Register_Routine (T, Test_JAL_Negative'Access, "Test Test_JAL_Negative");
   end Register_Tests;

   procedure Test_JAL_Positive(T : in out Test_Cases.Test_Case'Class) is
      CPU : CPU_Context := (
         ROM            => (others => 0),
         RAM            => (others => 0),
         Core_Registers => (
            X     => (others => 0),
            PC    => 16#24#,
            CSR   => (others => 0)
         ),
         Should_Quit => False,
         others => 0

      );
      Inst : Instruction := 16#00c0_006f#;
   begin
      JAL (CPU, Inst);
      Assert (CPU.Core_Registers.PC = 16#30#, "incorrect parsing of instruction for positive JAL");
   end Test_JAL_Positive;

   procedure Test_JAL_Negative(T : in out Test_Cases.Test_Case'Class) is
      CPU : CPU_Context := (
         ROM            => (others => 0),
         RAM            => (others => 0),
         Core_Registers => (
            X     => (others => 0),
            PC    => 16#20#,
            CSR   => (others => 0)
         ),
         Should_Quit => False,
         others => 0

      );
      Inst : Instruction := 16#ff5f_f06f#;
   begin
      JAL (CPU, Inst);
      Assert (CPU.Core_Registers.PC = 16#14#, "incorrect parsing of instruction for negative JAL");
   end Test_JAL_Negative;

end RISCV_Instruction_JAL_Test;
