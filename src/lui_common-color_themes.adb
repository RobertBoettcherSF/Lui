--------------------------------------------------------------------
--  Derived from LEA lea_common-color_themes.adb                  --
--  Copyright (c) 2017 .. 2026 Gautier de Montmollin              --
--  Adapted for Lui: Copyright (c) 2026 Robert Boettcher          --
--------------------------------------------------------------------

with Ada.Text_IO;
with Interfaces;

package body Lui_Common.Color_Themes is

   Selected_Theme : Color_Theme_Type := Default;

   White           : constant RGB_Type := 16#FFFFFF#;
   Black           : constant RGB_Type := 16#000000#;
   Very_Light_Gray : constant RGB_Type := 16#F8F8F8#;
   Light_Gray      : constant RGB_Type := 16#C0C0C0#;
   Gray            : constant RGB_Type := 16#808080#;
   Dark_Gray       : constant RGB_Type := 16#404040#;
   Very_Dark_Gray  : constant RGB_Type := 16#101010#;
   Red             : constant RGB_Type := 16#FF0000#;
   Dark_Red        : constant RGB_Type := 16#800000#;
   Green           : constant RGB_Type := 16#00FF00#;
   Dark_Green      : constant RGB_Type := 16#008000#;
   Light_Blue      : constant RGB_Type := 16#88DDFF#;
   Blue            : constant RGB_Type := 16#0000FF#;
   Dark_Blue       : constant RGB_Type := 16#000080#;
   Yellow          : constant RGB_Type := 16#FFFF00#;
   Pink            : constant RGB_Type := 16#FFAFAF#;
   Light_Pink      : constant RGB_Type := 16#FFF2F2#;
   Orange          : constant RGB_Type := 16#FFC800#;
   Dark_Orange     : constant RGB_Type := 16#F08D24#;

   package Solarized is
      Base02  : constant RGB_Type := 16#073642#;
      Base01  : constant RGB_Type := 16#586E75#;
      Base00  : constant RGB_Type := 16#657B83#;
      Base0   : constant RGB_Type := 16#839496#;
      Base1   : constant RGB_Type := 16#93A1A1#;
      Base2   : constant RGB_Type := 16#EEE8D5#;
      Base3   : constant RGB_Type := 16#FDF6E3#;
      Orange  : constant RGB_Type := 16#CB4B16#;
      Red     : constant RGB_Type := 16#DC322F#;
      Magenta : constant RGB_Type := 16#D33682#;
      Blue    : constant RGB_Type := 16#268BD2#;
      Cyan    : constant RGB_Type := 16#2AA198#;
      Green   : constant RGB_Type := 16#859900#;
   end Solarized;

   Theme_Color_Array : constant
     array (Color_Theme_Type, Color_Topic) of RGB_Type :=
     [Default =>
        [Foreground                        => Very_Dark_Gray,
         Background                        => White,
         Keyword                           => Blue,
         Number                            => Dark_Orange,
         Comment                           => Dark_Green,
         String_Literal                    => Solarized.Cyan,
         Character_Literal                 => Solarized.Blue,
         Error_Foreground                  => Red,
         Error_Background                  => Light_Pink,
         Caret                             => Black,
         Selection_Foreground              => Black,
         Selection_Background              => Light_Gray,
         Matched_Parenthesis               => Dark_Green,
         Unmatched_Parenthesis             => Dark_Red,
         Parenthesis_Background            => 16#CBE7F5#,
         Matched_Word_Highlight            => Dark_Green,
         Messages_Foreground               => Black,
         Messages_Background               => White,
         Messages_Control_Background       => White,
         Tool_Tip_Background               => Very_Light_Gray,
         Tool_Tip_Foreground_Highlighted   => Dark_Blue,
         Caret_Line_Background             => 16#F0F0FF#,
         Bookmark_Foreground               => Blue,
         Bookmark_Background               => Light_Blue,
         Line_Number_Foreground            => Light_Gray,
         Line_Number_Background            => Very_Light_Gray,
         Status_Bar_Foreground             => 16#202020#,
         Status_Bar_Foreground_Highlighted => Dark_Orange,
         Status_Bar_Background             => White,
         Splitter_Background               => Light_Gray,
         Splitter_Dashes                   => Gray,
         Tab_Bar_Background                => White,
         Tab_Background                    => 16#F8F8F8#,
         Tab_Background_Selected           => 16#F0F0FF#,
         Tab_Background_Hovered            => 16#F4F4FC#,
         Tab_Background_Selected_Hovered   => 16#D8D8EF#,
         Tab_Foreground                    => 16#848484#,
         Tab_Foreground_Selected           => Very_Dark_Gray,
         Tab_Foreground_Hovered            => 16#4A4A4A#,
         Tab_Foreground_Selected_Hovered   => Black,
         Tab_Frame                         => Black],

      Dark_Side =>
        [Foreground                        => Light_Gray,
         Background                        => 16#222324#,
         Keyword                           => Dark_Orange,
         Number                            => Red,
         Comment                           => 16#729FCF#,
         String_Literal                    => Yellow,
         Character_Literal                 => Orange,
         Error_Foreground                  => Pink,
         Error_Background                  => Dark_Red,
         Caret                             => White,
         Selection_Foreground              => White,
         Selection_Background              => 16#2280D2#,
         Matched_Parenthesis               => Green,
         Unmatched_Parenthesis             => Red,
         Parenthesis_Background            => 16#505050#,
         Matched_Word_Highlight            => Green,
         Messages_Foreground               => Light_Gray,
         Messages_Background               => 16#161718#,
         Messages_Control_Background       => 16#121314#,
         Tool_Tip_Background               => Dark_Gray,
         Tool_Tip_Foreground_Highlighted   => Light_Blue,
         Caret_Line_Background             => 16#402020#,
         Bookmark_Foreground               => 16#C06060#,
         Bookmark_Background               => 16#C06060#,
         Line_Number_Foreground            => Gray,
         Line_Number_Background            => 16#383334#,
         Status_Bar_Foreground             => Light_Gray,
         Status_Bar_Foreground_Highlighted => Orange,
         Status_Bar_Background             => 16#161718#,
         Splitter_Background               => Dark_Gray,
         Splitter_Dashes                   => Gray,
         Tab_Bar_Background                => 16#222324#,
         Tab_Background                    => 16#383334#,
         Tab_Background_Selected           => 16#402020#,
         Tab_Background_Hovered            => 16#3C292A#,
         Tab_Background_Selected_Hovered   => 16#503030#,
         Tab_Foreground                    => 16#7C7C7C#,
         Tab_Foreground_Selected           => 16#F8F8F8#,
         Tab_Foreground_Hovered            => 16#BABABA#,
         Tab_Foreground_Selected_Hovered   => 16#FCFCFC#,
         Tab_Frame                         => 16#A09C90#],

      Solarized_Light =>
        [Foreground                        => Solarized.Base01,
         Background                        => Solarized.Base3,
         Keyword                           => Solarized.Green,
         Number                            => Solarized.Magenta,
         Comment                           => Solarized.Base1,
         String_Literal                    => Solarized.Cyan,
         Character_Literal                 => Solarized.Blue,
         Error_Foreground                  => Solarized.Orange,
         Error_Background                  => Solarized.Base2,
         Caret                             => Black,
         Selection_Foreground              => Solarized.Base3,
         Selection_Background              => Solarized.Base00,
         Matched_Parenthesis               => Solarized.Green,
         Unmatched_Parenthesis             => Solarized.Red,
         Parenthesis_Background            => Solarized.Base2,
         Matched_Word_Highlight            => Orange,
         Messages_Foreground               => Solarized.Base02,
         Messages_Background               => Solarized.Base3,
         Messages_Control_Background       => Solarized.Base2,
         Tool_Tip_Background               => 16#FDF3E0#,
         Tool_Tip_Foreground_Highlighted   => Dark_Blue,
         Caret_Line_Background             => 16#FFE8D8#,
         Bookmark_Foreground               => 16#FFC8C8#,
         Bookmark_Background               => 16#FFC8C8#,
         Line_Number_Foreground            => Solarized.Base1,
         Line_Number_Background            => 16#F6ECDC#,
         Status_Bar_Foreground             => Solarized.Base02,
         Status_Bar_Foreground_Highlighted => Dark_Orange,
         Status_Bar_Background             => Solarized.Base3,
         Splitter_Background               => Solarized.Base2,
         Splitter_Dashes                   => Solarized.Base0,
         Tab_Bar_Background                => Solarized.Base3,
         Tab_Background                    => 16#F6ECDC#,
         Tab_Background_Selected           => 16#FFE8D8#,
         Tab_Background_Hovered            => 16#FAEADA#,
         Tab_Background_Selected_Hovered   => 16#FFEFDF#,
         Tab_Foreground                    => 16#ABB6BA#,
         Tab_Foreground_Selected           => 16#586E75#,
         Tab_Foreground_Hovered            => 16#819297#,
         Tab_Foreground_Selected_Hovered   => 16#485E65#,
         Tab_Frame                         => 16#D4A6C2#]];

function HTML_Image (RGB : RGB_Type) return String is
      use Interfaces;
      package IO_32 is new Ada.Text_IO.Integer_IO (Integer_32);
      Res : String (1 .. 11);
   begin
      IO_32.Put (Res, Integer_32 (RGB) + 16#1_00_00_00#, Base => 16);
      return Res (5 .. 10);
   end HTML_Image;

   function Nice_Image (CT : Color_Theme_Type) return UTF_16_String is
   begin
      case CT is
         when Default         => return "Default theme";
         when Dark_Side       => return "Dark Side";
         when Solarized_Light => return "Solarized Light";
      end case;
   end Nice_Image;

   function Nice_Value (Im : UTF_16_String) return Color_Theme_Type is
   begin
      for CT in Color_Theme_Type loop
         if Im = Nice_Image (CT) then
            return CT;
         end if;
      end loop;
      return Default;
   end Nice_Value;

   procedure Select_Theme (Theme : Color_Theme_Type) is
   begin
      Selected_Theme := Theme;
   end Select_Theme;

   function Current_Theme return Color_Theme_Type is
   begin
      return Selected_Theme;
   end Current_Theme;

   function Theme_Color (Topic : Color_Topic) return RGB_Type is
   begin
      return Theme_Color_Array (Selected_Theme, Topic);
   end Theme_Color;

   function Theme_Color
     (Theme : Color_Theme_Type; Topic : Color_Topic) return RGB_Type is
   begin
      return Theme_Color_Array (Theme, Topic);
   end Theme_Color;

   function Theme_Dark_Backgrounded return Boolean is
   begin
      return Selected_Theme = Dark_Side;
   end Theme_Dark_Backgrounded;

   function Theme_Dark_Backgrounded
     (Theme : Color_Theme_Type) return Boolean is
   begin
      return Theme = Dark_Side;
   end Theme_Dark_Backgrounded;

end Lui_Common.Color_Themes;
