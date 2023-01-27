@echo off
rem mlc: Merge LaTeX Container

if exist .devcontainer (
  echo already merged
  exit /b
)

mkdir .tmp
git mv .gitignore .latexmkrc .textlintrc .tmp
git commit -m "mv files temporary to avoid conflict"

echo merge LaTeX environment
git remote add latexenv https://github.com/smkwlab/latex-environment.git
git fetch latexenv
git merge --allow-unrelated-histories -m "merge latex environment" latexenv/main
git remote remove latexenv

git rm -r .gitignore .latexmkrc .textlintrc
git mv .tmp/.gitignore .tmp/.latexmkrc .tmp/.textlintrc .

git commit -m "update .gitignore & .textlintrc"
git push
