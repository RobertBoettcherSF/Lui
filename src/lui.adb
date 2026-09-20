--------------------------------------------------------------------
--  Lui CLI stub — MVP milestone blurb (no GUI yet)               --
--  Copyright (c) 2026 Robert Boettcher                           --
--------------------------------------------------------------------

with Ada.Text_IO;

procedure Lui is
   use Ada.Text_IO;
begin
   Put_Line ("Lui — Lightweight / LEA-inspired Ada editor");
   Put_Line ("Milestone: Linux-testable Ada core (MVP)");
   New_Line;
   Put_Line ("GUI is not built yet (no GWindows in this milestone).");
   Put_Line ("Run `make test` or `./bin/tests` for V&V.");
   Put_Line
     ("SciLexer strategy: write DLL bytes to a filesystem path, "
      & "then LoadLibrary (not MemoryModule).");
end Lui;
