TARGET					:= libCommon.a
CC						:= clang
CPC						:= clang++

COV_FLAGS               := --coverage
CFLAGS                  := -c -g -Wall
LDFLAGS                 := 

INCLUDES                := -I"$(abspath ./inc)"

SRC_DIR                 := $(abspath ./src)
SRCS                    := Common.cpp

OBJ_DIR                 := $(abspath ../obj)
OBJS                    := $(patsubst %.cpp, $(OBJ_DIR)/%.o, $(SRCS))

all: build_repo $(TARGET)

$(TARGET): $(OBJS)
	$(AR) -cvqT $@ $<

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CPC) $(CFLAGS) $(COV_FLAGS) $(INCLUDES) $< -o $@

build_repo: obj

obj:
	mkdir -p ./obj

clean:
	rm -rf ./obj
	rm -rf *.a