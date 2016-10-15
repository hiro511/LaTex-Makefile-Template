### Makefile for LaTex Project

# change to your project
PROJECT = sdcr
LATEX_FILES = $(shell find . -maxdepth 1 -name "*.tex")

# change to your project
OUTPUT_DIR = build

LATEX = platex
LATEX_FLAGS = -shell-escape -output-directory=$(OUTPUT_DIR)
DVIPDFMX = dvipdfmx

All:$(PROJECT).pdf

# generate .pdf from .dvi
$(PROJECT).pdf: $(OUTPUT_DIR) $(OUTPUT_DIR)/$(PROJECT).dvi
	$(DVIPDFMX) -o $(PROJECT).pdf $(OUTPUT_DIR)/$(PROJECT).dvi

# generate .dvi from .aux
$(OUTPUT_DIR)/$(PROJECT).dvi: $(OUTPUT_DIR)/$(PROJECT).aux
	$(LATEX) $(LATEX_FLAGS) $(LATEX_FILES)

# generate .aux from .tex
$(OUTPUT_DIR)/$(PROJECT).aux: $(LATEX_FILES)
	$(LATEX) $(LATEX_FLAGS) $(LATEX_FILES)

# make an output directory
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# open .pdf
view:$(PROJECT).pdf
	open $^

ref:
	$(LATEX) $(LATEX_FLAGS) $(LATEX_FILES)

clean:
	rm -rf $(shell find . -name "build" -o -name $(PROJECT).pdf)
