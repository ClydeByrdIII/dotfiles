# This file is (normally) processed on each interactive invocation of bash

# avoid problems with scp -- don't process the rest of the file if non-interactive
[[ $- != *i* ]] && return

# PATH --------------------------------------------------------------

if [ -d ~/bin ]; then
  export PATH=:~/bin:$PATH
fi

# Colors ------------------------------------------------------------

export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'

# Relevant for BSD, MAC
export CLICOLOR=1

# Setup some colors to use later in interactive shell or scripts
export COLOR_NC='\033[0m' # No Color
export COLOR_WHITE='\033[1;37m'
export COLOR_BLACK='\033[0;30m'
export COLOR_BLUE='\033[0;34m'
export COLOR_LIGHT_BLUE='\033[1;34m'
export COLOR_GREEN='\033[0;32m'
export COLOR_LIGHT_GREEN='\033[1;32m'
export COLOR_CYAN='\033[0;36m'
export COLOR_LIGHT_CYAN='\033[1;36m'
export COLOR_RED='\033[0;31m'
export COLOR_LIGHT_RED='\033[1;31m'
export COLOR_PURPLE='\033[0;35m'
export COLOR_LIGHT_PURPLE='\033[1;35m'
export COLOR_BROWN='\033[0;33m'
export COLOR_YELLOW='\033[1;33m'
export COLOR_GRAY='\033[1;30m'
export COLOR_LIGHT_GRAY='\033[0;37m'

# enable color support, should work with all modern terminals
if [ "$TERM" = "xterm" ] ; then
    if [ -z "$COLORTERM" ] ; then
        if [ -z "$XTERM_VERSION" ] ; then
            echo "Warning: Terminal wrongly calling itself 'xterm'."
        else
            case "$XTERM_VERSION" in
            "XTerm(256)") TERM="xterm-256color" ;;
            "XTerm(88)") TERM="xterm-88color" ;;
            "XTerm") ;;
            *)
                echo "Warning: Unrecognized XTERM_VERSION: $XTERM_VERSION"
                ;;
            esac
        fi
    else
        case "$COLORTERM" in
            gnome-terminal)
                # Those crafty Gnome folks require you to check COLORTERM,
                # but don't allow you to just *favor* the setting over TERM.
                # Instead you need to compare it and perform some guesses
                # based upon the value. This is, perhaps, too simplistic.
                TERM="gnome-256color"
                ;;
            *)
                echo "Warning: Unrecognized COLORTERM: $COLORTERM"
                ;;
        esac
    fi
fi

SCREEN_COLORS="`tput colors`"
if [ -z "$SCREEN_COLORS" ] ; then
    case "$TERM" in
        screen-*color-bce)
            echo "Unknown terminal $TERM. Falling back to 'screen-bce'."
            export TERM=screen-bce
            ;;
        *-88color)
            echo "Unknown terminal $TERM. Falling back to 'xterm-88color'."
            export TERM=xterm-88color
            ;;
        *-256color)
            echo "Unknown terminal $TERM. Falling back to 'xterm-256color'."
            export TERM=xterm-256color
            ;;
    esac
    SCREEN_COLORS=`tput colors`
fi
if [ -z "$SCREEN_COLORS" ] ; then
    case "$TERM" in
        gnome*|xterm*|konsole*|aterm|[Ee]term)
            echo "Unknown terminal $TERM. Falling back to 'xterm'."
            export TERM=xterm
            ;;
        rxvt*)
            echo "Unknown terminal $TERM. Falling back to 'rxvt'."
            export TERM=rxvt
            ;;
        screen*)
            echo "Unknown terminal $TERM. Falling back to 'screen'."
            export TERM=screen
            ;;
    esac
    SCREEN_COLORS=`tput colors`
fi

# Prompts -----------------------------------------------------------

if [ "$TERM" != "dumb" ]; then
    #nice pretty color prompt with the current user and our current directory

    # Prompt 1
    PS1="\[${COLOR_LIGHT_GREEN}\]\u:\[${COLOR_BLUE}\]\w\[${COLOR_YELLOW}\]$\[${COLOR_RED}\]"
fi

# Prompt 2
export PS2='> '

# Prompt 3
export PS3='#? '

# Prompt 4
export PS4='+ '

# change the title of your xterm* window
function xtitle {
  unset PROMPT_COMMAND
  echo -ne "\033]0;$1\007" 
}

# Other aliases ----------------------------------------------------

# Lists folders and files sizes in the current folder
alias ducks='du -cksh * | sort -rn|head -11'

# Lists all the colors, uses vars in .bashrc_non-interactive
alias colorslist="set | egrep 'COLOR_\w*'"  

# Remotely mount networked drives
alias mountece='sshfs -p 22 ecegrid.ecn: ~/ece -oauto_cache,reconnect,defer_permissions,noappledouble,negative_vncache,volname=ee469'
alias mountcs='sshfs -p 22 data.cs: ~/cs -oauto_cache,reconnect,defer_permissions,noappledouble,negative_vncache,volname=CS'
alias mounttest='sshfs -p 22 byrdc@ecegrid.ecn: ~/testece/ -oauto_cache,reconnect,defer_permissions,noappledouble,negative_vncache,volname=testece'

# Show top 20 most used commands
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

case "$(uname -s)" in

   Darwin)
      # Mac specific aliases
      alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
      alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
      ;;

   Linux)
      # Linux specific aliases
      ;;

   CYGWIN*|MINGW32*|MSYS*)
      # MS Windows specific aliases
      ;;

   *)
      # other OS (or missing cases for above OSs)
      ;;
esac

# Editors -----------------------------------------------------------

export EDITOR='vim'

# Misc --------------------------------------------------------------

export HISTCONTROL=ignoredups

# Number of lines stored
export HISTSIZE=100000

# Number of lines stored in file
export HISTFILESIZE=1000000

shopt -s checkwinsize # After each command, checks the windows size and changes lines and columns

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

man() {
    env LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}
