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
[ -d $ZPFX/bin ] || mkdir -p $ZPFX/bin

# --------------
# macOS bindings
# --------------
if [[ $OS = 'osx' ]]; then
  bindkey "[D" backward-word
  bindkey "[C" forward-word
  bindkey "^[a" beginning-of-line
  bindkey "^[e" end-of-line
fi

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
#### module_path+=( "$ZPLG_HOME/bin/zmodules/Src" )
#### zmodload zdharma/zplugin
#### zpmod source-study

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
  alias l='ls -FGlhG'
  alias ll='ls -FGlAhG'
# TODO: check for non-arch based distros
elif [[ $OS = 'linux' ]]; then
  alias l='ls -FGlh --color=auto'
  alias ll='ls -FGlAh --color=auto'
else
  echo 'could not identify OS to set ls colors alias'
  alias l='ls -FGlh'
  alias ll='ls -FGlAh'
fi

# ==> less
#     F: quit-if-one-screen
#     S: aka chop-long-lines (truncate; don't wrap long lines)
#     R: output ANSI color escape sequences in raw form (useful for piping)
#     X: don't send init/de-init strings to terminal (i.e. don't clear screen)
#     c: repaint screen from top-down (rather than bottom-up)
alias less='less -SRF'

alias v='nvim'
alias n='nvim'

# ----------------
# install programs
# ----------------

if (( $+commands[bat] )); then
  alias cat='bat'
fi

if (( $+commands[prettyping] )); then
  alias ping='prettyping --nolegend'
fi

if (( $+commands[diff-so-fancy] )); then
  git config --global core.pager "diff-so-fancy | less --tabs=1,5 -RFX"
fi

# =============================================================================
# Plugins
# =============================================================================
source "$ZPLG_HOME/bin/zplugin.zsh"

# -----
# Theme
# -----
zplugin ice pick"async.zsh" src"pure.zsh"
zplugin load sindresorhus/pure

zplugin load chriskempson/base16-shell

# --------------
# custom plugins
# --------------
# zplugin "~/$XDG_CONFIG_HOME/zsh/*.zsh", from:local

# ---------------------
# prezto plugin options
# ---------------------
zstyle ':prezto:*:*' case-sensitive 'no'
zstyle ':prezto:*:*' color 'yes'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# -------
# scripts
# -------
# ==> prettyping
zplugin ice as"program" cp"prettyping -> ping" pick"prettyping"
zplugin snippet https://github.com/denilsonsa/prettyping/raw/master/prettyping

# ==> httpstat
zplugin ice as"program" cp"httpstat.sh -> httpstat" pick"httpstat"
zplugin load "b4b4r07/httpstat"

# Zplugin
zplugin ice as"program" pick"bin/git-dsf"
zplugin light "zdharma/zsh-diff-so-fancy"

# docker-machine-port-forwarder
zplugin ice as"program" pick"pf"
zplugin light "johanhaleby/docker-machine-port-forwarder"

# ==> safe-rm
#### zplugin ice as"program" cp"rm.sh -> rm" pick"rm"
#### zplugin snippet http://github.com/kaelzhang/shell-safe-rm/raw/master/bin/rm.sh

# -------------
# basic plugins
# -------------
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

# ==> suggests aliases
zplugin load djui/alias-tips

# ==> crasis
#     (depends on zdharma/fast-syntax-highlighting)
zplugin load zdharma/zui
zplugin light zdharma/zplugin-crasis


# ------------
# vi emulation
# ------------
# ==> built-in vi-mode
bindkey -v
# ==> Sane bindings for zsh's vi mode so it behaves more vim like
#     NOTE:   doesn't work atm, kills highlighting in history-search-multi-word
#             see: https://github.com/softmoth/zsh-vim-mode/issues/8
# zplugin load softmoth/zsh-vim-mode

# ==> command-not-found
zplugin snippet PZT::modules/command-not-found/init.zsh

# -------------------------------
# autocomplete / search / history
# -------------------------------
# ==> Sets history options and defines history aliases
zplugin snippet PZT::modules/history/init.zsh

# ==> fzf
export FZF_DEFAULT_COMMAND='rg --files 2>/dev/null'
export FZF_DEFAULT_OPTS='--preview "[[ $(file --mime {}) =~ binary ]] &&
           echo {} is a binary file ||
           (bat --color=\"always\" {} || cat {}) 2> /dev/null | head -500"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ==> History Search Multi-Word
#     set reset-prompt-protect to be able to use zle reset-prompt in your e.g.
#     `sched` calls, in presence of zdharma/fast-syntax-highlighting,
#     zsh-users/zsh-syntax-highlighting, zsh-users/zsh-autosuggestions and other
#     plugins that hook up into Zshell by overloading Zle widgets. In general,
#     HSMW should be loaded in bulk (no gap) with all those plugins, right
#     before them.
zplugin load zdharma/history-search-multi-word
zstyle ":plugin:history-search-multi-word" reset-prompt-protect 1
zstyle ":history-search-multi-word" page-size "$LINES/3"               # Number of entries to show (default is $LINES/3)
zstyle ":history-search-multi-word" highlight-color "bold,underline"   # Color in which to highlight matched, searched text (default bg=17 on 256-color terminals)
zstyle ":plugin:history-search-multi-word" synhl "yes"                 # Whether to perform syntax highlighting (default true)
zstyle ":plugin:history-search-multi-word" active "bg=base03"           # Effect on active history entry. Try: standout, bold, bg=blue (default underline)
zstyle ":plugin:history-search-multi-word" check-paths "yes"           # Whether to check paths for existence and mark with magenta (default true)
zstyle ":plugin:history-search-multi-word" clear-on-cancel "yes"       # Whether pressing Ctrl-C or ESC should clear entered query

# ==> Additional completion definitions for Zsh
#     blockf will block the traditional method of adding completions.
#     Zplugin uses own method (based on symlinks instead of adding to $fpath).
#     Zplugin will automatically install completions of newly downloaded plugin
zplugin ice blockf
zplugin load "zsh-users/zsh-completions"

# ==> emoji-cli
#     depends on: fzf, jp
#     uses my copy of abbec/emoji-cli (a fork of b4b4r07/emoji-cli)
#       to print the emoji directly
zplugin ice blockf
zplugin load qubidt/emoji-cli

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
zplugin ice wait"1" lucid atload"zpcompinit; zpcdreplay"
zplugin load "zdharma/fast-syntax-highlighting"

# ==> zsh-autosuggestions
#     Autosuggestions uses precmd hook that is called right after processing
#     zshrc (before prompt). Turbo Mode will wait 1 second so precmd will be
#     called earlier than load of the plugin. This makes autosuggestions
#     inactive at first prompt. But the given atload Ice-mod fixes this, it
#     calls the same function precmd would, right after loading autosuggestions
# not working yet, conflicts with history serach
# see https://github.com/zdharma/zplugin/issues/69
#   bindkey '^\n' autosuggest-execute
bindkey '^ ' autosuggest-execute
zplugin ice wait'0' lucid atload'_zsh_autosuggest_start'  # load after fast-syntax-highlighting
zplugin load zsh-users/zsh-autosuggestions
