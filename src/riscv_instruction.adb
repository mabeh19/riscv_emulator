with Ada.Unchecked_Conversion;
with RISCV_CPU;
with RISCV_Registers;   use RISCV_Registers;
with RISCV_Base_Instruction_Set;
with RISCV_ECALL;
with RISCV_Memory;

package body RISCV_Instruction is

   function To_I_Format is new Ada.Unchecked_Conversion (
      Source => Instruction, 
      Target => I_Format
   );

   function To_J_Format is new Ada.Unchecked_Conversion (
      Source => Instruction, 
      Target => J_Format
   );

   function To_R_Format is new Ada.Unchecked_Conversion (
      Source => Instruction, 
      Target => R_Format
   );

   function To_B_Format is new Ada.Unchecked_Conversion (
      Source => Instruction,
      Target => B_Format
   );

   function To_U_Format is new Ada.Unchecked_Conversion (
      Source => Instruction,
      Target => U_Format
   );

   function To_S_Format is new Ada.Unchecked_Conversion (
      Source => Instruction,
      Target => S_Format
   );

   function Reg_To_Signed is new Ada.Unchecked_Conversion (
      Source => RISCV_Registers.Register,
      Target => Integer
   );

   function Imm_To_Signed is new Ada.Unchecked_Conversion (
      Source => Immediate,
      Target => Integer
   );
   procedure LB (CPU    : out RISCV_CPU.CPU_Context;
                 Inst   : Instruction) is
      Fmt         : I_Format := To_I_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg  : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Imm         : RISCV_Registers.Register := RISCV_Registers.Register (Create_I_Immediate (Fmt));
      Addr        : RISCV_Memory.Address := RISCV_Memory.Address (Source_Reg + Imm);
      Emu_Addr    : RISCV_Memory.Address := RISCV_CPU.Address_To_Emulated_Address (CPU, Addr);

      procedure Load_Byte (Mem : in out RISCV_Memory.Memory) is
         Byte  : Immediate := Immediate (RISCV_Memory.Read_Byte (Mem, Emu_Addr));
      begin
         Dest_Reg := RISCV_Registers.Register (
            RISCV_Base_Instruction_Format.Extend_Bit (
               Byte,
               Byte / (2 ** 15),
               31 - 16
            )
         );   
      end Load_Byte;
   begin
      RISCV_CPU.Mem_Region_RW (CPU, Addr, Load_Byte'Access);
   end LB;

   --  procedure FENCE (CPU    : out RISCV_CPU.CPU_Context;
   --                   Inst   : Instruction);
   procedure ADDI (CPU  : out RISCV_CPU.CPU_Context;
                   Inst : Instruction) is
      Fmt : I_Format := To_I_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg  : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Imm         : Immediate := Create_I_Immediate (Fmt);
   begin
      Dest_Reg := Source_Reg + RISCV_Registers.Register (Imm);
   end ADDI;

   procedure AUIPC (CPU    : out RISCV_CPU.CPU_Context;
                    Inst   : Instruction) is
      Fmt         : U_Format := To_U_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Imm         : Immediate := Create_U_Immediate (Fmt);
   begin
      Dest_Reg := CPU.Core_Registers.PC + RISCV_Registers.Register (Imm);
   end AUIPC;

   procedure SB (CPU    : out RISCV_CPU.CPU_Context;
                 Inst   : Instruction) is
      Fmt      : constant S_Format := To_S_Format (Inst);
      S1_Reg   : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      S2_Reg   : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs2));
      Imm      : constant RISCV_Registers.Register := RISCV_Registers.Register (Create_S_Immediate (Fmt));
      Addr     : constant RISCV_Memory.Address := RISCV_Memory.Address (S1_Reg + Imm);

      procedure Write_Byte (Mem : in out RISCV_MEmory.Memory) is
         Emu_Addr    : constant RISCV_Memory.Address := RISCV_CPU.Address_To_Emulated_Address (CPU, Addr);
      begin
         RISCV_Memory.Write_Byte (Mem, Emu_Addr, RISCV_Memory.Byte (S2_Reg));
      end Write_Byte;
   begin
      RISCV_CPU.Mem_Region_RW (CPU, Addr, Write_Byte'Access);
   end SB;

   procedure ADD (CPU   : out RISCV_CPU.CPU_Context;
                  Inst  : Instruction) is
      Fmt : R_Format := To_R_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg1 : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Source_Reg2 : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs2));
   begin
      Dest_Reg := Source_Reg1 + Source_Reg2;
   end ADD;

   procedure LUI (CPU   : out RISCV_CPU.CPU_Context;
                  Inst  : Instruction) is
      Fmt         : U_Format := To_U_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Imm         : Immediate := Create_U_Immediate (Fmt);
   begin
      Dest_reg := RISCV_Registers.Register (Imm);
   end LUI;

   procedure BEQ (CPU   : out RISCV_CPU.CPU_Context;
                  Inst  : Instruction) is
      Fmt : B_Format := To_B_Format (Inst);
      Imm : Immediate := Create_B_Immediate (Fmt);
      S1_Reg : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      S2_Reg : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs2));
   begin
      if S1_Reg = S2_Reg then
         CPU.Core_Registers.PC := CPU.Core_Registers.PC + 
                                    RISCV_Registers.Register (Imm) - 4;
      end if;
   end BEQ;

   procedure JALR (CPU  : out RISCV_CPU.CPU_Context;
                  Inst  : Instruction) is
      Fmt : I_Format := To_I_Format (Inst);
      Dest_Reg       : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      S1_Reg         : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Imm            : Immediate := Create_I_Immediate (Fmt);
      Dest_Addr      : RISCV_Registers.Register := S1_Reg + RISCV_Registers.Register (Imm);
      Link_Addr      : RISCV_Registers.Register := CPU.Core_Registers.PC + 4;
   begin
      Dest_Reg := Link_Addr;
      CPU.Core_Registers.PC := Dest_Addr - 4;
   end JALR;

   procedure JAL (CPU   : out RISCV_CPU.CPU_Context;
                  Inst  : Instruction) is
      Fmt : J_Format := To_J_Format (Inst);
      Dest_Reg       : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Imm            : Immediate := Create_J_Immediate (Fmt);
      Link_Addr      : RISCV_Registers.Register := CPU.Core_Registers.PC + 4;
   begin
      Dest_Reg := Link_Addr;
      CPU.Core_Registers.PC := CPU.Core_Registers.PC + 
                               RISCV_Registers.Register (Imm) - 4;
   end JAL;
   --  procedure EBREAK (CPU   : out RISCV_CPU.CPU_Context;
   --                    Inst  : Instruction);
   procedure LH (CPU    : out RISCV_CPU.CPU_Context;
                 Inst   : Instruction) is
      Fmt         : I_Format := To_I_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg  : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Imm         : RISCV_Registers.Register := RISCV_Registers.Register (Create_I_Immediate (Fmt));
      Addr        : RISCV_Memory.Address := RISCV_Memory.Address (Source_Reg + Imm);
      Emu_Addr    : RISCV_Memory.Address := RISCV_CPU.Address_To_Emulated_Address (CPU, Addr);

      procedure Load_Half (Mem : in out RISCV_Memory.Memory) is
         Half  : Immediate := Immediate (RISCV_Memory.Read_Half (Mem, Emu_Addr));
      begin
         Dest_Reg := RISCV_Registers.Register (
            RISCV_Base_Instruction_Format.Extend_Bit (
               Half,
               Half / (2 ** 15),
               31 - 16
            )
         );   
      end Load_Half;
   begin
      RISCV_CPU.Mem_Region_RW (CPU, Addr, Load_Half'Access);
   end LH;

   --  procedure FENCEI (CPU   : out RISCV_CPU.CPU_Context;
   --                    Inst  : Instruction);
   procedure SLLI (CPU  : out RISCV_CPU.CPU_Context;
                   Inst : Instruction) is
      Fmt         : I_Format := To_I_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg  : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Imm         : Natural := Natural (Create_I_Immediate (Fmt));
   begin
      Dest_Reg := RISCV_Registers.Register (Natural (Source_Reg) * (2 ** Imm));
   end SLLI;

   procedure SH (CPU    : out RISCV_CPU.CPU_Context;
                 Inst   : Instruction) is
      Fmt      : constant S_Format := To_S_Format (Inst);
      S1_Reg   : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      S2_Reg   : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs2));
      Imm      : constant RISCV_Registers.Register := RISCV_Registers.Register (Create_S_Immediate (Fmt));
      Addr     : constant RISCV_Memory.Address := RISCV_Memory.Address (S1_Reg + Imm);

      procedure Write_Half (Mem : in out RISCV_MEmory.Memory) is
         Emu_Addr    : constant RISCV_Memory.Address := RISCV_CPU.Address_To_Emulated_Address (CPU, Addr);
      begin
         RISCV_Memory.Write_Half (Mem, Emu_Addr, RISCV_Memory.Half (S2_Reg));
      end Write_Half;
   begin
      RISCV_CPU.Mem_Region_RW (CPU, Addr, Write_Half'Access);
   end SH;

   procedure SLL (CPU   : out RISCV_CPU.CPU_Context;
                  Inst  : Instruction) is
      Fmt : R_Format := To_R_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg1 : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Source_Reg2 : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs2));
   begin
      Dest_Reg := RISCV_Registers.Register (Natural (Source_Reg1) * (2 ** Natural (Source_Reg2)));
   end SLL;

   procedure BNE (CPU   : out RISCV_CPU.CPU_Context;
                  Inst  : Instruction) is
      Fmt : B_Format := To_B_Format (Inst);
      Imm : Immediate := Create_B_Immediate (Fmt);
      S1_Reg : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      S2_Reg : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs2));
   begin
      if S1_Reg /= S2_Reg then
         CPU.Core_Registers.PC := CPU.Core_Registers.PC + 
                                    RISCV_Registers.Register (Imm) - 4;
      end if;
   end BNE;

   --  procedure CSRRW (CPU    : out RISCV_CPU.CPU_Context;
   --                   Inst   : Instruction);
   procedure LW (CPU    : out RISCV_CPU.CPU_Context;
                 Inst   : Instruction) is
      Fmt         : I_Format := To_I_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg  : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Imm         : RISCV_Registers.Register := RISCV_Registers.Register (Create_I_Immediate (Fmt));
      Addr        : RISCV_Memory.Address := RISCV_Memory.Address (Source_Reg + Imm);
      Emu_Addr    : RISCV_Memory.Address := RISCV_CPU.Address_To_Emulated_Address (CPU, Addr);

      procedure Load_Word (Mem : in out RISCV_Memory.Memory) is
         Word  : Immediate := Immediate (RISCV_Memory.Read_Word (Mem, Emu_Addr));
      begin
         Dest_Reg := RISCV_Registers.Register (RISCV_Memory.Read_Word (Mem, Emu_Addr));   
      end Load_Word;
   begin
      RISCV_CPU.Mem_Region_RW (CPU, Addr, Load_Word'Access);
   end LW;

   procedure SLTI (CPU  : out RISCV_CPU.CPU_Context;
                   Inst : Instruction) is
      Fmt         : I_Format := To_I_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg  : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Imm         : Immediate := Create_I_Immediate (Fmt);
   begin
      if Integer (Source_Reg) < Integer (Imm) then
         Dest_Reg := 1;
      else
         Dest_Reg := 0;
      end if;
   end SLTI;
 
   procedure SW (CPU    : out RISCV_CPU.CPU_Context;
                 Inst   : Instruction) is
      Fmt      : constant S_Format := To_S_Format (Inst);
      S1_Reg   : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      S2_Reg   : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs2));
      Imm      : constant RISCV_Registers.Register := RISCV_Registers.Register (Create_S_Immediate (Fmt));
      Addr     : constant RISCV_Memory.Address := RISCV_Memory.Address (S1_Reg + Imm);

      procedure Write_Word (Mem : in out RISCV_MEmory.Memory) is
         Emu_Addr    : constant RISCV_Memory.Address := RISCV_CPU.Address_To_Emulated_Address (CPU, Addr);
      begin
         RISCV_Memory.Write_Word (Mem, Emu_Addr, RISCV_Memory.Word (S2_Reg));
      end Write_Word;
   begin
      RISCV_CPU.Mem_Region_RW (CPU, Addr, Write_Word'Access);
   end SW;

   procedure SLT (CPU   : out RISCV_CPU.CPU_Context;
                  Inst  : Instruction) is
      Fmt : R_Format := To_R_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg1 : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Source_Reg2 : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs2));
   begin
      if Integer (Source_Reg1) < Integer (Source_Reg2) then
         Dest_Reg := 1;
      else
         Dest_Reg := 0;
      end if;
   end SLT;

   --  procedure CSRRS (CPU    : out RISCV_CPU.CPU_Context;
   --                   Inst   : Instruction);
   procedure SLTIU (CPU    : out RISCV_CPU.CPU_Context;
                    Inst   : Instruction) is
      Fmt         : I_Format := To_I_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg  : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Imm         : Immediate := Create_I_Immediate (Fmt);
   begin
      if Source_Reg < RISCV_Registers.Register (Imm) then
         Dest_Reg := 1;
      else
         Dest_Reg := 0;
      end if;
   end SLTIU;
 
   procedure SLTU (CPU  : out RISCV_CPU.CPU_Context;
                   Inst : Instruction) is
      Fmt : R_Format := To_R_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg1 : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Source_Reg2 : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs2));
   begin
      if Source_Reg1 < Source_Reg2 then
         Dest_Reg := 1;
      else
         Dest_Reg := 0;
      end if;
   end SLTU;

   --  procedure CSRRC (CPU    : out RISCV_CPU.CPU_Context;
   --                   Inst   : Instruction);
   procedure LBU (CPU   : out RISCV_CPU.CPU_Context;
                  Inst  : Instruction) is
      Fmt         : I_Format := To_I_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg  : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Imm         : RISCV_Registers.Register := RISCV_Registers.Register (Create_I_Immediate (Fmt));
      Addr        : RISCV_Memory.Address := RISCV_Memory.Address (Source_Reg + Imm);

      procedure Load_Byte (Mem : in out RISCV_Memory.Memory) is
         Emu_Addr : RISCV_Memory.Address := RISCV_CPU.Address_To_Emulated_Address (CPU, Addr);
         Byte     : Immediate := Immediate (RISCV_Memory.Read_Byte (Mem, Emu_Addr));
      begin
         Dest_Reg := RISCV_Registers.Register (RISCV_Memory.Read_Byte (Mem, Emu_Addr));
      end Load_Byte;
   begin
      RISCV_CPU.Mem_Region_RW (CPU, Addr, Load_Byte'Access);
   end LBU;

   procedure XORI (CPU  : out RISCV_CPU.CPU_Context;
                   Inst : Instruction) is
      Fmt : I_Format := To_I_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg  : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Imm         : Immediate := Create_I_Immediate (Fmt);
   begin
      Dest_Reg := Source_Reg xor RISCV_Registers.Register (Imm);
   end XORI;
 
   procedure INST_XOR (CPU    : out RISCV_CPU.CPU_Context;
                       Inst   : Instruction) is
      Fmt : R_Format := To_R_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg1 : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Source_Reg2 : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs2));
   begin
      Dest_Reg := Source_Reg1 xor Source_Reg2;
   end INST_XOR;

   procedure BLT (CPU   : out RISCV_CPU.CPU_Context;
                  Inst  : Instruction) is
      Fmt : B_Format := To_B_Format (Inst);
      Imm : Immediate := Create_B_Immediate (Fmt);
      S1_Reg : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      S2_Reg : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs2));
   begin
      if Integer (S1_Reg) < Integer (S2_Reg) then
         CPU.Core_Registers.PC := CPU.Core_Registers.PC + 
                                    RISCV_Registers.Register (Imm) - 4;
      end if;
   end BLT;

   procedure LHU (CPU   : out RISCV_CPU.CPU_Context;
                  Inst  : Instruction) is
      Fmt         : I_Format := To_I_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg  : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Imm         : RISCV_Registers.Register := RISCV_Registers.Register (Create_I_Immediate (Fmt));
      Addr        : RISCV_Memory.Address := RISCV_Memory.Address (Source_Reg + Imm);
      Emu_Addr    : RISCV_Memory.Address := RISCV_CPU.Address_To_Emulated_Address (CPU, Addr);

      procedure Load_Half (Mem : in out RISCV_Memory.Memory) is
         Half  : Immediate := Immediate (RISCV_Memory.Read_Half (Mem, Emu_Addr));
      begin
         Dest_Reg := RISCV_Registers.Register (RISCV_Memory.Read_Half (Mem, Emu_Addr));
      end Load_Half;
   begin
      RISCV_CPU.Mem_Region_RW (CPU, Addr, Load_Half'Access);
   end LHU;

   procedure SRLI (CPU  : out RISCV_CPU.CPU_Context;
                   Inst : Instruction) is
      Fmt : I_Format := To_I_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg  : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Imm         : Natural := Natural (Create_I_Immediate (Fmt));
   begin
      Dest_Reg := RISCV_Registers.Register (Natural (Source_Reg) / (2 ** Imm));
   end SRLI;

   procedure SRL (CPU   : out RISCV_CPU.CPU_Context;
                  Inst  : Instruction) is
      Fmt : R_Format := To_R_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg1 : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Source_Reg2 : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs2));
   begin
      Dest_Reg := RISCV_Registers.Register (Natural (Source_Reg1) / (2 ** Natural (Source_Reg2)));
   end SRL;

   procedure BGE (CPU   : out RISCV_CPU.CPU_Context;
                  Inst  : Instruction) is
      Fmt : B_Format := To_B_Format (Inst);
      Imm : Immediate := Create_B_Immediate (Fmt);
      S1_Reg : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      S2_Reg : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs2));
   begin
      if Integer (S1_Reg) >= Integer (S2_Reg) then
         CPU.Core_Registers.PC := CPU.Core_Registers.PC + 
                                    RISCV_Registers.Register (Imm) - 4;
      end if;
   end BGE;
   --  procedure CSRRWI (CPU   : out RISCV_CPU.CPU_Context;
   --                    Inst  : Instruction);
   procedure ORI (CPU   : out RISCV_CPU.CPU_Context;
                  Inst  : Instruction) is
      Fmt : I_Format := To_I_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg  : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Imm         : Immediate := Create_I_Immediate (Fmt);
   begin
      Dest_Reg := Source_Reg or RISCV_Registers.Register (Imm);
   end ORI;
 
   procedure INST_OR (CPU  : out RISCV_CPU.CPU_Context;
                      Inst : Instruction) is
      Fmt : R_Format := To_R_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg1 : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Source_Reg2 : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs2));
   begin
      Dest_Reg := Source_Reg1 or Source_Reg2;
   end INST_OR;

   procedure BLTU (CPU  : out RISCV_CPU.CPU_Context;
                   Inst : Instruction) is
      Fmt : B_Format := To_B_Format (Inst);
      Imm : Immediate := Create_B_Immediate (Fmt);
      S1_Reg : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      S2_Reg : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs2));
   begin
      if S1_Reg < S2_Reg then
         CPU.Core_Registers.PC := CPU.Core_Registers.PC + 
                                    RISCV_Registers.Register (Imm) - 4;
      end if;
   end BLTU;

   --  procedure CSRRSI (CPU   : out RISCV_CPU.CPU_Context;
   --                    Inst  : Instruction);
   procedure ANDI (CPU  : out RISCV_CPU.CPU_Context;
                   Inst : Instruction) is
      Fmt : I_Format := To_I_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg  : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Imm         : Immediate := Create_I_Immediate (Fmt);
   begin
      Dest_Reg := Source_Reg and RISCV_Registers.Register (Imm);
   end ANDI;
 
   procedure INST_AND (CPU    : out RISCV_CPU.CPU_Context;
                       Inst   : Instruction) is
      Fmt : R_Format := To_R_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg1 : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Source_Reg2 : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs2));
   begin
      Dest_Reg := Source_Reg1 and Source_Reg2;
   end INST_AND;

   procedure BGEU (CPU  : out RISCV_CPU.CPU_Context;
                   Inst : Instruction) is
      Fmt : B_Format := To_B_Format (Inst);
      Imm : Immediate := Create_B_Immediate (Fmt);
      S1_Reg : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      S2_Reg : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs2));
   begin
      if S1_Reg >= S2_Reg then
         CPU.Core_Registers.PC := CPU.Core_Registers.PC + 
                                    RISCV_Registers.Register (Imm) - 4;
      end if;
   end BGEU;
   --  procedure CSRRCI (CPU   : out RISCV_CPU.CPU_Context;
   --                    Inst  : Instruction);
   procedure ECALL (CPU    : out RISCV_CPU.CPU_Context;
                    Inst   : Instruction) is
      Syscall_Num : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (17)); -- a7
      Retval      : Long_Integer;
   begin
      Retval := (case Syscall_Num is
                  when RISCV_Base_instruction_Set.ECALL_WRITE => RISCV_ECALL.E_Write (CPU),
                  when RISCV_Base_Instruction_Set.ECALL_EXIT  => RISCV_ECALL.E_Exit (CPU),
                  when others => -1);
   end ECALL;

   procedure SUB (CPU   : out RISCV_CPU.CPU_Context;
                  Inst  : Instruction) is
      Fmt : R_Format := To_R_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg1 : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Source_Reg2 : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs2));
   begin
      Dest_Reg := Source_Reg1 - Source_Reg2;
   end SUB;

   procedure SRAI (CPU  : out RISCV_CPU.CPU_Context;
                   Inst : Instruction) is
      Fmt : I_Format := To_I_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg  : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Imm         : Immediate := Create_I_Immediate (Fmt) and 16#1F#;
      Is_Negative : Boolean := Reg_to_Signed (Source_Reg) < 0;
   begin
      Dest_Reg := RISCV_Registers.Register'Mod (Reg_To_Signed (Source_Reg) / (2 ** Imm_To_Signed (Imm)));
      
      if Is_Negative then
         declare
            Bits_To_Ignore : RISCV_Registers.Register := RISCV_Registers.Register (2 ** (31 - Natural (Imm)));
            Mask : RISCV_Registers.Register := (16#FFFFFFFF# / Bits_To_Ignore) * Bits_To_Ignore;
         begin
            Dest_Reg := Dest_Reg or Mask;
         end;
      end if;
   end SRAI;
 
   procedure SRA (CPU   : out RISCV_CPU.CPU_Context;
                  Inst  : Instruction) is
      Fmt : R_Format := To_R_Format (Inst);
      Dest_Reg    : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rd));
      Source_Reg1 : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs1));
      Source_Reg2 : RISCV_Registers.Register renames CPU.Core_Registers.X (Integer (Fmt.Rs2));
      Is_Negative : Boolean := Reg_To_Signed (Source_Reg1) < 0;
   begin
      Dest_Reg := RISCV_Registers.Register'Mod (Reg_To_Signed (Source_Reg1) / (2 ** Reg_To_Signed (Source_Reg2)));

      if Is_Negative then
         declare
            Bits_To_Ignore : RISCV_Registers.Register := RISCV_Registers.Register (2 ** (31 - Natural (Source_Reg2)));
            Mask           : RISCV_Registers.Register := (16#FFFFFFFF# / Bits_To_Ignore) * Bits_To_Ignore;
         begin
            Dest_Reg := Dest_Reg or Mask;
         end;
      end if;
   end SRA;

end RISCV_Instruction;
