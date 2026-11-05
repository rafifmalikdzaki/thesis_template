# Editing guide

This guide explains how to fill and extend the LaTeX thesis template. It is written
for the person editing the thesis; the shipped content is placeholder text, numbers
and labels that you replace with your own. User-facing manuscript prose stays in
Indonesian; this documentation is in English.

The project builds with pdfLaTeX through `latexmk`; see the compiler section below for
the supported toolchain and package-ordering constraints.

## 1. Layers and editing rules

| Layer | Files | Rule |
| --- | --- | --- |
| Master | `main.tex` | Document order and `\include`s only. Calls `\thesiscovermatter`, `\thesisfrontmatter`, `\thesismainmatter` and `\thesisappendix`; holds no raw formatting. |
| Metadata | `metadata.tex` | Hand-edited administrative values only, one plain-text `\newcommand` each. |
| Layout | `preamble.tex`, `thesis-layout.sty` | Package loading, geometry, headings, captions, numbering transitions, object interfaces, administrative pages. |
| Content | `frontmatter/`, `chapters/`, `backmatter/`, `lampiran/` | Manuscript prose and portable objects only; no package loads, layout commands or `tikzpicture`. |

`main.tex` is the only master. It starts with `% !TEX program = pdflatex`, which editor
plugins and Overleaf use to select the engine. The page-numbering transitions live in
`thesis-layout.sty` behind `\thesiscovermatter` (no page number),
`\thesisfrontmatter` (roman, starting at i), `\thesismainmatter` (arabic, starting at
1) and `\thesisappendix` (switches the chapter prefix to `LAMPIRAN` and letter
numbering). Do not move these transitions or add formatting to `main.tex`: **all
layout and formatting belong to `thesis-layout.sty`**.

`preamble.tex` loads `metadata.tex` and `thesis-layout.sty` and sets the PDF document
information. The layout package also loads `indentfirst` (the first paragraph after a
heading is indented like every other paragraph) and `xurl` (long URLs in the
bibliography break cleanly instead of overflowing).

## 2. Build and editing loop

```bash
bash build.sh              # latexmk -> build/, then main.pdf at the repository root
rm -rf build main.pdf      # full clean rebuild after structural edits
```

`build.sh` works from any directory. It runs `latexmk -pdf -file-line-error
-synctex=1 -interaction=nonstopmode -halt-on-error -outdir=build main.tex` and copies
`build/main.pdf` to `main.pdf`. `.latexmkrc` fixes the same engine and flags and
disables BibTeX, so Overleaf behaves the same way. `build/` is git-ignored; the PDF is
a generated artefact, not a tracked file.

Read `build/main.log` after a build. A healthy build has no errors, no undefined
references, no font warnings and no overfull boxes:

```bash
grep -nE '^!|undefined|Font Warning|Overfull' build/main.log    # should print nothing
```

For a bug report, uncomment `% \listfiles` in `preamble.tex`, rebuild, and attach the
` *File List*` manifest printed at the end of the log together with `build/main.log`.

## 3. Metadata

Administrative values live only in `metadata.tex`. Edit that file and rebuild:

- **Identity**: title, English title, work type, author, NIM.
- **Affiliation**: programme, department, faculty, university, city, year, degree.
- **Examination and supervision**: examination date, both supervisors and their NIPs,
  head of programme and NIP, head of department and NIP.
- **Keywords**: Indonesian and English, semicolon separated.

