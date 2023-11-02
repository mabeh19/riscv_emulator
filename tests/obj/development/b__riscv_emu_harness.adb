pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__riscv_emu_harness.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__riscv_emu_harness.adb");
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
   E189 : Short_Integer; pragma Import (Ada, E189, "gnat_E");
   E124 : Short_Integer; pragma Import (Ada, E124, "ada__streams_E");
   E141 : Short_Integer; pragma Import (Ada, E141, "system__file_control_block_E");
   E140 : Short_Integer; pragma Import (Ada, E140, "system__finalization_root_E");
   E138 : Short_Integer; pragma Import (Ada, E138, "ada__finalization_E");
   E137 : Short_Integer; pragma Import (Ada, E137, "system__file_io_E");
   E184 : Short_Integer; pragma Import (Ada, E184, "system__storage_pools_E");
   E182 : Short_Integer; pragma Import (Ada, E182, "system__finalization_masters_E");
   E220 : Short_Integer; pragma Import (Ada, E220, "system__storage_pools__subpools_E");
   E177 : Short_Integer; pragma Import (Ada, E177, "ada__calendar_E");
   E133 : Short_Integer; pragma Import (Ada, E133, "ada__text_io_E");
   E186 : Short_Integer; pragma Import (Ada, E186, "system__pool_global_E");
   E149 : Short_Integer; pragma Import (Ada, E149, "system__img_llli_E");
   E146 : Short_Integer; pragma Import (Ada, E146, "system__img_lli_E");
   E118 : Short_Integer; pragma Import (Ada, E118, "aunit_E");
   E120 : Short_Integer; pragma Import (Ada, E120, "aunit__memory_E");
   E167 : Short_Integer; pragma Import (Ada, E167, "aunit__memory__utils_E");
   E164 : Short_Integer; pragma Import (Ada, E164, "ada_containers__aunit_lists_E");
   E180 : Short_Integer; pragma Import (Ada, E180, "aunit__tests_E");
   E171 : Short_Integer; pragma Import (Ada, E171, "aunit__time_measure_E");
   E169 : Short_Integer; pragma Import (Ada, E169, "aunit__test_results_E");
   E162 : Short_Integer; pragma Import (Ada, E162, "aunit__assertions_E");
   E158 : Short_Integer; pragma Import (Ada, E158, "aunit__test_filters_E");
   E160 : Short_Integer; pragma Import (Ada, E160, "aunit__simple_test_cases_E");
   E122 : Short_Integer; pragma Import (Ada, E122, "aunit__reporter_E");
   E202 : Short_Integer; pragma Import (Ada, E202, "aunit__reporter__text_E");
   E213 : Short_Integer; pragma Import (Ada, E213, "aunit__test_suites_E");
   E211 : Short_Integer; pragma Import (Ada, E211, "aunit__run_E");
   E218 : Short_Integer; pragma Import (Ada, E218, "riscv_memory_E");
   E216 : Short_Integer; pragma Import (Ada, E216, "riscv_memory_test_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E216 := E216 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "riscv_memory_test__finalize_spec");
      begin
         F1;
      end;
      E213 := E213 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "aunit__test_suites__finalize_spec");
      begin
         F2;
      end;
      E202 := E202 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "aunit__reporter__text__finalize_spec");
      begin
         F3;
      end;
      E158 := E158 - 1;
      E160 := E160 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "aunit__simple_test_cases__finalize_spec");
      begin
         F4;
      end;
      declare
         procedure F5;
         pragma Import (Ada, F5, "aunit__test_filters__finalize_spec");
      begin
         F5;
      end;
      E162 := E162 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "aunit__assertions__finalize_spec");
      begin
         F6;
      end;
      E169 := E169 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "aunit__test_results__finalize_spec");
      begin
         F7;
      end;
      declare
         procedure F8;
         pragma Import (Ada, F8, "aunit__tests__finalize_spec");
      begin
         E180 := E180 - 1;
         F8;
      end;
      E186 := E186 - 1;
      declare
         procedure F9;
         pragma Import (Ada, F9, "system__pool_global__finalize_spec");
      begin
         F9;
      end;
      E133 := E133 - 1;
      declare
         procedure F10;
         pragma Import (Ada, F10, "ada__text_io__finalize_spec");
      begin
         F10;
      end;
      E220 := E220 - 1;
      declare
         procedure F11;
         pragma Import (Ada, F11, "system__storage_pools__subpools__finalize_spec");
      begin
         F11;
      end;
      E182 := E182 - 1;
      declare
         procedure F12;
         pragma Import (Ada, F12, "system__finalization_masters__finalize_spec");
      begin
         F12;
      end;
      declare
         procedure F13;
         pragma Import (Ada, F13, "system__file_io__finalize_body");
      begin
         E137 := E137 - 1;
         F13;
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
      E189 := E189 + 1;
      Ada.Streams'Elab_Spec;
      E124 := E124 + 1;
      System.File_Control_Block'Elab_Spec;
      E141 := E141 + 1;
      System.Finalization_Root'Elab_Spec;
      E140 := E140 + 1;
      Ada.Finalization'Elab_Spec;
      E138 := E138 + 1;
      System.File_Io'Elab_Body;
      E137 := E137 + 1;
      System.Storage_Pools'Elab_Spec;
      E184 := E184 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E182 := E182 + 1;
      System.Storage_Pools.Subpools'Elab_Spec;
      E220 := E220 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E177 := E177 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E133 := E133 + 1;
      System.Pool_Global'Elab_Spec;
      E186 := E186 + 1;
      System.Img_Llli'Elab_Spec;
      E149 := E149 + 1;
      System.Img_Lli'Elab_Spec;
      E146 := E146 + 1;
      E120 := E120 + 1;
      E118 := E118 + 1;
      E167 := E167 + 1;
      E164 := E164 + 1;
      Aunit.Tests'Elab_Spec;
      E180 := E180 + 1;
      Aunit.Time_Measure'Elab_Spec;
      E171 := E171 + 1;
      Aunit.Test_Results'Elab_Spec;
      E169 := E169 + 1;
      Aunit.Assertions'Elab_Spec;
      Aunit.Assertions'Elab_Body;
      E162 := E162 + 1;
      Aunit.Test_Filters'Elab_Spec;
      Aunit.Simple_Test_Cases'Elab_Spec;
      E160 := E160 + 1;
      E158 := E158 + 1;
      Aunit.Reporter'Elab_Spec;
      E122 := E122 + 1;
      Aunit.Reporter.Text'Elab_Spec;
      E202 := E202 + 1;
      Aunit.Test_Suites'Elab_Spec;
      E213 := E213 + 1;
      E211 := E211 + 1;
      E218 := E218 + 1;
      Riscv_Memory_Test'Elab_Spec;
      Riscv_Memory_Test'Elab_Body;
      E216 := E216 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_riscv_emu_harness");

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
   --   /home/mathias/Documents/Ada/riscv_emulator/obj/development/riscv_memory.o
   --   /home/mathias/Documents/Ada/riscv_emulator/tests/obj/development/riscv_memory_test.o
   --   /home/mathias/Documents/Ada/riscv_emulator/tests/obj/development/riscv_emu_suite.o
   --   /home/mathias/Documents/Ada/riscv_emulator/tests/obj/development/riscv_emu_harness.o
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
