# Uploading the template to Overleaf

The project is Overleaf-ready in both forms: import the repository directly, or upload
the packaged zip. `main.tex` is the top-level master either way, so no file needs to be
moved after upload. `thesis.cls` detects the compiler, so all three LaTeX engines work
from the same package.

## Option A — import the repository

1. In Overleaf choose **Menu → New Project → Import from GitHub** and select this
   repository (the same route is available through the Overleaf Git integration).
2. Open **Menu → Settings** and set:
   - **Main document**: `main.tex`
   - **Compiler**: pdfLaTeX (recommended default)
   - **TeX Live version**: 2025 or newer
   - **Bibliography tool**: none
3. Click **Recompile**. The first build produces the 34-page placeholder PDF with the
   canonical institutional look.

XeLaTeX and LuaLaTeX are also supported: choose them in **Menu → Settings → Compiler**
and recompile. The class auto-detects the engine, switches to OpenType text fonts and
Latin Modern Mathematics, and pagination may shift slightly (about 35 pages with
XeLaTeX).

## Option B — upload the packaged zip

1. Build the archive on a machine with TeX Live 2025+ (`zip`/`unzip` are also needed):

   ```bash
   bash scripts/package_overleaf.sh
   ```

   This writes `dist/thesis_template_overleaf.zip`. By default the script also
   extracts the archive to a temporary directory, builds it with pdfLaTeX through
   `latexmk`, and fails unless a PDF is produced; pass `--no-verify` to skip that check
   when no TeX installation is available, or `--engine=xelatex`/`--engine=lualatex` to
   verify with another engine.
2. In Overleaf choose **Menu → New Project → Upload Project**, select
   `dist/thesis_template_overleaf.zip`, and confirm. Overleaf unpacks the archive
   and detects `main.tex` as the main document because it is at the archive root.
3. Verify **Menu → Settings** as in Option A: main document `main.tex`, compiler
   pdfLaTeX (or XeLaTeX/LuaLaTeX), TeX Live 2025 or newer, no bibliography tool.
4. Click **Recompile**.

The same one-page instructions are in [`../overleaf.txt`](../overleaf.txt).

## What the package contains

Everything the document needs, at the archive root:

```text
main.tex                  master: document order and numbering interfaces
thesis.cls                engine detection, fonts, mathematics, metadata, PDF info
thesis-layout.sty         layout, object interfaces, administrative pages
metadata.tex              administrative values to edit
.latexmkrc                engine-neutral latexmk flags, no BibTeX; used by Overleaf
overleaf.txt              this upload quick reference
README.md                 project overview, requirements and engine guide
frontmatter/              cover, approval, declaration, abstracts, preface
chapters/                 bab1.tex … bab7.tex
backmatter/referensi.tex  manual Harvard bibliography
lampiran/lampiran_a.tex   appendix
assets/                   logo and the six vector figure PDFs
```

Overleaf compiles the project with its own TeX Live; the repository does not bundle a
TeX distribution, and `.latexmkrc` only sets the compiler flags and the "no BibTeX"
setting (the engine is chosen by Overleaf's compiler setting). `assets/` paths are
relative to the project root, so they resolve in Overleaf without changes.

## What is intentionally excluded

- `build/`, `dist/` and `main.pdf` — generated locally and rebuilt by Overleaf.
- `examples/tikz/` — standalone TikZ sources for regenerating the figure PDFs; the
  manuscript never compiles them and the PDFs are already in `assets/`.
- `docs/` and `scripts/` — repository-only documentation and the local packaging
  script; they are not needed to compile the thesis.
- `.git/`, `.github/` — version-control metadata and CI, which Overleaf does not use.
- Any LaTeX intermediate file (`*.aux`, `*.log`, `*.fls`, `*.toc`, …) — the packaging
  script excludes them even if a local build left them behind.

The repository-level files outside the package remain available in the repository
itself; they are simply not needed inside Overleaf.

## Compiling and troubleshooting

- **Wrong main document** — set **Menu → Settings → Main document** to `main.tex`.
- **Wrong engine** — pdfLaTeX is recommended and produces the canonical look. XeLaTeX
  and LuaLaTeX are supported if you need OpenType/system fonts; select the engine in
  **Menu → Settings → Compiler** and expect slightly different pagination and Latin
  Modern Mathematics. Do not load `fontspec` or `unicode-math` yourself — `thesis.cls`
  already does it for those engines.
- **Old or stale PDF** — use **Recompile from scratch** (or clear cached files) and
  rebuild; the table of contents and cross-references need three passes.
- **Missing figure** — confirm the package was uploaded whole, including `assets/`,
  and that `\includegraphics{assets/<name>.pdf}` names an existing file.
- **"No file main.toc" on the first pass** — harmless; Overleaf reruns latexmk
  automatically. A final PDF has no undefined references.
- **Bibliography looks wrong** — the bibliography is manual text in
  `backmatter/referensi.tex`; no BibTeX or Biber pass is involved, so editing that file
  is the fix.

To update an existing project, re-upload a fresh `dist/thesis_template_overleaf.zip`
or commit to the connected repository; keep your edited `metadata.tex` and chapter files.
