# TikZ figure sources (LaTeX-only extension)

These six `.tex` files are the standalone sources of the vector figures used in the
manuscript. They are **not** part of the thesis build: `tikz`, `pgfplots` and the
palette below are not loaded by `thesis-layout.sty`. TikZ diagrams are a LaTeX-only
extension; the portable manuscript figures are the PDFs in `assets/`.

- `tikz-demo.tex` — shared font, palette and node-style preamble.
- `fig-3-alur.tex`, `fig-4-arsitektur.tex`, `fig-5-integrasi.tex`,
  `fig-6-alur.tex`, `fig-6-f1.tex`, `fig-6-latensi.tex` — one diagram per file.
- `build.sh` — compiles every source with `pdflatex` and copies the resulting vector
  PDFs to `assets/` at the repository root.

```bash
bash examples/tikz/build.sh    # regenerate assets/fig-*.pdf
```

To add a LaTeX-only diagram, copy one of these files, compile it to a PDF, place the
PDF in `assets/` and include it from `main.tex` with
`\thesisfigure{\includegraphics{assets/<name>.pdf}}` (asset paths are relative to the
LaTeX project root, the repository root). Do not add `tikzpicture` environments to
`chapters/` or `frontmatter/`: the manuscript content must not depend on LaTeX-only
drawing packages. See `docs/EDITING.md` for the full boundary rules.
