OBJS   := $(shell cat link.rsp | tr -s "+\n" " " |sed -e "s/\.obj/.o/g")
#CFLAGS := -g3 -w -fcompare-debug-second
#CFLAGS := -g3 -Wno-implicit-int -Wno-implicit-function-declaration -Wno-int-to-pointer-cast
CFLAGS := -g3
LIB    := -static -lm
#CC     := arm-linux-gnueabihf-gcc
STRIP  := echo

all: kern kcomp

kern: kern.o $(OBJS) kernel.h
	$(CC) -o $@ $? $(LIB)
	$(STRIP) $@

kcomp: kcomp.o $(OBJS) kernel.h
	$(CC) -o $@ $? $(LIB)
	$(STRIP) $@

chksizes: chksizes.c
	$(CC) -o $@ $?
	./$@
	$(RM) $@

%.o: %.c kernel.h
	$(CC) -c $< $(CFLAGS) -o $@

clean:
	$(RM) $(OBJS) kern.o kern kcomp.o kcomp
