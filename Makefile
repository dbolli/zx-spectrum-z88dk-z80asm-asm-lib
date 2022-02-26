# :dbolli:20220226 19:18:45 Based on ~/dev/unix-src/z88dk/libsrc/sprites/software/sp1/Makefile

Z88DKROOT=$(HOME)/dev/unix-src/z88dk

include $(Z88DKROOT)/libsrc/Make.config

Z80TARGETLIB=asm-lib

default: $(Z80TARGETLIB)-all

$(Z80TARGETLIB)-all:
	@echo
	@echo --- make build $(Z80TARGETLIB)---
	$(LIBLINKER) -v -x$(Z80TARGETLIB) -s -l -m -g @$(Z80TARGETLIB).lst

clean:
	$(RM) *.o
	$(RM) *.lis
	$(RM) *.sym
	$(RM) $(Z80TARGETLIB).lib
