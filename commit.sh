#!/usr/bin/env bash

gum=$(which gum)
if [ -z "$gum" ]; then
  echo ""
  echo -e "\e[31mThis program require Gum to load!\e[0m"
  echo -e "Check how to install Gum at: \e[4;34mhttps://github.com/charmbracelet/gum?tab=readme-ov-file#installation\e[0m"
  else
  
  gum style \
  --background "#cba6f7" \
  --foreground "#1e1e2e" \
  --padding "0 1" \
  --margin "1 0" \
  --bold \
  "commit"\
  
  if [ ! -d ".git" ]; then
    if gum confirm "Not a git repository, git init?"; then 
      git init && git add . && echo "" && git commit -m "first commit"
        echo ""
        if gum confirm "Add a remote?"; then
          Remote=$(gum input --header "Add a remote URL")
          
          while [ -z $Remote ]; do
            echo -e "\e[31mRemote URL cant be blank!\e[0m"
            Remote=$(gum input --header "Add a remote Url")
          done
          
          git remote add origin "$Remote"
          git push -u origin main
          
          exit 0
          else exit 0
        fi
      else
      echo -e "\e[31mYou must be on a git repo!\e[0m"
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
    
    echo "Final commit:"
    
    if [ -n "$DESCRIPTION" ]; then
      FINAL_TEXT="$COMMIT

$DESCRIPTION"

      else
      FINAL_TEXT="$COMMIT"
    fi
    
    gum style \
    --italic \
    --border rounded \
    --border-foreground "#89b4fa" \
    --padding "1 2" \
    --margin "1 0" \
    "$FINAL_TEXT"
    
    # opcao para editar commit
    
    if gum confirm "commit changes?";then
      echo -e "\e[32mOperation succed!\e[0m"
      git commit -m "$FINAL_TEXT"
      else
      echo -e "\e[31mOperation canceled!\e[0m"
    fi
  fi
fi