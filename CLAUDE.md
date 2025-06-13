# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a unified LaTeX thesis template for Kyushu Sangyo University's Faculty of Science and Engineering, Information Science Department. It supports both undergraduate (卒業論文) and graduate (修士論文) theses with automated GitHub-based review workflow.

## Key Commands

### LaTeX Compilation
```bash
# Undergraduate thesis
latexmk -pv sotsuron.tex    # Main thesis document
latexmk -pv gaiyou.tex      # Abstract document

# Graduate thesis  
latexmk -pv thesis.tex      # Main thesis document
latexmk -pv abstract.tex    # Abstract document
```

### Text Linting
```bash
# Japanese text linting (if textlint is available)
textlint sotsuron.tex
textlint thesis.tex
```

## File Architecture

### Core Template Structure
- **Unified Template**: Single template supports both undergraduate and graduate theses
- **Conditional Files**: Student repositories are created with only relevant files based on student ID patterns
- **Automated Workflow**: GitHub Actions handle branch creation and review management

### File Types by Thesis Level
#### Undergraduate (Student ID: k??rs???)
- `sotsuron.tex` - Main thesis document
- `gaiyou.tex` - Abstract document
- `example.tex`, `example-gaiyou.tex` - Reference examples

#### Graduate (Student ID: k??gjk??)
- `thesis.tex` - Main thesis document
- `abstract.tex` - Abstract document

### Configuration Files
- `.latexmkrc` - LaTeX compilation settings (uplatex, dvipdfmx)
- `.textlintrc` - Japanese academic writing linting rules
- `plistings.sty` - Programming code formatting package

## Development Environment

### DevContainer Integration
The template includes automatic LaTeX environment setup:
- Pre-configured VS Code with LaTeX Workshop extension
- TeX Live distribution with Japanese support
- textlint for Japanese academic writing standards
- Automatic dependency management

### LaTeX Engine Configuration
- **Engine**: uplatex (Unicode-enabled pLaTeX)
- **Bibliography**: upbibtex
- **PDF Generation**: dvipdfmx
- **Index**: mendex with Unicode support
- **SyncTeX**: Enabled for editor integration

## Branching Workflow

### Branch Naming Convention
- Draft branches: `0th-draft`, `1st-draft`, `2nd-draft`, etc.
- Abstract branches: `abstract-1st`, `abstract-2nd`, etc.
- Review branch: `review-branch` (persistent, auto-updated)
- Base branch: `initial` (for diff tracking)

### Automated Branch Management
- Next draft branch auto-created upon PR submission
- Review branch continuously updated with latest content
- Students work on sequential drafts with clear diff tracking
- Parallel execution: next draft can begin while previous is under review

## Important Conventions

### Student Repository Creation Process
1. Template repository provides unified base
2. Student-specific repository created with appropriate files only
3. Unused template files automatically removed based on student ID pattern
4. DevContainer environment added via aldc script
5. Initial workflow branches and persistent review PR established

### Review System Architecture
- **Differential Review**: Each draft PR shows changes from previous version
- **Comprehensive Review**: review-branch PR shows entire thesis content
- **Non-merge Workflow**: PRs are for review only, students close after addressing feedback
- **Suggestion Integration**: GitHub's suggestion feature for direct editorial input