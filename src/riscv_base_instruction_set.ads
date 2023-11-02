with RISCV_Base_Instruction_Format; use RISCV_Base_Instruction_Format;
with RISCV_CPU;
with RISCV_Instruction;
with RISCV_Registers;

package RISCV_Base_Instruction_Set is

   type Base_Instruction_Set is (
      lb,
      fence,
      addi,
      auipc,
      sb,
      add,
      lui,
      beq,
      jalr,
      jal,
      ecall,
      lh,
      fenceI,
      slli,
      sh,
      sll,
      bne,
      csrrw,
      lw,
      slti,
      sw,
      slt,
      csrrs,
      sltiu,
      sltu,
      csrrc,
      lbu,
      xori,
      inst_xor,
      blt,
      lhu,
      srli,
      srl,
      bge,
      csrrwi,
      ori,
      inst_or ,
      bltu,
      csrrsi,
      andi,
      inst_and,
      bgeu,
      csrrci,
      ebreak,
      sub,
      srai,
      sra
   );

   for Base_Instruction_Set use (
      lb       => 2#000_000_0011#,
      fence    => 2#000_000_1111#,
      addi     => 2#000_001_0011#,
      auipc    => 2#001_0111#,
      sb       => 2#000_010_0011#,
      add      => 2#000_011_0011#,
      lui      => 2#011_0111#,
      beq      => 2#000_110_0011#,
      jalr     => 2#000_110_0111#,
      jal      => 2#110_1111#,
      ecall    => 2#000_111_0011#,
      lh       => 2#001_000_0011#,
      fenceI   => 2#001_000_1111#,
      slli     => 2#001_001_0011#,
      sh       => 2#001_010_0011#,
      sll      => 2#001_011_0011#,
      bne      => 2#001_110_0011#,
      csrrw    => 2#001_111_0011#,
      lw       => 2#010_000_0011#,
      slti     => 2#010_001_0011#,
      sw       => 2#010_010_0011#,
      slt      => 2#010_011_0011#,
      csrrs    => 2#010_111_0011#,
      sltiu    => 2#011_001_0011#,
      sltu     => 2#011_011_0011#,
      csrrc    => 2#011_111_0011#,
      lbu      => 2#100_000_0011#,
      xori     => 2#100_001_0011#,
      inst_xor => 2#100_011_0011#,
      blt      => 2#100_110_0011#,
      lhu      => 2#101_000_0011#,
      srli     => 2#101_001_0011#,
      srl      => 2#101_011_0011#,
      bge      => 2#101_110_0011#,
      csrrwi   => 2#101_111_0011#,
      ori      => 2#110_001_0011#,
      inst_or  => 2#110_011_0011#,
      bltu     => 2#110_110_0011#,
      csrrsi   => 2#110_111_0011#,
      andi     => 2#111_001_0011#,
      inst_and => 2#111_011_0011#,
      bgeu     => 2#111_110_0011#,
      csrrci   => 2#111_111_0011#,

      --  Extra extended
      ebreak   => 2#000000000001_000_111_0011#,
      sub      => 2#010000000000_000_011_0011#,
      srai     => 2#010000000000_101_001_0011#,
      sra      => 2#010000000000_101_011_0011#
   );

   type Instruction_Subset is array (Base_Instruction_Set) of Boolean; --Base_Instruction_Set range jalr .. srai;
   
   I_Instruction : constant Instruction_Subset := [
      jalr  => True, 
      lb    => True,
      lh    => True,
      lw    => True,
      lbu   => True,
      lhu   => True,
      addi  => True,
      slti  => True,
      slli  => True,
      srai  => True,
      srli  => True,
      sltiu => True,
      xori  => True,
      ori   => True,
      andi  => True,
      others => False
   ];
   R_Instruction : constant Instruction_Subset := [
      add      => True,
      sub      => True,
      sll      => True,
      slt      => True,
      sltu     => True,
      inst_xor => True,
      srl      => True,
      sra      => True,
      inst_or  => True,
      inst_and => True,
      others   => False
   ];
   S_Instruction : constant Instruction_Subset := [
      sb    => True,
      sh    => True,
      sw    => True,
      others => False
   ];
   B_Instruction : constant Instruction_Subset := [
      beq   => True,
      bne   => True,
      blt   => True,
      bge   => True,
      bltu  => True,
      bgeu  => True,

      others => False
   ];
   U_Instruction : constant Instruction_Subset := [
      lui      => True,
      auipc    => True,
      others   => False
   ];
   J_Instruction : constant Instruction_Subset := [
      jal      => True,
      others   => False
   ];
   Special_Instruction : constant Instruction_Subset := [
      fence    => True,
      fenceI   => True,
      ecall    => True,
      ebreak   => True,
      others   => False
   ];
   CSR_Instruction : constant Instruction_Subset := [
      csrrw    => True,
      csrrs    => True,
      csrrc    => True,
      csrrwi   => True,
      csrrsi   => True,
      csrrci   => True,
      others => False
   ];


   --
   --  ECALL Table
   --
   ECALL_WRITE : constant RISCV_Registers.Register := 64;
   ECALL_EXIT  : constant RISCV_Registers.Register := 93;

   --
   --  Procs
   --
   type Instruction_Executor is access procedure (CPU : out RISCV_CPU.Cpu_Context; Instr : Instruction);

   function Get_Instruction_Executor (Instr : RISCV_Base_Instruction_Format.Instruction) return Instruction_Executor;

   function Get_Opcode (Instr : RISCV_Base_Instruction_Format.Instruction) return Instruction;
   function Get_Extended_Opcode (Instr : RISCV_Base_Instruction_Format.Instruction) return Instruction;
   function Get_R_Type_Opcode (Instr : RISCV_Base_Instruction_Format.Instruction) return Instruction;
   function Get_Special_Opcode (Instr : RISCV_Base_Instruction_Format.Instruction) return Instruction;
  
