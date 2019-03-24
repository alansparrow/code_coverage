TARGET1					:= Test
TARGET2					:= TestCombine

CC						:= clang
CPC						:= clang++

COV_FLAGS               := --coverage
CFLAGS                  := -c -g -Wall
LDFLAGS                 := -g -Wall

INCLUDES                := \
						-I"$(abspath ./libCommon/inc)" \
						-I"$(abspath ./libA/inc)" \
						-I"$(abspath ./libB/inc)" \
						-I"$(abspath ./libCombine/inc)" 

EXT_LIBS_PATHS			:= \
						-L$(abspath ./libA)
EXT_LIBS_NAMES			:= \
						-lA
#EXT_LIBS				:= $(EXT_LIBS_PATHS) $(EXT_LIBS_NAMES)
EXT_LIBS1				:= \
						$(abspath ./libA/libA.a) \
						$(abspath ./libB/libB.a)

EXT_LIBS2				:= \
						$(abspath ./libCombine/libCombine.a)

SRC_DIR                 := $(abspath ./)
SRCS1                   := Test.cpp
SRCS2                   := TestCombine.cpp

OBJ_DIR                 := $(abspath ./obj)
OBJS1                   := $(patsubst %.cpp, $(OBJ_DIR)/%.o, $(SRCS1))
OBJS2                   := $(patsubst %.cpp, $(OBJ_DIR)/%.o, $(SRCS2))

.PHONY: all build_repo build_libs libCommon libA libB libCombine clean

all: | build_repo build_libs $(TARGET1) $(TARGET2)

$(TARGET1): $(OBJS1)
	$(CPC) $(LDFLAGS) $(COV_FLAGS) -o $@ $(OBJS1) $(EXT_LIBS1)

$(TARGET2): $(OBJS2)
	$(CPC) $(LDFLAGS) $(COV_FLAGS) -o $@ $(OBJS2) $(EXT_LIBS2)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CPC) $(CFLAGS) $(COV_FLAGS) $(INCLUDES) $< -o $@

build_libs: | libCommon libA libB libCombine
	
libCommon:
	cd ./libCommon && $(MAKE)
libA:
	cd ./libA && $(MAKE)
libB:
	cd ./libB && $(MAKE)
libCombine:
	cd ./libCombine && $(MAKE)

build_repo:
	mkdir -p ./obj
	cp ./llvm-gcov.sh ./obj && chmod +x ./obj/llvm-gcov.sh

clean:
	rm -rf ./obj
	rm -rf *.a

	cd ./libCommon && $(MAKE) clean
	cd ./libA && $(MAKE) clean
	cd ./libB && $(MAKE) clean
	cd ./libCombine && $(MAKE) clean

	rm -rf Test TestCombine

	rm -rf ./*.profraw
	