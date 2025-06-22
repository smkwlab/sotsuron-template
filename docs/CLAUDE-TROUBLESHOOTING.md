# Sotsuron Template Troubleshooting Guide

This document provides troubleshooting information for common issues in sotsuron-template.

## Common Issues

### Compilation Errors
- Check file encoding (must be UTF-8)
- Verify Japanese font availability
- Test with minimal document first
- Check .latexmkrc configuration

### textlint Issues
- Validate .textlintrc syntax
- Check rule compatibility with content
- Test with example files
- Update textlint rules if needed

### Repository Creation Problems
- Verify student ID format
- Check Docker availability
- Test with debug mode: `DEBUG=1`
- Validate GitHub authentication

## Debug Commands

### LaTeX Environment
```bash
# Check LaTeX installation
kpsewhich jarticle.cls          # Japanese article class
kpsewhich plistings.sty         # Custom style file

# Test Japanese processing
echo "日本語テスト" | platex     # Basic Japanese test
```

### Template Testing
```bash
# Test undergraduate compilation
latexmk -pv sotsuron.tex
latexmk -pv gaiyou.tex

# Test graduate compilation
latexmk -pv thesis.tex  
latexmk -pv abstract.tex

# Test examples
latexmk -pv example.tex
latexmk -pv example-gaiyou.tex
```

### Text Quality Checking
```bash
# Check textlint configuration  
npx textlint --print-config     # Show active rules

# Check Japanese writing quality
textlint sotsuron.tex thesis.tex
textlint example*.tex

# Validate LaTeX syntax
chktex sotsuron.tex
chktex thesis.tex
```

### Development Commands
```bash
# Test with different engines
latexmk -pdf sotsuron.tex     # Force PDF mode
latexmk -dvi sotsuron.tex     # Force DVI mode

# Bibliography testing
pbibtex sotsuron && latexmk sotsuron.tex  # Manual bib processing
```

## Shell Command Gotchas

### Backticks in gh pr create/edit
When using `gh pr create` or `gh pr edit` with `--body`, backticks (`) in the body text are interpreted as command substitution by the shell. This causes errors like:
```
permission denied: .devcontainer/devcontainer.json
command not found: 2025c-test
```

**Solution**: Always escape backticks with backslashes when using them in PR bodies:
```bash
# Wrong - will cause errors
gh pr create --body "Updated `file.txt` to version `1.2.3`"

# Correct - escaped backticks
gh pr create --body "Updated \`file.txt\` to version \`1.2.3\`"
```