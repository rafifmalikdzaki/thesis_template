# latexmk configuration for the engine-agnostic thesis template.
#
# The engine is selected on the latexmk command line (-pdf for pdfLaTeX,
# -xelatex, -lualatex) by build.sh or by Overleaf's compiler setting; this
# file therefore defines the per-engine command strings with the same flags
# and does NOT set $pdf_mode. pdfLaTeX is the recommended default: it keeps
# the exact institutional look (Helvetica text, sans-serif mathematics via
# sansmathfonts) and stable pagination. XeLaTeX/LuaLaTeX use fontspec and
# Latin Modern Math, so pagination may shift slightly.
#
# Thesis.cls handles the engine-specific font setup. metadata.tex is read
# by the class, and the bibliography is manually maintained Harvard text in
# backmatter/referensi.tex, so no BibTeX, Biber or makeindex pass is needed.
#
# build.sh supplies the output directory (-outdir=build) and prepares the
# include subdirectories; Overleaf's own -outdir option takes precedence
# over any directory setting, so no output directory is fixed here.

$pdflatex = 'pdflatex -file-line-error -synctex=1 -interaction=nonstopmode -halt-on-error %O %S';
$xelatex = 'xelatex -file-line-error -synctex=1 -interaction=nonstopmode -halt-on-error %O %S';
$lualatex = 'lualatex -file-line-error -synctex=1 -interaction=nonstopmode -halt-on-error %O %S';

$bibtex_use = 0;  # never run BibTeX: the bibliography is manual text
$makeindex = '';  # no index in this document

@default_files = ('main.tex');
