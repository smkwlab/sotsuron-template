# Sotsuron Template Development Guide

This document provides detailed development guidance for sotsuron-template.

## Architecture

### Template Structure
The repository supports both thesis types with smart file organization:

**Undergraduate (卒業論文) files:**
- `sotsuron.tex` - Main thesis document
- `gaiyou.tex` - Abstract in Japanese
- `example.tex` - Example content for reference
- `example-gaiyou.tex` - Example abstract

**Graduate (修士論文) files:**
- `thesis.tex` - Main thesis document  
- `abstract.tex` - Abstract (English or Japanese)

**Shared files:**
- `plistings.sty` - Programming code formatting
- `.latexmkrc` - LaTeX compilation configuration
- `.textlintrc` - Japanese writing quality rules

### Student Repository Creation
Students create individual repositories using automated Docker-based tools:

```bash
# Self-service repository creation (zero dependencies)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/smkwlab/thesis-management-tools/main/create-repo/setup.sh)" bash thesis

# With student ID for automatic thesis type detection
STUDENT_ID=k21rs001 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/smkwlab/thesis-management-tools/main/create-repo/setup.sh)" bash thesis
```

### Automated File Cleanup
Based on student ID patterns:
- **k??rs???** (undergraduate): Keeps `sotsuron.tex`, `gaiyou.tex`, `example*.tex`
- **k??gjk??** (graduate): Keeps `thesis.tex`, `abstract.tex` only

### Review Workflow System
Simplified GitHub Actions-based supervision system:

**Branching Strategy:**
- **main**: Base branch and final deliverable
- Sequential draft branches: `0th-draft` → `1st-draft` → `2nd-draft` → ...
- Abstract branches: `abstract-1st` → `abstract-2nd` → ...

**Faculty Review Features:**
- Individual draft PRs directly to main for each revision
- GitHub PR comments and suggestions for feedback
- Automated next draft branch creation after PR opened
- Final submission via `final-*` tag triggers auto-merge

## File Structure Conventions

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
└── .github/workflows/        # Student workflow automation
```

### Development Files (not in student repos)
```
├── CLAUDE.md                 # This file (development only)
├── README.md                 # Template documentation
├── WRITING-GUIDE.md          # Academic writing guidance
└── .github/workflows/        # Template management workflows
```

## Student ID Pattern Recognition
The system automatically detects thesis type:

**Undergraduate patterns:**
- `k??rs???` (e.g., k21rs001, k23rs099)
- Receives: `sotsuron.tex`, `gaiyou.tex`, examples

**Graduate patterns:**  
- `k??gjk??` (e.g., k21gjk01, k23gjk15)
- Receives: `thesis.tex`, `abstract.tex` only

## Document Structure Standards

### Undergraduate thesis (sotsuron.tex):
- Introduction (はじめに)
- Literature Review (関連研究)
- Methodology (提案手法)
- Experiments (実験)
- Discussion (考察)
- Conclusion (おわりに)

### Graduate thesis (thesis.tex):
- More comprehensive structure
- Research background
- Detailed methodology
- Extensive experiments
- Academic contributions

## Japanese Academic Writing
- **Encoding**: UTF-8 throughout
- **Style**: Academic dearu-調 (断定調)
- **Length**: Undergraduate ~20-30 pages, Graduate ~40-60 pages
- **Citations**: Academic format with proper bibliography

## Development Workflow

### For Template Improvements
1. **Test changes** with both undergraduate and graduate examples
2. **Verify compatibility** with both thesis types
3. **Update documentation** (README.md, WRITING-GUIDE.md)
4. **Test automated repository creation**
5. **Coordinate with thesis-management-tools** for deployment

### For Document Examples
1. **Maintain realistic examples** reflecting actual thesis content
2. **Keep examples current** with latest academic standards
3. **Test compilation** with uplatex engine
4. **Validate textlint rules** against examples

### For Workflow Integration
1. **Test review branch system** with sample content
2. **Verify GitHub Actions** functionality
3. **Validate student repository creation**
4. **Test faculty review workflows**

## Testing Guidelines

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

### Quality Assurance
```bash
# Check Japanese writing quality
textlint sotsuron.tex thesis.tex
textlint example*.tex
```

### Integration Testing
- Test repository creation with sample student IDs
- Verify file cleanup for both thesis types
- Test devcontainer functionality
- Validate GitHub Actions workflows

## Ecosystem Integration

### Related Repositories
- **latex-environment**: Development container base
- **thesis-management-tools**: Student repository creation and management
- **latex-release-action**: Automated PDF generation
- **texlive-ja-textlint**: Base Docker image for compilation

### Version Dependencies
- Uses `latex-environment:release` for development container
- Integrates with `thesis-management-tools` for student onboarding
- Compatible with `latex-release-action@v2.2.0` for CI/CD

### Faculty Tools Integration
- Review workflows in `thesis-management-tools`
- Automated supervision via GitHub Actions
- Progress tracking and deadline management
- Quality assurance through automated checks

## Security and Permission Guidelines

### 🚨 CRITICAL: GitHub Administration Rules

#### Git and GitHub Operations
- **NEVER use `--admin` flag** with `gh pr merge` or similar commands
- **NEVER bypass Branch Protection Rules** without explicit user permission
- **ALWAYS respect the configured workflow**: approval process, status checks, etc.

#### When Branch Protection Blocks Operations
1. **Report the situation** to user with specific error message
2. **Explain available options**:
   - Wait for required approvals
   - Wait for status checks to pass
   - Use `--auto` flag for automatic merge after requirements met
   - Request explicit permission for admin override (emergency only)
3. **Wait for user instruction** - never assume intent

#### Proper Error Handling Example
```bash
# When this fails:
gh pr merge 90 --squash --delete-branch
# Error: Pull request is not mergeable: the base branch policy prohibits the merge

# CORRECT response:
echo "Branch Protection Rules prevent merge. Options:"
echo "1. Wait for required approvals (currently need: 1)"
echo "2. Wait for status checks (currently pending: build-and-release-pdf)"
echo "3. Use --auto to merge automatically when requirements met"
echo "4. Request admin override (emergency only)"
echo "Please specify how to proceed."

# WRONG response:
gh pr merge 90 --squash --delete-branch --admin  # NEVER DO THIS
```

#### Emergency Admin Override
- Only use `--admin` flag when explicitly requested by user
- Document the reason for override in commit/PR description
- Report the action taken and why it was necessary

### Rationale
Branch Protection Rules exist to:
- Ensure code quality through required reviews
- Prevent accidental breaking changes
- Maintain audit trail of changes
- Enforce consistent development workflow

Bypassing these rules undermines repository security and development process integrity.

## Contributing Guidelines

### Template Content
- Maintain realistic academic examples
- Ensure compatibility with both thesis types
- Follow Japanese academic writing standards
- Test extensively before deployment

### Documentation
- Keep WRITING-GUIDE.md current with academic standards
- Update README.md for user-facing changes
- Document breaking changes clearly
- Maintain example consistency

### Quality Standards
- All LaTeX code must compile without errors
- textlint rules must pass on all example content
- Support both undergraduate and graduate requirements
- Maintain clean, professional output

### Review Process
- Test with sample student repositories
- Verify automated workflows
- Check integration with ecosystem tools
- Validate faculty review functionality