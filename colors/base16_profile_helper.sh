#!/usr/bin/bash
# https://stackoverflow.com/a/25515370
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; return -1; }
try() { "$@" || die "cannot ($?): $*"; }

# https://stackoverflow.com/a/11097703
if [ -n "$BASH" ] ; then
  curr_shell="bash"
elif [ -n "$ZSH_NAME " ] ; then
  curr_shell="$ZSH_NAME"
else
  curr_shell=$(ps -p $$ -o ucomm= | sed 's/[[:space:]]*//g')
fi

if [ "$curr_shell" = "zsh" ]; then
  script_dir=${0:a:h}
elif [ "$curr_shell" = "bash" ]; then
  file_name=${BASH_SOURCE[0]}
  script_dir="$( cd "$( dirname "$file_name" )" >/dev/null 2>&1 && pwd )"
else
  die "don't recognize running shell: '$curr_shell'"
fi

themes_dir="$script_dir/base16-shell/scripts"
current_theme_link="$script_dir/current_base16_theme"

get_abs_path() { perl -MCwd -le 'print Cwd::abs_path(shift)' "$1" ; }

cat <<FUNC
_base16()
{
  local theme=\$1

  echo "Changing base16: \$theme"

  script="$themes_dir/base16-\${theme}.sh"
  [ -f "\$script" ] || { echo "failed to find script (\$script) for theme (\$theme)" && return 1 ; }
  source "\$script" >&2 || die "couldn't source script: \$script"

  export BASE16_THEME="\${theme}"

  # run shell hooks
  if [ -n "\$BASE16_SHELL_HOOKS" ] && [ -d "\${BASE16_SHELL_HOOKS}" ]; then
    failures=
    for hook in "\$BASE16_SHELL_HOOKS"/*; do
      if [ -f "\$hook" ] && [ -x "\$hook" ] && hook_output=\$(\$hook); then
        echo "Hook ran successfully: \$(basename "\$hook")\${hook_output:+ (\$hook_output)}"
      else
        echo "Hook failed: \$hook (\$hook_output)" 1>&2
        failures="\$hook;\$failures"
      fi
    done
    [ -z "\$failures" ] || return 1
  fi
}
FUNC

ls $themes_dir | sed 's/^base16-\(.*\)\.sh/alias base16-\1="_base16 \\"\1\\""/'

if [ -n "$BASE16_THEME" ]; then
  echo ". $themes_dir/base16-\${BASE16_THEME}.sh"
elif [[ -h "$current_theme_link" ]] ; then
  script_path="$(get_abs_path $current_theme_link)"
  if [[ -e "$script_path" ]]; then
    script_name=$(basename "$script_path" .sh)
    echo "export BASE16_THEME=${script_name##base16-}"
    echo ". $current_theme_link"
  else
    echo "could not find script at $script_path" >&2
  fi
else
  echo "BASE16_THEME not set and could not find theme link at $current_theme_link" >&2
fi
