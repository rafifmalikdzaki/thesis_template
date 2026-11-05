#!/usr/bin/env bash
set -euo pipefail
# Build the LaTeX thesis template with latexmk (pdflatex engine). Settings are
# kept in step with .latexmkrc; the compiled main.pdf is copied to the
# repository root. Intermediate files stay in build/, which is git-ignored.
# Works from any working directory.
cd "$(dirname "$0")"

command -v latexmk >/dev/null 2>&1 || {
  printf 'error: latexmk not found; install TeX Live 2025+ with latexmk\n' >&2
  exit 1
}

# latexmk -outdir does not create the subdirectories that \include needs for
# the per-part .aux files, so prepare them first.
mkdir -p build build/frontmatter build/chapters build/backmatter build/lampiran

latexmk -pdf -file-line-error -synctex=1 \
  -interaction=nonstopmode -halt-on-error \
  -outdir=build main.tex

cp -f build/main.pdf main.pdf
printf 'built %s/main.pdf\n' "$(pwd)"
