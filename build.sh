#!/usr/bin/env bash
set -euo pipefail
# Build the LaTeX thesis template with latexmk. The document class detects the
# engine; pdfLaTeX is the optimized default, XeLaTeX and LuaLaTeX are also
# supported. Intermediate files stay in build/ (git-ignored) and the compiled
# main.pdf is copied to the repository root. Works from any working directory.
#
#   bash build.sh                          # pdfLaTeX (default, recommended)
#   bash build.sh --engine=xelatex         # XeLaTeX
#   bash build.sh --engine lualatex        # LuaLaTeX
#   ENGINE=xelatex bash build.sh           # same, via environment
#
# Options:
#   --engine=ENGINE | --engine ENGINE   pdflatex (default), xelatex, lualatex
#   -h, --help                          print this help and exit

usage() {
  sed -n '3,15p' "$0" | sed 's/^# \{0,1\}//'
}

engine="${ENGINE:-pdflatex}"
while (($#)); do
  case "$1" in
    --engine=*)
      engine="${1#*=}"
      shift
      ;;
    --engine)
      (($# >= 2)) || {
        printf 'error: --engine requires a value\n' >&2
        exit 2
      }
      engine="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf 'error: unknown argument: %s\n' "$1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

case "$engine" in
  pdflatex)
    engine_binary="pdflatex"
    latexmk_mode="-pdf"
    ;;
  xelatex)
    engine_binary="xelatex"
    latexmk_mode="-xelatex"
    ;;
  lualatex)
    engine_binary="lualatex"
    latexmk_mode="-lualatex"
    ;;
  *)
    printf 'error: unsupported engine: %s\n' "$engine" >&2
    printf 'supported engines: pdflatex, xelatex, lualatex\n' >&2
    exit 2
    ;;
esac

cd "$(dirname "$0")"

command -v latexmk >/dev/null 2>&1 || {
  printf 'error: latexmk not found; install TeX Live 2025+ with latexmk\n' >&2
  exit 1
}
command -v "$engine_binary" >/dev/null 2>&1 || {
  printf 'error: %s not found; install TeX Live 2025+ with %s support\n' \
    "$engine_binary" "$engine_binary" >&2
  exit 1
}

# latexmk -outdir does not create the subdirectories that \include needs for
# the per-part .aux files, so prepare them first. Separate build trees keep
# engines from reusing each other's auxiliary files.
mkdir -p build build/frontmatter build/chapters build/backmatter build/lampiran

latexmk "$latexmk_mode" -file-line-error -synctex=1 \
  -interaction=nonstopmode -halt-on-error \
  -outdir=build main.tex

cp -f build/main.pdf main.pdf
printf 'built %s/main.pdf with %s\n' "$(pwd)" "$engine"
