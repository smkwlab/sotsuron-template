# Workflows and Usage Examples

This document covers workflows and detailed command examples for sotsuron-template.

## Student Workflow (for reference)

### Phase 1: Thesis Writing
```
0th-draft (outline) → 1st-draft → 2nd-draft → ... → submit tag
```

### Phase 2: Abstract Writing
```
abstract-1st → abstract-2nd → abstract completion
```

### Phase 3: Final Submission
```
Further improvements → Final PR → Faculty approval → final-* tag → Auto-merge to main
```

### Branch Management for Students
- **Work branches**: Students create drafts in sequence
- **Review branch**: Automatically updated with latest content
- **Faculty feedback**: Provided via GitHub PR comments and suggestions
- **History tracking**: Complete revision history maintained

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