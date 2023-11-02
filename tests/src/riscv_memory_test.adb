with AUnit.Assertions; use AUnit.Assertions;
with RISCV_Memory;   use RISCV_Memory;

package body RISCV_Memory_Test is

   function Name (T: Test) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin 
      return AUnit.Format ("Test RISCV Memory");
   end Name;

   procedure Run_Test (T: in out Test) is
      R_Mem : RAM_Memory;
      Test_Buf: Memory := (1, 2, 3, 4);
      Read_Back: Memory (Test_Buf'Range);
   begin
      Write (R_Mem, RAM_START, Test_Buf);
      Assert (R_Mem (RAM_START) = Test_Buf (0), "No write to mem");
      Read_Back := Read (R_Mem, RAM_START, Test_Buf'Length);
      Assert (Read_Back = Test_Buf, "No read from mem");
   end Run_Test;

end RISCV_Memory_Test;
