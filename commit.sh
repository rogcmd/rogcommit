#!bin/bash

echo ""

gum style \
--background "#cba6f7" \
--foreground "#1e1e2e" \
--padding "0 1" \
--bold \
"commit"\

echo ""
if [ ! -d ".git" ]; then
    if gum confirm "not a git repository, git init?"; then 
     git init && git branch -M "master" && git add . && echo ""
     
    else
    gum style \
    --foreground "#f38ba8" \
    "You must be on a git repo"
     
    fi 
fi

if [ -d ".git" ]; then

TYPE=$(gum choose "fix" "feat" "docs" "style" "refactor" "test" "chore" "revert")
SCOPE=$(gum input --header "scope: " --placeholder "scope of the commit")
TITLE=$(gum write --header "$TYPE($SCOPE):" --placeholder "title of the commit")
DESCRIPTION=$(gum write --header "Description" --placeholder "description of the commit")

COMMIT="$TYPE($SCOPE): $TITLE"

gum style \
"Final commit:"\

if [ -n "$DESCRIPTION" ]; then
    FINAL_TEXT="$COMMIT

$DESCRIPTION"
else
    FINAL_TEXT="$COMMIT"
fi

gum style \
--foreground "#cba6f7" \
--border rounded \
--padding "1 1" \
--border-foreground "#89b4fa" \
--italic \
"$FINAL_TEXT"

echo ""

# opcao para editar commit

if gum confirm "commit changes?";
then
gum style \
--foreground "#a6e3a1" \
--italic \
"operation succed"\
&& git commit -m "$FINAL_TEXT"
echo ""

if gum confirm "show last 3 logs?"; then
git log -3 --oneline
fi
else
gum style \
--foreground "#f38ba8" \
"cancelled operation"
fi

fi