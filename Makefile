SHELL := /bin/bash
# use bash for <( ) syntax

.PHONY : figs


popsim-slides.slides.html : figs

figs :
	$(MAKE) -C figs

# change this to the location of your local MathJax.js library
LOCAL_MATHJAX = /usr/share/javascript/mathjax/MathJax.js
ifeq ($(wildcard $(LOCAL_MATHJAX)),)
	MATHJAX = https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js
else
	MATHJAX = $(LOCAL_MATHJAX)
endif

# may want to add "--self-contained" to the following
PANDOC_OPTS = --mathjax=$(MATHJAX)?config=TeX-AMS-MML_HTMLorMML --standalone
# optionally add in a latex file with macros
LATEX_MACROS = macros.tex
ifeq ($(wildcard $(LATEX_MACROS)),)
	# macros file isn't there
else
	PANDOC_OPTS += -H .pandoc.$(LATEX_MACROS)
endif

.pandoc.$(LATEX_MACROS) : $(LATEX_MACROS)
	(echo '\['; cat $(LATEX_MACROS); echo '\]') > $@

setup : .pandoc.$(LATEX_MACROS)
	@:

%.html : %.Rmd
	Rscript -e 'templater::render_template("$<", output="$@", change.rootdir=TRUE, clean=FALSE)'

%.html : %.md setup
	pandoc -o $@ $(PANDOC_OPTS) $<

%.md : %.Rmd
	# cd $$(dirname $<); Rscript -e 'knitr::knit_patterns[["set"]]($(KNITR_PATTERNS)); knitr::knit(basename("$<"),output=basename("$@"))'
	Rscript -e 'knitr::knit_patterns[["set"]]($(KNITR_PATTERNS)); templater::render_template("$<", output="$@", change.rootdir=TRUE)'


## VARIOUS SLIDE METHODS
REVEALJS_OPTS = -t revealjs -V theme=simple -V slideNumber=true -V transition=none -H resources/adjust-revealjs.style --slide-level 2
SLIDES_OPTS = $(REVEALJS_OPTS)

%.slides.html : %.md setup
	pandoc -o $@ $(SLIDES_OPTS) $(PANDOC_OPTS) $<

%.revealjs.html : %.md setup
	pandoc -o $@ $(REVEALJS_OPTS) $(PANDOC_OPTS) $<

## image conversion

%.pdf : %.svg
	inkscape $< --export-pdf=$@

# %.svg : %.pdf
# 	inkscape $< --export-plain-svg=$@

%.png : %.pdf
	convert -density 300 $< -flatten $@

%.gif : %.pdf
	convert -density 300 $< -flatten $@

%.png : %.svg
	convert -density 300 $< -flatten $@

%.gif : %.svg
	convert -density 300 $< -flatten $@

%.pdf : %.ink.svg
	inkscape $< --export-pdf=$@

# animated gif
%.anim.gif : $(wildcard %/*.gif)
	convert -loop 0 -delay 10 -coalesce -fuzz 2% -layers optimize $$(ls $*/*.gif) $@

