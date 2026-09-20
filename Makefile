# Lui — Lightweight / LEA-inspired Ada editor (core MVP)
# Makefile-first; no Alire required for this milestone.

ADAFLAGS = -gnatwa -gnat2022 -gnato -fstack-check
SRCDIR   = src
TESTDIR  = tests
OBJDIR   = obj
BINDIR   = bin

.PHONY: all lui test run clean dirs

all: lui

dirs:
	mkdir -p $(OBJDIR) $(BINDIR)

lui: dirs $(BINDIR)/lui

$(BINDIR)/lui: $(SRCDIR)/lui.adb
	gnatmake $(ADAFLAGS) -D $(OBJDIR) -I$(SRCDIR) \
		$(SRCDIR)/lui.adb -o $(BINDIR)/lui

test: dirs $(BINDIR)/tests
	./$(BINDIR)/tests

$(BINDIR)/tests: $(TESTDIR)/tests.adb $(wildcard $(SRCDIR)/*)
	gnatmake $(ADAFLAGS) -D $(OBJDIR) -I$(SRCDIR) \
		$(TESTDIR)/tests.adb -o $(BINDIR)/tests

run: lui
	./$(BINDIR)/lui

clean:
	rm -rf $(OBJDIR) $(BINDIR) gnatprove
