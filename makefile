OBJS 	:= $(shell cat link.rsp | tr -s "+\n" " " | sed -e "s/\.obj/.o/g")
#CFLAGS   := -I. -g3 -w -fcompare-debug-second
#CFLAGS   := -I. -g3 -Wno-implicit-int -Wno-implicit-function-declaration -Wno-int-to-pointer-cast
#CFLAGS   := -I. -g3 -Wno-implicit-int -Wno-implicit-function-declaration
#CFLAGS   := -I. -g3 -Wno-implicit-int
#CFLAGS  := -I. -Wno-pointer-to-int-cast -Wno-int-to-pointer-cast
#CFLAGS  := -I. -Wno-pointer-to-int-cast
#CFLAGS  := -I. -Wno-int-to-pointer-cast
CFLAGS   := -I.
LDFLAGS := -L. -lkern -lm
STRIP   := strip
QEMU	:=

ifeq ($(DEBUG), t)
	CFLAGS  += -ggdb3
	STRIP	:= echo
endif
ifeq ($(OPTIMIZE), t)
	CFLAGS  += -O3
endif
ifeq ($(PROFILE), t)
	CFLAGS	+= -pg
	STRIP	:= echo
endif
ifeq ($(RTL), t)
	CFLAGS  += -fdump-rtl-expand
	STRIP   := echo
endif
ifeq ($(TARGET), armhf)
	CC    	:= arm-linux-gnueabihf-gcc
	QEMU    := qemu-arm -L /usr/arm-linux-gnueabihf
endif

all: kern kcomp

kern.o: kernel.h libkern.a
kern: kern.o
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
	$(STRIP) $@

kcomp.o: kernel.h libkern.a
kcomp: kcomp.o
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
	$(STRIP) $@

libkern.a: $(OBJS)
	ar -crs libkern.a $^

%.o: %.c kernel.h
	$(CC) $(CFLAGS) -c $< -o $@

%: %.k kernel.h libkern.a
	$(QEMU) ./kcomp $< $@.c
	$(CC) $(CFLAGS) $@.c -o $@ $(LDFLAGS)

.PHONY: run clean cleanlisp cleanexpand chksizes showobjs callgraph

run:
	$(QEMU) ./kern

clean:
	$(RM) $(OBJS) kern.o kern kcomp.o kcomp libkern.a

cleanlisp:
	$(RM) lisp/*.c `find lisp -type f -executable -print`

cleanexpand:
	$(RM) *.expand

chksizes: chksizes.c
	$(RM) $@
	$(CC) -o $@ $?
	$(QEMU) ./$@
	$(RM) $@
showobjs: $(OBJS)
	@echo $(OBJS) | tr " " "\n"

callgraph:
	find . -name "*.expand" | xargs cally --caller $(TOP) --exclude "_mcount" | dot -Grankdir=LR -Tpdf -o callgraph/callgraph_$(TOP).pdf
