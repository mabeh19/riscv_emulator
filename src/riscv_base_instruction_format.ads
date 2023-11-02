with System;

package RISCV_Base_Instruction_Format is

   type Instruction  is mod 2 ** 32 with Size => 32;
   type Immediate    is mod 2 ** 32 with Size => 32;

   type Operation    is mod 2 ** 7 with Size => 7;
   type Register     is mod 2 ** 5 with Size => 5;
   type Byte         is mod 2 ** 1 with Size => 1;
   type Res3         is mod 2 ** 3 with Size => 3;
   type Res7         is mod 2 ** 7 with Size => 7;
   type Imm_11_0     is mod 2 ** 12 with Size => 12;
   type Imm_11_5     is mod 2 ** 7 with Size => 7;
   type Imm_4_0      is mod 2 ** 5 with Size => 5;
   type Imm_31_12    is mod 2 ** 20 with Size => 20;
   type Imm_4_1      is mod 2 ** 4 with Size => 4;
   type Imm_10_5     is mod 2 ** 6 with Size => 6;
   type Imm_19_12    is mod 2 ** 8 with Size => 8;
   type Imm_10_1     is mod 2 ** 10 with Size => 10;
   type Imm_20       is new Byte;

   type R_Format is record
      Opcode   : Operation := 0;
      Rd       : Register  := 0;
      Funct3   : Res3      := 0;
      Rs1      : Register  := 0;
      Rs2      : Register  := 0;
      Funct7   : Res7      := 0;
   end record
      with  Size        => Instruction'Size,
            Bit_Order   => System.Low_Order_First;

   for R_Format use record
      Opcode   at 0 range 0 .. 6;
      Rd       at 0 range 7 .. 11;
      Funct3   at 0 range 12 .. 14;
      Rs1      at 0 range 15 .. 19;
      Rs2      at 0 range 20 .. 24;
      Funct7   at 0 range 25 .. 31;
   end record;

   type I_Format is record
      Opcode   : Operation := 0;
      Rd       : Register  := 0;
      Funct3   : Res3      := 0;
      Rs1      : Register  := 0;
      Imm      : Imm_11_0  := 0;
   end record
      with  Size        => Instruction'Size,
            Bit_Order   => System.Low_Order_First;

   for I_Format use record
      Opcode   at 0 range 0 .. 6;
      Rd       at 0 range 7 .. 11;
      Funct3   at 0 range 12 .. 14;
      Rs1      at 0 range 15 .. 19;
      Imm      at 0 range 20 .. 31;
   end record;

   type S_Format is record
      Opcode   : Operation := 0;
      Imm_L    : Imm_4_0   := 0;
      Funct3   : Res3      := 0;
      Rs1      : Register  := 0;
      Rs2      : Register  := 0;
      Imm_H    : Imm_11_5  := 0;
   end record
      with  Size        => Instruction'Size,
            Bit_Order   => System.Low_Order_First;

   for S_Format use record
      Opcode   at 0 range 0 .. 6;
      Imm_L    at 0 range 7 .. 11;
      Funct3   at 0 range 12 .. 14;
      Rs1      at 0 range 15 .. 19;
      Rs2      at 0 range 20 .. 24;
      Imm_H    at 0 range 25 .. 31;
   end record;

   type U_Format is record
      Opcode   : Operation := 0;
      Rd       : Register  := 0;
      Imm      : Imm_31_12 := 0;
   end record
      with  Size        => Instruction'Size,
            Bit_Order   => System.Low_Order_First;

   for U_Format use record
      Opcode   at 0 range 0 .. 6;
      Rd       at 0 range 7 .. 11;
      Imm      at 0 range 12 .. 31;
   end record;

   type B_Format is record
      Opcode   : Operation := 0;
      Imm11    : Byte      := 0;
      Imm41    : Imm_4_1   := 0;
      Funct3   : Res3      := 0;
      Rs1      : Register  := 0;
      Rs2      : Register  := 0;
      Imm105   : Imm_10_5  := 0;
      Imm12    : Byte      := 0;
   end record
      with  Size        => Instruction'Size,
            Bit_Order   => System.Low_Order_First;

   for B_Format use record
      Opcode   at 0 range 0 .. 6;
      Imm11    at 0 range 7 .. 7;
      Imm41    at 0 range 8 .. 11;
      Funct3   at 0 range 12 .. 14;
      Rs1      at 0 range 15 .. 19;
      Rs2      at 0 range 20 .. 24;
      Imm105   at 0 range 25 .. 30;
      Imm12    at 0 range 31 .. 31;
   end record;

   type J_Format is record
      Opcode   : Operation := 0;
      Rd       : Register  := 0;
      Imm1912  : Imm_19_12 := 0;
      Imm11    : Byte      := 0;
      Imm101   : Imm_10_1  := 0;
      Imm20    : Imm_20    := 0;
   end record
      with  Size        => Instruction'Size,
            Bit_Order   => System.Low_Order_First;

   for J_Format use record
      Opcode   at 0 range 0 .. 6;
      Rd       at 0 range 7 .. 11;
      Imm1912  at 0 range 12 .. 19;
      Imm11    at 0 range 20 .. 20;
      Imm101   at 0 range 21 .. 30;
      Imm20    at 0 range 31 .. 31;
   end record;

   function Create_I_Immediate (Inst : I_Format) return Immediate;
   function Create_S_Immediate (Inst : S_Format) return Immediate;
   function Create_U_Immediate (Inst : U_Format) return Immediate;
   function Create_B_Immediate (Inst : B_Format) return Immediate;
   function Create_J_Immediate (Inst : J_Format) return Immediate;
   function Extend_Bit (Imm : Immediate; Last_Bit : Immediate; Bits : Immediate) return Immediate;

end RISCV_Base_Instruction_Format;
