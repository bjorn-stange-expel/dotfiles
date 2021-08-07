#!/usr/bin/env zsh

# This script iterates through all possible colors for a powerline go theme attribute
# This might be useful for customizing your powerline go theme, since the color values are
# not something I understand, this brute-force approach seems necessary to make informed decisions
# about powerline themes

# Usage powerline_go_palette.sh [theme_file_path] [theme_attribute_name]
# e.g. ./powerline_go_palette.sh ~/.config/powerline-go/themes/custom.json GitNotStagedBg

theme_file=$1

if [ -z "$theme_file" ]; then
  echo "Theme file not provided"
  echo "Usage: powerline_go_palette.sh [theme_file_path] [theme_attribute_name]"
  echo "e.g. ./powerline_go_palette.sh ~/.config/powerline-go/themes/custom.json GitNotStagedBg"
  exit 1
fi

if [ -f "$theme_file" ]; then
  echo "Found $theme_file"
else
  echo "Could not find theme file $theme_file"
  echo "Exiting"
  exit 1
fi

attribute_name=$2

if [ -z "$attribute_name" ]; then
  echo "Attribute name not provided"
  echo "Usage: powerline_go_palette.sh [theme_file_path] [theme_attribute_name]"
  echo "e.g. ./powerline_go_palette.sh ~/.config/powerline-go/themes/custom.json GitNotStagedBg"
  exit 1
fi

if grep --quiet "$attribute_name" "$theme_file"; then
  echo "$attribute_name was found in $theme_file"
else
  echo "$attribute_name was found not $theme_file"
  echo "Exiting"
  exit 1
fi

echo "Backing up theme file..."

cp "$theme_file" "$theme_file".backup

osx=0

OS=$(uname)
if [ "$OS" = 'Darwin' ]; then
  if ! command -v gsed &> /dev/null
  then
    echo "gsed is not installed, please install it with"
    echo "brew install gnu-sed"
    exit 1
  fi
  osx=1
fi

for i in {0..255}
do
  # TODO Check the behavior on OSX...might have to check uname and switch to gsed on Mac. So far
  # this has only been tested on Linux
  if [ "$osx" = 1 ]; then
    gsed -ri 's,('"$attribute_name"')": [0-9]+,\1": '"$i"',' "$theme_file"
  else
    sed -ri 's,('"$attribute_name"')": [0-9]+,\1": '"$i"',' "$theme_file"
  fi
  # You might have to change the below line to match your powerline_precmd function defined in your
  # zshrc
  PS1="$($GOPATH/bin/powerline-go -theme ~/.config/powerline-go/themes/custom.json -modules kube,cwd,git,exit -error $? -jobs ${${(%):%j}:-0})"
  print -P "$PS1" # https://zsh.sourceforge.io/Doc/Release/Shell-Builtin-Commands.html
  echo $i
done

echo "Restoring theme file from backup"

cp "$theme_file".backup "$theme_file"
