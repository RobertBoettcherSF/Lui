--------------------------------------------------------------------
--  User options (adapted from LEA_Common.User_options).          --
--  Derived from LEA (https://github.com/zertovitch/lea)          --
--  Copyright (c) 2017 .. 2026 Gautier de Montmollin              --
--  Adapted for Lui: Copyright (c) 2026 Robert Boettcher          --
--                                                                --
--  HAC_Sys dependency removed. Clamp helpers carry Ada contracts.--
--------------------------------------------------------------------

with Lui_Common.Color_Themes;

package Lui_Common.User_Options is

   use Ada.Strings.Wide_Unbounded;

   Use_Default : constant := -1;

   subtype MRU_Range is Integer range 1 .. 9;

   type MRU_Item is record
      Name : UTF_16_Unbounded_String := Null_Unbounded_Wide_String;
      Line : Natural := 0;
   end record;

   type MRU_List is array (MRU_Range) of MRU_Item;

   type Backup_Mode is (None, Bak);

   type Option_Pack_Type is record
      View_Mode    : View_Mode_Type := Notepad;
      Color_Theme  : Color_Themes.Color_Theme_Type := Color_Themes.Default;
      Backup       : Backup_Mode := None;
      Indentation  : Integer := 2;
      Tab_Width    : Integer := 2;
      Right_Margin : Integer := 100;
      Show_Special : Show_Special_Symbol_Mode := None;
      Show_Indent  : Boolean := False;
      Auto_Insert  : Boolean := True;
      Toolset      : Toolset_Mode_Type := HAC_Mode;
      Project_Tree_Portion    : Float := 0.25;
      Message_List_Portion    : Float := 0.20;
      Subprogram_Tree_Portion : Float := 0.25;
      Win_Left, Win_Top, Win_Width, Win_Height : Integer := Use_Default;
      MDI_Children_Maximized : Boolean := True;
      MDI_Main_Maximized     : Boolean := True;
      MRU                    : MRU_List;
      Ada_Files_Filter       : Unbounded_Wide_String :=
        To_Unbounded_Wide_String ("*.ads;*.adb;*.ada;*.hac");
      Smart_Editor           : Boolean := True;
   end record;

   Options : Option_Pack_Type;

   procedure Toggle_Show_Special (O : in out Option_Pack_Type);

   Indentation_Min : constant Integer := 1;
   Indentation_Max : constant Integer := 16;
   Tab_Width_Min   : constant Integer := 1;
   Tab_Width_Max   : constant Integer := 16;
   Margin_Min      : constant Integer := 0;
   Margin_Max      : constant Integer := 512;

   function Clamp_Int (Value, Lo, Hi : Integer) return Integer
     with Pre  => Lo <= Hi,
          Post => Clamp_Int'Result in Lo .. Hi
          and then (if Value < Lo then Clamp_Int'Result = Lo
                    elsif Value > Hi then Clamp_Int'Result = Hi
                    else Clamp_Int'Result = Value);

   procedure Clamp_Options (O : in out Option_Pack_Type)
     with Post =>
       O.Indentation in Indentation_Min .. Indentation_Max
       and then O.Tab_Width in Tab_Width_Min .. Tab_Width_Max
       and then O.Right_Margin in Margin_Min .. Margin_Max;

end Lui_Common.User_Options;
