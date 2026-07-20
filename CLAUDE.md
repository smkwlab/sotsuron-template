# CLAUDE.md

Unified thesis template for Kyushu Sangyo University, supporting both undergraduate (卒業論文) and graduate (修士論文) theses with automated workflows and review systems.

## Quick Start

### LaTeX Compilation
```bash
# Undergraduate thesis
latexmk -pv sotsuron.tex      # Main thesis document
latexmk -pv gaiyou.tex        # Abstract (概要)

# Graduate thesis  
latexmk -pv thesis.tex        # Main thesis document
latexmk -pv abstract.tex      # Abstract

# Cleanup
latexmk -c                    # Clean auxiliary files
latexmk -C                    # Clean all generated files including PDF
```

### Text Quality Checking
```bash
# Check Japanese academic writing
textlint *.tex                # Check all .tex files
textlint sotsuron.tex         # Check specific file
textlint example.tex          # Check example content
```

## File Structure

### Template Files
```
├── sotsuron.tex              # Undergraduate main document
├── thesis.tex                # Graduate main document
├── gaiyou.tex                # Undergraduate abstract
├── abstract.tex              # Graduate abstract
├── example.tex               # Example undergraduate content
├── example-gaiyou.tex        # Example undergraduate abstract
└── plistings.sty             # Code formatting style
```

### Configuration Files
```
├── .latexmkrc                # LaTeX build configuration
├── .textlintrc               # Japanese writing rules
├── .devcontainer/            # VSCode container setup
└── .github/workflows/        # Automated workflows
```

## Thesis Type Detection

Student repositories keep only the files for their thesis type (undergraduate
→ `sotsuron.tex`/`gaiyou.tex`/examples, graduate → `thesis.tex`/`abstract.tex`).
The detection and cleanup are implemented in student-repo-management; see
[docs/CLAUDE-DEVELOPMENT.md](docs/CLAUDE-DEVELOPMENT.md#thesis-type-detection-and-file-cleanup)
for the contract and implementation pointers.

## Student Repository Creation

Students create individual repositories with the automated setup script; see
the [README](README.md#リポジトリ作成) for the current one-liner.

## Review Workflow

This template uses a simplified Pull Request-based review workflow:

**Branch Structure:**
- **main**: Base branch and final deliverable
- **xth-draft**: Sequential draft branches (0th-draft, 1st-draft, 2nd-draft, ...)
- **abstract-xth**: Abstract/summary branches (abstract-1st, abstract-2nd, ...)

**Workflow:**
1. Student creates PR from draft branch to previous draft (or main for 1st-draft)
2. PR shows only changes since previous revision for efficient review
3. Faculty reviews via GitHub PR comments and suggestions
4. After review, PR is closed (not merged) and student continues on next draft
5. Next draft branch is automatically created based on current draft
6. Students mark the submission version with the `submit` tag (README「論文提出について」);
   the `final` / `final-*` tags trigger the auto-final-merge automation at faculty direction

## Common Tasks

### Test Template Compilation
```bash
# Test all document types
latexmk -pv sotsuron.tex && latexmk -pv gaiyou.tex
latexmk -pv thesis.tex && latexmk -pv abstract.tex
latexmk -pv example.tex && latexmk -pv example-gaiyou.tex
```

### Development Testing
```bash
# Test with different engines
latexmk -pdf sotsuron.tex     # Force PDF mode
latexmk -dvi sotsuron.tex     # Force DVI mode

# Bibliography testing
pbibtex sotsuron && latexmk sotsuron.tex
```

### Quality Assurance
```bash
# Check writing quality and LaTeX syntax
textlint sotsuron.tex thesis.tex example*.tex
chktex sotsuron.tex thesis.tex
```

## Detailed Documentation

*Note: docs/ directory contains development-specific information, except
docs/README.md*

- **[Development Guide](docs/CLAUDE-DEVELOPMENT.md)** - Architecture, thesis type detection, workflow inventory, testing, ecosystem integration
- **[docs/README.md](docs/README.md)** - Author-information template (name, student ID, thesis type)
  filled in by the student. GitHub resolves READMEs in the order `.github/` → root → `docs/`,
  so this repository still shows root README.md; student repositories show docs/README.md
  because student-repo-management removes root README.md at creation time.

The student-facing writing workflow is documented in
[latex-ecosystem STUDENT-WORKFLOW.md](https://github.com/smkwlab/latex-ecosystem/blob/main/docs/STUDENT-WORKFLOW.md)
(ecosystem-wide flow) and this repo's [README.md](README.md) / [WRITING-GUIDE.md](WRITING-GUIDE.md)
(concrete steps).