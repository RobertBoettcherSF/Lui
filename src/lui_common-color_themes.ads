--------------------------------------------------------------------
--  Color themes (adapted from LEA_Common.Color_Themes).          --
--  Derived from LEA (https://github.com/zertovitch/lea)          --
--  Copyright (c) 2017 .. 2026 Gautier de Montmollin              --
--  Adapted for Lui: Copyright (c) 2026 Robert Boettcher          --
--------------------------------------------------------------------

package Lui_Common.Color_Themes is

   type Color_Theme_Type is (Default, Dark_Side, Solarized_Light);

   type Color_Topic is
     (Foreground,
      Background,
      Keyword,
      Number,
      Comment,
      String_Literal,
      Character_Literal,
      Error_Foreground,
      Error_Background,
      Caret,
      Selection_Foreground,
      Selection_Background,
      Matched_Parenthesis,
      Unmatched_Parenthesis,
      Parenthesis_Background,
      Matched_Word_Highlight,
      Messages_Foreground,
      Messages_Background,
      Messages_Control_Background,
      Tool_Tip_Background,
      Tool_Tip_Foreground_Highlighted,
      Caret_Line_Background,
      Bookmark_Foreground,
      Bookmark_Background,
      Line_Number_Foreground,
      Line_Number_Background,
      Status_Bar_Foreground,
      Status_Bar_Foreground_Highlighted,
      Status_Bar_Background,
      Splitter_Background,
      Splitter_Dashes,
      Tab_Bar_Background,
      Tab_Background,
      Tab_Background_Selected,
      Tab_Background_Hovered,
      Tab_Background_Selected_Hovered,
      Tab_Foreground,
      Tab_Foreground_Selected,
      Tab_Foreground_Hovered,
      Tab_Foreground_Selected_Hovered,
      Tab_Frame);

   type RGB_Type is range 0 .. 2**24 - 1;

   function HTML_Image (RGB : RGB_Type) return String;

   function Nice_Image (CT : Color_Theme_Type) return UTF_16_String;
   function Nice_Value (Im : UTF_16_String) return Color_Theme_Type;

   procedure Select_Theme (Theme : Color_Theme_Type);
   function Current_Theme return Color_Theme_Type;

   function Theme_Color (Topic : Color_Topic) return RGB_Type;
   function Theme_Color
     (Theme : Color_Theme_Type; Topic : Color_Topic) return RGB_Type;

   function Theme_Dark_Backgrounded return Boolean;
   function Theme_Dark_Backgrounded (Theme : Color_Theme_Type) return Boolean;

end Lui_Common.Color_Themes;
