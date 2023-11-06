with Ada.Text_IO;
with Ada.Unchecked_Conversion;
with RISCV_Registers;
with RISCV_CPU;
with RISCV_Memory;      use RISCV_Memory;

package body RISCV_ECALL is

   FD_STDIN    : constant Integer := 0;
   FD_STDOUT   : constant Integer := 1;
   FD_STDERR   : constant Integer := 2;

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

      if Integer (FD) = FD_STDOUT then
         Ada.Text_IO.Put (S);
      end if;

      return Long_Integer (Count);
   end E_Write;

   function E_Read (CPU : in out RISCV_CPU.CPU_Context) return Long_Integer is
      FD    : RISCV_Registers.Register renames CPU.Core_Registers.X (10);  --  a0: fd
      Buf   : RISCV_Registers.Register renames CPU.Core_Registers.X (11);  --  a1: buffer
      Len   : RISCV_Registers.Register renames CPU.Core_Registers.X (12);  --  a2: length of buffer

      Emulated_Address : Address := RISCV_CPU.Address_To_Emulated_Address (CPU, Address (Buf));

      procedure Do_Read (Mem : in out Memory) is
         S : String (1 .. Integer (Len));
      begin
         Ada.Text_IO.Get (S);

         for Idx in 1 .. Address (Len) loop
            Mem (Emulated_Address + Idx - 1) := Byte (Character'Pos (S (Integer (Idx))));
         end loop;
      end Do_Read;
   begin
      RISCV_CPU.Mem_Region_RW (CPU, Address (Buf), Do_Read'Access);

      return Long_Integer (Len);
   end E_Read;

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
