#  ROG commit
A commit cli made with [charm gum](https://github.com/charmbracelet/gum)

## prerequisites
git & [charm gum](https://github.com/charmbracelet/gum)

## Instalation
clone this repo:

```sh
gh repo clone https://github.com/rogcmd/rogcommit.git
```

## How to use

### Executable: 
use chmod to execute the file
```sh
chmod +x commit.sh

# then execute the sript 
./commit.sh
```

### With alias! 
create an alias to execute the file anyware
```sh title:config.fish
# Fish example
alias commit = "bash path/to/file/commit.sh"
```

## Styling
u can customize the colors  to your 
liking changing the eviroment variables! 

```sh title:config.fish
# example - Catppuccin Machiato
set -gx GUM_INPUT_PROMPT "❯ "
set -gx GUM_INPUT_HEADER_FOREGROUND "#94e2d5" # teal
set -gx GUM_INPUT_PROMPT_FOREGROUND "#89b4fa" # blue
set -gx GUM_INPUT_PLACEHOLDER_FOREGROUND "#6c7086" # overlay0

set -gx GUM_CHOOSE_CURSOR "❯ "
set -gx GUM_CHOOSE_CURSOR_FOREGROUND "#89b4fa" # blue
set -gx GUM_CHOOSE_HEADER_FOREGROUND "#94e2d5" # teal
set -gx GUM_CHOOSE_SELECTED_BACKGROUND "a6e3a1" # green

set -gx GUM_WRITE_HEADER_FOREGROUND "#94e2d5" # Teal
set -gx GUM_WRITE_PLACEHOLDER_FOREGROUND "#6c7086" # overlay0

set -gx GUM_CONFIRM_PROMPT_FOREGROUND "#cdd6f4" # text
set -gx GUM_CONFIRM_SELECTED_BACKGROUND "#313244" # surface0
```

TODO: 
- [x] verificar se o git ta ativo
- [ ] verificar se adicionou algum arquivo pra commit
- [ ] opção para editar commit
- [x] verificar se tem alguma mensagem de descrição vazia
- [x] mostrar ultimos 3 commits
- [ ] verificar se o titulo ta em branco