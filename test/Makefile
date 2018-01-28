TEMP-EXTENSIONS=.pdf .txt .aux .bbl .bcf .bib .blg .idx .ilg .ind .log .out .run.xml
LUALATEX=lualatex -interaction=batchmode
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
     pagination.txt \
     bookpagination.txt

.PRECIOUS: %.bcf %.bbl %.pdf

.PHONY: test clean

test: $(TXTS)

%.bcf: %.tex $(DEPS)
	@echo -n "Building $< (first pass) ... "
	@$(LUALATEX) $< > /dev/null
	@echo "Done."

%.bbl: %.bcf
	@echo -n "Running Biber on $< ... "
	@$(BIBER) $<
	@touch $@
	@echo "Done."

%.pdf: %.bbl
	@echo -n "Building $(basename $<).tex (second pass) ... "
	@$(LUALATEX) $(basename $<).tex > /dev/null
	@echo "Done."
	@echo -n "Building $(basename $<).tex (third pass) ... "
	@$(LUALATEX) $(basename $<).tex > /dev/null
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
	@rm -f $(addprefix bookpagination, $(TEMP-EXTENSIONS))
	@echo "Done."
