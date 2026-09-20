# Lui

**Lui** (Lightweight / LEA-inspired Ada editor) is a green-field editor
project inspired by [LEA](https://github.com/zertovitch/lea)
(Lightweight Editor for Ada) by Gautier de Montmollin.

This repository is an **honest MVP**: a Linux-testable Ada **core**, not a
finished Windows GUI editor.

## What works today

Clone on Linux Mint (or any Linux with GNAT) and run the tests:

```sh
git clone https://github.com/RobertBoettcherSF/Lui.git
cd Lui
make test
```

Requires a recent GNAT (`gnatmake`). Flags used: `-gnatwa -gnat2022`.

### Packages in this milestone

| Package | Role |
|---------|------|
| `Lui_Common` | UTF helpers, shared enumerations |
| `Lui_Common.Color_Themes` | Theme names + RGB tables (LEA-derived) |
| `Lui_Common.Syntax` | Ada/GPR keyword lists + `Guess_Syntax` (LEA-derived) |
| `Lui_Common.User_Options` | Option records + clamp helpers (LEA-derived, no HAC) |
| `Lui_Scintilla_Deploy` | Write DLL/payload bytes to a disk path; join/cleanup |

`make test` exercises themes, syntax guessing, option clamps, UTF round-trip,
and SciLexer **deploy logic** with a tiny fake payload (no real PE / DLL).

## What is *not* in this milestone

- **No full GUI editor.** LEA’s UI needs GWindows + SciLexer on Windows.
- **No GWindows port yet.**
- **No real SciLexer.dll** bundled.
- **No MemoryModule** (`MemoryModule.c` / `.h`, `MEMORYMODULE_LICENSE`,
  `memorymodule.o`) — deliberately omitted (MPL / in-memory PE load).
- **No Alire crate** yet (Makefile-first; Alire only if deps demand it later).

## What’s next

1. Windows integration: extract/copy real `SciLexer.dll` to temp or app dir,
   then `LoadLibrary` that path.
2. GWindows UI port (editor frame, menus, Scintilla control wiring).
3. Optional Alire when third-party Ada crates are pulled in.
4. Optional SPARK Level 2 on more pure helpers (`Clamp_Int` / `Join_Path`
   already carry Ada contracts).

## How SciLexer will be loaded (Lui vs LEA)

| | **LEA** | **Lui (this project)** |
|---|---------|-------------------------|
| Packaging | SciLexer inside ZIP appended to `lea.exe` | DLL bytes written to a **filesystem path** |
| Load | [MemoryModule](https://github.com/fancycode/MemoryModule) (MPL) — load PE from memory | Windows `LoadLibrary` / `LoadLibraryW` on the written path |
| In this repo | — | `Lui_Scintilla_Deploy` implements write / join / cleanup; Linux tests use a fake file |

## License

- **Our code:** MIT — see [LICENSE](LICENSE).
- **LEA-derived files:** retain **Gautier de Montmollin** copyright notices
  in headers; LEA itself is MIT. Credit:
  [zertovitch/lea](https://github.com/zertovitch/lea).
- Details: [THIRD_PARTY.md](THIRD_PARTY.md).

## LLM usage disclosure

AI assistance (LLM tooling) was used to help draft and adapt code, tests,
and documentation for this project. Human review and local `make test`
validation remain the gate for what is published.

## Credits

- [LEA](https://github.com/zertovitch/lea) — Gautier de Montmollin
- Scintilla / SciLexer — upstream Scintilla project (to be integrated later)
