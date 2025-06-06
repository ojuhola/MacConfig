################################################################################
# My custom fish shell configurations
# MacOS, Linux (Arch, Ubuntu)
#
# 02.04.2025 OP
################################################################################

# Check if fish is running interactively
if not status --is-interactive
    exit
end

# Suppress the default fish greeting
set -g fish_greeting

# Function for reloading fish config when needed
function reload
    set -l config (status -f)
    source $config
end

# Determine the operating system
switch (uname)
    case Darwin   # macOS
        # Aliases for updating the system
        alias update="brew update --quiet && brew upgrade --greedy --quiet && \
            brew cleanup --quiet && echo -e '==> Done'" 
    case Linux
        # Check for specific Linux distribution
        if test -f /etc/arch-release   # Arch Linux
            alias update="sudo pacman -Syyu --color auto"
            alias upall="$HOME/.config/waybar/scripts/news_upd.py"
        else if test -f /etc/ubuntu-release -o -f /etc/lsb-release    # Ubuntu
            alias update="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y"
            alias upall="sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo snap refresh"
        else
            echo "Unknown Linux distribution, only partial configuration applied."
        end
    case '*'
        echo "Unknown OS, only partial configuration applied."
end

# Aliases for file operations with confirmation
alias grep="grep --color=auto"
alias ping="ping -c 5"
alias mkdir="mkdir -p"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias rmdir="rmdir -i"

# Git aliases 
if command -sq git
    alias g="git"
    alias g.s="git status -s"
    alias g.p="git pull"
    alias g.f="git fetch"
    alias g.lg="git log --oneline --decorate --graph --color=always"
    alias g.lc="git for-each-ref --sort=-committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) \
     - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
    alias g.discard="git reset --hard; git clean -df"

    # Function to add, commit, and push changes
    function g.all
        set -l message (string join " " $argv)
        if test -z "$message"
            echo "Error: Please provide a commit message."
            return 1
        end
        git add --all
        git commit -m "$message"
        git push
    end
end

# Nicer looking cat command
if command -sq bat
    alias cat="bat --style=plain --color=always"
end

# Replace ls-command with eza 
if command -sq eza
    alias l="eza -1 --icons --no-user --color=always --group-directories-first --git-ignore"
    alias ls="eza -l --icons --no-user --color=always --group-directories-first --git-ignore"
    alias ll="eza -la --icons --no-user --color=always --group-directories-first --git-ignore --time-style='+%d.%m.%y %H:%M'"
    alias lt="eza -la --icons --no-user  --color=always --group-directories-first -T -D --git-ignore"
end

# Starship prompt initialization
if command -sq starship
    starship init fish | source
end

# Decorations at the beginning of the terminal session for easy identification
if command -sq fastfetch
    fastfetch
end
