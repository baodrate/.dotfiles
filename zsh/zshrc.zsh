# =============================================================================
# Setup
# =============================================================================

# ==> Parse operating system
if [[ `uname` = 'Linux' ]]; then
  export OS=linux
elif [[ `uname` = 'Darwin' ]]; then
  export OS=osx
else
  echo "Can't detect OS" >&2
  return 1
fi

if [[ $OS = 'linux' ]]; then
  alias yolo='pacaur -Syuu --noconfirm'
fi

CASK_HOME="/usr/local/Homebrew/Library/Taps"
FORMULA_HOME="/usr/local/Cellar"

ZPLG_HOME="${ZDOTDIR:-$HOME}/.zplugin"
# => ZPFX (polaris) directory to store compiled programs
[ -d $ZPFX/bin ] || mkdir -p $ZPFX/bin

# ==> zplugin automatic compilation module
#     lets you use source-study module to check load times
#     (call with `zpmod source-study`)
# module_path = 
if [[ -d "$ZPLG_HOME/bin/zmodules/Src"  ]] ; then
  module_path+=( "$ZPLG_HOME/bin/zmodules/Src" )
  (zmodload zdharma/zplugin) >/dev/null 2>&1
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
    return 1
  fi
fi

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
local ls_cmd="ls"
local ls_default_flags=()

# Default i.e. posix flags
local ls_long="-l"
local ls_short=""
local ls_sort_newest="-t"
local ls_hidden=""
local ls_show_hidden="-a"
local ls_one_line="-1"

# platform-specific flags
local ls_colors=""
local ls_indicators=""
local ls_human_filesizes=""
local ls_group_dirs

if (( $+commands[exa] )) ; then
  local exa_grid="--grid"                           # -G show long format in grid (multi-column)
  local exa_git="--git"                             #    show git status in table
  local exa_gitignore="--git"                       #    hide files defined in gitignore

  ls_long="--long"                           # -l
  ls_short="$exa_grid $ls_long"
  ls_sort_newest="--sort=oldest"             # -sort=modified -reverse
  ls_hidden="--git-ignore"
  ls_show_hidden="--all"                     # -a (call twice to show . and ..)
  ls_one_line="--oneline"                    # -1
  ls_colors="--color=always"                 #    'always' to forward to e.g. less
  ls_indicators="--classify"                 # -F
  ls_human_filesizes="--binary"              # -b use binary prefixes (e.g. KiB vs KB)
  ls_group_dirs="--group-directories-first"  #    self-explanatory

  ls_default_flags+=($exa_colors $exa_indicators $exa_human_filesizes $exa_group_dirs)
  ls_cmd="exa"

else
  if [[ $OS = 'linux' || $OS = 'osx' && (( $+commands[gls] )) ]] ; then
    # macOS but we have `brew coreutils`
    if [[ $OS = 'osx' ]] ; then
      ls_cmd="gls"
    fi

    ls_long="-l"
    ls_short=""
    ls_sort_newest="-t"
    ls_hidden=""
    ls_show_hidden="-A"
    ls_one_line="-1"
    ls_colors="--color=always"
    ls_indicators="-F"
    ls_human_filesizes="-h"

    ls_group_dirs="--group-directories-first"

  elif [[ $OS = 'osx' ]]; then
    ls_long="-l"
    ls_short=""
    ls_sort_newest="-t"
    ls_hidden=""
    ls_show_hidden="-A"
    ls_one_line="-1"
    ls_colors="-G"
    ls_indicators="-F"
    ls_human_filesizes="-h"
  fi

fi

ls_default_flags+=($ls_colors $ls_indicators $ls_human_filesizes $ls_group_dirs)
ls_cmd_short="$ls_cmd ${^ls_default_flags} $ls_short"
ls_cmd_long="$ls_cmd ${^ls_default_flags} $ls_long"

alias ls="$ls_cmd ${^ls_default_flags} $ls_hidden"
alias lsa="$ls_cmd ${^ls_default_flags} $ls_show_hidden"

alias l="$ls_cmd_short $ls_hidden"
alias la="$ls_cmd_short $ls_show_hidden"
alias lt="$ls_cmd_short $ls_hidden $ls_sort_newest"
alias lat="$ls_cmd_short $ls_show_hidden $ls_sort_newest"
alias ll="$ls_cmd_long $ls_hidden"
alias lla="$ls_cmd_long $ls_show_hidden"
alias llt="$ls_cmd_long $ls_hidden $ls_sort_newest"
alias llat="$ls_cmd_long $ls_show_hidden $ls_sort_newest"

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

# ------
# Colors
# ------
BASE16_SHELL_HOOKS=$HOME/.colors/base16-shell-hooks
source ~/.colors/base16_profile_helper.sh # call before prompt because this checks [ -n "$PS1" ]

# =============================================================================
# Plugins
# =============================================================================

source "$ZPLG_HOME/bin/zplugin.zsh"

# -----
# Theme
# -----

# ==> spaceship (not using because slow for now)
#     wait for https://github.com/denysdovhan/spaceship-prompt/pull/499
# zplugin ice src"spaceship.zsh"
# zplugin load denysdovhan/spaceship-prompt

# ==> pure prompt
zplugin ice pick"async.zsh" src"pure.zsh"
zplugin load sindresorhus/pure

# --------------
# custom plugins
# --------------
# zplugin "$XDG_CONFIG_HOME/zsh/*.zsh", from:local

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

# ==> diff-so-fancy
zplugin ice as"program" pick"bin/git-dsf"
zplugin light "zdharma/zsh-diff-so-fancy"

# ==> git-now
zplugin ice wait"2" lucid as"program" pick"$ZPFX/bin/git-now" make"prefix=$ZPFX install"
zplugin light iwata/git-now

# ==> git extras
zplugin ice wait"2" lucid as"program" pick"$ZPFX/bin/git-alias" make"PREFIX=$ZPFX" nocompile
zplugin light tj/git-extras

# docker-machine-port-forwarder
zplugin ice as"program" pick"pf"
zplugin light "johanhaleby/docker-machine-port-forwarder"

# -------------
# basic plugins
# -------------
# ==> Sane options for zsh, in the spirit of vim-sensible
zplugin load willghatch/zsh-saneopt

# ==> command-not-found
#     suggests package name
zplugin snippet PZT::modules/command-not-found/init.zsh

# # https://github.com/sorin-ionescu/prezto/blob/master/modules/command-not-found/init.zsh
# # Load command-not-found on Debian-based distributions.
# zplugin ice if"[[ -s '/etc/zsh_command_not_found' ]]"
# zplugin load  '/etc/zsh_command_not_found'
# # Load command-not-found on Arch Linux-based distributions.
# zplugin ice if"[[ -s '/usr/share/doc/pkgfile/command-not-found.zsh' ]]"
# zplugin load '/usr/share/doc/pkgfile/command-not-found.zsh'
# # Load command-not-found on macOS when homebrew tap is configured.
# zplugin ice if"[[ -s '/usr/local/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh' ]]"
# zplugin load '/usr/local/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh'

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
zplugin ice if"(( $+commands[pacman] ))"
zplugin snippet PZT::modules/pacman/init.zsh

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
zplugin ice wait'0' lucid atload'_zsh_autosuggest_start; bindkey "^ " autosuggest-execute'  # load after fast-syntax-highlighting
zplugin load zsh-users/zsh-autosuggestions
