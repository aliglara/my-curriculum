# My resume

The resume is built with Quarto from `resume.qmd`. The resume content lives in
`resume.md`, which `resume.qmd` includes so there is only one copy to maintain.

Render both the editable Word document and PDF:

```bash
quarto render resume.qmd
```

Rendered files are placed in `output/` and named with the local render date,
for example `2026-07-19_resume.pdf` and `2026-07-19_resume.docx`.

Render only one format:

```bash
quarto render resume.qmd --to docx
quarto render resume.qmd --to pdf
```

Word formatting is controlled by `resume-reference.docx`. PDF formatting is
controlled by `resume-preamble.tex`. The `resume.lua` filter formats the contact
line and right-aligns dates in both outputs.

The original Markdown resume format was based on
https://raw.githubusercontent.com/mikepqr/resume.md/main/resume.md.
