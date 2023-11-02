with Ada.Text_IO;
with AUnit.Assertions;  use AUnit.Assertions;
with RISCV_Base_Instruction_Format; use RISCV_Base_Instruction_Format;
with RISCV_Instruction; use RISCV_Instruction;
with RISCV_Registers;   use RISCV_Registers;
with RISCV_CPU;         use RISCV_CPU;

package body RISCV_Instruction_ADD_Test is

   function Name (T: Test) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Test RISCV Instruction ADD");
   end Name;

   procedure Register_Tests (T : in out Test) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_ADD_x0x0x0'Access, "Test Test_ADD_x0x0x0");
      Register_Routine (T, Test_ADD_x1x1x1'Access, "Test Test_ADD_x1x1x1");
      Register_Routine (T, Test_ADD_x4x2x3'Access, "Test Test_ADD_x4x2x3");
   end Register_Tests;

   procedure Test_ADD_x0x0x0(T : in out Test_Cases.Test_Case'Class) is
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
      Inst : Instruction := 16#0000_0033#;
   begin
      CPU.Core_Registers.X (0) := 2;
      ADD (CPU, Inst);
      Assert (CPU.Core_Registers.X (0) = 4, "incorrect parsing of instruction for `add x0, x0, x0`");
   end Test_ADD_x0x0x0;

   procedure Test_ADD_x1x1x1(T : in out Test_Cases.Test_Case'Class) is
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
      Inst : Instruction := 16#0010_80b3#;
   begin
      CPU.Core_Registers.X (1) := 100;
      ADD (CPU, Inst);
      Assert (CPU.Core_Registers.X (1) = 200, "incorrect parsing of instruction for `add x1, x1, x1`");
   end Test_ADD_x1x1x1;

   procedure Test_ADD_x4x2x3(T : in out Test_Cases.Test_Case'Class) is
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
      Inst : Instruction := 16#0031_0233#;
   begin
      CPU.Core_Registers.X (2) := 50;
      CPU.Core_Registers.X (3) := 700;
      ADD (CPU, Inst);
      Assert (CPU.Core_Registers.X (4) = 750, "incorrect parsing of instruction for `add x4, x2, x3`");
   end Test_ADD_x4x2x3;

end RISCV_Instruction_ADD_Test;
