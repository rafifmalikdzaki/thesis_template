#!/usr/bin/env bash
set -euo pipefail
# Build an Overleaf-ready archive of this project and (by default) verify it.
#
#   bash scripts/package_overleaf.sh                   build + verify (pdfLaTeX)
#   bash scripts/package_overleaf.sh --engine=xelatex  verify with XeLaTeX
#   bash scripts/package_overleaf.sh --no-verify       build the archive only
#
# The archive is dist/thesis_template_overleaf.zip and holds the project at
# its root, so main.tex is the top-level master. thesis.cls detects the
# engine, so the same archive works with any Overleaf compiler.
#
# Dependencies: zip, unzip, and (unless --no-verify) latexmk with the engine
# used for verification (pdfLaTeX by default) from TeX Live 2025 or newer.
# The script is runnable from any directory.

usage() {
  sed -n '3,15p' "$0" | sed 's/^# \{0,1\}//'
}

verify=1
verify_engine=pdflatex
while (($#)); do
  case "$1" in
    --no-verify)
      verify=0
      shift
      ;;
    --engine=*)
      verify_engine="${1#*=}"
      shift
      ;;
    --engine)
      (($# >= 2)) || {
        printf 'error: --engine requires a value\n' >&2
        exit 2
      }
      verify_engine="$2"
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

case "$verify_engine" in
  pdflatex)
    verify_binary="pdflatex"
    verify_mode="-pdf"
    ;;
  xelatex)
    verify_binary="xelatex"
    verify_mode="-xelatex"
    ;;
  lualatex)
    verify_binary="lualatex"
    verify_mode="-lualatex"
    ;;
  *)
    printf 'error: unsupported verification engine: %s\n' "$verify_engine" >&2
    printf 'supported engines: pdflatex, xelatex, lualatex\n' >&2
    exit 2
    ;;
esac

repo_root=$(cd "$(dirname "$0")/.." && pwd)
cd "$repo_root"

for tool in zip unzip; do
  command -v "$tool" >/dev/null 2>&1 || {
    printf 'error: %s not found; install zip and unzip\n' "$tool" >&2
    exit 1
  }
done
if (( verify )); then
  for tool in latexmk "$verify_binary"; do
    command -v "$tool" >/dev/null 2>&1 || {
      printf 'error: %s not found; install TeX Live 2025+ with %s\n' \
        "$tool" "$verify_engine" >&2
      exit 1
    }
  done
fi

dist_dir="$repo_root/dist"
zip_path="$dist_dir/thesis_template_overleaf.zip"
mkdir -p "$dist_dir"
rm -f "$zip_path"

# Project files that belong in the Overleaf package, at the archive root.
# examples/tikz/, docs/, scripts/, .github/, build/, dist/ and main.pdf are
# intentionally not included: Overleaf only needs the document sources.
project_files=(
  main.tex
  thesis.cls
  thesis-layout.sty
  metadata.tex
  .latexmkrc
  overleaf.txt
  README.md
  frontmatter
  chapters
  backmatter
  lampiran
  assets
  fonts
)

# Defensive exclusions: these artefacts never belong in the package even if
# a previous build left them inside one of the included directories.
zip -r -X -q "$zip_path" "${project_files[@]}" \
  -x '*/build/*' 'build/*' 'dist/*' \
     '*.aux' '*.log' '*.fls' '*.fdb_latexmk' '*.synctex.gz' \
     '*.out' '*.toc' '*.lof' '*.lot' '*.lol' '*.bbl' '*.blg' \
     '*.bcf' '*.run.xml' '*.xdv' '*.pdf.bak' '*.DS_Store'

printf 'wrote %s\n' "$zip_path"
printf 'contents:\n'
unzip -Z1 "$zip_path" | sed 's/^/  /'

if (( ! verify )); then
  printf 'verification skipped (--no-verify)\n'
  exit 0
fi

# Verification: extract the archive to a temporary directory and build it
# there with latexmk using the selected engine. The package is only valid if
# that build produces a PDF.
tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/thesis-overleaf-verify.XXXXXX")
trap 'rm -rf "$tmp_dir"' EXIT

unzip -q "$zip_path" -d "$tmp_dir"

[[ -f "$tmp_dir/main.tex" ]] || {
  printf 'error: main.tex is not at the archive root\n' >&2
  exit 1
}
[[ -f "$tmp_dir/thesis.cls" ]] || {
  printf 'error: thesis.cls is missing from the archive\n' >&2
  exit 1
}
[[ -f "$tmp_dir/.latexmkrc" ]] || {
  printf 'error: .latexmkrc is missing from the archive\n' >&2
  exit 1
}
if [[ "$verify_engine" != "pdflatex" ]]; then
  [[ -f "$tmp_dir/fonts/texgyreheros-regular.otf" ]] || {
    printf 'error: fonts/ is missing from the archive (required by %s)\n' "$verify_engine" >&2
    exit 1
  }
fi

# The same include layout that build.sh prepares for \include .aux files.
mkdir -p "$tmp_dir/build" "$tmp_dir/build/frontmatter" "$tmp_dir/build/chapters" \
  "$tmp_dir/build/backmatter" "$tmp_dir/build/lampiran"

printf 'verifying: extracting and building the archive with %s\n' "$verify_engine"
if ! ( cd "$tmp_dir" && latexmk "$verify_mode" -file-line-error -synctex=1 \
         -interaction=nonstopmode -halt-on-error \
         -outdir=build main.tex >verify-build.out 2>&1 ); then
  printf 'error: the extracted Overleaf package failed to build with %s\n' \
    "$verify_engine" >&2
  tail -40 "$tmp_dir/verify-build.out" >&2
  exit 1
fi

[[ -s "$tmp_dir/build/main.pdf" ]] || {
  printf 'error: the extracted package build produced no PDF\n' >&2
  exit 1
}

if command -v pdfinfo >/dev/null 2>&1; then
  pages=$(pdfinfo "$tmp_dir/build/main.pdf" | awk '/^Pages:/ {print $2}')
  printf 'verified: extracted package built %s pages of PDF with %s (build/main.pdf)\n' \
    "${pages:-?}" "$verify_engine"
else
  printf 'verified: extracted package built build/main.pdf with %s\n' "$verify_engine"
fi
