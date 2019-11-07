#!/usr/bin/env bash
command=${1:?}
shift

scripts=( $(ls ${XDG_CONFIG_HOME:-$HOME/.config}/colors/base16-shell/scripts/*) )
themes=()
for file in "${scripts[@]}" ; do
  theme=${file##*base16-}
  theme=${theme%.sh}
  themes+=("$theme")
done

get_index() {
    theme_name=${1:?}
    shift

    # get index of current theme
    for (( i=0; i<${#themes[@]}; i++ )); do
      [[ "$theme_name" == "${themes[i]}" ]] && break
    done

    printf '%d' $i
}

prev() {
    curr_theme=${1:?}
    i=$(get_index $curr_theme)
    # loop around if at beginning
    if (( $i == 0 )) ; then i=$(( ${#themes[@]} )) ; fi
    index $(( i-1 ))
}

next() {
    curr_theme=${1:?}
    i=$(get_index $curr_theme)
    # loop around if at end
    if (( $i == ( ${#themes[@]} - 1 ) )) ; then
      i=$(( 0 ))
    else
      i=$(( i+1 ))
    fi
    index $i
}

index() {
    i=${1:?}
    theme ${themes[i]}
}

theme() {
    theme_name=${1:?}
    theme_script=${XDG_CONFIG_HOME:-$HOME/.config}/colors/base16-shell/scripts/base16-${theme_name}.sh

    printf '%s (%s)' "$theme_name" "$theme_script"

    export BASE16_THEME="$theme_name"

    theme_name=${1:?}
    . $theme_script
}

colortest() {
    ansi_mappings=(
      Black
      Red
      Green
      Yellow
      Blue
      Magenta
      Cyan
      White
      Bright_Black
      Bright_Red
      Bright_Green
      Bright_Yellow
      Bright_Blue
      Bright_Magenta
      Bright_Cyan
      Bright_White
    )

    colors=(
      base00
      base08
      base0B
      base0A
      base0D
      base0E
      base0C
      base05
      base03
      base08
      base0B
      base0A
      base0D
      base0E
      base0C
      base07
      base09
      base0F
      base01
      base02
      base04
      base06
    )

    for padded_value in `seq -w 0 21`; do
      color_variable="color${padded_value}"
      eval current_color=\$${color_variable}
      current_color=$(echo ${current_color//\//} | tr '[:lower:]' '[:upper:]') # get rid of slashes, and uppercase
      non_padded_value=$((10#$padded_value))
      base16_color_name=${colors[$non_padded_value]}
      current_color_label=${current_color:-unknown}
      ansi_label=${ansi_mappings[$non_padded_value]} 
      block=$(printf "\x1b[48;5;${non_padded_value}m___________________________")
      foreground=$(printf "\x1b[38;5;${non_padded_value}m$color_variable")
      printf "%s %s %s %-30s %s\x1b[0m\n" $foreground $base16_color_name $current_color_label ${ansi_label:-""} $block
    done;
}

set_permanent() {
    # run shell hooks
    if [ -n "$BASE16_SHELL_HOOKS" ] && [ -d "${BASE16_SHELL_HOOKS}" ]; then
      failures=
      for hook in "$BASE16_SHELL_HOOKS"/*; do
        if [ -f "$hook" ] && [ -x "$hook" ] && hook_output=$($hook); then
          echo "Hook ran successfully: $(basename "$hook")${hook_output:+ ($hook_output)}"
        else
          echo "Hook failed: $hook ($hook_output)" 1>&2
          failures="$hook;$failures"
        fi
      done
      [ -z "$failures" ] || return 1
    fi
}

case $command in
  interactive)
    case "$SHELL" in
      *zsh)  read_flags="-k 1 -s -r" ;;
      *bash) read_flags="" ;;
      *)
        echo "unsupported shell: $SHELL" >&2
        return 1
        ;;
    esac

    interactive_help() {
      message=${1:-"commands"}
      printf '%s:\t' "$message"
      printf '%s (%s) ' n next p previous q quit s save h help | paste -s -d '|' -
    }

    tput rmcup
    tput smcup
    tput clear

    theme $BASE16_THEME
    echo
    colortest

    while IFS= read -n 1 -s -r char ; do
      tput cup 0 0
      tput el

      case $char in
        h|H) interactive_help ;;
        n|N) next $BASE16_THEME;;
        p|P) prev $BASE16_THEME;;
        s|S)
          tput clear
          tput rmcup
          set_permanent
          exit $?
          ;;
        q|Q) exit 0 ;;
        *) interactive_help "unknown command: '$char'; try" ;;
      esac

      tput ll
    done
    ;;

  prev) prev "$@" ;;
  next) next "$@" ;;
  index) index "$@" ;;
  theme) theme "$@" ;;
  colortest) colortest "$@" ;;
  set-permanent) set_permanent "$@" ;;

  *)
    echo "unknown command: '$command'" >&2
    return 1
    ;;
esac
