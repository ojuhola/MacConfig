if not status --is-interactive
    exit
end

####################################################################################
# My custom fish shell configurations
#
# 2.04.2025 OP
####################################################################################

# Suppress the default fish greeting
set  -g fish_greeting

# Function for reloading fish config when needed
function reload
    exec fish
    set -l config (status -f)
    echo "reloading: $config"
end

# Replace ls-command with eza for directory listings
if type -q eza
    alias l="eza -1 --icons --no-user --color=always --group-directories-first --git-ignore"
    alias ls="eza -l --icons --no-user --color=always --group-directories-first --git-ignore"
    alias ll="eza -la --icons --no-user --color=always --group-directories-first --git-ignore --time-style='+%d.%m.%y %H:%M'"
    alias lt="eza -la --icons --no-user  --color=always --group-directories-first -T -D --git-ignoreD "
end

# Additional aliases
alias update="brew update --quiet && brew upgrade && brew cleanup"
alias hh="history | tail -n 200"
alias grep="grep --color=auto"
alias ip="ip -color"
alias ping="ping -c 5"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias rmdir="rmdir -i"
alias mkdir="mkdir -p"

# Starship prompt initialization
if command -sq starship
    starship init fish | source
end

# Decorations at the beginning of the terminal session
echo -e "\n"
fastfetch
