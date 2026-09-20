# Lui — Lightweight / LEA-inspired Ada editor
# Makefile-first; no Alire required for this milestone.

ADAFLAGS = -gnatwa -gnat2022 -gnato -fstack-check
SRCDIR   = src
TESTDIR  = tests
OBJDIR   = obj
BINDIR   = bin

.PHONY: all lui gui lui-gui test run run-gui clean dirs

all: lui

dirs:
	mkdir -p $(OBJDIR) $(BINDIR)

lui: dirs $(BINDIR)/lui

$(BINDIR)/lui: $(SRCDIR)/lui.adb
	gnatmake $(ADAFLAGS) -D $(OBJDIR) -I$(SRCDIR) \
		$(SRCDIR)/lui.adb -o $(BINDIR)/lui

# Thin GtkAda GUI (Linux). Requires: apt install libgtkada-dev gprbuild
gui lui-gui: dirs
	gprbuild -p -P lui_gui.gpr

test: dirs $(BINDIR)/tests
	./$(BINDIR)/tests

$(BINDIR)/tests: $(TESTDIR)/tests.adb $(wildcard $(SRCDIR)/*)
	gnatmake $(ADAFLAGS) -D $(OBJDIR) -I$(SRCDIR) \
		$(TESTDIR)/tests.adb -o $(BINDIR)/tests

run: lui
	./$(BINDIR)/lui

run-gui: gui
	./$(BINDIR)/lui-gui

clean:
	rm -rf $(OBJDIR) $(BINDIR) gnatprove
	-gprclean -q -P lui_gui.gpr 2>/dev/null || true
