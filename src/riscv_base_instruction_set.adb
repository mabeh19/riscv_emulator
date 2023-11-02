with Ada.Unchecked_Conversion;
with Ada.Text_IO;
with RISCV_Base_Instruction_Format; use RISCV_Base_Instruction_Format;

package body RISCV_Base_Instruction_Set is

   function Get_Instruction_Executor (Instr : Instruction) return Instruction_Executor is
      Unknown_Instruction : exception;

      --  Op          : Instruction := Instr and 16#3F#;
      --  Extended_Op : Instruction := Op + ((Instr and 16#700#) / (2 ** 5));
      --  R_Type_Op   : Instruction := Extended_Op + ((Instr and 16#FE00_0000#) / (2 ** (5 + 5)));
      --  Special_Op  : Instruction := R_Type_Op + (Instr and 2 ** 20) / (2 ** (5 + 5));
      Func        : Instruction_Executor;
   begin
      --  First try short opcode
      Func := Try_Get_U_J_Executor (Get_Opcode (Instr));
      if Func /= null then
         return Func;
      end if;

      --  Then try R type opcode
      Func := Try_Get_R_Executor (Instr);
      if Func /= null then
         return Func;
      end if;

      --  Then try extended (I, S and B type) opcode
      Func := Try_Get_I_S_B_Executor (Instr);
      if Func /= null then
         return Func;
      end if;
      
      --  Finally try ecall/ebreak
      Func := Try_Get_System_Executor (Get_Special_Opcode (instr));
      if Func /= null then
         return Func;
      end if;

      return null;
   end Get_Instruction_Executor;


   function Try_Get_U_J_Executor (Opcode : Instruction) return Instruction_Executor is
      Op : Base_Instruction_Set;
   begin
      Op := Base_Instruction_Set'Enum_Val (Opcode);
      if U_Instruction (Op) or J_Instruction (Op) then
         return Instruction_Executors (Op);
      end if;

      return null;
   exception
      when others =>
         return null;
   end Try_Get_U_J_Executor;

   function Try_Get_R_Executor (Opcode : Instruction) return Instruction_Executor is
      Extended_Opcode : Instruction := Get_R_Type_Opcode (Opcode);
      Op : Base_Instruction_Set;
   begin
      Op := Base_Instruction_Set'Enum_Val (Extended_Opcode);
      if R_Instruction (Op) then
          --  Perform check to see if this is logic or arithmetic shift
         if Op = srl and Opcode > 2 ** 30 then
            Op := sra;
         end if;
         return Instruction_Executors (Op);
      end if;

      return null;
   exception
      when others =>
         return null;
   end Try_Get_R_Executor;

   function Try_Get_I_S_B_Executor (Opcode : Instruction) return Instruction_Executor is
      Extended_Opcode : Instruction := Get_Extended_Opcode (Opcode);
      Op : Base_Instruction_Set;
   begin
      Op := Base_Instruction_Set'Enum_Val (Extended_Opcode);
      if I_Instruction (Op) or S_Instruction (Op) or B_Instruction (Op) then
         --  Perform check to see if this is logic or arithmetic shift
         if Op = srli and Opcode > 2 ** 30 then
            Op := srai;
         end if;
         return Instruction_Executors (Op);
      end if;

      return null;
   exception
      when others =>
         return null;
   end Try_Get_I_S_B_Executor;

   function Try_Get_System_Executor (Opcode : Instruction) return Instruction_Executor is
      Op : Base_Instruction_Set;
   begin
      Op := Base_Instruction_Set'Enum_Val (Opcode);
      if CSR_Instruction (Op) or Special_Instruction (Op) then
         return Instruction_Executors (Op);
      end if;

      return null;
   exception
      when others =>
         return null;
   end Try_Get_System_Executor;

   function Get_Executor_From_Opcode (Opcode : Instruction) return Instruction_Executor is
   begin
      return Instruction_Executors (Base_Instruction_Set'Enum_Val (Opcode));
   exception
      when others =>
         return null;
   end Get_Executor_From_Opcode;

   function Get_Opcode (Instr : Instruction) return Instruction is
   begin
      return Instr and 16#7F#;
   end Get_Opcode;

   function Get_Extended_Opcode (Instr : Instruction) return Instruction is
   begin
      return Get_Opcode (Instr) + ((Instr and 16#7000#) / (2 ** 5));
   end Get_Extended_Opcode;

   function Get_R_Type_Opcode (Instr : Instruction) return Instruction is
   begin
      return Get_Extended_Opcode (Instr) + ((Instr and 16#FE00_0000#) / (2 ** (5 + 5)));
   end Get_R_Type_Opcode;

   function Get_Special_Opcode (Instr : Instruction) return Instruction is
   begin
      return Get_R_Type_Opcode (Instr) + ((Instr and (2 ** 20)) / (2 ** (5 + 5)));
   end Get_Special_Opcode;

end RISCV_Base_Instruction_Set;
