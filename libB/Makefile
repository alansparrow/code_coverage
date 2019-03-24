TARGET					:= libB.a
CC						:= clang
CPC						:= clang++

COV_FLAGS               := --coverage
CFLAGS                  := -c -g -Wall
LDFLAGS                 := 

INCLUDES                := \
						-I"$(abspath ./inc)" \
						-I"$(abspath ../libCommon/inc)"
EXT_LIBS				:= $(abspath ../libCommon/libCommon.a)
						
PRJ_DIR					:= $(abspath .)
SRC_DIR                 := $(abspath ./src)
SRCS                    := B.cpp

OBJ_DIR                 := $(abspath ../obj)
OBJS                    := $(patsubst %.cpp, $(OBJ_DIR)/%.o, $(SRCS))

all: 
	$(MAKE) x_objs && $(MAKE) $(TARGET)

$(TARGET): $(OBJS)
	$(AR) -cvr $(abspath $@) $(abspath $<) $(wildcard *.o)
	rm -rf *.o

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp 
	$(CPC) $(CFLAGS) $(COV_FLAGS) $(INCLUDES) $(abspath $<) -o $(abspath $@)

x_objs:
	for lib in $(EXT_LIBS); do ar -x $$lib; done

clean:
	rm -rf *.o
	rm -rf *.a