Every value is plain text on one line: no formatting commands, mathematics or line
breaks, and LaTeX special characters (`& % $ # _ { } ~ ^ \`) must be escaped. Bare
placeholders stay in brackets, for example `[Judul Tesis]`. The cover, approval and
declaration pages render only these values; the abstracts take their title, author, NIM
and keywords from them. No signature image, stamp or signature date is rendered.

## 4. Object interfaces

Numbering is chapter-based: `Gambar 3.1`, `Tabel 3.1`, `Kode Sumber 5.1`, `(3.1)`. In
the appendix the same objects number `A.1`, `(A.1)`, `(A.2)`. Every numbered object
carries a label and every reference must resolve. Captions are bold and centred: below
figures, above tables and listings.

### Figures

```latex
\begin{figure}[H]
  \centering
  \thesisfigure{\includegraphics{assets/fig-3-alur.pdf}}
  \caption{Alur penelitian}
  \label{fig:3.alur}
\end{figure}
```

`\thesisfigure` scales one image to the text block (maximum width and 87% of the text
height). Use one vector PDF per figure from `assets/`; do not embed raster substitutes
or `tikzpicture` in manuscript files. Reference it as `Gambar~\ref{fig:3.alur}`.

### Tables

```latex
% Caption and label go in the first head so the caption prints above the table.
\begin{thesistable}
\begin{longtable}{@{}l r r@{}}
  \caption{Contoh tabel}
  \label{tab:contoh}\\
  \toprule
  \textbf{Kolom 1} & \textbf{Kolom 2} & \textbf{Kolom 3} \\
  \midrule
  \endfirsthead
  \toprule
  \textbf{Kolom 1} & \textbf{Kolom 2} & \textbf{Kolom 3} \\
  \midrule
  \endhead
  \bottomrule
  \endlastfoot
  isi & isi & isi \\
\end{longtable}
\end{thesistable}
```

`thesistable` scopes table typography (`\small`, tighter `\arraystretch`, 3 pt column
separation) around the `longtable`. Repeat the head rows between `\endfirsthead` and
`\endhead`; the template also prints a "Lanjutan Tabel n.m" banner above the repeated
header. Keep the longtable head order `\endfirsthead`, `\endhead`, `\endfoot`,
`\endlastfoot`. For a wide table put a `landscape` environment inside `thesistable`.
See `chapters/bab6.tex` for a multipage table and a landscape table.

### Code listings

```latex
\begin{lstlisting}[language=Python, caption={Implementasi fungsi kunci}, label={lst:5.kode1}]
def fungsi_kunci(parameter_a, parameter_b):
    ...
\end{lstlisting}
```

The listing name is "Kode Sumber" and listings are numbered per chapter from the
`lstlisting` `caption`/`label` options. Reference one as
`Kode Sumber~\ref{lst:5.kode1}`.

### Equations

```latex
\begin{equation}
  F_1 = 2 \cdot \frac{TP \times FP}{TP + FP}
  \label{eq:f1}
\end{equation}

Persamaan~\eqref{eq:f1} menunjukkan ...
```

Equations are numbered per chapter and referenced with `\eqref`; the appendix numbers
them `(A.1)`, `(A.2)`.

### Appendix

`main.tex` calls `\thesisappendix` before including `lampiran/lampiran_a.tex`. The
layout switches the chapter prefix to `LAMPIRAN` and letter numbering follows: the
first appendix reads `LAMPIRAN A`, its first section `A.1`, and its objects
`Tabel A.1`, `(A.1)`. Add further appendices as `lampiran/lampiran_b.tex` and include
them after the first one.

### Cross-references and citations

Use `\label{...}` on every numbered object, `\ref{...}` to reference it and
`\eqref{...}` for equations. Label names follow the object type and location:
`fig:3.alur`, `tab:3.dataset`, `eq:f1`, `lst:5.kode1`, `sec:3.4`, `lam:a`. One label per
object. Citations are parenthetical author–year text: there are no citation keys and no
BibTeX stage.

## 5. Headings, captions and numbering

| Item | Format |
| --- | --- |
| Chapter | `BAB <n> <TITLE>`, centred, bold, uppercase |
| Section | `<n>.<m> <Title>`, bold, left aligned |
| Subsection | `<n>.<m>.<k> <Title>` |
| Figure caption | Below the figure, bold, centred |
| Table caption | Above the table, bold, centred |
| Listing caption | Above the listing, bold, centred; name "Kode Sumber" |
| Equation number | Per chapter: `(3.1)`; appendix `(A.1)` |
| Figure/table/listing number | Per chapter: `Gambar 3.1`, `Tabel 3.1`, `Kode Sumber 5.1` |
| Appendix | `LAMPIRAN A`; sections and objects `A.1`, `A.2` |

Do not hard-code a number in a heading or caption; the counters do that. Do not move
the page-numbering transitions out of the layout interfaces.

## 6. Administrative pages

| Page | File | Interface |
| --- | --- | --- |
| Cover | `frontmatter/cover.tex` | `\thesiscoverpage` |
| Approval | `frontmatter/lembar_pengesahan.tex` | `\thesisapprovalpage` |
| Declaration | `frontmatter/pernyataan_keaslian.tex` | `\thesisdeclarationpage` |

Each file contains exactly one interface call; `thesis-layout.sty` owns the composition
and prose and renders the metadata values. Do not add prose to these files. The pages
compose:

- **Cover** — title, work type, purpose statement with the degree sought, author and
  NIM, logo, and the programme, department, faculty, university, city and year.
- **Approval** — examination date, both supervisor signatures, and the
  head-of-programme and head-of-department signatories.
- **Declaration** — the author's originality statement.

The abstracts (`frontmatter/abstrak.tex`) and the preface
(`frontmatter/kata_pengantar.tex`) are ordinary manuscript content. No signature image,
stamp or signature date is part of the template.

## 7. Bibliography

`backmatter/referensi.tex` holds the bibliography as manual Harvard Anglia Ruskin
University (ARU) text inside the `thesisbibliography` container: no BibTeX, no `.bib`
file, no citation keys. Entries are in alphabetical order by first-author surname and
follow the format examples already in the file. Cite in the text as parenthetical
author–year text.

## 8. The TikZ boundary

TikZ is a LaTeX-only extension and stays outside the manuscript build. The document
does not load `tikz` or `pgfplots`, and chapter files must not contain `tikzpicture`
environments. The portable manuscript figures are the vector PDFs in `assets/`.

The six example diagrams are built from the standalone sources in `examples/tikz/`
(with the shared `tikz-demo.tex` preamble):

```bash
bash examples/tikz/build.sh    # regenerate assets/fig-*.pdf
```

To add a diagram:

1. Copy an existing source in `examples/tikz/` and edit it.
2. Compile it to a vector PDF with the script or `pdflatex`.
3. Put the PDF in `assets/`.
4. Include it in the chapter through the figure interface (never `tikzpicture`):
   `\thesisfigure{\includegraphics{assets/<name>.pdf}}` inside a `figure` environment
   with a caption and label.
5. Document the new source in `examples/tikz/README.md`.

## 9. Compiler lock-down

Keep the compiler and package order fixed:

- **Engine**: pdfLaTeX only (`% !TEX program = pdflatex`, `.latexmkrc`,
  `latexmk -pdf`). The layout uses Type1 fonts (`helvet`, `sansmathfonts`) and no
  `fontspec`; XeLaTeX and LuaLaTeX are unsupported.
- **No bibliography tool**: the bibliography is manual text, so BibTeX/Biber and
  `makeindex` are never run. `.latexmkrc` sets `$bibtex_use = 0`.
- **Package order**: `hyperref` late; `xurl` after `hyperref`; `calc` before
  `adjustbox`; `sansmathfonts` with `nottext` so the text family stays Helvetica;
  `longtable` heads ordered `\endfirsthead`, `\endhead`, `\endfoot`, `\endlastfoot`.
- **Conflicts**: do not load `fontspec`, `unicode-math`, `biblatex`/`biber`,
  `times`/`mathptmx`, or a second `hyperref`, and do not add `tikz` to the manuscript.

The full package list and rationale are in the repository `README.md`.

## 10. Quality checklist

Before handing over a change:

- [ ] `bash build.sh` exits 0 and refreshes `main.pdf` (34 pages on the shipped
      placeholder manuscript).
- [ ] `grep -nE '^!|undefined|Font Warning|Overfull' build/main.log` prints nothing.
- [ ] Every numbered object has a label and every reference resolves.
- [ ] Chapter headings read `BAB <n>`, sections `<n>.<m>`, appendix `LAMPIRAN A`.
- [ ] Captions sit above tables/listings and below figures; captions are bold and
      centred.
- [ ] A multipage table repeats its header; the landscape table is present.
- [ ] The four outlines (contents, figures, tables, listings) are complete.
- [ ] Cover unnumbered, front matter roman, body arabic; transitions intact.
- [ ] Metadata was changed only in `metadata.tex`.
- [ ] No formatting in `main.tex`, no layout commands in manuscript files and no
      `tikzpicture` in chapters.
- [ ] `bash scripts/package_overleaf.sh` succeeds and its extracted build produces a
      PDF.
- [ ] No personal data beyond the placeholder author fields, no research results.

## 11. First steps

1. Install TeX Live 2025+ including `latexmk` (and `zip`/`unzip` for the Overleaf
   package).
2. Run `bash build.sh` once to confirm the shipped template builds.
3. Fill `metadata.tex`, rebuild, and check the cover, approval and declaration pages.
4. Replace the placeholder chapter content, figures, tables, listings and equations
   using the interfaces above.
5. Fill the bibliography and the appendix, rebuild, and run the checklist.
6. Build the Overleaf package with `bash scripts/package_overleaf.sh` when you are ready
   to upload, or import the repository directly as described in
   [`OVERLEAF.md`](OVERLEAF.md).
