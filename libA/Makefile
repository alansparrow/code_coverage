TARGET					:= libA.a
CC						:= clang
CPC						:= clang++

COV_FLAGS               := --coverage
CFLAGS                  := -c -g -Wall
LDFLAGS                 := 

INCLUDES                := \
						-I"$(abspath ./inc)" \
						-I"$(abspath ../libCommon/inc)"
EXT_LIBS				:= $(abspath ../libCommon/libCommon.a)
						

SRC_DIR                 := $(abspath ./src)
SRCS                    := A.cpp

OBJ_DIR                 := $(abspath ../obj)
OBJS                    := $(patsubst %.cpp, $(OBJ_DIR)/%.o, $(SRCS))

all: build_repo $(TARGET)

$(TARGET): $(OBJS)
	$(AR) -cvqT $(abspath $@) $(abspath $<) $(EXT_LIBS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CPC) $(CFLAGS) $(COV_FLAGS) $(INCLUDES) $(abspath $<) -o $(abspath $@)

build_repo: obj

obj:
	mkdir -p obj

clean:
	rm -rf ./obj
	rm -rf *.a