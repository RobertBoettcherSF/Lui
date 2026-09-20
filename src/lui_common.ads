--------------------------------------------------------------------
--  Lui_Common — GUI-agnostic pieces for the Lui editor project.  --
--                                                                --
--  Derived from LEA (https://github.com/zertovitch/lea)          --
--  Copyright (c) 2017 .. 2026 Gautier de Montmollin              --
--  Adapted for Lui: Copyright (c) 2026 Robert Boettcher          --
--------------------------------------------------------------------

with Ada.Strings.UTF_Encoding;
with Ada.Strings.Wide_Unbounded;

package Lui_Common is

   Lui_Web_Page : constant String :=
     "https://github.com/RobertBoettcherSF/Lui";

   subtype UTF_16_String is Ada.Strings.UTF_Encoding.UTF_16_Wide_String;
   subtype UTF_16_Unbounded_String is
     Ada.Strings.Wide_Unbounded.Unbounded_Wide_String;

   Form_For_IO_Open_And_Create : constant String := "encoding=utf8";

   subtype UTF_8_String is Ada.Strings.UTF_Encoding.UTF_8_String;

   function File_Exists (S : UTF_8_String) return Boolean;

   function To_UTF_16 (S : UTF_8_String) return UTF_16_String;
   function To_UTF_8 (S : UTF_16_String) return UTF_8_String;

   type View_Mode_Type is (Notepad, Studio);

   type Search_Action is
     (Find_Next,
      Find_Previous,
      Replace_And_Find_Next,
      Find_All,
      Replace_All);

   type Show_Special_Symbol_Mode is (None, Spaces, Spaces_Eols);

   type Toolset_Mode_Type is (HAC_Mode, GNAT_Mode, Alire_Mode);

   type Document_Kind_Type is (Editable_Text, Help_Main);

end Lui_Common;
