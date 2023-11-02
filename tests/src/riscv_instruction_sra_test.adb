with Ada.Text_IO;
with AUnit.Assertions;  use AUnit.Assertions;
with RISCV_Base_Instruction_Format; use RISCV_Base_Instruction_Format;
with RISCV_Instruction; use RISCV_Instruction;
with RISCV_Registers;   use RISCV_Registers;
with RISCV_CPU;         use RISCV_CPU;

package body RISCV_Instruction_SRA_Test is

   function Name (T: Test) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Test RISCV Instruction SRA");
   end Name;

   procedure Register_Tests (T : in out Test) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_SRA_Positive'Access, "Test Test_SRA_Positive");
      Register_Routine (T, Test_SRA_Negative'Access, "Test Test_SRA_Negative");
   end Register_Tests;

   procedure Test_SRA_Positive(T : in out Test_Cases.Test_Case'Class) is
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
      Inst : Instruction := 16#4010_5033#;
   begin
      CPU.Core_Registers.X (0) := 2;
      CPU.Core_Registers.X (1) := 1;
      SRA (CPU, Inst);
      Assert (CPU.Core_Registers.X (0) = 1, "incorrect parsing of instruction for `SRA x0, x0, x1`");
   end Test_SRA_Positive;

   procedure Test_SRA_Negative(T : in out Test_Cases.Test_Case'Class) is
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
      Inst : Instruction := 16#4010_5033#;
   begin
      CPU.Core_Registers.X (0) := RISCV_Registers.Register'Mod (-128);
      CPU.Core_Registers.X (1) := 2;
      SRA (CPU, Inst);
      Assert (CPU.Core_Registers.X (0) = -32, "incorrect parsing of instruction for `SRA x0, x0, x1`");
   end Test_SRA_Negative;

end RISCV_Instruction_SRA_Test;
