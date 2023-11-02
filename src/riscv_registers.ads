
package RISCV_Registers is

   type Register is mod 2 ** 32 with Size => 32;
   type Base_Core_Registers is array (0 .. 31) of Register;
   type CSR_Space is array (0 .. 4095) of Register;

   type Core_Registers is record
      X     : Base_Core_Registers;
      PC    : Register;
      CSR   : CSR_Space;
   end record;

   function Get_Register (Regs : Core_Registers;
                          Reg  : Integer) return Register;

   procedure Set_Register (Regs  : out Core_Registers;
                           Reg   : Integer;
                           Value : Register);

   procedure Add_Register (Reg   : in out Register;
                           Value : Register);
end RISCV_Registers;
