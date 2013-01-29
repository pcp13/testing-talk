base = slides
slidefilename = NAME

all: $(base).pdf

git-sha:
	echo `git describe --tags` > git-sha

$(base).pdf: | git-sha $(base).tex $(base).wiki.tex
	pdflatex -shell-escape $(base).tex
	pdflatex -shell-escape $(base).tex
	cp slides.pdf "$(slidefilename)"-`cat git-sha`.pdf

$(base).wiki.tex: $(base).wiki
	./wiki2beamer-0.9.4 $(base).wiki > $(base).wiki.tex

clean:
	-rm -vf $(addprefix $(base).,toc snm log aux out nav)

distclean: clean
	-rm -vf $(base).pdf $(base).wiki.tex "$(slidefilename)"-`cat git-sha`.pdf git-sha