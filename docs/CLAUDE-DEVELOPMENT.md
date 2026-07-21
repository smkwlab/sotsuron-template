# Sotsuron Template Development Guide

This document provides detailed development guidance for sotsuron-template.

The student-facing writing workflow is documented elsewhere and is not
duplicated here: the ecosystem-wide flow lives in
[STUDENT-WORKFLOW.md](https://github.com/smkwlab/latex-ecosystem/blob/main/docs/STUDENT-WORKFLOW.md),
and this template's concrete steps (GitHub Desktop operations, submit-tag
procedure, FAQ) live in [.github/README.md](../.github/README.md) and
[WRITING-GUIDE.md](../WRITING-GUIDE.md).

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

Students create individual repositories with the automated setup script; see
the [README](../README.md#リポジトリ作成) for the current one-liner.

### Thesis Type Detection and File Cleanup

When a student repository is created, unused files are removed based on the
thesis type:

- **Undergraduate**: keeps `sotsuron.tex`, `gaiyou.tex`, `example*.tex`
  (removes `thesis.tex`, `abstract.tex`)
- **Graduate**: keeps `thesis.tex`, `abstract.tex`
  (removes `sotsuron.tex`, `gaiyou.tex`, `example*.tex`)

This is implemented in **student-repo-management**, not in this repository:
`create-repo/main.sh` decides the type in `determine_thesis_type` (a student
ID matching `^k[0-9]{2}g` is graduate, anything else is undergraduate) and
prunes files in `remove_unused_thesis_files`. When changing the template's
file set, coordinate with those functions.

### Review Workflow System
Simplified GitHub Actions-based supervision system:

**Branching Strategy:**
- **main**: Base branch and final deliverable
- Sequential draft branches: `0th-draft` → `1st-draft` → `2nd-draft` → ...
- Abstract branches: `abstract-1st` → `abstract-2nd` → ...

**Faculty Review Features:**
- Draft PRs target previous draft branch (1st-draft→main, 2nd-draft→1st-draft, 3rd-draft→2nd-draft, etc.)
- Shows only incremental changes from previous revision for efficient review
- GitHub PR comments and suggestions for feedback
- Automated next draft branch creation after PR opened
- PRs remain open for iterative review without merging

**Submission tags** (two tags with different roles):
- `submit` — pushed by the **student** to mark the submission version of the
  thesis body (see README「論文提出について」). Any tag push also triggers the
  PDF release build.
- `final` / `final-*` — trigger the **auto-final-merge** automation
  (merging approved PRs and creating the release); used at faculty direction,
  not part of the student's own procedure.

## GitHub Actions Workflows

All eight workflows are thin callers of the org-standard reusable workflows
in `smkwlab/.github` (`@v1`), which centrally pins tool versions for the
whole ecosystem:

| Workflow | Trigger | Purpose |
|---|---|---|
| `latex-build.yml` | PR / tag push | Build the PDF; release on tags |
| `create-next-draft.yml` | PR opened | Auto-create the next draft branch |
| `sync-next-draft.yml` | push to `*-draft` / `abstract-*` | Merge applied suggestions into the next draft; opens a sync PR on conflict |
| `prevent-draft-merge.yml` | PR | Block accidental merges of draft PRs |
| `auto-final-merge.yml` | `final` / `final-*` tag | Final submission processing |
| `ai-paper-review.yml` | PR | AI-based paper review comments |
| `claude-qa.yml` | issue/PR comment | @claude Q&A for students |
| `notify-ml-on-pr.yml` | PR | Notify the lab ML |

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
└── .github/workflows/        # Workflow automation (see inventory above)
```

### Documentation Files
```
├── CLAUDE.md                 # Claude Code guidance (this repo)
├── docs/CLAUDE-DEVELOPMENT.md # This file
├── README.md                 # Template documentation (student-facing)
└── WRITING-GUIDE.md          # Academic writing guidance (student-facing)
```

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
5. **Coordinate with student-repo-management** for deployment

### For Document Examples
1. **Maintain realistic examples** reflecting actual thesis content
2. **Keep examples current** with latest academic standards
3. **Test compilation** with uplatex engine
4. **Validate textlint rules** against examples

### For Workflow Integration
1. **Test the draft-chain workflows** (create-next-draft, sync-next-draft) with sample content
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

# Cleanup
latexmk -c                    # Remove auxiliary files
latexmk -C                    # Remove all generated files including PDF
```

### Manual Compilation (bypassing latexmk)
The `.latexmkrc` is configured for uplatex; the equivalent manual chain is:

```bash
uplatex sotsuron.tex          # 1st pass (thesis.tex for graduate)
upbibtex sotsuron             # Bibliography
uplatex sotsuron.tex          # 2nd pass
uplatex sotsuron.tex          # 3rd pass
dvipdfmx sotsuron.dvi         # Convert to PDF
```

### Quality Assurance
```bash
# Check Japanese writing quality
textlint sotsuron.tex thesis.tex
textlint example*.tex

# Auto-fix fixable issues (use with care)
textlint --fix *.tex
```

### Integration Testing
- Test repository creation with sample student IDs
- Verify file cleanup for both thesis types
- Test devcontainer functionality
- Validate GitHub Actions workflows

## Ecosystem Integration

### Related Repositories
- **latex-environment**: Development container base
- **student-repo-management**: Student repository creation and registration
  (also implements thesis type detection / file cleanup — see above)
- **smkwlab/.github**: Org-standard reusable workflows (build, draft chain,
  review automation) called by this repo's workflows; tool versions are
  pinned centrally there
- **texlive-ja-textlint**: Base Docker image for compilation

### Version Dependencies
- The devcontainer tracks the `latex-environment` template
- CI/CD comes entirely from `smkwlab/.github` reusable workflows (`@v1`);
  this repository pins no action versions of its own

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
