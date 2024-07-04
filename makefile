OBJS     := $(shell cat link.rsp | tr -s "+\n" " " | sed -e "s/\.obj/.o/g")
#CFLAGS   := -g3 -w -fcompare-debug-second
#CFLAGS   := -g3 -Wno-implicit-int -Wno-implicit-function-declaration -Wno-int-to-pointer-cast
#CFLAGS   := -g3
CFLAGS   := -I.
LDFLAGS  := -static -L. -lkern -lm
#CC       := arm-linux-gnueabihf-gcc
STRIP    := strip

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
	./kcomp $< $@.c
	$(CC) $(CFLAGS) $@.c -o $@ $(LDFLAGS)

clean:
	$(RM) $(OBJS) kern.o kern kcomp.o kcomp libkern.a

cleanlisp:
	$(RM) lisp/*.c `find lisp -type f -executable -print`

chksizes: chksizes.c
	$(RM) $@
	$(CC) -o $@ $?
	./$@
	$(RM) $@

showobjs: $(OBJS)
	@echo $(OBJS) | tr " " "\n"

