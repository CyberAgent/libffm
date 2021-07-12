CXX = g++
CXXFLAGS = -Wall -O3 -std=c++0x -march=native

ifneq ($(USESSE), OFF)
	DFLAG += -DUSESSE
endif

ifneq ($(USEOMP), OFF)
	DFLAG += -DUSEOMP
	OMP_CXXFLAGS ?= -fopenmp
	CXXFLAGS += $(OMP_CXXFLAGS)
endif

all: ffm-train ffm-predict

valgrind:
	docker build -t cyberagent/libffm .
	docker run -it --rm \
		-v `PWD`/data:/usr/src/data \
		bash

ffm-train: ffm-train.cpp ffm.o
	$(CXX) $(CXXFLAGS) -o $@ $^

ffm-predict: ffm-predict.cpp ffm.o
	$(CXX) $(CXXFLAGS) -o $@ $^

ffm.o: ffm.cpp ffm.h
	$(CXX) $(CXXFLAGS) $(DFLAG) -c -o $@ $<

clean:
	rm -f ffm-train ffm-predict ffm.o
