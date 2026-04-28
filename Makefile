GBDK_HOME = $(HOME)/Desktop/gbdk
LCC       = $(GBDK_HOME)/bin/lcc
TARGET    = adventure.gb
SRCS      = main.c cursor.c character.c camera.c hotspot.c scene.c
OBJS      = $(SRCS:.c=.o)
CFLAGS    = -Wf-MMD

all: $(TARGET)

%.o: %.c
	$(LCC) $(CFLAGS) -c -o $@ $<

$(TARGET): $(OBJS)
	$(LCC) -o $(TARGET) $(OBJS)

clean:
	rm -f $(OBJS) $(TARGET) *.adb *.asm *.lst *.map *.noi *.sym
