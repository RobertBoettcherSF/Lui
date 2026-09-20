--------------------------------------------------------------------
--  Copyright (c) 2026 Robert Boettcher                           --
--------------------------------------------------------------------

with Ada.Directories;
with Ada.Streams.Stream_IO;

package body Lui_Scintilla_Deploy is

   function Join_Path (Dir, Name : String) return String is
   begin
      if Dir'Length = 0 then
         return Name;
      elsif Dir (Dir'Last) = '/' or else Dir (Dir'Last) = '\' then
         return Dir & Name;
      else
         return Dir & '/' & Name;
      end if;
   end Join_Path;

   procedure Write_Payload_To_Path
     (Target_Path : String; Payload : Stream_Element_Array)
   is
      use Ada.Streams.Stream_IO;
      File : File_Type;
   begin
      if Target_Path'Length = 0 then
         raise Deploy_Error with "empty target path";
      end if;
      Create (File, Out_File, Target_Path);
      begin
         if Payload'Length > 0 then
            Write (File, Payload);
         end if;
         Close (File);
      exception
         when others =>
            if Is_Open (File) then
               Close (File);
            end if;
            raise;
      end;
   end Write_Payload_To_Path;

   function Deploy_To_Directory
     (Directory : String;
      Payload   : Stream_Element_Array;
      DLL_Name  : String := Default_DLL_Name) return String
   is
      Full : constant String := Join_Path (Directory, DLL_Name);
   begin
      if not Ada.Directories.Exists (Directory) then
         Ada.Directories.Create_Path (Directory);
      end if;
      Write_Payload_To_Path (Full, Payload);
      return Full;
   end Deploy_To_Directory;

   procedure Cleanup_Path (Target_Path : String) is
   begin
      if Ada.Directories.Exists (Target_Path) then
         Ada.Directories.Delete_File (Target_Path);
      end if;
   end Cleanup_Path;

   function Path_Exists (Target_Path : String) return Boolean is
   begin
      return Ada.Directories.Exists (Target_Path);
   end Path_Exists;

   function LoadLibrary_Hint (Deployed_Path : String) return String is
   begin
      return
        "Windows: after writing SciLexer.dll to """
        & Deployed_Path
        & """, call LoadLibraryW/A on that path "
        & "(not MemoryModule). Documented for future GWindows integration.";
   end LoadLibrary_Hint;

end Lui_Scintilla_Deploy;
