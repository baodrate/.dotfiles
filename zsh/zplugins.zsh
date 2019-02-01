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
zplugin ice as"program" pick"prettyping"
zplugin load "denilsonsa/prettyping"
alias ping=prettyping

# ==> httpstat
zplugin ice as"program" cp"httpstat.sh -> httpstat" pick"httpstat"
zplugin load "b4b4r07/httpstat"

# ==> diff-so-fancy
zplugin ice as"program" pick"diff-so-fancy"
zplugin load "so-fancy/diff-so-fancy"

# ==> git-now
zplugin ice as"program" pick"$ZPFX/bin/git-*" make"prefix=$ZPFX"
zplugin ice src'etc/_git-now' as'completion'
zplugin load iwata/git-now

# ==> git extras
zplugin ice as"program" make"PREFIX=$ZPFX" pick"$ZPFX/bin/git-*"
zplugin ice src'etc/git-extras-completion.zsh' as'completion'
zplugin load tj/git-extras


# -------------
# basic plugins
# -------------
# ==> Sane options for zsh, in the spirit of vim-sensible
zplugin load willghatch/zsh-saneopt

# ==> command-not-found
#     suggests package name

# https://github.com/sorin-ionescu/prezto/blob/master/modules/command-not-found/init.zsh
# Load command-not-found on Debian-based distributions.
zplugin ice if"[[ -s '/etc/zsh_command_not_found' ]]"
zplugin load  '/etc/zsh_command_not_found'
# Load command-not-found on Arch Linux-based distributions.
zplugin ice if"[[ -s '/usr/share/doc/pkgfile/command-not-found.zsh' ]]"
zplugin load '/usr/share/doc/pkgfile/command-not-found.zsh'
# Load command-not-found on macOS when homebrew tap is configured.
zplugin ice if"[[ -s '/usr/local/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh' ]]"
zplugin load '/usr/local/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh'

# ----------------------
# linux specific plugins
# ----------------------
# ==> pacman aliases
zplugin ice svn if"(( $+commands[pacman] ))"
zplugin snippet PZT::modules/pacman

# -------------
# misc. plugins
# -------------

# ==> git-sync
zplugin load caarlos0/zsh-git-sync                              # Sync git repositories and clean them up.

# ==> colored manpages
zplugin snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

# ==> suggests aliases
zplugin load djui/alias-tips

# ==> crasis
#     (depends on zdharma/fast-syntax-highlighting)
zplugin load zdharma/zui
zplugin load zdharma/zplugin-crasis


# -------------------------------
# autocomplete / search / history
# -------------------------------
# ==> fzf
export FZF_DEFAULT_COMMAND='rg --files 2>/dev/null'
export FZF_DEFAULT_OPTS='--preview "[[ $(file --mime {}) =~ binary ]] &&
           echo {} is a binary file ||
           (bat --color=\"always\" {} || cat {}) 2> /dev/null | head -500"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
zplugin ice from"gh-r" as"program"
zplugin load junegunn/fzf-bin
zplugin ice multisrc'shell/{completion,key-bindings}.zsh'
zplugin load junegunn/fzf

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

# ==> zsh-autosuggestions
#     Autosuggestions uses precmd hook that is called right after processing
#     zshrc (before prompt). Turbo Mode will wait 1 second so precmd will be
#     called earlier than load of the plugin. This makes autosuggestions
#     inactive at first prompt. But the given atload Ice-mod fixes this, it
#     calls the same function precmd would, right after loading autosuggestions
# not working yet, conflicts with history serach
# see https://github.com/zdharma/zplugin/issues/69
#   bindkey '^\n' autosuggest-execute
zplugin ice lucid atload'_zsh_autosuggest_start; bindkey "^ " autosuggest-execute'  # load after fast-syntax-highlighting
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
zplugin ice lucid atload"zpcompinit; zpcdreplay"
zplugin load "zdharma/fast-syntax-highlighting"
