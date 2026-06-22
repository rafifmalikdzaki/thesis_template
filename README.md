# Thesis LaTeX Template

Clean template for Indonesian university theses.

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
