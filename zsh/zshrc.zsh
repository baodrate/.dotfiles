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
source "$ZPLG_HOME/bin/zplugin.zsh"

# ==> source-study module
module_path+=( "$ZPLG_HOME/bin/zmodules/Src" )
zmodload zdharma/zplugin
zpmod source-study

# =============================================================================
# Configuration
# =============================================================================
export TERM='screen-256color'

# =============================================================================
# Plugins
# =============================================================================

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
# ==> Sane options for zsh, in the spirit of vim-sensible
zplugin load willghatch/zsh-saneopt

# ==> Sets general shell options and defines environment variables.
zplugin snippet PZT::modules/environment/init.zsh

# ==> suggests package name
if [[ $OS = 'osx' ]]; then
    # tap the command-not-found homebrew cask silently and in the background
    # (will need to start a new terminal session to see results)
    zplugin ice wait'0' lucid atinit' \
        [ -d "$CASK_HOME/homebrew/homebrew-command-not-found" ] \
        || brew tap homebrew/command-not-found >/dev/null 2>&1 &!'
else
    echo 'installing command-not-found not implemented for this system'
    exit 1
fi
zplugin snippet PZT::modules/command-not-found/init.zsh

# ----------------------
# macOS specific plugins
# ----------------------
if [[ $OS = 'osx' ]]; then
    zplugin ice wait"0" lucid
    zplugin snippet PZT::modules/osx/init.zsh
    zplugin snippet PZT::modules/homebrew/init.zsh
elif [[ $OS = 'linux' ]]; then
    zplugin snippet PZT::modules/pacman/init.zsh
fi

# -------------
# misc. plugins
# -------------

# ==> git aliases
zplugin ice svn silent
zplugin snippet PZT::modules/git
# ==> git-sync
zplugin load caarlos0/zsh-git-sync                              # Sync git repositories and clean them up.

# ==> colored manpages
zplugin snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
# ==> cat with syntax highlighting
zplugin snippet OMZ::plugins/colorize/colorize.plugin.zsh
# ==> cp with progress bar (rsync)
zplugin snippet OMZ::plugins/cp/cp.plugin.zsh

# ==> Utility aliases and functions.
zplugin ice svn silent
zplugin snippet https://github.com/zimfw/zimfw/trunk/modules/utility

# ==> httpstat
zplugin ice as"program" cp"httpstat.sh -> httpstat" pick"httpstat"
zplugin load "b4b4r07/httpstat"

# ==> suggests aliases
zplugin load djui/alias-tips

# ==> crasis
zplugin load zdharma/zui
zplugin ice wait'[[ -n ${ZLAST_COMMANDS[(r)cras*]} ]]' lucid    # depends on zdharma/fast-syntax-highlighting
zplugin load zdharma/zplugin-crasis

# ==> jq
if [[ $OS = 'osx' ]]; then
    # install jq in the background 
    # (will need to start a new terminal session to see results)
    zplugin ice wait'0' lucid atload' \
        [ -d "$FORMULA_HOME/jq" ] \
        || brew install jq >/dev/null &!'
else
    echo 'installing jq not implemented for this system'
    exit 1
fi

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
zstyle :plugin:history-search-multi-word reset-prompt-protect 1
zstyle ":plugin:history-search-multi-word" clear-on-cancel "yes"

# ==> fzf
if [[ $OS = 'osx' ]]; then
    # install fzf in the background 
    # (will need to start a new terminal session to see results)
    zplugin ice atload' \
        [ -d "$FORMULA_HOME/fzf" ] \
        || brew install fzf >/dev/null &!'
else
    echo 'installing fzf not implemented for this system'
    exit 1
fi
# peco/percol/fzf wrapper plugin for zsh
zplugin ice
zplugin load mollifier/anyframe

# ==> emoji-cli
#     depends on: fzf, jp
#     uses my copy of abbec/emoji-cli (a fork of b4b4r07/emoji-cli)
#       to print the emoji directly
zplugin ice
zplugin load qubidt/emoji-cli

# ==> Additional completion definitions for Zsh
#     blockf will block the traditional method of adding completions.
#     Zplugin uses own method (based on symlinks instead of adding to $fpath).
#     Zplugin will automatically install completions of newly downloaded plugin
zplugin ice blockf
zplugin light "zsh-users/zsh-completions"

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
zplugin load zdharma/fast-syntax-highlighting

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