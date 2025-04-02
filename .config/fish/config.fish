if not status --is-interactive
    exit
end

####################################################################################
# My custom fish shell configurations
#
# 2.04.2025 OP
####################################################################################

# Suppresses the default fish greeting
set fish_greeting

# Function for reloading fish config
function reload
    exec fish
    set -l config (status -f)
    echo "reloading: $config"
end

# Starship prompt initialization
if command -sq starship
    starship init fish | source
end

# Replace ls-command with eza for directory listings
if type -q eza
    alias l="eza -1 --icons --no-user --color=always --group-directories-first --git-ignore"
    alias ls="eza -l --icons --no-user --color=always --group-directories-first --git-ignore"
    alias ll="eza -la --icons --no-user --color=always --group-directories-first --git-ignore --time-style='+%d.%m.%y %H:%M'"
    alias lt="eza -la --icons --no-user  --color=always --group-directories-first -T -D --git-ignoreD "
end

# Prompt for verification before executing commands
alias rm="rm -i"
alias mv="mv -i"

# Additional aliases
alias update="brew update && brew upgrade"
alias hh="history | tail -n 200"
alias grep="grep --color=auto"
alias ip="ip -color"

# Decorations at the beginning of the terminal
echo -e "\n"
fastfetch


