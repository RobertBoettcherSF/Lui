--------------------------------------------------------------------
--  Lui_Scintilla_Deploy — disk-based SciLexer deployment         --
--                                                                --
--  NO MemoryModule.                                              --
--                                                                --
--  LEA: unpack SciLexer.dll from appended ZIP + MemoryModule.    --
--  Lui: write DLL bytes to a filesystem path, then on Windows    --
--       call LoadLibrary on that path.                           --
--                                                                --
--  Linux tests: write / join / cleanup with a fake payload.      --
--                                                                --
--  Copyright (c) 2026 Robert Boettcher                           --
--------------------------------------------------------------------

with Ada.Streams;

package Lui_Scintilla_Deploy is

   use Ada.Streams;

   Default_DLL_Name : constant String := "SciLexer.dll";

   Deploy_Error : exception;

   function Join_Path (Dir, Name : String) return String
     with Pre  => Name'Length > 0
                  and then Dir'Length + Name'Length + 1 < Integer'Last,
          Post => Join_Path'Result'Length >= Name'Length;

   procedure Write_Payload_To_Path
     (Target_Path : String; Payload : Stream_Element_Array);

   function Deploy_To_Directory
     (Directory : String;
      Payload   : Stream_Element_Array;
      DLL_Name  : String := Default_DLL_Name) return String;

   procedure Cleanup_Path (Target_Path : String);

   function Path_Exists (Target_Path : String) return Boolean;

   function LoadLibrary_Hint (Deployed_Path : String) return String;

end Lui_Scintilla_Deploy;
