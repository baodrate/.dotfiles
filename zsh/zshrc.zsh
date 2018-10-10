# =============================================================================
# Setup
# =============================================================================

# ==> Parse operating system
if [[ `uname` = 'Linux' ]]; then
  export OS=linux
elif [[ `uname` = 'Darwin' ]]; then
  export OS=osx
else
  >&2 echo "Can't detect OS"
  return
fi

if [[ $OS = 'linux' ]]; then
  alias yolo='pacaur -Syuu --noconfirm'
fi

CASK_HOME="/usr/local/Homebrew/Library/Taps"
FORMULA_HOME="/usr/local/Cellar"

ZPLG_HOME="${ZDOTDIR:-$HOME}/.zplugin"
# => ZPFX (polaris) directory to store compiled programs
[ -d $ZPFX/bin ] || mkdir $ZPFX/bin

# -------------
# gpg ssh agent
# -------------
if [[ $OS = 'linux' ]]; then
  unset SSH_AGENT_PID
  if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  fi
fi

# ------------------------
# zplugin (plugin manager)
# ------------------------

# ==> bootstrapper
if [[ ! -d "$ZPLG_HOME/bin" ]]; then
  if (( $+commands[git] )); then
    git clone https://github.com/zdharma/zplugin.git $ZPLG_HOME/bin
  else
    echo 'git not found' >&2
    exit 1
  fi
fi

# ==> source-study module
#     NOTWORKING for now (on this computer)
# module_path+=( "$ZPLG_HOME/bin/zmodules/Src" )
# zmodload zdharma/zplugin
# zpmod source-study

# =============================================================================
# Configuration
# =============================================================================

# ------------
# zsh settings
# ------------
# ==> correct commands
setopt CORRECT
# ==> Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# ==> General settings
#     from zim:modules/environment
# Use smart URL pasting and escaping.
autoload -Uz bracketed-paste-url-magic && zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic && zle -N self-insert url-quote-magic
# Allow comments starting with `#` even in interactive shells.
setopt INTERACTIVE_COMMENTS
# Remove path separtor from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}
# Set less or more as the default pager.
if (( ! ${+PAGER} )); then
  if (( ${+commands[less]} )); then
    export PAGER=less
  else
    export PAGER=more
  fi
fi

# ==> Jobs
#     from prezto:modules/environment
setopt LONG_LIST_JOBS     # List jobs in the long format by default.
setopt AUTO_RESUME        # Treat single word simple commands without redirection as candidates for resumption of an existing job.
setopt NOTIFY             # Report the status of background jobs immediately, rather than waiting until just before printing a prompt.
setopt NO_BG_NICE         # Prevent runing all background jobs at a lower priority.
setopt NO_HUP             # Prevent sending the HUP signal to running jobs when the shell exits.
# Don't report on jobs when shell exit.
# Prevent reporting the status of background and suspended jobs before exiting a shell with job control.
# NO_CHECK_JOBS is best used only in combination with NO_HUP, else such jobs will be killed automatically.
setopt NO_CHECK_JOBS

# -------
# aliases
# -------
# ==> cp/mv
#     prompt for overwrite; displays changes
alias cp='cp -iv'
alias mv='mv -iv'
# ==> mkdir
#     create intermediate directories; display created directories
alias mkdir='mkdir -pv'
# ==> ls
#     F : indicator suffixes for directories, executables, symlinks, sockets, whiteouts, and named pipes
#     p : (alternatively to F) indicator suffix ('/') for directories
#     G : colorized output
#     l : long format
#     A : don't list '.' and '..'
#     h : use suffixes for file sizes
if [[ $OS = 'osx' ]]; then
    alias ll='ls -FGlAhG'
# TODO: check for non-arch based distros
elif [[ $OS = 'linux' ]]; then
    alias ll='ls -FGlAh --color=auto'
else
    echo 'could not identify OS to set ls colors alias'
    alias ll='ls -FGlAh'
fi
alias l='ll'
alias less='less -FSRXc'                                                    # Preferred 'less' implementation

# rm aliased to safe-rm (see Plugins/Basic-Plugins section)

# ----------------
# install programs
# ----------------

