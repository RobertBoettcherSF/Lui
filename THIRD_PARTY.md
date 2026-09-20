# Third-party notices

## LEA (Lightweight Editor for Ada)

- Upstream: https://github.com/zertovitch/lea
- License: MIT
- Copyright: (c) 2017 .. 2026 Gautier de Montmollin

Lui adapts GUI-agnostic pieces from `lea_common*` (syntax helpers, color
themes, user option records) under `Lui_*` names. Derived files keep the
original copyright notice.

## SciLexer / Scintilla

- Not bundled in this repository yet.
- On Windows, Lui will extract or copy `SciLexer.dll` to a filesystem path
  and load it with `LoadLibrary` (or equivalent).
- LEA loads SciLexer from an appended ZIP via MemoryModule (MPL). Lui
  deliberately omits MemoryModule (`MemoryModule.c` / `.h`,
  `MEMORYMODULE_LICENSE`, `memorymodule.o`) to keep the tree MIT-clean.

## MemoryModule

**Not included.** Intentionally omitted because of the MPL license and
in-memory PE loading approach.
