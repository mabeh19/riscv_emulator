with Ada.Text_IO;
with AUnit.Assertions;  use AUnit.Assertions;
with RISCV_Base_Instruction_Format; use RISCV_Base_Instruction_Format;
with RISCV_Instruction; use RISCV_Instruction;
with RISCV_Registers;   use RISCV_Registers;
with RISCV_CPU;         use RISCV_CPU;

package body RISCV_Instruction_SUB_Test is

   function Name (T: Test) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Test RISCV Instruction SUB");
   end Name;

   procedure Register_Tests (T : in out Test) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_SUB_x0x0x0'Access, "Test Test_SUB_x0x0x0");
      Register_Routine (T, Test_SUB_x1x1x1'Access, "Test Test_SUB_x1x1x1");
      Register_Routine (T, Test_SUB_x4x2x3'Access, "Test Test_SUB_x4x2x3");
   end Register_Tests;

   procedure Test_SUB_x0x0x0(T : in out Test_Cases.Test_Case'Class) is
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
      Inst : Instruction := 16#4000_0033#;
   begin
      CPU.Core_Registers.X (0) := 2;
      SUB (CPU, Inst);
      Assert (CPU.Core_Registers.X (0) = 0, "incorrect parsing of instruction for `SUB x0, x0, x0`");
   end Test_SUB_x0x0x0;

   procedure Test_SUB_x1x1x1(T : in out Test_Cases.Test_Case'Class) is
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
      Inst : Instruction := 16#4010_80b3#;
   begin
      CPU.Core_Registers.X (1) := 100;
      SUB (CPU, Inst);
      Assert (CPU.Core_Registers.X (1) = 0, "incorrect parsing of instruction for `SUB x1, x1, x1`");
   end Test_SUB_x1x1x1;

   procedure Test_SUB_x4x2x3(T : in out Test_Cases.Test_Case'Class) is
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
      Inst : Instruction := 16#4031_0233#;
   begin
      CPU.Core_Registers.X (2) := 50;
      CPU.Core_Registers.X (3) := 700;
      SUB (CPU, Inst);
      Assert (CPU.Core_Registers.X (4) = -650, "incorrect parsing of instruction for `SUB x4, x2, x3`");
   end Test_SUB_x4x2x3;

end RISCV_Instruction_SUB_Test;
