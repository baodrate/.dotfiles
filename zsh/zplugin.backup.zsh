# => ZPFX (polaris) directory to store compiled programs
[ -d $ZPFX/bin ] || mkdir $ZPFX/bin

if [[ `uname` = 'Linux' ]]; then
  export OS=linux
elif [[ `uname` = 'Darwin' ]]; then
  export OS=osx
else
  >&2 echo "Can't detect OS"
  return
fi

module_path+=( "$ZPLG_HOME/bin/zmodules/Src" )
zmodload zdharma/zplugin
zpmod source-study

CASK_HOME="/usr/local/Homebrew/Library/Taps"
FORMULA_HOME="/usr/local/Cellar"

# -----
# Theme
# -----
zplugin ice pick"async.zsh" src"pure.zsh"
zplugin load sindresorhus/pure

# ---------------------
# prezto plugin options
# ---------------------
zstyle ':prezto:*:*' case-sensitive 'yes'
zstyle ':prezto:*:*' color 'yes'

zplugin ice svn; zplugin snippet PZT::modules/utility       # Defines general aliases and functions.
# zplugin "plugins/common-aliases", from:oh-my-zsh

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
zplugin ice wait"0" lucid
zplugin snippet PZT::modules/git/alias.zsh
zplugin ice wait"0" lucid
zplugin snippet PZT::modules/git/init.zsh

zplugin load zdharma/zui                                        # needed by crasis
zplugin ice wait'[[ -n ${ZLAST_COMMANDS[(r)cras*]} ]]' lucid    # depends on zdharma/fast-syntax-highlighting
zplugin load zdharma/zplugin-crasis
zplugin load caarlos0/zsh-git-sync                      # Sync git repositories and clean them up.

zplugin load djui/alias-tips                            # suggests aliases

zplugin snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh  # colored manpages
zplugin snippet OMZ::plugins/colorize/colorize.plugin.zsh           # cat with syntax highlighting
zplugin snippet OMZ::plugins/cp/cp.plugin.zsh                 # cp with progress bar (rsync)

# zplugin ice as"program" cp"httpstat.sh -> httpstat" pick"httpstat"
# zplugin load "b4b4r07/httpstat"

zplugin ice pick"httpstat" as"command" cp"httpstat.sh -> httpstat"
zplugin load b4b4r07/httpstat

# # ==> jq
# #     needed for b4b4r07/emoji-cli
# if [[ $OS = 'osx' ]]; then
#     # install jq in the background 
#     # (will need to start a new terminal session to see results)
#     zplugin ice wait'0' lucid atload' \
#         [ -d "$FORMULA_HOME/jq" ] \
#         || brew install jq >/dev/null &!'
# else
#     echo 'installing jq not implemented for this system'
#     exit 1
# fi
# zplugin snippet PZT::modules/command-not-found/init.zsh
# zplugin load stedolan/jq

# ==> emojis
zplugin ice wait"0" lucid
zplugin load b4b4r07/emoji-cli # depends on jq

# --------------
# custom plugins
# --------------
# The output of find is stored as a string
# zplugin "~/$XDG_CONFIG_HOME/zsh/*.zsh", from:local

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
zstyle :plugin:history-search-multi-word reset-prompt-protect 1
zplugin load zdharma/history-search-multi-word

# ==> vi-mode
bindkey -v

# ==> cd command with an interactive filter
#disabled ENHANCD_DISABLE_DOT=1
#disabled zplugin load b4b4r07/enhancd

# ==> Additional completion definitions for Zsh
#     blockf will block the traditional method of adding completions.
#     Zplugin uses own method (based on symlinks instead of adding to $fpath).
#     Zplugin will automatically install completions of newly downloaded plugin
if [[ -d /usr/local/Homebrew/completions/zsh ]]; then
  zplugin ice blockf
  zplugin load /usr/local/Homebrew/completions/zsh
fi
zplugin ice blockf
zplugin load zsh-users/zsh-completions

# ==> zsh-autosuggestions
#     Autosuggestions uses precmd hook that is called right after processing
#     zshrc (before prompt). Turbo Mode will wait 1 second so precmd will be
#     called earlier than load of the plugin. This makes autosuggestions
#     inactive at first prompt. But the given atload Ice-mod fixes this, it
#     calls the same function precmd would, right after loading autosuggestions
# zplugin ice wait'1' lucid atload'_zsh_autosuggest_start'
zplugin load zsh-users/zsh-autosuggestions

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
zplugin ice wait"1" lucid atinit"zpcompinit; zpcdreplay"
zplugin load zdharma/fast-syntax-highlighting

function zplugin_end(){
    autoload -z compinit && compinit -i
    zplugin cdreplay -q # -q is for quiet
    # autoload -Uz _zplugin
    # (( ${+_comps} )) && _comps[zplugin]=_zplugin
}

# zplugin_end