# ==> homebrew
brew_packages=(
    'bat'           # prettier cat tool
    'prettyping'    # prettier ping tool
    'diff-so-fancy' # prettier diff tool
    'glances'       # top alternative
    'jq'
  # 'htop'          # top alternative
)
for package in $brew_packages; do
    if (( ! $+commands[$package] )); then
        if [[ $OS = 'osx' ]]; then
            brew install $package >/dev/null
        # TODO: check for non-arch based distros
        elif [[ $OS = 'linux' ]]; then
            sudo pacman -S $package
        else
            echo 'installing packages not implemented for this system'
        fi
    fi
done
alias cat='bat'
#alias top='htop'
alias ping='prettyping --nolegend'
#alias diff='diff-so-fancy'
git config --global core.pager "diff-so-fancy | less --tabs=1,5 -RFX"

# ==> python
#### python_packages=(
####     'glances'
#### )
#### if [[ $OS = 'osx' ]]; then
####     pip_exec='pip3'
#### # TODO: check for non-arch based distros
#### elif [[ $OS = 'linux' ]]; then
####     pip_exec='pip'
#### else
####     echo 'installing python packages not implemented for this system'
#### fi
#### for package in $python_packages; do
####     (( $+commands[$package] )) || $pip_exec install --user $package
#### done


# =============================================================================
# Configuration
# =============================================================================
export TERM='screen-256color'

# =============================================================================
# Plugins
# =============================================================================
source "$ZPLG_HOME/bin/zplugin.zsh"

# -----
# Theme
# -----
zplugin ice pick"async.zsh" src"pure.zsh"
zplugin load sindresorhus/pure

# --------------
# custom plugins
# --------------
# zplugin "~/$XDG_CONFIG_HOME/zsh/*.zsh", from:local

# ---------------------
# prezto plugin options
# ---------------------
zstyle ':prezto:*:*' case-sensitive 'yes'
zstyle ':prezto:*:*' color 'yes'

# -------------
# basic plugins
# -------------
# ==> safe-rm
zplugin ice as"program" cp"rm.sh -> rm" pick"rm"
zplugin snippet http://github.com/kaelzhang/shell-safe-rm/raw/master/bin/rm.sh

# ==> Sane options for zsh, in the spirit of vim-sensible
zplugin load willghatch/zsh-saneopt

# ==> suggests package name
    # tap the command-not-found homebrew cask silently and in the background
    # (will need to start a new terminal session to see results)
zplugin ice wait'0' lucid atload'
    if [[ $OS = 'osx' ]]; then
        [[ -d "$CASK_HOME/homebrew/homebrew-command-not-found" ]] \
        || brew tap homebrew/command-not-found >/dev/null 2>&1 &!
    fi'
zplugin snippet PZT::modules/command-not-found/init.zsh

# ----------------------
# macOS specific plugins
# ----------------------
# ==> homebrew aliases
zplugin ice if"[[ $OS = 'osx' ]]"
zplugin snippet PZT::modules/homebrew/init.zsh

# ----------------------
# linux specific plugins
# ----------------------
# ==> pacman aliases
zplugin ice if"[[ $OS = 'linux' ]]"
zplugin snippet PZT::modules/pacman/init.zsh

# ==> ls colors
#     extension:color mappings (requires terminal with 256 colors)
zplugin ice if"[[ $OS = 'linux' ]]" atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh"
zplugin light trapd00r/LS_COLORS

# -------------
# misc. plugins
# -------------

# ==> git aliases
zplugin snippet OMZ::plugins/git/git.plugin.zsh
# ==> git-sync
zplugin load caarlos0/zsh-git-sync                              # Sync git repositories and clean them up.

# ==> colored manpages
zplugin snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
# ==> cat with syntax highlighting
zplugin snippet OMZ::plugins/colorize/colorize.plugin.zsh
# ==> cp: `cpv` function that uses rsync so that you get the features and security of this command
#     rsync -pogbr -hhh --backup-dir=/tmp/rsync -e /dev/null --progress "$@"
zplugin snippet OMZ::plugins/cp/cp.plugin.zsh

# ==> httpstat
zplugin ice as"program" cp"httpstat.sh -> httpstat" pick"httpstat"
zplugin load "b4b4r07/httpstat"

# ==> suggests aliases
zplugin load djui/alias-tips

