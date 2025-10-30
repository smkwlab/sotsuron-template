# Workflows and Usage Examples

This document covers workflows and detailed command examples for sotsuron-template.

## Student Workflow (for reference)

### Simplified Workflow Overview

This template uses a simplified Pull Request-based review system with only two types of branches:

**Branch Structure:**
- **main**: Base branch and final deliverable
- **xth-draft**: Sequential draft branches (0th-draft, 1st-draft, 2nd-draft, ...)
- **abstract-xth**: Abstract/summary branches (abstract-1st, abstract-2nd, ...)

### Phase 1: Thesis Writing
```
main ← 0th-draft (outline) → PR → Review → Approval
main ← 1st-draft → PR → Review → Approval
main ← 2nd-draft → PR → Review → Approval
...
```

### Phase 2: Abstract Writing
```
main ← abstract-1st → PR → Review → Approval
main ← abstract-2nd → PR → Review → Approval
```

### Phase 3: Final Submission
```
main ← final-draft → PR → Faculty approval → final-* tag → Auto-merge to main
```

### Branch Management for Students
- **Work branches**: Students create PRs from draft branches directly to main
- **Faculty feedback**: Provided via GitHub PR comments and suggestions on each draft PR
- **Next draft**: Automatically created after PR is opened
- **History tracking**: Complete revision history maintained in main branch
- **No review-branch**: Simplified structure removes the persistent review branch

## LaTeX Compilation Examples

### Undergraduate Thesis Compilation
```bash
# Main thesis document
latexmk -pv sotsuron.tex      # Compile and preview
latexmk -c                    # Clean auxiliary files
latexmk -C                    # Clean all generated files including PDF

# Abstract (概要)
latexmk -pv gaiyou.tex        # Compile abstract

# Direct compilation (if needed)
platex sotsuron.tex           # Main document
pbibtex sotsuron              # Bibliography
platex sotsuron.tex           # Second pass
platex sotsuron.tex           # Final pass
dvipdfmx sotsuron.dvi        # Convert to PDF
```

### Graduate Thesis Compilation
```bash
# Main thesis document
latexmk -pv thesis.tex        # Compile and preview
latexmk -c                    # Clean auxiliary files
latexmk -C                    # Clean all generated files including PDF

# Abstract
latexmk -pv abstract.tex      # Compile abstract

# Direct compilation (if needed)
platex thesis.tex             # Main document
pbibtex thesis                # Bibliography
platex thesis.tex             # Second pass
platex thesis.tex             # Final pass
dvipdfmx thesis.dvi          # Convert to PDF
```

## Text Quality Checking Examples

### Basic textlint Usage
```bash
# Check all .tex files
textlint *.tex                

# Auto-fix issues where possible (use with caution)
textlint --fix *.tex          

# Check specific files
textlint sotsuron.tex         # Undergraduate main
textlint thesis.tex           # Graduate main
textlint gaiyou.tex          # Undergraduate abstract
textlint abstract.tex        # Graduate abstract

# Check example files
textlint example.tex          
textlint example-gaiyou.tex   
```

### Advanced Quality Checks
```bash
# Validate LaTeX syntax
chktex sotsuron.tex
chktex thesis.tex

# Test with different engines
latexmk -pdfdvi sotsuron.tex    # platex workflow (recommended)
latexmk -pdf sotsuron.tex       # pdflatex workflow (if supported)
```

## MCP Tools Usage

### GitHub Operations
Use MCP tools instead of `gh` command for GitHub operations:
- **Development**: Use `mcp__gh-toshi__*` tools for development work
- **Student testing**: Use `mcp__gh-k19__*` tools only when testing student workflows