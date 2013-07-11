#!/usr/bin/env bash

#
# Setting Solarized(Dark) theme for gnome-terminal in GNOME (>=v3.8, using dconf)
#
# Thanks to 
# http://unix.stackexchange.com/questions/66579/how-do-i-get-the-solarized-colour-scheme-working-with-gnome-terminal-tmux-and-v
# https://github.com/sigurdga/gnome-terminal-colors-solarized
#

### Colors

#DARK_BG='#000014141A1A'
DARK_BG='#00002B2B3636' # original
#LIGHTEST='#FFFFFBFBF0F0'
LIGHTEST='#FDFDF6F6E3E3' # original

bg_color=$DARK_BG
fg_color="#65657B7B8383"
bd_color="#9393A1A1A1A1"
palette="'#070736364242','#D3D301010202','#858599990000','#B5B589890000','#26268B8BD2D2','#D3D336368282','#2A2AA1A19898','#EEEEE8E8D5D5','$DARK_BG','#CBCB4B4B1616','#58586E6E7575','#65657B7B8383','#838394949696','#6C6C7171C4C4','#9393A1A1A1A1','$LIGHTEST'"


### Dconf path
dconfdir=/org/gnome/terminal/legacy/profiles:
profiles=($(dconf list $dconfdir/ | grep ^: | sed 's/\///g')); # list all profile IDs
profile=$1


die() {
  echo $1
  exit ${2:-1}
}

validate_profile() {
  local profile=$1;
  [[ -z "$profile" ]] && die "Please input profile ID" 2 ## if no input
  for p in $profiles
  do
    if [[ ":$profile" = "$p" ]]
    then
      return 1 # found input profile
    fi
  done
  die "$profile is not found" 3;
}

validate_profile $profile

profile_path=$dconfdir/:$profile

# set color palette
dconf write $profile_path/palette "[$palette]"

# set foreground, background and highlight color
dconf write $profile_path/bold-color "'$bd_color'"
dconf write $profile_path/background-color "'$bg_color'"
dconf write $profile_path/foreground-color "'$fg_color'"

# make sure the profile is set to not use theme colors
dconf write $profile_path/use-theme-colors "false"

# set highlighted color to be different from foreground color
dconf write $profile_path/bold-color-same-as-fg "false"

