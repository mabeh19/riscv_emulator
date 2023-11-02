with RISCV_CPU;

package RISCV_ECALL is

   function E_Write (CPU : in RISCV_CPU.CPU_Context) return Long_Integer;
   function E_Exit  (CPU : out RISCV_CPU.CPU_Context) return Long_Integer;

end RISCV_ECALL;
