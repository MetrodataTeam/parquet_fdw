MODULE_big = parquet_fdw
OBJS = parquet.o parquet_fdw.o 
PGFILEDESC = "parquet_fdw - foreign data wrapper for parquet"

SHLIB_LINK = -lm -lstdc++ -lparquet -larrow
PG_CXXFLAGS += -std=c++11 -O3

EXTENSION = parquet_fdw
DATA = parquet_fdw--0.1.sql

REGRESS = parquet_fdw

EXTRA_CLEAN = sql/parquet_fdw.sql expected/parquet_fdw.out

PG_CONFIG ?= pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

parquet.bc:
	$(COMPILE.cxx.bc) $(CCFLAGS) $(CPPFLAGS) -fPIC -c -o $@ parquet_impl.cpp

parquet.o:
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(PG_CXXFLAGS) parquet_impl.cpp $(PG_LIBS) -c -fPIC $(LDFLAGS) $(LDFLAGS_EX) $(LIBS) -o $@$(X)
