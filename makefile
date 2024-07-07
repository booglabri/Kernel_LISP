OBJS     := $(shell cat link.rsp | tr -s "+\n" " " | sed -e "s/\.obj/.o/g")
#CFLAGS   := -I. -g3 -w -fcompare-debug-second
#CFLAGS   := -I. -g3 -Wno-implicit-int -Wno-implicit-function-declaration -Wno-int-to-pointer-cast
#CFLAGS   := -I. -g3 -Wno-implicit-int -Wno-implicit-function-declaration
#CFLAGS   := -I. -g3 -Wno-implicit-int
#CFLAGS   := -I. -g3
#CFLAGS   := -I. -O3
CFLAGS   := -I.
LDFLAGS  := -static -L. -lkern -lm
ifeq ($(TARGET), armhf)
	CC       := arm-linux-gnueabihf-gcc
	QEMU     := qemu-arm -L /usr/arm-linux-gnueabihf
endif
STRIP    := strip
#STRIP    := echo

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

.PHONY: run clean cleanlips chksizes showobjs

run:
	$(QEMU) ./kern

clean:
	$(RM) $(OBJS) kern.o kern kcomp.o kcomp libkern.a

cleanlisp:
	$(RM) lisp/*.c `find lisp -type f -executable -print`

chksizes: chksizes.c
	$(RM) $@
	$(CC) -o $@ $?
	$(QEMU) ./$@
	$(RM) $@

showobjs: $(OBJS)
	@echo $(OBJS) | tr " " "\n"

