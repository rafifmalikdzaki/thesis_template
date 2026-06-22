# Thesis LaTeX Template

Clean template for Indonesian university theses.

## Preview

> Add a compiled screenshot here: compile `main.tex`, export page 1 as PNG, save as `assets/preview.png`, then replace this block with `![preview](assets/preview.png)`.

```
┌─────────────────────────────────────────────┐
│  ← 4 cm →│                      │← 3 cm →  │
│           │                      │           │
│           │   BAB 1 PENDAHULUAN  │  ← chapter heading:
│           │   (centered, bold)   │     all-caps, one line
│           │                      │
│           │   1.1 Latar Belakang │  ← section: bold, left
│           │                      │
│           │     Lorem ipsum      │  ← paragraph: 1.27 cm
│           │   dolor sit amet,    │    first-line indent,
│           │   consectetur...     │    1.5 line spacing,
│           │                      │    justified
│           │   Tabel 1.1 Judul    │  ← table caption: above,
│           │  ┌──────┬──────────┐ │    bold, centered
│           │  │ Kol1 │  Kol 2   │ │  ← full-border table
│           │  ├──────┼──────────┤ │
│           │  │ data │  data    │ │
│           │  └──────┴──────────┘ │
│           │                      │
│           │   [figure/diagram]   │
│           │  Gambar 1.1 Judul    │  ← figure caption: below,
│           │  (centered, bold)    │    bold, centered
│           │                      │
│           │          1           │  ← page number
└─────────────────────────────────────────────┘
```

## Structure

```
thesis_template/
├── main.tex                        ← compile this
├── frontmatter/
│   ├── cover.tex                   ← halaman judul
│   ├── lembar_pengesahan.tex       ← tanda tangan pembimbing
│   ├── pernyataan_keaslian.tex     ← anti-plagiarism statement
│   ├── abstrak.tex                 ← abstrak (ID) + abstract (EN)
│   └── kata_pengantar.tex          ← acknowledgements
├── chapters/
│   ├── bab1.tex                    ← Pendahuluan
│   ├── bab2.tex                    ← Tinjauan Pustaka
│   ├── bab3.tex                    ← Metodologi
│   ├── bab4.tex                    ← Perancangan
│   ├── bab5.tex                    ← Implementasi
│   ├── bab6.tex                    ← Pengujian & Analisis
│   └── bab7.tex                    ← Kesimpulan & Saran
├── backmatter/
│   └── referensi.tex               ← Daftar Pustaka (Harvard ARU)
└── assets/
    └── logo_institusi.png          ← ganti dengan logo kampus Anda
```

## Compile

```bash
pdflatex -interaction=nonstopmode main.tex
pdflatex -interaction=nonstopmode main.tex   # run twice for TOC/refs
```

## Customization checklist

1. `frontmatter/cover.tex` — ganti semua `[...]` dengan data Anda
2. `main.tex` line `\title{...}` — judul PDF metadata
3. `assets/logo_institusi.png` — logo universitas
4. Setiap bab — ganti teks `[...]` dengan konten riil

## Page layout

| Setting       | Value         |
|---------------|---------------|
| Paper         | A4            |
| Font          | Arial/Helvetica (12pt) |
| Line spacing  | 1.5           |
| Left margin   | 4 cm          |
| Right/Top/Bot | 3 cm          |
| Para indent   | 1.27 cm       |
