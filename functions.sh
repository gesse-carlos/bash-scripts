#!/bin/bash

# Create a directory and access him
function mkcd () {
  mkdir -p $1
  cd $1
}

# Copy an input to the clipboard
# Need xclip package, you can install using:
# sudo apt-get update
# sudo apt-get install xclip
function copy-to-clipboard () {
  cat $1 | xclip -i -selection clipboard
}

# Remove branches differents from main, staging and dev
function delete-branches () {
  for i in $(git branch | grep -v -E -w '(main|staging|dev)$'); do
    git branch -D "$i"
  done
}

# This function will list all files containing the string provided
function find-file-name () {
  find . -type f -exec grep -l "$1" {} \;
}

# This function will replace strings equal to the first input provided by the second input provided
function replace-strings () {
  find . -type f -exec grep -l "$1" {} \; | xargs sed -i "$2";
}

# This function will delete files with the specified type
function delete-files () {
  find . -type f -name "*.$1" -exec rm {} \;
}

# This function will delete files older than the specified days
function delete-files-older-than () {
  find . -type f -mtime +$1 -exec rm {} \;
}

# This function starts a webcam for screencast
function webcam () {
    mplayer -cache 128 -tv driver=v4l2:width=350:height=350 -vo xv tv:// -noborder -geometry "+1340+445" -ontop -quiet 2>/dev/null >/dev/null
}

# This function import a gpg key
function apt-import-key () {
    gpg --keyserver subkeys.pgp.net --recv-keys $1 | gpg --armor --export $1 | sudo apt-key add -
}

# This function translate, the arguments are 1 - The word that you want to translate, 2 - The primary language and 3 - The language you want to translate
function translate() {
    wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=$2|${3:-en}" | sed 's/.*"translatedText":"\([^"]*\)".*}/\1\n/'
}