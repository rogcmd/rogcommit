#!/usr/bin/env bash

gum=$(which gum)
if [ -z "$gum" ]; then
  echo ""
  echo -e "\e[31mThis program require Gum to load!\e[0m"
  echo -e "Check how to install Gum at: \e[34mhttps://github.com/charmbracelet/gum?tab=readme-ov-file#installation\e[0m"
  else
  
  gum style \
  --background "#cba6f7" \
  --foreground "#1e1e2e" \
  --padding "0 1" \
  --margin "1 0" \
  --bold \
  "commit"\
  
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
    TYPE=$(gum choose --header "Select the type" "fix" "feat" "docs" "style" "refactor" "test" "chore" "revert")
    SCOPE=$(gum input --header "Scope of the commit: " --placeholder "scope of the commit")
    test -n "$SCOPE" && SCOPE="($SCOPE)"
    TITLE=$(gum write --header "Title of the commit:" --placeholder "changes you made")
    
    while [ -z "$TITLE" ]; do
      echo -e "\e[31mTitle cant be blank!\e[0m"
      TITLE=$(gum write --header "Title of the commit:" --placeholder "changes you made")
    done
    
    DESCRIPTION=$(gum write --header "Description" --placeholder "description of the commit")
    COMMIT="$TYPE$SCOPE: $TITLE"
    
    clear
    
    gum style \
    "Final commit:"\
    
    if [ -n "$DESCRIPTION" ]; then
      FINAL_TEXT="$COMMIT

$DESCRIPTION"

      else
      FINAL_TEXT="$COMMIT"
    fi
    
    gum style \
    --italic \
    --border rounded \
    --foreground "#cba6f7" \
    --border-foreground "#89b4fa" \
    --padding "1 2" \
    --margin "1 0" \
    "$FINAL_TEXT"
    
    # opcao para editar commit
    
    if gum confirm "commit changes?";then
      gum style \
      --foreground "#94e2d5" \
      --margin "1 0" \
      "operation succed"\
      && git commit -m "$FINAL_TEXT"
      echo ""
      
      if gum confirm "push changes?"; then
      git push
      echo ""
      fi
      
      if gum confirm "show last 3 logs?"; then
      git log -3 --oneline
      fi
      else
      clear
      gum style \
      --foreground "#f38ba8" \
      "cancelled operation"
    fi
  fi
fi