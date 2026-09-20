--------------------------------------------------------------------
--  Derived from LEA lea_common.adb                               --
--  Copyright (c) 2017 .. 2026 Gautier de Montmollin              --
--  Adapted for Lui: Copyright (c) 2026 Robert Boettcher          --
--------------------------------------------------------------------

with Ada.Directories;
with Ada.Strings.UTF_Encoding.Conversions;

package body Lui_Common is

   function To_UTF_16 (S : UTF_8_String) return UTF_16_String is
   begin
      return Ada.Strings.UTF_Encoding.Conversions.Convert (S);
   end To_UTF_16;

   function To_UTF_8 (S : UTF_16_String) return UTF_8_String is
   begin
      return Ada.Strings.UTF_Encoding.Conversions.Convert (S);
   end To_UTF_8;

   function File_Exists (S : UTF_8_String) return Boolean is
   begin
      return Ada.Directories.Exists (S);
   end File_Exists;

end Lui_Common;
