# Lui — Lightweight / LEA-inspired Ada editor (core MVP)
# Makefile-first; no Alire required for this milestone.

ADAFLAGS = -gnatwa -gnat2022 -gnato -fstack-check
SRCDIR   = src
TESTDIR  = tests
OBJDIR   = obj
BINDIR   = bin

.PHONY: all test clean dirs

all: test

dirs:
	mkdir -p $(OBJDIR) $(BINDIR)

test: dirs $(BINDIR)/tests
	./$(BINDIR)/tests

$(BINDIR)/tests: $(TESTDIR)/tests.adb $(wildcard $(SRCDIR)/*)
	gnatmake $(ADAFLAGS) -D $(OBJDIR) -I$(SRCDIR) \
		$(TESTDIR)/tests.adb -o $(BINDIR)/tests

clean:
	rm -rf $(OBJDIR) $(BINDIR) gnatprove
