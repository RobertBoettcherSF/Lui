--------------------------------------------------------------------
--  Lui core tests — Linux-friendly MVP                           --
--  Copyright (c) 2026 Robert Boettcher                           --
--------------------------------------------------------------------

with Ada.Directories;
with Ada.Streams;
with Ada.Strings.Fixed;
with Ada.Text_IO;

with Lui_Common;
with Lui_Common.Color_Themes;
with Lui_Common.Syntax;
with Lui_Common.User_Options;
with Lui_Scintilla_Deploy;

procedure Tests is

   use Ada.Text_IO;
   use Lui_Common;
   use Lui_Common.Color_Themes;
   use Lui_Common.Syntax;
   use Lui_Common.User_Options;
   use Lui_Scintilla_Deploy;

   Failed : Natural := 0;
   Passed : Natural := 0;

   procedure Check (Cond : Boolean; Msg : String) is
   begin
      if Cond then
         Passed := Passed + 1;
         Put_Line ("  PASS: " & Msg);
      else
         Failed := Failed + 1;
         Put_Line ("  FAIL: " & Msg);
      end if;
   end Check;

   procedure Test_Color_Themes is
   begin
      Put_Line ("-- Color themes");
      Select_Theme (Default);
      Check (Current_Theme = Default, "default theme selected");
      Check (Theme_Color (Keyword) = 16#0000FF#, "default keyword blue");
      Check (not Theme_Dark_Backgrounded, "default not dark");

      Select_Theme (Dark_Side);
      Check (Current_Theme = Dark_Side, "dark side selected");
      Check (Theme_Dark_Backgrounded, "dark side is dark");
      Check
        (Theme_Color (Dark_Side, Background) = 16#222324#,
         "dark background RGB");

      Check
        (Nice_Value ("Solarized Light") = Solarized_Light,
         "nice_value solarized");
      declare
         Hex : constant String := HTML_Image (16#0A0B0C#);
      begin
         Check (Hex = "0A0B0C" or else Hex = "0a0b0c", "html_image hex");
      end;
   end Test_Color_Themes;

   procedure Test_Syntax is
      Filter : constant UTF_16_String := "*.ads;*.adb;*.ada;*.hac";
   begin
      Put_Line ("-- Syntax");
      Check
        (Guess_Syntax ("hello.adb", Filter) = Ada_Syntax,
         "guess .adb via filter");
      Check
        (Guess_Syntax ("pkg.ADS", Filter) = Ada_Syntax,
         "guess .ADS case-insensitive");
      Check
        (Guess_Syntax ("proj.gpr", Filter) = GPR_Syntax,
         "guess .gpr hard-coded");
      Check
        (Guess_Syntax ("readme.txt", Filter) = Undefined,
         "guess .txt undefined");
      Check
        (File_Type_Image (Ada_Syntax) = "Ada file",
         "file_type_image ada");
   end Test_Syntax;

   procedure Test_Options is
      O : Option_Pack_Type;
   begin
      Put_Line ("-- User options");
      O.Indentation  := 99;
      O.Tab_Width    := 0;
      O.Right_Margin := -5;
      Clamp_Options (O);
      Check (O.Indentation = Indentation_Max, "clamp indent high");
      Check (O.Tab_Width = Tab_Width_Min, "clamp tab low");
      Check (O.Right_Margin = Margin_Min, "clamp margin low");

      Check (Clamp_Int (5, 1, 10) = 5, "clamp mid");
      Check (Clamp_Int (-1, 0, 3) = 0, "clamp below");
      Check (Clamp_Int (99, 0, 3) = 3, "clamp above");

      O.Show_Special := None;
      Toggle_Show_Special (O);
      Check (O.Show_Special = Spaces, "toggle show_special");
   end Test_Options;

   procedure Test_Common_Strings is
   begin
      Put_Line ("-- Common strings / UTF");
      declare
         U8   : constant UTF_8_String  := "cafe";
         U16  : constant UTF_16_String := To_UTF_16 (U8);
         Back : constant UTF_8_String  := To_UTF_8 (U16);
      begin
         Check (Back = U8, "utf-8 round-trip");
      end;
   end Test_Common_Strings;

   procedure Test_Scintilla_Deploy is
      use Ada.Streams;
      Tmp_Dir : constant String := "obj/scintilla_test";
      Fake    : constant Stream_Element_Array :=
        [Stream_Element'(16#4D#),
         Stream_Element'(16#5A#),
         Stream_Element'(16#00#),
         Stream_Element'(16#FF#)];
   begin
      Put_Line ("-- SciLexer deploy (fake payload, disk path)");

      Check
        (Join_Path ("/tmp", "SciLexer.dll") = "/tmp/SciLexer.dll",
         "join_path slash");
      Check
        (Join_Path ("/tmp/", "x.dll") = "/tmp/x.dll",
         "join_path already slash");
      Check
        (Join_Path ("C:\App\", "SciLexer.dll") = "C:\App\SciLexer.dll",
         "join_path backslash retained");

      declare
         Full : constant String :=
           Deploy_To_Directory (Tmp_Dir, Fake, "fake_scilexer.bin");
         use type Ada.Directories.File_Size;
      begin
         Check (Path_Exists (Full), "deployed fake payload exists");
         Check
           (Ada.Directories.Size (Full) =
              Ada.Directories.File_Size (Fake'Length),
            "deployed size matches");
         declare
            Hint : constant String := LoadLibrary_Hint (Full);
         begin
            Check
              (Ada.Strings.Fixed.Index (Hint, "LoadLibrary") > 0,
               "loadlibrary hint mentions LoadLibrary");
         end;
         Cleanup_Path (Full);
         Check (not Path_Exists (Full), "cleanup removed file");
      end;
   end Test_Scintilla_Deploy;

begin
   Put_Line ("Lui core tests");
   Put_Line ("==============");
   Test_Color_Themes;
   Test_Syntax;
   Test_Options;
   Test_Common_Strings;
   Test_Scintilla_Deploy;
   New_Line;
   Put_Line
     ("Result:"
      & Natural'Image (Passed)
      & " passed,"
      & Natural'Image (Failed)
      & " failed");
   if Failed > 0 then
      raise Program_Error with "tests failed";
   end if;
end Tests;
