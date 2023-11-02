pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__tests.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__tests.adb");
pragma Suppress (Overflow_Check);
with Ada.Exceptions;

package body ada_main is

   E077 : Short_Integer; pragma Import (Ada, E077, "system__os_lib_E");
   E016 : Short_Integer; pragma Import (Ada, E016, "ada__exceptions_E");
   E012 : Short_Integer; pragma Import (Ada, E012, "system__soft_links_E");
   E010 : Short_Integer; pragma Import (Ada, E010, "system__exception_table_E");
   E043 : Short_Integer; pragma Import (Ada, E043, "ada__containers_E");
   E072 : Short_Integer; pragma Import (Ada, E072, "ada__io_exceptions_E");
   E025 : Short_Integer; pragma Import (Ada, E025, "ada__numerics_E");
   E007 : Short_Integer; pragma Import (Ada, E007, "ada__strings_E");
   E061 : Short_Integer; pragma Import (Ada, E061, "ada__strings__maps_E");
   E064 : Short_Integer; pragma Import (Ada, E064, "ada__strings__maps__constants_E");
   E048 : Short_Integer; pragma Import (Ada, E048, "interfaces__c_E");
   E019 : Short_Integer; pragma Import (Ada, E019, "system__exceptions_E");
   E086 : Short_Integer; pragma Import (Ada, E086, "system__object_reader_E");
   E055 : Short_Integer; pragma Import (Ada, E055, "system__dwarf_lines_E");
   E100 : Short_Integer; pragma Import (Ada, E100, "system__soft_links__initialize_E");
   E042 : Short_Integer; pragma Import (Ada, E042, "system__traceback__symbolic_E");
   E024 : Short_Integer; pragma Import (Ada, E024, "system__img_int_E");
   E067 : Short_Integer; pragma Import (Ada, E067, "system__img_uns_E");
   E104 : Short_Integer; pragma Import (Ada, E104, "ada__strings__utf_encoding_E");
   E112 : Short_Integer; pragma Import (Ada, E112, "ada__tags_E");
   E005 : Short_Integer; pragma Import (Ada, E005, "ada__strings__text_buffers_E");
   E190 : Short_Integer; pragma Import (Ada, E190, "gnat_E");
   E125 : Short_Integer; pragma Import (Ada, E125, "ada__streams_E");
   E142 : Short_Integer; pragma Import (Ada, E142, "system__file_control_block_E");
   E141 : Short_Integer; pragma Import (Ada, E141, "system__finalization_root_E");
   E139 : Short_Integer; pragma Import (Ada, E139, "ada__finalization_E");
   E138 : Short_Integer; pragma Import (Ada, E138, "system__file_io_E");
   E185 : Short_Integer; pragma Import (Ada, E185, "system__storage_pools_E");
   E183 : Short_Integer; pragma Import (Ada, E183, "system__finalization_masters_E");
   E225 : Short_Integer; pragma Import (Ada, E225, "ada__strings__text_buffers__unbounded_E");
   E253 : Short_Integer; pragma Import (Ada, E253, "system__storage_pools__subpools_E");
   E178 : Short_Integer; pragma Import (Ada, E178, "ada__calendar_E");
   E134 : Short_Integer; pragma Import (Ada, E134, "ada__text_io_E");
   E187 : Short_Integer; pragma Import (Ada, E187, "system__pool_global_E");
   E150 : Short_Integer; pragma Import (Ada, E150, "system__img_llli_E");
   E147 : Short_Integer; pragma Import (Ada, E147, "system__img_lli_E");
   E119 : Short_Integer; pragma Import (Ada, E119, "aunit_E");
   E121 : Short_Integer; pragma Import (Ada, E121, "aunit__memory_E");
   E168 : Short_Integer; pragma Import (Ada, E168, "aunit__memory__utils_E");
   E165 : Short_Integer; pragma Import (Ada, E165, "ada_containers__aunit_lists_E");
   E181 : Short_Integer; pragma Import (Ada, E181, "aunit__tests_E");
   E172 : Short_Integer; pragma Import (Ada, E172, "aunit__time_measure_E");
   E170 : Short_Integer; pragma Import (Ada, E170, "aunit__test_results_E");
   E163 : Short_Integer; pragma Import (Ada, E163, "aunit__assertions_E");
   E159 : Short_Integer; pragma Import (Ada, E159, "aunit__test_filters_E");
   E161 : Short_Integer; pragma Import (Ada, E161, "aunit__simple_test_cases_E");
   E123 : Short_Integer; pragma Import (Ada, E123, "aunit__reporter_E");
   E203 : Short_Integer; pragma Import (Ada, E203, "aunit__reporter__text_E");
   E221 : Short_Integer; pragma Import (Ada, E221, "aunit__test_cases_E");
   E214 : Short_Integer; pragma Import (Ada, E214, "aunit__test_suites_E");
   E212 : Short_Integer; pragma Import (Ada, E212, "aunit__run_E");
   E219 : Short_Integer; pragma Import (Ada, E219, "riscv_base_instruction_format_E");
   E217 : Short_Integer; pragma Import (Ada, E217, "riscv_base_instruction_format_test_E");
   E235 : Short_Integer; pragma Import (Ada, E235, "riscv_memory_E");
   E251 : Short_Integer; pragma Import (Ada, E251, "riscv_memory_test_E");
   E237 : Short_Integer; pragma Import (Ada, E237, "riscv_registers_E");
   E233 : Short_Integer; pragma Import (Ada, E233, "riscv_cpu_E");
   E239 : Short_Integer; pragma Import (Ada, E239, "riscv_ecall_E");
   E231 : Short_Integer; pragma Import (Ada, E231, "riscv_instruction_E");
   E229 : Short_Integer; pragma Import (Ada, E229, "riscv_base_instruction_set_E");
   E223 : Short_Integer; pragma Import (Ada, E223, "riscv_base_instruction_set_test_E");
   E241 : Short_Integer; pragma Import (Ada, E241, "riscv_instruction_add_test_E");
   E243 : Short_Integer; pragma Import (Ada, E243, "riscv_instruction_addi_test_E");
   E245 : Short_Integer; pragma Import (Ada, E245, "riscv_instruction_jal_test_E");
   E247 : Short_Integer; pragma Import (Ada, E247, "riscv_instruction_sra_test_E");
   E249 : Short_Integer; pragma Import (Ada, E249, "riscv_instruction_sub_test_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E249 := E249 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "riscv_instruction_sub_test__finalize_spec");
      begin
         F1;
      end;
      E247 := E247 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "riscv_instruction_sra_test__finalize_spec");
      begin
         F2;
      end;
      E245 := E245 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "riscv_instruction_jal_test__finalize_spec");
      begin
         F3;
      end;
      E243 := E243 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "riscv_instruction_addi_test__finalize_spec");
      begin
         F4;
      end;
      E241 := E241 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "riscv_instruction_add_test__finalize_spec");
      begin
         F5;
      end;
      E223 := E223 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "riscv_base_instruction_set_test__finalize_spec");
      begin
         F6;
      end;
      E251 := E251 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "riscv_memory_test__finalize_spec");
      begin
         F7;
      end;
      E217 := E217 - 1;
      declare
         procedure F8;
         pragma Import (Ada, F8, "riscv_base_instruction_format_test__finalize_spec");
      begin
         F8;
      end;
      E214 := E214 - 1;
      declare
         procedure F9;
         pragma Import (Ada, F9, "aunit__test_suites__finalize_spec");
      begin
         F9;
      end;
      E221 := E221 - 1;
      declare
         procedure F10;
         pragma Import (Ada, F10, "aunit__test_cases__finalize_spec");
      begin
         F10;
      end;
      E203 := E203 - 1;
      declare
         procedure F11;
         pragma Import (Ada, F11, "aunit__reporter__text__finalize_spec");
      begin
         F11;
      end;
      E159 := E159 - 1;
      E161 := E161 - 1;
      declare
         procedure F12;
         pragma Import (Ada, F12, "aunit__simple_test_cases__finalize_spec");
      begin
         F12;
      end;
      declare
         procedure F13;
         pragma Import (Ada, F13, "aunit__test_filters__finalize_spec");
      begin
         F13;
      end;
      E163 := E163 - 1;
      declare
         procedure F14;
         pragma Import (Ada, F14, "aunit__assertions__finalize_spec");
      begin
         F14;
      end;
      E170 := E170 - 1;
      declare
         procedure F15;
         pragma Import (Ada, F15, "aunit__test_results__finalize_spec");
      begin
         F15;
      end;
      declare
         procedure F16;
         pragma Import (Ada, F16, "aunit__tests__finalize_spec");
      begin
         E181 := E181 - 1;
         F16;
      end;
      E187 := E187 - 1;
      declare
         procedure F17;
         pragma Import (Ada, F17, "system__pool_global__finalize_spec");
      begin
         F17;
      end;
      E134 := E134 - 1;
      declare
         procedure F18;
         pragma Import (Ada, F18, "ada__text_io__finalize_spec");
      begin
         F18;
      end;
      E253 := E253 - 1;
      declare
         procedure F19;
         pragma Import (Ada, F19, "system__storage_pools__subpools__finalize_spec");
      begin
         F19;
      end;
      E225 := E225 - 1;
      declare
         procedure F20;
         pragma Import (Ada, F20, "ada__strings__text_buffers__unbounded__finalize_spec");
      begin
         F20;
      end;
      E183 := E183 - 1;
      declare
         procedure F21;
         pragma Import (Ada, F21, "system__finalization_masters__finalize_spec");
      begin
         F21;
      end;
      declare
         procedure F22;
         pragma Import (Ada, F22, "system__file_io__finalize_body");
      begin
         E138 := E138 - 1;
         F22;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (Ada, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;
   pragma Favor_Top_Level (No_Param_Proc);

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Exception_Tracebacks : Integer;
      pragma Import (C, Exception_Tracebacks, "__gl_exception_tracebacks");
      Exception_Tracebacks_Symbolic : Integer;
      pragma Import (C, Exception_Tracebacks_Symbolic, "__gl_exception_tracebacks_symbolic");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Exception_Tracebacks := 1;
      Exception_Tracebacks_Symbolic := 1;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      Ada.Exceptions'Elab_Spec;
      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E010 := E010 + 1;
      Ada.Containers'Elab_Spec;
      E043 := E043 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E072 := E072 + 1;
      Ada.Numerics'Elab_Spec;
      E025 := E025 + 1;
      Ada.Strings'Elab_Spec;
      E007 := E007 + 1;
      Ada.Strings.Maps'Elab_Spec;
      E061 := E061 + 1;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E064 := E064 + 1;
      Interfaces.C'Elab_Spec;
      E048 := E048 + 1;
      System.Exceptions'Elab_Spec;
      E019 := E019 + 1;
      System.Object_Reader'Elab_Spec;
      E086 := E086 + 1;
      System.Dwarf_Lines'Elab_Spec;
      System.Os_Lib'Elab_Body;
      E077 := E077 + 1;
      System.Soft_Links.Initialize'Elab_Body;
      E100 := E100 + 1;
      E012 := E012 + 1;
      System.Traceback.Symbolic'Elab_Body;
      E042 := E042 + 1;
      System.Img_Int'Elab_Spec;
      E024 := E024 + 1;
      E016 := E016 + 1;
      System.Img_Uns'Elab_Spec;
      E067 := E067 + 1;
      E055 := E055 + 1;
      Ada.Strings.Utf_Encoding'Elab_Spec;
      E104 := E104 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E112 := E112 + 1;
      Ada.Strings.Text_Buffers'Elab_Spec;
      E005 := E005 + 1;
      Gnat'Elab_Spec;
      E190 := E190 + 1;
      Ada.Streams'Elab_Spec;
      E125 := E125 + 1;
      System.File_Control_Block'Elab_Spec;
      E142 := E142 + 1;
      System.Finalization_Root'Elab_Spec;
      E141 := E141 + 1;
      Ada.Finalization'Elab_Spec;
      E139 := E139 + 1;
      System.File_Io'Elab_Body;
      E138 := E138 + 1;
      System.Storage_Pools'Elab_Spec;
      E185 := E185 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E183 := E183 + 1;
      Ada.Strings.Text_Buffers.Unbounded'Elab_Spec;
      E225 := E225 + 1;
      System.Storage_Pools.Subpools'Elab_Spec;
      E253 := E253 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E178 := E178 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E134 := E134 + 1;
      System.Pool_Global'Elab_Spec;
      E187 := E187 + 1;
      System.Img_Llli'Elab_Spec;
      E150 := E150 + 1;
      System.Img_Lli'Elab_Spec;
      E147 := E147 + 1;
      E121 := E121 + 1;
      E119 := E119 + 1;
      E168 := E168 + 1;
      E165 := E165 + 1;
      Aunit.Tests'Elab_Spec;
      E181 := E181 + 1;
      Aunit.Time_Measure'Elab_Spec;
      E172 := E172 + 1;
      Aunit.Test_Results'Elab_Spec;
      E170 := E170 + 1;
      Aunit.Assertions'Elab_Spec;
      Aunit.Assertions'Elab_Body;
      E163 := E163 + 1;
      Aunit.Test_Filters'Elab_Spec;
      Aunit.Simple_Test_Cases'Elab_Spec;
      E161 := E161 + 1;
      E159 := E159 + 1;
      Aunit.Reporter'Elab_Spec;
      E123 := E123 + 1;
      Aunit.Reporter.Text'Elab_Spec;
      E203 := E203 + 1;
      Aunit.Test_Cases'Elab_Spec;
      E221 := E221 + 1;
      Aunit.Test_Suites'Elab_Spec;
      E214 := E214 + 1;
      E212 := E212 + 1;
      E219 := E219 + 1;
      Riscv_Base_Instruction_Format_Test'Elab_Spec;
      Riscv_Base_Instruction_Format_Test'Elab_Body;
      E217 := E217 + 1;
      E235 := E235 + 1;
      Riscv_Memory_Test'Elab_Spec;
      Riscv_Memory_Test'Elab_Body;
      E251 := E251 + 1;
      E237 := E237 + 1;
      E239 := E239 + 1;
      E229 := E229 + 1;
      E233 := E233 + 1;
      E231 := E231 + 1;
      Riscv_Base_Instruction_Set_Test'Elab_Spec;
      Riscv_Base_Instruction_Set_Test'Elab_Body;
      E223 := E223 + 1;
      Riscv_Instruction_Add_Test'Elab_Spec;
      Riscv_Instruction_Add_Test'Elab_Body;
      E241 := E241 + 1;
      Riscv_Instruction_Addi_Test'Elab_Spec;
      Riscv_Instruction_Addi_Test'Elab_Body;
      E243 := E243 + 1;
      Riscv_Instruction_Jal_Test'Elab_Spec;
      Riscv_Instruction_Jal_Test'Elab_Body;
      E245 := E245 + 1;
      Riscv_Instruction_Sra_Test'Elab_Spec;
      Riscv_Instruction_Sra_Test'Elab_Body;
      E247 := E247 + 1;
      Riscv_Instruction_Sub_Test'Elab_Spec;
      Riscv_Instruction_Sub_Test'Elab_Body;
      E249 := E249 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_tests");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      if gnat_argc = 0 then
         gnat_argc := argc;
         gnat_argv := argv;
      end if;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   /home/mathias/Documents/Ada/riscv_emulator/obj/development/riscv_base_instruction_format.o
   --   /home/mathias/Documents/Ada/riscv_emulator/tests/obj/development/riscv_base_instruction_format_test.o
   --   /home/mathias/Documents/Ada/riscv_emulator/obj/development/riscv_memory.o
   --   /home/mathias/Documents/Ada/riscv_emulator/tests/obj/development/riscv_memory_test.o
   --   /home/mathias/Documents/Ada/riscv_emulator/obj/development/riscv_registers.o
   --   /home/mathias/Documents/Ada/riscv_emulator/obj/development/riscv_ecall.o
   --   /home/mathias/Documents/Ada/riscv_emulator/obj/development/riscv_base_instruction_set.o
   --   /home/mathias/Documents/Ada/riscv_emulator/obj/development/riscv_cpu.o
   --   /home/mathias/Documents/Ada/riscv_emulator/obj/development/riscv_instruction.o
   --   /home/mathias/Documents/Ada/riscv_emulator/tests/obj/development/riscv_base_instruction_set_test.o
   --   /home/mathias/Documents/Ada/riscv_emulator/tests/obj/development/riscv_instruction_add_test.o
   --   /home/mathias/Documents/Ada/riscv_emulator/tests/obj/development/riscv_instruction_addi_test.o
   --   /home/mathias/Documents/Ada/riscv_emulator/tests/obj/development/riscv_instruction_jal_test.o
   --   /home/mathias/Documents/Ada/riscv_emulator/tests/obj/development/riscv_instruction_sra_test.o
   --   /home/mathias/Documents/Ada/riscv_emulator/tests/obj/development/riscv_instruction_sub_test.o
   --   /home/mathias/Documents/Ada/riscv_emulator/tests/obj/development/riscv_emu_suite.o
   --   /home/mathias/Documents/Ada/riscv_emulator/tests/obj/development/riscv_emu_harness.o
   --   /home/mathias/Documents/Ada/riscv_emulator/tests/obj/development/tests.o
   --   -L/home/mathias/Documents/Ada/riscv_emulator/tests/obj/development/
   --   -L/home/mathias/Documents/Ada/riscv_emulator/tests/obj/development/
   --   -L/home/mathias/Documents/Ada/riscv_emulator/tests/alire/cache/dependencies/aunit_22.0.0_cbd7a80a/lib/aunit/native-full/
   --   -L/home/mathias/Documents/Ada/riscv_emulator/obj/development/
   --   -L/usr/lib/gcc/x86_64-pc-linux-gnu/13.2.1/adalib/
   --   -static
   --   -lgnat
   --   -ldl
--  END Object file/option list   

end ada_main;
