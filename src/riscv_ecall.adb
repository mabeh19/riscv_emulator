with Ada.Text_IO;
with Ada.Unchecked_Conversion;
with RISCV_Registers;
with RISCV_CPU;
with RISCV_Memory;      use RISCV_Memory;

package body RISCV_ECALL is
 
   function E_Write (CPU : in RISCV_CPU.CPU_Context) return Long_Integer is
      FD    : RISCV_Registers.Register renames CPU.Core_Registers.X (10);  --  a0: int fd
      S_Loc : RISCV_Registers.Register renames CPU.Core_Registers.X (11);  --  a1: const char* buf
      Count : RISCV_Registers.Register renames CPU.Core_Registers.X (12);  --  a2: size_t count
      S     : String (1 .. Integer (Count));

      Emulated_Address : Address := RISCV_CPU.Address_To_Emulated_Address (CPU, Address (S_Loc));
   begin
      if Emulated_Address in Flash_Address then
         for Idx in 0 .. Integer (Count) - 1 loop
            S (Idx + 1) := Character'Val (CPU.ROM (Address (Idx) + Emulated_Address));
         end loop;
      elsif Emulated_Address in RAM_Address then
         for Idx in 0 .. Integer (Count) - 1 loop
            S (Idx + 1) := Character'Val (CPU.RAM (Address (Idx) + Emulated_Address));
         end loop;
      end if;

      Ada.Text_IO.Put (S);

      return Long_Integer (Count);
   end E_Write;

   function E_Exit  (CPU : out RISCV_CPU.CPU_Context) return Long_Integer is
      function To_Signed is new Ada.Unchecked_Conversion (
         Source => RISCV_Registers.Register,
         Target => Integer
      );
      Error_Code : RISCV_Registers.Register renames CPU.Core_Registers.X (10);   -- a0 int error_code
   begin
      Ada.Text_IO.Put_Line ("Exit with:" & To_Signed (Error_Code)'Image);
      CPU.Should_Quit := True;
      return 0;
   end E_Exit;

end RISCV_ECALL;
