CXX = g++
TARGET = bin/main.exe
OBJ = obj/main.o
CXXFLAGS = -c -Wall

$(TARGET): $(OBJ)
    $(CXX) -o $@ $^

obj/%.o: src/%.cpp
    $(CXX) $(CXXFLAGS) $< -o $@
