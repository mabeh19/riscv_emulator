with Ada.Text_IO; use Ada.Text_IO;
package body RISCV_Base_Instruction_Format is

   function Create_I_Immediate (Inst: I_Format) return Immediate is
      I        : Immediate := Immediate (Inst.Imm);
      Last_Bit : constant Immediate := Immediate (Inst.Imm) / (2 ** 11);
   begin
      I := Extend_Bit (I, Last_Bit, 31 - 11);
      return I;
   end Create_I_Immediate;

   function Create_S_Immediate (Inst: S_Format) return Immediate is
      I        : Immediate := Immediate (Inst.Imm_L) + (Immediate (Inst.Imm_H) * (2 ** 5));
      Last_Bit : constant Immediate := Immediate (Inst.Imm_H) / (2 ** 6);
   begin
      I := Extend_Bit (I, Last_Bit, 31 - 11);
      return I;
   end Create_S_Immediate;

   function Create_U_Immediate (Inst: U_Format) return Immediate is
      I : Immediate := Immediate (Inst.Imm) * (2 ** 12);
   begin
      return I;
   end Create_U_Immediate;

   function Create_B_Immediate (Inst: B_Format) return Immediate is
      I        : Immediate := Immediate (Inst.Imm41)   * (2 ** 1) +
                              Immediate (Inst.Imm105)  * (2 ** 5) +
                              Immediate (Inst.Imm11)   * (2 ** 11);
      Last_Bit : constant Immediate := Immediate (Inst.Imm12);
   begin
      I := Extend_Bit (I, Last_Bit, 31 - 12);
      return I;
   end Create_B_Immediate;

   function Create_J_Immediate (Inst: J_Format) return Immediate is
      I        : Immediate := Immediate (Inst.Imm101)  * (2 ** 1) +
                              Immediate (Inst.Imm11)   * (2 ** 11) +
                              Immediate (Inst.Imm1912) * (2 ** 12);
      Last_Bit : constant Immediate := Immediate (Inst.Imm20);
   begin
      I := Extend_Bit (I, Last_Bit, 31 - 20);
      return I;
   end Create_J_Immediate;

   function Extend_Bit (Imm: Immediate; Last_Bit: Immediate; Bits: Immediate) return Immediate is
      I : Immediate := Imm;
   begin
      if Last_Bit = 1 then
         declare 
            Bits_To_Ignore : constant Immediate := Immediate (2 ** (31 - Natural (Bits)));
            -- Clear all bits not part of extend
            Mask : constant Immediate := (16#FFFFFFFF# / Bits_To_Ignore) * Bits_To_Ignore;
         begin
            I := I or Mask;
         end;
      end if;
      return I;
   end Extend_Bit;

end RISCV_Base_Instruction_Format;
