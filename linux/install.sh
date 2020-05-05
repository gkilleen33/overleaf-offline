#!/bin/bash
# Change the CD to the directory specified 
cd "$1"

# First create or update the gitignore file 
if test -f ".gitignore"; then
    grep -qxF 'pdf/' .gitignore || echo 'pdf/' >> .gitignore
    grep -qxF 'latexmkrc' .gitignore || echo 'latexmkrc' >> .gitignore
    grep -qxF 'compile.command' .gitignore || echo 'compile.command' >> .gitignore
    if ! git diff-index --quiet HEAD --; then
        echo '' >> .gitignore
        git add .gitignore
        git commit -m "Updated gitignore"
    fi
else
    printf 'pdf/\nlatexmkrc\ncompile.command\n' >> .gitignore
    git add .gitignore
    git commit -m "Created gitignore"
fi

# Second create latexmkrc
curl https://raw.githubusercontent.com/gkilleen33/overleaf-offline/master/latexmkrc -o latexmkrc

# Third create compile.command 
curl https://raw.githubusercontent.com/gkilleen33/overleaf-offline/master/linux/compile.sh -o compile.sh
chmod +x compile.sh 
