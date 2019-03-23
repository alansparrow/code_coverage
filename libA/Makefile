TARGET					:= libA.a
CC						:= clang
CPC						:= clang++

COV_FLAGS               := -fprofile-arcs -ftest-coverage
CFLAGS                  := -c -g -Wall
LDFLAGS                 := -fprofile-arcs -ftest-coverage

INCLUDES                := \
						-I"./inc" \
						-I"../libCommon/inc"
EXT_LIBS				:= ../libCommon/libCommon.a
						

SRC_DIR                 := ./src
SRCS                    := A.cpp

OBJ_DIR                 := ./obj
OBJS                    := $(patsubst %.cpp, $(OBJ_DIR)/%.o, $(SRCS))

all: build_repo $(TARGET)

$(TARGET): $(OBJS)
	$(AR) -cvqT $@ $< $(EXT_LIBS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CPC) $(CFLAGS) $(COV_FLAGS) $(INCLUDES) $< -o $@

build_repo: obj

obj:
	mkdir -p obj

clean:
	rm -rf ./obj
	rm -rf *.a