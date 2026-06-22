# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build

```bash
pdflatex -interaction=nonstopmode main.tex
pdflatex -interaction=nonstopmode main.tex   # run twice — TOC/refs need two passes
```

## Structure

- `main.tex` — root file; compile this. Contains all preamble packages and `\include` calls.
- `frontmatter/` — cover, approval page, originality statement, abstract (ID+EN), acknowledgements
- `chapters/bab1–bab7.tex` — Pendahuluan → Tinjauan Pustaka → Metodologi → Perancangan → Implementasi → Pengujian → Kesimpulan
- `backmatter/referensi.tex` — bibliography (Harvard Anglia Ruskin University style)
- `assets/` — images referenced via `\includegraphics`; `\graphicspath{{assets/}}` set in preamble

## Key conventions

- Equations numbered per-chapter: `(3.1)`, `(3.2)` — via `\numberwithin{equation}{chapter}`
- Code listings use `lstdefinestyle{kode}` with Indonesian caption name `Kode Sumber`
- TikZ flowchart node styles (`term`, `proc`, `procplain`, `io`, `dec`, `arr`) defined in preamble — use these for all diagrams
- `\gambarbesar{...}` macro for full-width/height-constrained figures
- `siunitx` decimal marker set to `,` (Indonesian convention)
- Page numbering: cover = none, frontmatter = roman, main body = arabic

## Customization checklist

1. `frontmatter/cover.tex` — replace all `[...]` placeholders
2. `main.tex` `\hypersetup` — update `pdftitle` and `pdfauthor`
3. `assets/logo_institusi.png` — replace with actual university logo
4. Each chapter file — replace `[...]` with real content
