# latexmk configuration for the LaTeX thesis template.
#
# The document is compiled with pdflatex only. The layout uses Type1 fonts
# (helvet for text, sansmathfonts for mathematics) and never loads fontspec
# or looks up system fonts, so XeLaTeX and LuaLaTeX are not supported.
#
# The bibliography is manually maintained Harvard text in
# backmatter/referensi.tex, so no BibTeX, Biber or makeindex pass is needed.
#
# build.sh supplies the output directory (-outdir=build) and prepares the
# include subdirectories; this file keeps the engine and the compiler flags
# in step with build.sh and is also honoured when Overleaf compiles main.tex.
# Overleaf's own -outdir option takes precedence over any directory setting,
# so no output directory is fixed here.

$pdf_mode = 1;    # pdf mode: pdflatex -> PDF
$pdflatex = 'pdflatex -file-line-error -synctex=1 -interaction=nonstopmode -halt-on-error %O %S';
$bibtex_use = 0;  # never run BibTeX: the bibliography is manual text
$makeindex = '';  # no index in this document

@default_files = ('main.tex');
