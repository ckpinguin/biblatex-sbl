TEMP-EXTENSIONS=.pdf .txt .aux .bbl .bcf .bib .blg .idx .ilg .ind .log .out .run.xml
PDFLATEX=pdflatex -interaction=batchmode
LUALATEX=lualatex -interaction=batchmode
BIBER=biber -q -q
CMP=cmp --silent

TEST-PASS=' \e[1;32m[PASS]\e[0m'
TEST-FAIL=' \e[1;31m[FAIL]\e[0m'

PDFLATEX-TEST-FILES=standard-entries-minimal.txt \
	standard-entries-full.txt \
	sbl-entries-full.txt \
	biblatex-examples.txt

LUALATEX-TEST-FILES=sblhs-tests.txt

.PHONY: test clean

test: $(PDFLATEX-TEST-FILES) $(LUALATEX-TEST-FILES)

$(PDFLATEX-TEST-FILES):
	@echo -n "Testing $(basename $@) ..."
	@rm -f $(addprefix $(basename $@), $(TEMP-EXTENSIONS))
	@$(PDFLATEX) $(basename $@) > /dev/null
	@echo -n "."
	@$(BIBER) $(basename $@)
	@$(PDFLATEX) $(basename $@) > /dev/null
	@echo -n "."
	@$(PDFLATEX) $(basename $@) > /dev/null
	@pdftotext $(addprefix $(basename $@), .pdf)
	@$(CMP) $@ $(addprefix $(basename $@), .ref.txt) && /bin/echo -e $(TEST-PASS) || /bin/echo -e $(TEST-FAIL)
	@rm $@

$(LUALATEX-TEST-FILES):
	@echo -n "Testing $(basename $@) ..."
	@rm -f $(addprefix $(basename $@), $(TEMP-EXTENSIONS))
	@$(LUALATEX) $(basename $@) > /dev/null
	@echo -n "."
	@$(BIBER) $(basename $@)
	@$(LUALATEX) $(basename $@) > /dev/null
	@echo -n "."
	@$(LUALATEX) $(basename $@) > /dev/null
	@pdftotext $(addprefix $(basename $@), .pdf)
	@$(CMP) $@ $(addprefix $(basename $@), .ref.txt) && /bin/echo -e $(TEST-PASS) || /bin/echo -e $(TEST-FAIL)
	@rm $@

clean:
	@echo -n "Cleaning test temporary files... "
	@rm -f $(addprefix standard-entries-minimal, $(TEMP-EXTENSIONS))
	@rm -f $(addprefix standard-entries-full, $(TEMP-EXTENSIONS))
	@rm -f $(addprefix sbl-entries-full, $(TEMP-EXTENSIONS))
	@rm -f $(addprefix biblatex-examples, $(TEMP-EXTENSIONS))
	@rm -f $(addprefix sblhs-tests, $(TEMP-EXTENSIONS))
	@echo "Done."
