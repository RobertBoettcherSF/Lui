--------------------------------------------------------------------
--  Lui CLI stub — MVP milestone blurb                             --
--  Copyright (c) 2026 Robert Boettcher                           --
--------------------------------------------------------------------

with Ada.Text_IO;

procedure Lui is
   use Ada.Text_IO;
begin
   Put_Line ("Lui — Lightweight / LEA-inspired Ada editor");
   Put_Line ("Milestone: Linux-testable Ada core + thin GtkAda GUI");
   New_Line;
   Put_Line ("CLI stub: this binary is not the GUI.");
   Put_Line ("  make test      — V&V (expect 28 PASS)");
   Put_Line ("  make gui       — build bin/lui-gui (needs libgtkada-dev)");
   Put_Line ("  make run-gui   — run the GtkAda editor window");
   Put_Line
     ("SciLexer strategy: write DLL bytes to a filesystem path, "
      & "then LoadLibrary (not MemoryModule).");
end Lui;
