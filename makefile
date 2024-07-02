OBJS   := $(shell cat link.rsp | tr -s "+\n" " " |sed -e "s/\.obj/.o/g")
CFLAGS := -g3 -w -fcompare-debug-second
#CFLAGS := -g3
LIB    := -static -lm
#CC     := arm-linux-gnueabihf-gcc
STRIP  := echo

all: kern kcomp

kern: kern.o $(OBJS)
	$(CC) -o $@ $? $(LIB)
	$(STRIP) $@

kcomp: kcomp.o $(OBJS)
	$(CC) -o $@ $? $(LIB)
	$(STRIP) $@

%.o: $.h

%.o: $.c
	$(CC) $< $(CFLAGS) -o $@

clean:
	rm -f $(OBJS) kern.o kern kcomp.o kcomp
