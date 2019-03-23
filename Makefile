TARGET					:= Test
CC						:= clang
CPC						:= clang++

COV_FLAGS               := -fprofile-arcs -ftest-coverage
CFLAGS                  := -c -g -Wall
LDFLAGS                 := -g -Wall

INCLUDES                := \
						-I"./libA/inc"

EXT_LIBS_PATHS			:= \
						-L./libA
EXT_LIBS_NAMES			:= \
						-lA
#EXT_LIBS				:= $(EXT_LIBS_PATHS) $(EXT_LIBS_NAMES)
EXT_LIBS				:= \
						./libA/libA.a

SRC_DIR                 := ./
SRCS                    := Test.cpp

OBJ_DIR                 := ./obj
OBJS                    := $(patsubst %.cpp, $(OBJ_DIR)/%.o, $(SRCS))

.PHONY: all build_repo build_libs libCommon libA libB clean

all: | build_repo build_libs $(TARGET)

$(TARGET): $(OBJS)
	$(CPC) $(LDFLAGS) $(COV_FLAGS) -o $@ $(OBJS) $(EXT_LIBS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CPC) $(CFLAGS) $(COV_FLAGS) $(INCLUDES) $< -o $@

build_libs: | libCommon libA libB
	
libCommon:
	cd ./libCommon && $(MAKE)
libA:
	cd ./libA && $(MAKE)
libB:
	cd ./libB && $(MAKE)

build_repo:
	mkdir -p ./obj

clean:
	rm -rf ./obj
	rm -rf *.a

	cd ./libCommon && $(MAKE) clean
	cd ./libA && $(MAKE) clean
	cd ./libB && $(MAKE) clean
	