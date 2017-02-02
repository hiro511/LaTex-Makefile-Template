### Makefile for LaTex Project

# change to your project
PROJECT = sdcr
LATEX_FILES = $(shell find . -maxdepth 1 -name "*.tex")
BIB_FILE = $(shell find . -maxdepth 1 -name "*.bib")

# change to your project
OUTPUT_DIR = build

LATEX = pdflatex
LATEX_FLAGS = -shell-escape -output-directory=$(OUTPUT_DIR)
DVIPDFMX = dvipdfmx
BIBTEX = bibtex

All:$(PROJECT).pdf

# generate .pdf from .dvi
$(PROJECT).pdf: $(OUTPUT_DIR) $(OUTPUT_DIR)/$(PROJECT).dvi
	$(LATEX) $(LATEX_FLAGS) $(LATEX_FILES)
	mv $(OUTPUT_DIR)/$(PROJECT).pdf ./$(PROJECT).pdf

# generate .aux from .tex
$(OUTPUT_DIR)/$(PROJECT).aux: $(LATEX_FILES)
	$(LATEX) $(LATEX_FLAGS) $(LATEX_FILES)

# generate .bbl from .bib
$(OUTPUT_DIR)/$(PROJECT).bbl:  $(BIB_FILE)
	$(BIBTEX) $(OUTPUT_DIR)/$(PROJECT).aux

# generate .dvi from .aux and .bbl
$(OUTPUT_DIR)/$(PROJECT).dvi: $(OUTPUT_DIR)/$(PROJECT).aux $(OUTPUT_DIR)/$(PROJECT).bbl
	$(LATEX) $(LATEX_FLAGS) $(LATEX_FILES)

# make an output directory
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# open .pdf
view:$(PROJECT).pdf
	open $^

clean:
	rm -rf $(shell find . -name "build" -o -name $(PROJECT).pdf)
