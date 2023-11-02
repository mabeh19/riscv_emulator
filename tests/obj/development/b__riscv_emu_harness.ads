pragma Warnings (Off);
pragma Ada_95;
with System;
with System.Parameters;
with System.Secondary_Stack;
package ada_main is

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: 13.2.1 20230801" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   GNAT_Version_Address : constant System.Address := GNAT_Version'Address;
   pragma Export (C, GNAT_Version_Address, "__gnat_version_address");

   Ada_Main_Program_Name : constant String := "_ada_riscv_emu_harness" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#b0c68f1f#;
   pragma Export (C, u00001, "riscv_emu_harnessB");
   u00002 : constant Version_32 := 16#7320ff5f#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#50630821#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#a201b8c5#;
   pragma Export (C, u00004, "ada__strings__text_buffersB");
   u00005 : constant Version_32 := 16#a7cfd09b#;
   pragma Export (C, u00005, "ada__strings__text_buffersS");
   u00006 : constant Version_32 := 16#76789da1#;
   pragma Export (C, u00006, "adaS");
   u00007 : constant Version_32 := 16#e6d4fa36#;
   pragma Export (C, u00007, "ada__stringsS");
   u00008 : constant Version_32 := 16#426dafb8#;
   pragma Export (C, u00008, "systemS");
   u00009 : constant Version_32 := 16#c71e6c8a#;
   pragma Export (C, u00009, "system__exception_tableB");
   u00010 : constant Version_32 := 16#cf46d9a1#;
   pragma Export (C, u00010, "system__exception_tableS");
   u00011 : constant Version_32 := 16#fd5f5f4c#;
   pragma Export (C, u00011, "system__soft_linksB");
   u00012 : constant Version_32 := 16#3ff0395b#;
   pragma Export (C, u00012, "system__soft_linksS");
   u00013 : constant Version_32 := 16#d4c699bf#;
   pragma Export (C, u00013, "system__secondary_stackB");
   u00014 : constant Version_32 := 16#6a2f1a0f#;
   pragma Export (C, u00014, "system__secondary_stackS");
   u00015 : constant Version_32 := 16#e9d77c55#;
   pragma Export (C, u00015, "ada__exceptionsB");
   u00016 : constant Version_32 := 16#1e7524b5#;
   pragma Export (C, u00016, "ada__exceptionsS");
   u00017 : constant Version_32 := 16#0740df23#;
   pragma Export (C, u00017, "ada__exceptions__last_chance_handlerB");
   u00018 : constant Version_32 := 16#6dc27684#;
   pragma Export (C, u00018, "ada__exceptions__last_chance_handlerS");
   u00019 : constant Version_32 := 16#70c8108a#;
   pragma Export (C, u00019, "system__exceptionsS");
   u00020 : constant Version_32 := 16#69416224#;
   pragma Export (C, u00020, "system__exceptions__machineB");
   u00021 : constant Version_32 := 16#8bdfdbe3#;
   pragma Export (C, u00021, "system__exceptions__machineS");
   u00022 : constant Version_32 := 16#7706238d#;
   pragma Export (C, u00022, "system__exceptions_debugB");
   u00023 : constant Version_32 := 16#7263f7eb#;
   pragma Export (C, u00023, "system__exceptions_debugS");
   u00024 : constant Version_32 := 16#32ee70d0#;
   pragma Export (C, u00024, "system__img_intS");
   u00025 : constant Version_32 := 16#f2c63a02#;
   pragma Export (C, u00025, "ada__numericsS");
   u00026 : constant Version_32 := 16#174f5472#;
   pragma Export (C, u00026, "ada__numerics__big_numbersS");
   u00027 : constant Version_32 := 16#b847d0e1#;
   pragma Export (C, u00027, "system__unsigned_typesS");
   u00028 : constant Version_32 := 16#5e8f37b6#;
   pragma Export (C, u00028, "system__val_intS");
   u00029 : constant Version_32 := 16#48912782#;
   pragma Export (C, u00029, "system__val_unsS");
   u00030 : constant Version_32 := 16#96e09402#;
   pragma Export (C, u00030, "system__val_utilB");
   u00031 : constant Version_32 := 16#71a87b35#;
   pragma Export (C, u00031, "system__val_utilS");
   u00032 : constant Version_32 := 16#b98923bf#;
   pragma Export (C, u00032, "system__case_utilB");
   u00033 : constant Version_32 := 16#8d7e78ed#;
   pragma Export (C, u00033, "system__case_utilS");
   u00034 : constant Version_32 := 16#8d029d03#;
   pragma Export (C, u00034, "system__wid_unsS");
   u00035 : constant Version_32 := 16#2a95d23d#;
   pragma Export (C, u00035, "system__storage_elementsB");
   u00036 : constant Version_32 := 16#e939c75c#;
   pragma Export (C, u00036, "system__storage_elementsS");
   u00037 : constant Version_32 := 16#5c7d9c20#;
   pragma Export (C, u00037, "system__tracebackB");
   u00038 : constant Version_32 := 16#c4f75b05#;
   pragma Export (C, u00038, "system__tracebackS");
   u00039 : constant Version_32 := 16#5f6b6486#;
   pragma Export (C, u00039, "system__traceback_entriesB");
   u00040 : constant Version_32 := 16#8a711034#;
   pragma Export (C, u00040, "system__traceback_entriesS");
   u00041 : constant Version_32 := 16#b5f8ae26#;
   pragma Export (C, u00041, "system__traceback__symbolicB");
   u00042 : constant Version_32 := 16#d9e66ad1#;
   pragma Export (C, u00042, "system__traceback__symbolicS");
   u00043 : constant Version_32 := 16#179d7d28#;
   pragma Export (C, u00043, "ada__containersS");
   u00044 : constant Version_32 := 16#701f9d88#;
   pragma Export (C, u00044, "ada__exceptions__tracebackB");
   u00045 : constant Version_32 := 16#eb07882c#;
   pragma Export (C, u00045, "ada__exceptions__tracebackS");
   u00046 : constant Version_32 := 16#15f799c2#;
   pragma Export (C, u00046, "interfacesS");
   u00047 : constant Version_32 := 16#545fe66d#;
   pragma Export (C, u00047, "interfaces__cB");
   u00048 : constant Version_32 := 16#9d395173#;
   pragma Export (C, u00048, "interfaces__cS");
   u00049 : constant Version_32 := 16#821dff88#;
   pragma Export (C, u00049, "system__parametersB");
   u00050 : constant Version_32 := 16#96f90b1e#;
   pragma Export (C, u00050, "system__parametersS");
   u00051 : constant Version_32 := 16#6ef2c461#;
   pragma Export (C, u00051, "system__bounded_stringsB");
   u00052 : constant Version_32 := 16#35908ea1#;
   pragma Export (C, u00052, "system__bounded_stringsS");
   u00053 : constant Version_32 := 16#1cff99e6#;
   pragma Export (C, u00053, "system__crtlS");
   u00054 : constant Version_32 := 16#9f199b4a#;
   pragma Export (C, u00054, "system__dwarf_linesB");
   u00055 : constant Version_32 := 16#a5cb9aae#;
   pragma Export (C, u00055, "system__dwarf_linesS");
   u00056 : constant Version_32 := 16#5b4659fa#;
   pragma Export (C, u00056, "ada__charactersS");
   u00057 : constant Version_32 := 16#f70a517e#;
   pragma Export (C, u00057, "ada__characters__handlingB");
   u00058 : constant Version_32 := 16#ea6baced#;
   pragma Export (C, u00058, "ada__characters__handlingS");
   u00059 : constant Version_32 := 16#cde9ea2d#;
   pragma Export (C, u00059, "ada__characters__latin_1S");
   u00060 : constant Version_32 := 16#16f45e54#;
   pragma Export (C, u00060, "ada__strings__mapsB");
   u00061 : constant Version_32 := 16#9df1863a#;
   pragma Export (C, u00061, "ada__strings__mapsS");
   u00062 : constant Version_32 := 16#96b40646#;
   pragma Export (C, u00062, "system__bit_opsB");
   u00063 : constant Version_32 := 16#8f9e0384#;
   pragma Export (C, u00063, "system__bit_opsS");
   u00064 : constant Version_32 := 16#4642cba6#;
   pragma Export (C, u00064, "ada__strings__maps__constantsS");
   u00065 : constant Version_32 := 16#a0d3d22b#;
   pragma Export (C, u00065, "system__address_imageB");
   u00066 : constant Version_32 := 16#e3813282#;
   pragma Export (C, u00066, "system__address_imageS");
   u00067 : constant Version_32 := 16#cdf7317a#;
   pragma Export (C, u00067, "system__img_unsS");
   u00068 : constant Version_32 := 16#20ec7aa3#;
   pragma Export (C, u00068, "system__ioB");
   u00069 : constant Version_32 := 16#dc2f58f7#;
   pragma Export (C, u00069, "system__ioS");
   u00070 : constant Version_32 := 16#754b4bb8#;
   pragma Export (C, u00070, "system__mmapB");
   u00071 : constant Version_32 := 16#7a46ab42#;
   pragma Export (C, u00071, "system__mmapS");
   u00072 : constant Version_32 := 16#367911c4#;
   pragma Export (C, u00072, "ada__io_exceptionsS");
   u00073 : constant Version_32 := 16#dd82c35a#;
   pragma Export (C, u00073, "system__mmap__os_interfaceB");
   u00074 : constant Version_32 := 16#37fd3b64#;
   pragma Export (C, u00074, "system__mmap__os_interfaceS");
   u00075 : constant Version_32 := 16#3e3920c1#;
   pragma Export (C, u00075, "system__mmap__unixS");
   u00076 : constant Version_32 := 16#1d7382c4#;
   pragma Export (C, u00076, "system__os_libB");
   u00077 : constant Version_32 := 16#b8017fe7#;
   pragma Export (C, u00077, "system__os_libS");
   u00078 : constant Version_32 := 16#6e5d049a#;
   pragma Export (C, u00078, "system__atomic_operations__test_and_setB");
   u00079 : constant Version_32 := 16#57acee8e#;
   pragma Export (C, u00079, "system__atomic_operations__test_and_setS");
   u00080 : constant Version_32 := 16#850ed59d#;
   pragma Export (C, u00080, "system__atomic_operationsS");
   u00081 : constant Version_32 := 16#29cc6115#;
   pragma Export (C, u00081, "system__atomic_primitivesB");
   u00082 : constant Version_32 := 16#0524e799#;
   pragma Export (C, u00082, "system__atomic_primitivesS");
   u00083 : constant Version_32 := 16#256dbbe5#;
   pragma Export (C, u00083, "system__stringsB");
   u00084 : constant Version_32 := 16#d9efafa0#;
   pragma Export (C, u00084, "system__stringsS");
   u00085 : constant Version_32 := 16#2fdbc40e#;
   pragma Export (C, u00085, "system__object_readerB");
   u00086 : constant Version_32 := 16#55f4bbb3#;
   pragma Export (C, u00086, "system__object_readerS");
   u00087 : constant Version_32 := 16#d7e08022#;
   pragma Export (C, u00087, "system__val_lliS");
   u00088 : constant Version_32 := 16#6a5ef568#;
   pragma Export (C, u00088, "system__val_lluS");
   u00089 : constant Version_32 := 16#bad10b33#;
   pragma Export (C, u00089, "system__exception_tracesB");
   u00090 : constant Version_32 := 16#aef5c6de#;
   pragma Export (C, u00090, "system__exception_tracesS");
   u00091 : constant Version_32 := 16#fd158a37#;
   pragma Export (C, u00091, "system__wch_conB");
   u00092 : constant Version_32 := 16#9b6e8cdb#;
   pragma Export (C, u00092, "system__wch_conS");
   u00093 : constant Version_32 := 16#5c289972#;
   pragma Export (C, u00093, "system__wch_stwB");
   u00094 : constant Version_32 := 16#b67fa0da#;
   pragma Export (C, u00094, "system__wch_stwS");
   u00095 : constant Version_32 := 16#f8305de6#;
   pragma Export (C, u00095, "system__wch_cnvB");
   u00096 : constant Version_32 := 16#9dae46ab#;
   pragma Export (C, u00096, "system__wch_cnvS");
   u00097 : constant Version_32 := 16#e538de43#;
   pragma Export (C, u00097, "system__wch_jisB");
   u00098 : constant Version_32 := 16#28192481#;
   pragma Export (C, u00098, "system__wch_jisS");
   u00099 : constant Version_32 := 16#0286ce9f#;
   pragma Export (C, u00099, "system__soft_links__initializeB");
   u00100 : constant Version_32 := 16#2ed17187#;
   pragma Export (C, u00100, "system__soft_links__initializeS");
   u00101 : constant Version_32 := 16#8599b27b#;
   pragma Export (C, u00101, "system__stack_checkingB");
   u00102 : constant Version_32 := 16#e2b806a2#;
   pragma Export (C, u00102, "system__stack_checkingS");
   u00103 : constant Version_32 := 16#8b7604c4#;
   pragma Export (C, u00103, "ada__strings__utf_encodingB");
   u00104 : constant Version_32 := 16#4d0e0994#;
   pragma Export (C, u00104, "ada__strings__utf_encodingS");
   u00105 : constant Version_32 := 16#bb780f45#;
   pragma Export (C, u00105, "ada__strings__utf_encoding__stringsB");
   u00106 : constant Version_32 := 16#b85ff4b6#;
   pragma Export (C, u00106, "ada__strings__utf_encoding__stringsS");
   u00107 : constant Version_32 := 16#d1d1ed0b#;
   pragma Export (C, u00107, "ada__strings__utf_encoding__wide_stringsB");
   u00108 : constant Version_32 := 16#5678478f#;
   pragma Export (C, u00108, "ada__strings__utf_encoding__wide_stringsS");
   u00109 : constant Version_32 := 16#c2b98963#;
   pragma Export (C, u00109, "ada__strings__utf_encoding__wide_wide_stringsB");
   u00110 : constant Version_32 := 16#d7af3358#;
   pragma Export (C, u00110, "ada__strings__utf_encoding__wide_wide_stringsS");
   u00111 : constant Version_32 := 16#f38d604a#;
   pragma Export (C, u00111, "ada__tagsB");
   u00112 : constant Version_32 := 16#4d1deaec#;
   pragma Export (C, u00112, "ada__tagsS");
   u00113 : constant Version_32 := 16#3548d972#;
   pragma Export (C, u00113, "system__htableB");
   u00114 : constant Version_32 := 16#c3b4f753#;
   pragma Export (C, u00114, "system__htableS");
   u00115 : constant Version_32 := 16#1f1abe38#;
   pragma Export (C, u00115, "system__string_hashB");
   u00116 : constant Version_32 := 16#64f1772c#;
   pragma Export (C, u00116, "system__string_hashS");
   u00117 : constant Version_32 := 16#75e1825b#;
   pragma Export (C, u00117, "aunitB");
   u00118 : constant Version_32 := 16#76cdf7c6#;
   pragma Export (C, u00118, "aunitS");
   u00119 : constant Version_32 := 16#b6c145a2#;
   pragma Export (C, u00119, "aunit__memoryB");
   u00120 : constant Version_32 := 16#94910938#;
   pragma Export (C, u00120, "aunit__memoryS");
   u00121 : constant Version_32 := 16#bd1125e3#;
   pragma Export (C, u00121, "aunit__reporterB");
   u00122 : constant Version_32 := 16#7beb347d#;
   pragma Export (C, u00122, "aunit__reporterS");
   u00123 : constant Version_32 := 16#b4f41810#;
   pragma Export (C, u00123, "ada__streamsB");
   u00124 : constant Version_32 := 16#67e31212#;
   pragma Export (C, u00124, "ada__streamsS");
   u00125 : constant Version_32 := 16#abd3c34b#;
   pragma Export (C, u00125, "system__put_imagesB");
   u00126 : constant Version_32 := 16#5ec3a8a7#;
   pragma Export (C, u00126, "system__put_imagesS");
   u00127 : constant Version_32 := 16#22b9eb9f#;
   pragma Export (C, u00127, "ada__strings__text_buffers__utilsB");
   u00128 : constant Version_32 := 16#89062ac3#;
   pragma Export (C, u00128, "ada__strings__text_buffers__utilsS");
   u00129 : constant Version_32 := 16#27f4ceba#;
   pragma Export (C, u00129, "aunit__ioS");
   u00130 : constant Version_32 := 16#f64b89a4#;
   pragma Export (C, u00130, "ada__integer_text_ioB");
   u00131 : constant Version_32 := 16#dc1f7556#;
   pragma Export (C, u00131, "ada__integer_text_ioS");
   u00132 : constant Version_32 := 16#67eb6d5a#;
   pragma Export (C, u00132, "ada__text_ioB");
   u00133 : constant Version_32 := 16#3cf1122b#;
   pragma Export (C, u00133, "ada__text_ioS");
   u00134 : constant Version_32 := 16#73d2d764#;
   pragma Export (C, u00134, "interfaces__c_streamsB");
   u00135 : constant Version_32 := 16#7acc80b4#;
   pragma Export (C, u00135, "interfaces__c_streamsS");
   u00136 : constant Version_32 := 16#1aa716c1#;
   pragma Export (C, u00136, "system__file_ioB");
   u00137 : constant Version_32 := 16#3ecf6aed#;
   pragma Export (C, u00137, "system__file_ioS");
   u00138 : constant Version_32 := 16#86c56e5a#;
   pragma Export (C, u00138, "ada__finalizationS");
   u00139 : constant Version_32 := 16#95817ed8#;
   pragma Export (C, u00139, "system__finalization_rootB");
   u00140 : constant Version_32 := 16#0d9fdc28#;
   pragma Export (C, u00140, "system__finalization_rootS");
   u00141 : constant Version_32 := 16#e09c58a9#;
   pragma Export (C, u00141, "system__file_control_blockS");
   u00142 : constant Version_32 := 16#44bc8f6a#;
   pragma Export (C, u00142, "ada__text_io__generic_auxB");
   u00143 : constant Version_32 := 16#ba6faca0#;
   pragma Export (C, u00143, "ada__text_io__generic_auxS");
   u00144 : constant Version_32 := 16#8b9a2c46#;
   pragma Export (C, u00144, "system__img_biuS");
   u00145 : constant Version_32 := 16#c6c4eb98#;
   pragma Export (C, u00145, "system__img_llbS");
   u00146 : constant Version_32 := 16#602bc0ef#;
   pragma Export (C, u00146, "system__img_lliS");
   u00147 : constant Version_32 := 16#ad0ace1a#;
   pragma Export (C, u00147, "system__wid_lluS");
   u00148 : constant Version_32 := 16#b1351eea#;
   pragma Export (C, u00148, "system__img_lllbS");
   u00149 : constant Version_32 := 16#868c229b#;
   pragma Export (C, u00149, "system__img_llliS");
   u00150 : constant Version_32 := 16#eaaea841#;
   pragma Export (C, u00150, "system__val_llliS");
   u00151 : constant Version_32 := 16#5ce094b2#;
   pragma Export (C, u00151, "system__val_llluS");
   u00152 : constant Version_32 := 16#ceb71b59#;
   pragma Export (C, u00152, "system__wid_llluS");
   u00153 : constant Version_32 := 16#bb4107e6#;
   pragma Export (C, u00153, "system__img_lllwS");
   u00154 : constant Version_32 := 16#9af69e93#;
   pragma Export (C, u00154, "system__img_llwS");
   u00155 : constant Version_32 := 16#b4409774#;
   pragma Export (C, u00155, "system__img_wiuS");
   u00156 : constant Version_32 := 16#e99cd447#;
   pragma Export (C, u00156, "aunit__optionsS");
   u00157 : constant Version_32 := 16#e9d6512d#;
   pragma Export (C, u00157, "aunit__test_filtersB");
   u00158 : constant Version_32 := 16#9a67cba8#;
   pragma Export (C, u00158, "aunit__test_filtersS");
   u00159 : constant Version_32 := 16#6e9501f4#;
   pragma Export (C, u00159, "aunit__simple_test_casesB");
   u00160 : constant Version_32 := 16#5a323d45#;
   pragma Export (C, u00160, "aunit__simple_test_casesS");
   u00161 : constant Version_32 := 16#8872fb1a#;
   pragma Export (C, u00161, "aunit__assertionsB");
   u00162 : constant Version_32 := 16#9769caa2#;
   pragma Export (C, u00162, "aunit__assertionsS");
   u00163 : constant Version_32 := 16#57fc9d67#;
   pragma Export (C, u00163, "ada_containers__aunit_listsB");
   u00164 : constant Version_32 := 16#c8d9569a#;
   pragma Export (C, u00164, "ada_containers__aunit_listsS");
   u00165 : constant Version_32 := 16#11329e00#;
   pragma Export (C, u00165, "ada_containersS");
   u00166 : constant Version_32 := 16#9b1c7ff2#;
   pragma Export (C, u00166, "aunit__memory__utilsB");
   u00167 : constant Version_32 := 16#fb2f6c57#;
   pragma Export (C, u00167, "aunit__memory__utilsS");
   u00168 : constant Version_32 := 16#b891ec3b#;
   pragma Export (C, u00168, "aunit__test_resultsB");
   u00169 : constant Version_32 := 16#c2a99f30#;
   pragma Export (C, u00169, "aunit__test_resultsS");
   u00170 : constant Version_32 := 16#2db05237#;
   pragma Export (C, u00170, "aunit__time_measureB");
   u00171 : constant Version_32 := 16#a10d315e#;
   pragma Export (C, u00171, "aunit__time_measureS");
   u00172 : constant Version_32 := 16#bc39daba#;
   pragma Export (C, u00172, "ada__strings__fixedB");
   u00173 : constant Version_32 := 16#889cc4e3#;
   pragma Export (C, u00173, "ada__strings__fixedS");
   u00174 : constant Version_32 := 16#9211d95c#;
   pragma Export (C, u00174, "ada__strings__searchB");
   u00175 : constant Version_32 := 16#501fe7a7#;
   pragma Export (C, u00175, "ada__strings__searchS");
   u00176 : constant Version_32 := 16#37ff5dbb#;
   pragma Export (C, u00176, "ada__calendarB");
   u00177 : constant Version_32 := 16#8324cd02#;
   pragma Export (C, u00177, "ada__calendarS");
   u00178 : constant Version_32 := 16#307180be#;
   pragma Export (C, u00178, "system__os_primitivesB");
   u00179 : constant Version_32 := 16#4590ca4e#;
   pragma Export (C, u00179, "system__os_primitivesS");
   u00180 : constant Version_32 := 16#6b6cea8f#;
   pragma Export (C, u00180, "aunit__testsS");
   u00181 : constant Version_32 := 16#28888d98#;
   pragma Export (C, u00181, "system__finalization_mastersB");
   u00182 : constant Version_32 := 16#02e4eddb#;
   pragma Export (C, u00182, "system__finalization_mastersS");
   u00183 : constant Version_32 := 16#35d6ef80#;
   pragma Export (C, u00183, "system__storage_poolsB");
   u00184 : constant Version_32 := 16#bf8c6aef#;
   pragma Export (C, u00184, "system__storage_poolsS");
   u00185 : constant Version_32 := 16#7c78c3c5#;
   pragma Export (C, u00185, "system__pool_globalB");
   u00186 : constant Version_32 := 16#91b367a5#;
   pragma Export (C, u00186, "system__pool_globalS");
   u00187 : constant Version_32 := 16#1982dcd0#;
   pragma Export (C, u00187, "system__memoryB");
   u00188 : constant Version_32 := 16#19e99d68#;
   pragma Export (C, u00188, "system__memoryS");
   u00189 : constant Version_32 := 16#b5988c27#;
   pragma Export (C, u00189, "gnatS");
   u00190 : constant Version_32 := 16#93c26f9a#;
   pragma Export (C, u00190, "gnat__source_infoS");
   u00191 : constant Version_32 := 16#931654a0#;
   pragma Export (C, u00191, "gnat__tracebackB");
   u00192 : constant Version_32 := 16#9229a92c#;
   pragma Export (C, u00192, "gnat__tracebackS");
   u00193 : constant Version_32 := 16#2086345e#;
   pragma Export (C, u00193, "gnat__traceback__symbolicS");
   u00194 : constant Version_32 := 16#d50f3cfb#;
   pragma Export (C, u00194, "system__stream_attributesB");
   u00195 : constant Version_32 := 16#5e0388d4#;
   pragma Export (C, u00195, "system__stream_attributesS");
   u00196 : constant Version_32 := 16#3aecdcda#;
   pragma Export (C, u00196, "system__stream_attributes__xdrB");
   u00197 : constant Version_32 := 16#42985e70#;
   pragma Export (C, u00197, "system__stream_attributes__xdrS");
   u00198 : constant Version_32 := 16#815f70d4#;
   pragma Export (C, u00198, "system__fat_fltS");
   u00199 : constant Version_32 := 16#a76d79d9#;
   pragma Export (C, u00199, "system__fat_lfltS");
   u00200 : constant Version_32 := 16#ddbdd733#;
   pragma Export (C, u00200, "system__fat_llfS");
   u00201 : constant Version_32 := 16#b61e55fe#;
   pragma Export (C, u00201, "aunit__reporter__textB");
   u00202 : constant Version_32 := 16#1676cc84#;
   pragma Export (C, u00202, "aunit__reporter__textS");
   u00203 : constant Version_32 := 16#fa09c8ad#;
   pragma Export (C, u00203, "system__arith_64B");
   u00204 : constant Version_32 := 16#b6ccbb3b#;
   pragma Export (C, u00204, "system__arith_64S");
   u00205 : constant Version_32 := 16#119c6c25#;
   pragma Export (C, u00205, "system__sparkS");
   u00206 : constant Version_32 := 16#812db2df#;
   pragma Export (C, u00206, "system__spark__cut_operationsB");
   u00207 : constant Version_32 := 16#46c019b4#;
   pragma Export (C, u00207, "system__spark__cut_operationsS");
   u00208 : constant Version_32 := 16#e6e7837e#;
   pragma Export (C, u00208, "system__exn_intS");
   u00209 : constant Version_32 := 16#e652c197#;
   pragma Export (C, u00209, "system__return_stackS");
   u00210 : constant Version_32 := 16#90614e9c#;
   pragma Export (C, u00210, "aunit__runB");
   u00211 : constant Version_32 := 16#dc46304b#;
   pragma Export (C, u00211, "aunit__runS");
   u00212 : constant Version_32 := 16#276e73f2#;
   pragma Export (C, u00212, "aunit__test_suitesB");
   u00213 : constant Version_32 := 16#50924664#;
   pragma Export (C, u00213, "aunit__test_suitesS");
   u00214 : constant Version_32 := 16#65841bdf#;
   pragma Export (C, u00214, "riscv_emu_suiteB");
   u00215 : constant Version_32 := 16#041e6e2d#;
   pragma Export (C, u00215, "riscv_memory_testB");
   u00216 : constant Version_32 := 16#97650e9e#;
   pragma Export (C, u00216, "riscv_memory_testS");
   u00217 : constant Version_32 := 16#56869ed0#;
   pragma Export (C, u00217, "riscv_memoryB");
   u00218 : constant Version_32 := 16#1e6d3db6#;
   pragma Export (C, u00218, "riscv_memoryS");
   u00219 : constant Version_32 := 16#b49a0e5d#;
   pragma Export (C, u00219, "system__storage_pools__subpoolsB");
   u00220 : constant Version_32 := 16#a2d8d50c#;
   pragma Export (C, u00220, "system__storage_pools__subpoolsS");
   u00221 : constant Version_32 := 16#b0df1928#;
   pragma Export (C, u00221, "system__storage_pools__subpools__finalizationB");
   u00222 : constant Version_32 := 16#562129f7#;
   pragma Export (C, u00222, "system__storage_pools__subpools__finalizationS");

   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.characters%s
   --  ada.characters.latin_1%s
   --  interfaces%s
   --  system%s
   --  system.atomic_operations%s
   --  system.io%s
   --  system.io%b
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  interfaces.c_streams%s
   --  interfaces.c_streams%b
   --  system.os_primitives%s
   --  system.os_primitives%b
   --  system.spark%s
   --  system.spark.cut_operations%s
   --  system.spark.cut_operations%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.return_stack%s
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.string_hash%s
   --  system.string_hash%b
   --  system.htable%s
   --  system.htable%b
   --  system.strings%s
   --  system.strings%b
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  system.unsigned_types%s
   --  system.img_biu%s
   --  system.img_llb%s
   --  system.img_lllb%s
   --  system.img_lllw%s
   --  system.img_llw%s
   --  system.img_wiu%s
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%s
   --  system.wch_cnv%b
   --  system.traceback%s
   --  system.traceback%b
   --  ada.characters.handling%s
   --  system.atomic_operations.test_and_set%s
   --  system.case_util%s
   --  system.os_lib%s
   --  system.secondary_stack%s
   --  system.standard_library%s
   --  ada.exceptions%s
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  system.soft_links%s
   --  system.val_llu%s
   --  system.val_lli%s
   --  system.val_uns%s
   --  system.val_int%s
   --  system.val_util%s
   --  system.val_util%b
   --  system.wch_stw%s
   --  system.wch_stw%b
   --  ada.exceptions.last_chance_handler%s
   --  ada.exceptions.last_chance_handler%b
   --  ada.exceptions.traceback%s
   --  ada.exceptions.traceback%b
   --  system.address_image%s
   --  system.address_image%b
   --  system.bit_ops%s
   --  system.bit_ops%b
   --  system.bounded_strings%s
   --  system.bounded_strings%b
   --  system.case_util%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  ada.containers%s
   --  ada.io_exceptions%s
   --  ada.numerics%s
   --  ada.numerics.big_numbers%s
   --  ada.strings%s
   --  ada.strings.maps%s
   --  ada.strings.maps%b
   --  ada.strings.maps.constants%s
   --  interfaces.c%s
   --  interfaces.c%b
   --  system.atomic_primitives%s
   --  system.atomic_primitives%b
   --  system.exceptions%s
   --  system.exceptions.machine%s
   --  system.exceptions.machine%b
   --  ada.characters.handling%b
   --  system.atomic_operations.test_and_set%b
   --  system.exception_traces%s
   --  system.exception_traces%b
   --  system.memory%s
   --  system.memory%b
   --  system.mmap%s
   --  system.mmap.os_interface%s
   --  system.mmap%b
   --  system.mmap.unix%s
   --  system.mmap.os_interface%b
   --  system.object_reader%s
   --  system.object_reader%b
   --  system.dwarf_lines%s
   --  system.os_lib%b
   --  system.secondary_stack%b
   --  system.soft_links.initialize%s
   --  system.soft_links.initialize%b
   --  system.soft_links%b
   --  system.standard_library%b
   --  system.traceback.symbolic%s
   --  system.traceback.symbolic%b
   --  system.wid_uns%s
   --  system.img_int%s
   --  ada.exceptions%b
   --  system.img_uns%s
   --  system.dwarf_lines%b
   --  ada.strings.search%s
   --  ada.strings.search%b
   --  ada.strings.fixed%s
   --  ada.strings.fixed%b
   --  ada.strings.utf_encoding%s
   --  ada.strings.utf_encoding%b
   --  ada.strings.utf_encoding.strings%s
   --  ada.strings.utf_encoding.strings%b
   --  ada.strings.utf_encoding.wide_strings%s
   --  ada.strings.utf_encoding.wide_strings%b
   --  ada.strings.utf_encoding.wide_wide_strings%s
   --  ada.strings.utf_encoding.wide_wide_strings%b
   --  ada.tags%s
   --  ada.tags%b
   --  ada.strings.text_buffers%s
   --  ada.strings.text_buffers%b
   --  ada.strings.text_buffers.utils%s
   --  ada.strings.text_buffers.utils%b
   --  gnat%s
   --  gnat.source_info%s
   --  system.arith_64%s
   --  system.arith_64%b
   --  system.fat_flt%s
   --  system.fat_lflt%s
   --  system.fat_llf%s
   --  system.put_images%s
   --  system.put_images%b
   --  ada.streams%s
   --  ada.streams%b
   --  system.file_control_block%s
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  ada.finalization%s
   --  system.file_io%s
   --  system.file_io%b
   --  system.storage_pools%s
   --  system.storage_pools%b
   --  system.finalization_masters%s
   --  system.finalization_masters%b
   --  system.storage_pools.subpools%s
   --  system.storage_pools.subpools.finalization%s
   --  system.storage_pools.subpools.finalization%b
   --  system.storage_pools.subpools%b
   --  system.stream_attributes%s
   --  system.stream_attributes.xdr%s
   --  system.stream_attributes.xdr%b
   --  system.stream_attributes%b
   --  system.val_lllu%s
   --  system.val_llli%s
   --  ada.calendar%s
   --  ada.calendar%b
   --  ada.text_io%s
   --  ada.text_io%b
   --  ada.text_io.generic_aux%s
   --  ada.text_io.generic_aux%b
   --  gnat.traceback%s
   --  gnat.traceback%b
   --  gnat.traceback.symbolic%s
   --  system.exn_int%s
   --  system.pool_global%s
   --  system.pool_global%b
   --  system.wid_lllu%s
   --  system.img_llli%s
   --  system.wid_llu%s
   --  system.img_lli%s
   --  ada.integer_text_io%s
   --  ada.integer_text_io%b
   --  ada_containers%s
   --  aunit%s
   --  aunit.memory%s
   --  aunit.memory%b
   --  aunit%b
   --  aunit.io%s
   --  aunit.memory.utils%s
   --  aunit.memory.utils%b
   --  ada_containers.aunit_lists%s
   --  ada_containers.aunit_lists%b
   --  aunit.tests%s
   --  aunit.time_measure%s
   --  aunit.time_measure%b
   --  aunit.test_results%s
   --  aunit.test_results%b
   --  aunit.assertions%s
   --  aunit.assertions%b
   --  aunit.test_filters%s
   --  aunit.options%s
   --  aunit.simple_test_cases%s
   --  aunit.simple_test_cases%b
   --  aunit.test_filters%b
   --  aunit.reporter%s
   --  aunit.reporter%b
   --  aunit.reporter.text%s
   --  aunit.reporter.text%b
   --  aunit.test_suites%s
   --  aunit.test_suites%b
   --  aunit.run%s
   --  aunit.run%b
   --  riscv_memory%s
   --  riscv_memory%b
   --  riscv_memory_test%s
   --  riscv_memory_test%b
   --  riscv_emu_suite%b
   --  riscv_emu_harness%b
   --  END ELABORATION ORDER

end ada_main;
