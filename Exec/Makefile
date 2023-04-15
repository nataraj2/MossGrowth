# Compiler flags
FC = gfortran
FCFLAGS = -O2

# Directories
MOD_DIR = mod

SRC_DIR=../Source

# List of source files
SRC_FILES = $(addprefix $(SRC_DIR)/, module_moss.f90 module_global.f90 module_io.f90 module_initialize.f90 module_timestep.f90 main.f90)

# List of object files
OBJ_FILES = $(addprefix $(MOD_DIR)/, $(notdir $(SRC_FILES:.f90=.o)))

# Rule to build object files
$(MOD_DIR)/%.o: $(SRC_DIR)/%.f90
	@mkdir -p $(MOD_DIR)
	$(FC) $(FCFLAGS) -c $< -o $@ -J$(MOD_DIR)

# Rule to build the executable
moss_growth.ex: $(OBJ_FILES)
	$(FC) $(FCFLAGS) $^ -o $@

# Rule to clean up object and mod files
clean:
	rm -f moss_growth.ex $(MOD_DIR)/*.o $(MOD_DIR)/*.mod
