with AUnit; use AUnit;
with AUnit.Simple_Test_Cases;
with RISCV_Memory;

package RISCV_Memory_Test is

   type Test is new AUnit.Simple_Test_Cases.Test_Case with null record;

   function Name (T: Test) return AUnit.Message_String;

   procedure Run_Test (T: in out Test);

end RISCV_Memory_Test;

