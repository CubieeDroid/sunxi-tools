CC = gcc
CFLAGS = -g -O2 -Wall -Wextra
CFLAGS += -std=c99 -D_POSIX_C_SOURCE=200112L

FEXC_MULTI = bin2fex fex2bin
TOOLS = fexc pins
ALL = $(TOOLS) $(FEXC_MULTI)

.PHONY: all clean

all: $(ALL)

clean:
	@rm -vf $(ALL)


$(TOOLS): Makefile common.h

$(FEXC_MULTI): fexc
	ln -s $< $@

fexc: script.h script.c \
	script_bin.h script_bin.c \
	script_fex.h script_fex.c

pins: pins_a10.c

%: %.c %.h
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(filter %.c,$^) $(LIBS)

.gitignore: Makefile
	@for x in $(ALL) '*.o' '*.swp'; do \
		echo $$x; \
	done > $@