# ==> crasis
#     (depends on zdharma/fast-syntax-highlighting)
zplugin load zdharma/zui
zplugin ice wait'[[ -n ${ZLAST_COMMANDS[(r)cras*]} ]]' lucid
zplugin load zdharma/zplugin-crasis


# ------------
# vi emulation
# ------------
# ==> built-in vi-mode
bindkey -v
# ==> Sane bindings for zsh's vi mode so it behaves more vim like
#     NOTE:   doesn't work because ^R conflicting with softmoth/zsh-vim-mode
#             see: https://github.com/zdharma/zplugin/issues/69
# zplugin load softmoth/zsh-vim-mode

# -------------------------------
# autocomplete / search / history
# -------------------------------
# ==> Sets history options and defines history aliases
zplugin snippet PZT::modules/history/init.zsh

# ==> History Search Multi-Word
#     set reset-prompt-protect to be able to use zle reset-prompt in your e.g.
#     sched calls, in presence of zdharma/fast-syntax-highlighting,
#     zsh-users/zsh-syntax-highlighting, zsh-users/zsh-autosuggestions and other
#     plugins that hook up into Zshell by overloading Zle widgets. In general,
#     HSMW should be loaded in bulk (no gap) with all those plugins, right
#     before them.
zplugin load zdharma/history-search-multi-word
zstyle ":plugin:history-search-multi-word" reset-prompt-protect 1
zstyle ":plugin:history-search-multi-word" clear-on-cancel "yes"

# ==> fzf
zplugin ice atload'
    if (( ! $+commands[fzf] )); then
        if [[ $OS = 'osx' ]]; then
            # install fzf in the background
            # (will need to start a new terminal session to see results)
            brew install fzf >/dev/null &!
        # TODO: check for non-arch based distros
        elif [[ $OS = 'linux' ]]; then
            sudo pacman -S fzf
        else
            echo ''installing fzf not implemented for this system''
        fi
    fi'
zplugin snippet PZT::modules/command-not-found/init.zsh
# peco/percol/fzf wrapper plugin for zsh
zplugin ice
zplugin load mollifier/anyframe

# ==> emoji-cli
#     depends on: fzf, jp
#     uses my copy of abbec/emoji-cli (a fork of b4b4r07/emoji-cli)
#       to print the emoji directly
zplugin ice blockf
zplugin load qubidt/emoji-cli

# ==> Additional completion definitions for Zsh
#     blockf will block the traditional method of adding completions.
#     Zplugin uses own method (based on symlinks instead of adding to $fpath).
#     Zplugin will automatically install completions of newly downloaded plugin
zplugin ice blockf
zplugin load "zsh-users/zsh-completions"

# ==> Syntax Highlighting
#     If you load completions using wait'' mode then you can add
#     atinit'zpcompinit' to syntax-highlighting plugin (which should be the last
#     one), or atload'zpcompinit' to last completion-related plugin. zpcompinit
#     is a function that runs autoload compinit; compinit. There's also
#     zpcdreplay, so you can also do: atinit'zpcompinit; zpcdreplay', etc.
#     Basically, it's the same as normal compinit call, but it is done in atinit
#     or atload hook of last related plugin.
#     # zplugin ice wait"0" lucid atinit"ZPLGM[COMPINIT_OPTS]-C; zpcompinit; zpcdreplay"
#     ZPLGM[COMPINIT_OPTS]=-C skips compaudit (audit the fpath to assure that it
#     contains all the directories needed by the completion system, and that
#     those directories are at least unlikely to contain dangerous files)
zplugin ice wait"0" lucid atinit"zpcompinit; zpcdreplay"
zplugin load "zdharma/fast-syntax-highlighting"

# ==> zsh-autosuggestions
#     Autosuggestions uses precmd hook that is called right after processing
#     zshrc (before prompt). Turbo Mode will wait 1 second so precmd will be
#     called earlier than load of the plugin. This makes autosuggestions
#     inactive at first prompt. But the given atload Ice-mod fixes this, it
#     calls the same function precmd would, right after loading autosuggestions
zplugin ice wait'0' lucid atload'_zsh_autosuggest_start'  # load after fast-syntax-highlighting
zplugin load zsh-users/zsh-autosuggestions
# not working yet, see https://github.com/zdharma/zplugin/issues/69
# bindkey '^\n' autosuggest-execute
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh