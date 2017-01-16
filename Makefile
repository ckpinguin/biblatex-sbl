# Makefile to create zip file for CTAN upload

CTANDIR = biblatex-sbl
TDSDIR = biblatex-sbl.tds
TDSDOCDIR = $(TDSDIR)/doc/latex/biblatex-sbl
TDSTEXDIR = $(TDSDIR)/tex/latex/biblatex-sbl
TDSISTDIR = $(TDSDIR)/makeindex/biblatex-sbl

README   = README.md
ISTFILES = doc/sbl-paper-bibleref.ist
DOCFILES = doc/biblatex-sbl.bib \
	   doc/biblatex-sbl.pdf \
	   doc/biblatex-sbl.tex \
	   doc/biblatex-sbl-ibid.pdf \
	   doc/biblatex-sbl-ibid.tex \
	   doc/biblatex-sbl-test.pdf \
	   doc/biblatex-sbl-test.tex \
	   doc/sbl-paper.pdf \
	   doc/sbl-paper.tex
TEXFILES = doc/sbl-paper.sty \
	   latex/biblatex-sbl.def \
	   latex/sbl.bbx \
	   latex/sbl.cbx \
	   latex/sbl.dbx \
	   latex/sbl-american.lbx \
	   latex/sbl-british.lbx \
	   latex/sbl-english.lbx \
	   latex/sbl-german.lbx \
	   latex/sbl-spanish.lbx
TDSZIP   = biblatex-sbl.tds.zip
CTANZIP  = biblatex-sbl.zip

BIBLATEX-SBL-VERSION = $(shell grep def.sbl@abx@version latex/biblatex-sbl.def | awk -vRS='}' -vFS='{' '{print $$2}')
BIBLATEX-SBL-DATE = $(shell grep def.sbl@abx@date latex/biblatex-sbl.def | awk -vRS='}' -vFS='{' '{print $$2}')
BIBLATEX-SBL-COPYRIGHT = $(shell grep Copyright README.md)
SBL-PAPER-DATE = $(shell grep Society.of.Bibilical.Literature.Paper.Style doc/sbl-paper.sty | awk -vRS=']' -vFS='[' '{print $$2}' | awk '{print $$1}')
SBL-PAPER-COPYRIGHT = $(shell grep Copyright doc/sbl-paper.sty | sed -r 's/^.//')

ctanzip: $(CTANZIP)

tdszip: $(TDSZIP)

$(CTANZIP):
	rm -rf $(CTANZIP) $(CTANDIR)
	mkdir -p $(CTANDIR)
	cp $(README) $(CTANDIR)
	cp $(ISTFILES) $(CTANDIR)
	cp $(DOCFILES) $(CTANDIR)
	cp $(TEXFILES) $(CTANDIR)
	zip -r $(CTANZIP) $(CTANDIR)
	rm -rf $(CTANDIR)

$(TDSZIP):
	rm -rf $(TDSZIP) $(TDSDIR)
	mkdir -p $(TDSDOCDIR)
	mkdir -p $(TDSTEXDIR)
	mkdir -p $(TDSISTDIR)
	cp $(ISTFILES) $(TDSISTDIR)
	cp $(README) $(DOCFILES) $(TDSDOCDIR)
	cp $(TEXFILES) $(TDSTEXDIR)
	cd $(TDSDIR) && zip -r $(TDSZIP) *
	mv $(TDSDIR)/$(TDSZIP) .
	rm -rf $(TDSDIR)

test:
	cd test && make test

ctancheck:
	@echo "CTAN upload info:"
	@echo "\tName: biblatex-sbl"
	@echo "\tVersion: $(BIBLATEX-SBL-VERSION) $(BIBLATEX-SBL-DATE)"
	@echo "\tAuthor: David Purton"
	@echo "\tEmail: dcpurton@marshwiggle.net"
	@echo "\tSummary: Society of Biblical Literature (SBL) style files for BibLaTeX"
	@echo "\tCTAN directory: /macros/latex/contrib/biblatex-contrib/biblatex-sbl"
	@echo "\tType of Upload: Update (with announcement)"
	@echo "\tLicense type: license type: LaTeX Public Project License (version 1.3)"
	@echo "\nOther Checks:"
	@echo "\tsbl-paper.sty date: $(SBL-PAPER-DATE)"
	@echo "\tbiblatex-sbl copyright: $(BIBLATEX-SBL-COPYRIGHT)"
	@echo "\tsbl-paper.sty copyright: $(SBL-PAPER-COPYRIGHT)"

clean:
	@rm -rf $(TDSZIP) $(CTANZIP) $(CTANDIR) $(TDSDIR)
	@echo "Cleaning CTAN and TDS zip files"
	@cd test && make clean
