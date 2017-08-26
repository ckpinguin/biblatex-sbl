TEMP-EXTENSIONS=.pdf .txt .aux .bbl .bcf .bib .blg .idx .ilg .ind .log .out .run.xml
PDFLATEX=pdflatex -interaction=batchmode
XELATEX=xelatex -interaction=batchmode
BIBER=biber -q -q
CMP=cmp --silent

export TEXINPUTS := ../latex/:$(TEXINPUTS):

TEST-PASS='\e[1;32m[PASS]\e[0m'
TEST-FAIL='\e[1;31m[FAIL]\e[0m'

DEPS=../latex/biblatex-sbl.def \
     ../latex/sbl.cbx \
     ../latex/sbl.bbx \
     ../latex/sbl.dbx \
     ../latex/sbl-american.lbx \
     ../latex/sbl-english.lbx

TXTS=standard-entries-minimal.txt \
     standard-entries-full.txt \
     sbl-entries-full.txt \
     biblatex-examples.txt \
     sblhs-tests.txt \
     pagination.txt

.PRECIOUS: %.bcf %.bbl %.pdf

.PHONY: test clean

test: $(TXTS)

%.bcf: %.tex $(DEPS)
	@echo -n "Building $< (first pass) ... "
	@$(PDFLATEX) $< > /dev/null
	@echo "Done."

sblhs-tests.bcf: sblhs-tests.tex $(DEPS) ../doc/biblatex-sbl.bib
	@echo -n "Building $< (first pass) ... "
	@$(XELATEX) $< > /dev/null
	@echo "Done."

pagination.bcf: pagination.tex $(DEPS) ../doc/biblatex-sbl.bib
	@echo -n "Building $< (first pass) ... "
	@$(XELATEX) $< > /dev/null
	@echo "Done."

%.bbl: %.bcf
	@echo -n "Running Biber on $< ... "
	@$(BIBER) $<
	@touch $@
	@echo "Done."

%.pdf: %.bbl
	@echo -n "Building $(basename $<).tex (second pass) ... "
	@$(PDFLATEX) $(basename $<).tex > /dev/null
	@echo "Done."
	@echo -n "Building $(basename $<).tex (third pass) ... "
	@$(PDFLATEX) $(basename $<).tex > /dev/null
	@touch $(basename $@).bcf
	@touch $(basename $@).bbl
	@touch $@
	@echo "Done."

sblhs-tests.pdf: sblhs-tests.bbl
	@echo -n "Building $(basename $<).tex (second pass) ... "
	@$(XELATEX) $(basename $<).tex > /dev/null
	@echo "Done."
	@echo -n "Building $(basename $<).tex (third pass) ... "
	@$(XELATEX) $(basename $<).tex > /dev/null
	@touch $(basename $@).bcf
	@touch $(basename $@).bbl
	@touch $@
	@echo "Done."

pagination.pdf: pagination.bbl
	@echo -n "Building $(basename $<).tex (second pass) ... "
	@$(XELATEX) $(basename $<).tex > /dev/null
	@echo "Done."
	@echo -n "Building $(basename $<).tex (third pass) ... "
	@$(XELATEX) $(basename $<).tex > /dev/null
	@touch $(basename $@).bcf
	@touch $(basename $@).bbl
	@touch $@
	@echo "Done."

%.txt: %.pdf
	@echo -n "Testing $(basename $<).tex ... "
	@pdftotext $<
	@$(CMP) $@ $(basename $@).ref.txt && /bin/echo -e $(TEST-PASS) || /bin/echo -e $(TEST-FAIL)
	@rm $@

clean:
	@echo -n "Cleaning test temporary files... "
	@rm -f $(addprefix standard-entries-minimal, $(TEMP-EXTENSIONS))
	@rm -f $(addprefix standard-entries-full, $(TEMP-EXTENSIONS))
	@rm -f $(addprefix sbl-entries-full, $(TEMP-EXTENSIONS))
	@rm -f $(addprefix biblatex-examples, $(TEMP-EXTENSIONS))
	@rm -f $(addprefix sblhs-tests, $(TEMP-EXTENSIONS))
	@rm -f $(addprefix pagination, $(TEMP-EXTENSIONS))
	@echo "Done."
