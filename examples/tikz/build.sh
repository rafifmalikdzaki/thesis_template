#!/usr/bin/env bash
set -euo pipefail
# Rebuild the six example diagrams as vector PDFs in ../../assets/.
# This is a LaTeX-only extension: the manuscript build never runs TikZ.
# Asset paths stay relative to the LaTeX project root (../../assets from
# examples/tikz/). The script works from any working directory.
cd "$(dirname "$0")"
assets_dir="../../assets"
mkdir -p build

figures=(
  fig-3-alur
  fig-4-arsitektur
  fig-5-integrasi
  fig-6-alur
  fig-6-f1
  fig-6-latensi
)

for figure in "${figures[@]}"; do
  pdflatex -interaction=nonstopmode -halt-on-error \
    -file-line-error -output-directory=build "${figure}.tex"
  cp -f "build/${figure}.pdf" "${assets_dir}/${figure}.pdf"
  printf 'wrote %s/%s.pdf\n' "${assets_dir}" "${figure}"
done
