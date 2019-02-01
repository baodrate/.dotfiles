required_vars=(SCRIPTS_DIR XDG_CONFIG_HOME BASE16_SHELL)
for i in "${required_vars[@]}"; do eval "val=\$$i"; if [ -z "$val" ]; then echo "$i is unset or empty"; exit -1; fi; done

profile_helper="$XDG_CONFIG_HOME"/colors/base16_profile_helper.sh

if [ -d $profile_helper ]; then echo "Couldn't find base16_profile_helper at $profile_helper"; exit -1; fi
source $profile_helper
