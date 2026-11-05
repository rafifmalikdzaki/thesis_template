# 🎓 Indonesian Thesis LaTeX Template

[![CI](https://github.com/rafifmalikdzaki/thesis_template/actions/workflows/ci.yml/badge.svg)](https://github.com/rafifmalikdzaki/thesis_template/actions/workflows/ci.yml)

A clean, self-contained LaTeX template for Indonesian undergraduate, graduate and
doctoral theses. The institutional conventions are already applied: A4 paper, 4–3–3–3 cm
margins, Helvetica/Arial-compatible 12 pt type, 1.5 line spacing, 1.27 cm first-line
indent, `BAB`/`LAMPIRAN` numbering and bold centred captions. You write chapters; the
layout stays where it belongs.

> **Choose your engine.** This repository is the **LaTeX** starter. The **Typst** starter
> lives in [`thesis_template_typst`](https://github.com/rafifmalikdzaki/thesis_template_typst),
> and the shared conversion, metadata and parity tools live in
> [`thesis_template_tools`](https://github.com/rafifmalikdzaki/thesis_template_tools).
> Pick one engine; neither is a derivative of the other.

The repository contains no personal data and no research results: every administrative
value is a bracketed placeholder, and the chapter text is template prose to replace.

## ✨ Features

- **Standardized layout in one package.** Margins, typeface, spacing, headings,
  captions, chapter-based object numbering and appendix numbering live in
  `thesis-layout.sty`, never in your chapter files.
- **Clean master file.** `main.tex` only orders the document and calls the numbering
  interfaces, so a writing mistake cannot break the required format.
- **Figures, multipage tables, listings and equations** behind small interfaces, with a
  landscape table and a table that repeats its header across pages in the example.
- **Manual Harvard (Anglia Ruskin University) bibliography** — no BibTeX, Biber or
  citation keys to manage, matching the common Indonesian thesis convention.
- **Compiler locked to pdfLaTeX** with a `% !TEX` magic comment and `.latexmkrc`, so
  Overleaf and local builds behave identically.
- **One-command Overleaf package**, plus a repository that Overleaf can import directly.
- **CI** builds the PDF and re-builds the packaged archive on every push.

## 🚀 Getting Started

### 1. Requirements

- TeX Live 2025 or newer (or MiKTeX on Windows, MacTeX on macOS), with `latexmk`.
- `zip` and `unzip` only if you use the Overleaf packaging script.
- No Python, no BibTeX/Biber, no `makeindex`.

On Ubuntu/Debian the full set is:

```bash
sudo apt-get -qq update && sudo apt-get install -y --no-install-recommends \
    texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended \
    texlive-fonts-extra texlive-science texlive-lang-other latexmk zip unzip
```

### 2. Clone and build

```bash
git clone https://github.com/rafifmalikdzaki/thesis_template.git
cd thesis_template
bash build.sh
```

`build.sh` runs `latexmk -pdf` with file/line diagnostics and SyncTeX, keeps
intermediate files in `build/`, and writes `main.pdf` at the repository root. You can
also run `latexmk -pdf main.tex` directly; the `.latexmkrc` sets the same flags.

### 3. Start writing

1. Fill in `metadata.tex` — title, author, NIM, programme, faculty, university, degree,
   examination date, supervisors, head of programme and head of department.
2. Replace the bracketed placeholders in `chapters/bab1.tex` … `chapters/bab7.tex`.
3. Replace the logo in `assets/` and the example figures with your own vector PDFs.
4. Edit the bibliography entries in `backmatter/referensi.tex`.
5. Replace the example appendix in `lampiran/lampiran_a.tex`.

## ☁️ Overleaf

The repository ships an Overleaf-ready package:

```bash
bash scripts/package_overleaf.sh
# -> dist/thesis_template_overleaf.zip
```

Upload that zip with **Menu → New Project → Upload Project**, or import this GitHub
repository directly with **Menu → New Project → Import from GitHub**. Then set:

- **Main document:** `main.tex`
- **Compiler:** pdfLaTeX (XeLaTeX and LuaLaTeX are not supported)
- **Bibliography tool:** None

`.latexmkrc` and `overleaf.txt` are included in the archive, so the first recompile
already matches the local build. The packaging script extracts the archive and rebuilds
it before exiting, so a broken package fails immediately (`--no-verify` skips that
check). Details: [`docs/OVERLEAF.md`](docs/OVERLEAF.md).

## 📁 Project Structure

```text
thesis_template/
├── main.tex                    # Master file: document order and numbering only
├── metadata.tex                # Administrative values (the only place for personal data)
├── preamble.tex                # Loads metadata and the layout package, sets PDF info
├── thesis-layout.sty           # Layout, headings, captions, object interfaces, admin pages
├── .latexmkrc                  # pdfLaTeX / latexmk lock, also honoured by Overleaf
├── overleaf.txt                # Overleaf import quick start
├── build.sh                    # Build -> main.pdf
├── scripts/
│   └── package_overleaf.sh     # dist/thesis_template_overleaf.zip + verification
├── frontmatter/                # Cover, approval, declaration, abstracts, preface
├── chapters/                   # bab1.tex ... bab7.tex
├── backmatter/
│   └── referensi.tex           # Manual Harvard ARU bibliography
├── lampiran/
│   └── lampiran_a.tex          # Example appendix (LAMPIRAN A)
├── assets/                     # Logo, illustration and six vector figure PDFs
├── examples/tikz/              # TikZ sources of those figures (LaTeX-only extension)
└── docs/                       # EDITING.md and OVERLEAF.md
```

## 🛠️ Customization Checklist

- [ ] **Logo:** replace `assets/ub-logo-small.png` (or point the cover macro elsewhere).
- [ ] **Metadata:** fill in every value in `metadata.tex`; keep values plain text.
- [ ] **Chapters:** replace the placeholders in `chapters/`, keeping the `\label`s of
      figures, tables, listings and equations you reference.
- [ ] **Figures:** export vector PDFs into `assets/` and include them through
      `\thesisfigure`.
- [ ] **Bibliography:** replace the example entries in `backmatter/referensi.tex`,
      keeping the alphabetical order and Harvard ARU format.
- [ ] **Appendix:** replace the example content in `lampiran/lampiran_a.tex`, or remove
      the appendix section from `main.tex` if you have none.
- [ ] **Review the administrative pages:** cover, approval and declaration are rendered
      from `metadata.tex`; no signature images or dates are added.

## 📐 Formatting Reference

| Setting | Value |
| :--- | :--- |
| Paper | A4 |
| Margins | Left 4 cm; right, top and bottom 3 cm |
| Typeface | Helvetica (Arial-compatible), 12 pt |
| Line spacing | 1.5 |
| Paragraph indent | 1.27 cm, first paragraph after a heading included |
| Chapter heading | `BAB <n> <TITLE>`, centred, bold, uppercase |
| Section heading | `<n>.<m> <Title>`, bold, left aligned |
| Table captions | Above the table, bold, centred |
| Figure captions | Below the figure, bold, centred |
| Listing captions | Above the listing, bold, centred; name "Kode Sumber" |
| Equation numbering | Per chapter: (3.1), (3.2) |
| Figure/table/listing numbering | Per chapter: Gambar 3.1, Tabel 3.1, Kode Sumber 5.1 |
| Appendix numbering | LAMPIRAN A with sections A.1 and objects A.1, A.2 |
| Page numbering | Cover unnumbered; front matter roman; body arabic |
| Bibliography | Manual Harvard Anglia Ruskin University (ARU) style |

## ✍️ Writing Your Thesis

The layout package provides small interfaces so chapter files stay plain content:

```latex
\begin{figure}[H]
  \centering
  \thesisfigure{\includegraphics{assets/fig-3-alur.pdf}}
  \caption{Alur penelitian}
  \label{fig:3.alur}
\end{figure}

\begin{thesistable}
\begin{longtable}{@{}l r r@{}}
  \caption{Contoh tabel}
  \label{tab:contoh}\\
  \toprule
  \textbf{Kolom 1} & \textbf{Kolom 2} & \textbf{Kolom 3} \\
  \midrule
  \endfirsthead
  \multicolumn{3}{@{}l}{\footnotesize\itshape Lanjutan Tabel~\thetable}\\
  \toprule
  \textbf{Kolom 1} & \textbf{Kolom 2} & \textbf{Kolom 3} \\
  \midrule
  \endhead
  \bottomrule
  \endfoot
  \bottomrule
  \endlastfoot
  isi & isi & isi \\
\end{longtable}
\end{thesistable}

\begin{lstlisting}[language=Python, caption={Contoh kode}, label={lst:contoh}]
def contoh():
    return 1
\end{lstlisting}

\begin{equation}
  F_1 = 2 \cdot \frac{P \times R}{P + R}
  \label{eq:f1}
\end{equation}
Lihat Persamaan~\eqref{eq:f1}.
```

Wide tables put a `landscape` environment inside the same `thesistable` wrapper. See
[`docs/EDITING.md`](docs/EDITING.md) for the full interface reference, editing rules and
the TikZ boundary.

## ⚙️ Compiler and Dependencies

**Use pdfLaTeX.** `main.tex` starts with `% !TEX program = pdflatex`, `.latexmkrc` fixes
`$pdf_mode = 1`, and `build.sh` runs `latexmk -pdf`. The layout uses classic Type1 fonts
(`helvet` for text, `sansmathfonts` for mathematics) and never loads `fontspec` or looks
up system fonts, so XeLaTeX and LuaLaTeX are intentionally unsupported.

All formatting rules live in `thesis-layout.sty`, which also owns the package ordering:
`calc` is required by the proportional column widths, `hyperref` is loaded late, `xurl`
follows it so long bibliography URLs break, and `sansmathfonts` is loaded with the
`nottext` option so the text family stays Helvetica. When reporting a build problem, add
`\listfiles` to the preamble (a commented line is ready in `preamble.tex`) and include the
resulting file list in the issue.

## 🤖 CI / Automated Build

On every push and pull request, GitHub Actions installs TeX Live, runs `bash build.sh`,
builds the Overleaf package, and re-builds the extracted archive to prove it is complete.
The PDF and the zip are attached to the workflow run as artifacts:

- `main-pdf` — the compiled `main.pdf`
- `overleaf-package` — `dist/thesis_template_overleaf.zip`

Locally the same checks are:

```bash
bash build.sh
bash scripts/package_overleaf.sh
```

## 🔁 Converting to or from Typst

The shared tools repository converts between this project and the Typst starter, and
verifies that both render the same manuscript:

```bash
python3 scripts/convert_latex_to_typst.py --source ../thesis_template --target ../thesis_template_typst
python3 scripts/convert_typst_to_latex.py --source ../thesis_template_typst --target ../thesis_template
python3 scripts/verify_parity.py --latex ../thesis_template --typst ../thesis_template_typst
```

Conversion is best-effort and documented in
[`thesis_template_tools`](https://github.com/rafifmalikdzaki/thesis_template_tools): it
fails loudly on TikZ, merged cells, raw TeX and other unsupported constructs instead of
silently dropping them.

## 📚 Documentation

- [`docs/EDITING.md`](docs/EDITING.md) — editing conventions, object interfaces,
  bibliography, appendices, the TikZ boundary and a fill-in walkthrough.
- [`docs/OVERLEAF.md`](docs/OVERLEAF.md) — exact Overleaf upload steps and what the
  package contains.
- `thesis-layout.sty` — the reference for every formatting rule.

---
*Happy Writing! Semoga sukses sidangnya! 🎓*
