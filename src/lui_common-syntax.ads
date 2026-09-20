--------------------------------------------------------------------
--  Syntax helpers (adapted from LEA_Common.Syntax).              --
--  Derived from LEA (https://github.com/zertovitch/lea)          --
--  Copyright (c) 2017 .. 2026 Gautier de Montmollin              --
--  Adapted for Lui: Copyright (c) 2026 Robert Boettcher          --
--------------------------------------------------------------------

package Lui_Common.Syntax is

   type Syntax_Type is (Undefined, Ada_Syntax, GPR_Syntax);

   Ada_Keywords : constant UTF_16_String :=
     "abort abs abstract accept access aliased all and array at begin body "
     & "case constant declare delay delta digits do else elsif end entry "
     & "exception exit for function generic goto if in interface is limited "
     & "loop mod new not null of or others out overriding package parallel "
     & "pragma private procedure protected raise range record rem renames "
     & "requeue return reverse select separate some subtype synchronized "
     & "tagged task terminate then type until use when while with xor";

   GPR_Keywords : constant UTF_16_String :=
     "abstract case end extends external for is package project type use "
     & "when with";

   function Guess_Syntax
     (File_Name, Custom_Filter : UTF_16_String) return Syntax_Type;

   function File_Type_Image (Syn : Syntax_Type) return UTF_16_String;

end Lui_Common.Syntax;
