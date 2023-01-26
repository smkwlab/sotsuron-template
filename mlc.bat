@echo off

rem mlc: Merge LaTeX Container

if exist .devcontainer (
  echo "already merged"
  exit /b
)

set LATEX_REPO="https://github.com/smkwlab/latex-environment.git"

git rm .gitignore .latexmkrc
git commit -m "remove .gitignore & .latexmkrc to avoid conflict"

set REMOTE=latex-env
git remote add %REMOTE% %LATEX_REPO%
git fetch %REMOTE%
git merge --allow-unrelated-histories -m "merge latex environment" %REMOTE%/main
git remote remove %REMOTE%

type .gitignore-local >> .gitignore
del .gitignore-local
git add .
git commit -m "update .gitignore"
git push
