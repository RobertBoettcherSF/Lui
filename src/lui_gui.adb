--------------------------------------------------------------------
--  Lui thin GtkAda GUI (Linux) — Pareto milestone                  --
--  Copyright (c) 2026 Robert Boettcher                           --
--  MIT License                                                    --
--------------------------------------------------------------------

with Ada.Text_IO;
with Ada.Strings.Unbounded;

with Gtk.Main;         use Gtk.Main;
with Gtk.Window;       use Gtk.Window;
with Gtk.Widget;       use Gtk.Widget;
with Gtk.Box;          use Gtk.Box;
with Gtk.Enums;        use Gtk.Enums;
with Gtk.Menu_Bar;     use Gtk.Menu_Bar;
with Gtk.Menu;         use Gtk.Menu;
with Gtk.Menu_Item;    use Gtk.Menu_Item;
with Gtk.Scrolled_Window; use Gtk.Scrolled_Window;
with Gtk.Text_View;    use Gtk.Text_View;
with Gtk.Text_Buffer;  use Gtk.Text_Buffer;
with Gtk.Dialog;       use Gtk.Dialog;
with Gtk.File_Chooser; use Gtk.File_Chooser;
with Gtk.File_Chooser_Dialog; use Gtk.File_Chooser_Dialog;

procedure Lui_Gui is

   Main_Win : Gtk_Window;
   Vbox     : Gtk_Vbox;
   Menu_Bar : Gtk_Menu_Bar;
   File_Menu_Item : Gtk_Menu_Item;
   File_Menu      : Gtk_Menu;
   Open_Item      : Gtk_Menu_Item;
   Quit_Item      : Gtk_Menu_Item;
   Scrolled       : Gtk_Scrolled_Window;
   View           : Gtk_Text_View;
   Buffer         : Gtk_Text_Buffer;

   function Slurp_File (Path : String) return String is
      use Ada.Text_IO;
      use Ada.Strings.Unbounded;
      F   : File_Type;
      Acc : Unbounded_String;
   begin
      Open (F, In_File, Path);
      while not End_Of_File (F) loop
         Append (Acc, Get_Line (F));
         if not End_Of_File (F) then
            Append (Acc, ASCII.LF);
         end if;
      end loop;
      Close (F);
      return To_String (Acc);
   exception
      when others =>
         if Is_Open (F) then
            Close (F);
         end if;
         return "";
   end Slurp_File;

   procedure On_Win_Destroy
     (Self : access Gtk_Widget_Record'Class)
   is
      pragma Unreferenced (Self);
   begin
      Main_Quit;
   end On_Win_Destroy;

   procedure On_Quit
     (Self : access Gtk_Menu_Item_Record'Class)
   is
      pragma Unreferenced (Self);
   begin
      Destroy (Main_Win);
   end On_Quit;

   procedure On_Open
     (Self : access Gtk_Menu_Item_Record'Class)
   is
      pragma Unreferenced (Self);
      Dialog : Gtk_File_Chooser_Dialog;
      Dummy  : Gtk_Widget;
      pragma Unreferenced (Dummy);
   begin
      Gtk_New
        (Dialog,
         Title  => "Open File",
         Parent => Main_Win,
         Action => Action_Open);
      Dummy := Add_Button (Dialog, "_Cancel", Gtk_Response_Cancel);
      Dummy := Add_Button (Dialog, "_Open", Gtk_Response_Accept);

      if Run (Dialog) = Gtk_Response_Accept then
         declare
            Name : constant String := Get_Filename (Dialog);
         begin
            if Name'Length > 0 then
               Set_Text (Buffer, Slurp_File (Name));
            end if;
         end;
      end if;

      Destroy (Dialog);
   end On_Open;

begin
   Init;

   Gtk_New (Main_Win);
   Set_Title (Main_Win, "Lui");
   Set_Default_Size (Main_Win, 800, 600);
   Main_Win.On_Destroy (On_Win_Destroy'Unrestricted_Access);

   Gtk_New_Vbox (Vbox, Homogeneous => False, Spacing => 0);
   Main_Win.Add (Vbox);

   Gtk_New (Menu_Bar);

   Gtk_New_With_Mnemonic (File_Menu_Item, "_File");
   Gtk_New (File_Menu);
   Set_Submenu (File_Menu_Item, File_Menu);

   Gtk_New_With_Mnemonic (Open_Item, "_Open…");
   Open_Item.On_Activate (On_Open'Unrestricted_Access);
   Append (File_Menu, Open_Item);

   Gtk_New_With_Mnemonic (Quit_Item, "_Quit");
   Quit_Item.On_Activate (On_Quit'Unrestricted_Access);
   Append (File_Menu, Quit_Item);

   Append (Menu_Bar, File_Menu_Item);
   Pack_Start (Vbox, Menu_Bar, Expand => False, Fill => False, Padding => 0);

   Gtk_New (Scrolled);
   Set_Policy (Scrolled, Policy_Automatic, Policy_Automatic);
   Pack_Start (Vbox, Scrolled, Expand => True, Fill => True, Padding => 0);

   Gtk_New (View);
   Set_Monospace (View, True);
   Buffer := Get_Buffer (View);
   Set_Text
     (Buffer,
      "Lui — Lightweight / LEA-inspired Ada editor" & ASCII.LF
      & "Thin GtkAda GUI milestone (Linux)." & ASCII.LF
      & "File → Open… loads a file into this buffer." & ASCII.LF
      & "File → Quit closes the window." & ASCII.LF);
   Scrolled.Add (View);

   Show_All (Main_Win);
   Main;
end Lui_Gui;
