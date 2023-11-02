package body RISCV_Registers is

   function Get_Register (Regs : Core_Registers;
                          Reg  : Integer) return Register is
   begin
      return Regs.X (Reg);
   end Get_Register;

   procedure Set_Register (Regs  : out Core_Registers;
                           Reg   : Integer;
                           Value : Register) is
   begin
      Regs.X (Reg) := Value;
   end Set_Register;

   procedure Add_Register (Reg   : in out Register;
                           Value : Register) is
   begin
      Reg := Reg + Value;
   end Add_Register;

end RISCV_Registers;
