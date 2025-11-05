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

## Student ID Pattern Recognition

The system automatically detects thesis type:

**Undergraduate patterns:**
- `k??rs???` (e.g., k21rs001) → keeps `sotsuron.tex`, `gaiyou.tex`, examples

**Graduate patterns:**  
- `k??gjk??` (e.g., k21gjk01) → keeps `thesis.tex`, `abstract.tex` only

## Student Repository Creation

Students create individual repositories using automated tools:

```bash
# Self-service repository creation (zero dependencies)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/smkwlab/thesis-management-tools/main/create-repo/setup.sh)" bash thesis

# With student ID for automatic thesis type detection
STUDENT_ID=k21rs001 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/smkwlab/thesis-management-tools/main/create-repo/setup.sh)" bash thesis
```

## Review Workflow

This template uses a simplified Pull Request-based review workflow:

**Branch Structure:**
- **main**: Base branch and final deliverable
- **xth-draft**: Sequential draft branches (0th-draft, 1st-draft, 2nd-draft, ...)
- **abstract-xth**: Abstract/summary branches (abstract-1st, abstract-2nd, ...)

**Workflow:**
1. Student creates PR from draft branch to main
2. Faculty reviews via GitHub PR comments and suggestions
3. After approval and final-* tag, PR auto-merges to main
4. Next draft branch is automatically created for continued work

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

*Note: docs/ directory contains development-specific information*

- **[Development Guide](docs/CLAUDE-DEVELOPMENT.md)** - Architecture, workflows, ecosystem integration
- **[Workflows & Examples](docs/CLAUDE-WORKFLOWS.md)** - Student workflows, detailed command examples