private

   function Get_Executor_From_Opcode (Opcode : Instruction) return Instruction_Executor;
   function Try_Get_U_J_Executor (Opcode : Instruction) return Instruction_Executor;
   function Try_Get_R_Executor (Opcode : Instruction) return Instruction_Executor;
   function Try_Get_I_S_B_Executor (Opcode : Instruction) return Instruction_Executor;
   function Try_Get_System_Executor (Opcode : Instruction) return Instruction_Executor;

   type Instruction_Set is array (Base_Instruction_Set) of Instruction_Executor;
   
   --
   --  Instruction Executors
   --  Function pointers defined in RISCV_Instruction
   --
   Instruction_Executors : Instruction_Set := (
      addi     => RISCV_Instruction.ADDI'Access,
      auipc    => RISCV_Instruction.AUIPC'Access,
      add      => RISCV_Instruction.ADD'Access,
      lui      => RISCV_Instruction.LUI'Access,
      beq      => RISCV_Instruction.BEQ'Access,
      jalr     => RISCV_Instruction.JALR'Access,
      jal      => RISCV_Instruction.JAL'Access,
      slli     => RISCV_Instruction.SLLI'Access,
      sll      => RISCV_Instruction.SLL'Access,
      bne      => RISCV_Instruction.BNE'Access,
      slti     => RISCV_Instruction.SLTI'Access,
      slt      => RISCV_Instruction.SLT'Access,
      sltiu    => RISCV_Instruction.SLTIU'Access,
      XORI     => RISCV_Instruction.XORI'Access,
      inst_xor => RISCV_Instruction.INST_XOR'Access,
      blt      => RISCV_Instruction.BLT'Access,
      srli     => RISCV_Instruction.SRLI'Access,
      srl      => RISCV_Instruction.SRL'Access,
      bge      => RISCV_Instruction.BGE'Access,
      ori      => RISCV_Instruction.ORI'Access,
      inst_or  => RISCV_Instruction.INST_OR'Access,
      bltu     => RISCV_Instruction.BLTU'Access,
      andi     => RISCV_Instruction.ANDI'Access,
      inst_and => RISCV_Instruction.INST_AND'Access,
      bgeu     => RISCV_Instruction.BGEU'Access,
      ecall    => RISCV_Instruction.ECALL'Access,
      sub      => RISCV_Instruction.SUB'Access,
      srai     => RISCV_Instruction.SRAI'Access,
      sra      => RISCV_Instruction.SRA'Access,
      lb       => RISCV_Instruction.LB'Access,
      lbu      => RISCV_Instruction.LBU'Access,
      lh       => RISCV_Instruction.LH'Access,
      lhu      => RISCV_Instruction.LHU'Access,
      lw       => RISCV_Instruction.LW'Access,
      sw       => RISCV_Instruction.SW'Access,
      sb       => RISCV_Instruction.SB'Access,
      sh       => RISCV_Instruction.SH'Access,
      others   => null
   );
   
end RISCV_Base_Instruction_Set;
