# 🎓 Indonesian University Thesis LaTeX Template

A clean, highly organized, and fully-featured LaTeX template designed for undergraduate, graduate, and doctoral theses at Indonesian universities. It strictly adheres to the standard academic formatting guidelines (4-3-3-3 margins, 1.5 spacing, Arial/Helvetica typography) so you can focus entirely on writing your research.

## ✨ Key Features

- **Standardized Layout:** A4 paper with precise margins (Left 4 cm; Top, Right, Bottom 3 cm).
- **Typography:** Uses Helvetica (Arial equivalent) 12pt font with 1.5 line spacing and proper 1.27 cm paragraph indentation.
- **Pre-configured Chapters:** A 7-chapter structure ready to be populated.
- **Figures & Tables:** Centered captions, bold labels, and beautifully formatted tables (`booktabs`).
- **Diagrams & Charts:** Out-of-the-box support for `tikz` flowcharts and `pgfplots` data visualizations with predefined clean color palettes.
- **Code Listings:** Professional syntax highlighting for source code (`listings`).
- **Citation:** Ready for standard citation management (Harvard ARU style).

## 📁 Project Structure

```text
thesis_template/
├── main.tex                        # The main file (Compile this!)
├── frontmatter/                    # Pre-chapter pages
│   ├── cover.tex                   # Title page / Cover
│   ├── lembar_pengesahan.tex       # Approval page
│   ├── pernyataan_keaslian.tex     # Declaration of originality
│   ├── abstrak.tex                 # Abstract (ID & EN)
│   └── kata_pengantar.tex          # Acknowledgements
├── chapters/                       # Main content chapters
│   ├── bab1.tex                    # Bab 1: Pendahuluan
│   ├── bab2.tex                    # Bab 2: Tinjauan Pustaka
│   ├── bab3.tex                    # Bab 3: Metodologi Penelitian
│   ├── bab4.tex                    # Bab 4: Perancangan Sistem
│   ├── bab5.tex                    # Bab 5: Implementasi
│   ├── bab6.tex                    # Bab 6: Pengujian & Analisis
│   └── bab7.tex                    # Bab 7: Kesimpulan & Saran
├── backmatter/                     # Post-chapter pages
│   └── referensi.tex               # References / Bibliography
└── assets/                         # Images and graphics
    └── ub-logo-small.png           # Your university logo here
```

## 🚀 Getting Started

### 1. Prerequisites
You will need a TeX distribution installed on your system. 
- **Windows:** MiKTeX or TeX Live
- **macOS:** MacTeX
- **Linux:** `sudo apt-get install texlive-full` (Ubuntu/Debian)

Alternatively, you can upload this entire folder to [Overleaf](https://www.overleaf.com/) to work entirely in the browser without installing anything!

### 2. Compilation
To generate the PDF, you must compile `main.tex`. It's recommended to run the compiler **twice** to ensure the table of contents and cross-references are accurately generated.

```bash
pdflatex -interaction=nonstopmode main.tex
pdflatex -interaction=nonstopmode main.tex
```

## 🛠️ Customization Checklist

Before you begin writing, make sure to personalize the template:

1. [ ] **Logo:** Replace `assets/ub-logo-small.png` with your university's official logo.
2. [ ] **Cover Page:** Edit `frontmatter/cover.tex` and replace all `[...]` placeholders with your actual details (Name, NIM, Program, etc.).
3. [ ] **PDF Metadata:** Update `main.tex` at the `\title{...}` and `\author{...}` block so your final PDF file has the correct metadata.
4. [ ] **Write your Thesis:** Go through each file in the `chapters/` folder and replace the placeholder text with your actual research content.

## 📐 Formatting Reference

| Setting | Value |
| :--- | :--- |
| **Paper Size** | A4 |
| **Font** | Helvetica / Arial (12pt) |
| **Line Spacing** | 1.5 |
| **Margins** | Left: 4 cm, Right: 3 cm, Top: 3 cm, Bottom: 3 cm |
| **Paragraph Indent** | 1.27 cm |
| **Table Captions** | Above the table, bold, centered |
| **Figure Captions** | Below the figure, bold, centered |

---
*Happy Writing! Semoga sukses sidangnya! 🎓*
