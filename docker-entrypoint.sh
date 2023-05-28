#!/bin/sh

set -e

# Default to * if AWS_REGION not set.
if [ ! -v DIR ]; then
  DIR="."
fi

# shellcheck disable=SC2112
function title_msg() {

  echo "   _                                 ____            _   _       _"
  echo "  | |       __ _   _ __     __ _    | __ )   _   _  (_) | |   __| |   ___   _ __"
  echo "  | |      / _' | | '_ \   / _' |   |  _ \  | | | | | | | |  / _' |  / _ \ | '__|"
  echo "  | |___  | (_| | | | | | | (_| |   | |_) | | |_| | | | | | | (_| | |  __/ | |"
  echo "  |_____|  \__,_| |_| |_|  \__, |   |____/   \__,_| |_| |_|  \__,_|  \___| |_|"
  echo "                           |___/ "

}
function line_msg() {
  echo '-----------------------------'
}

title_msg
line_msg
echo "Build language files..."
line_msg

echo "Found files in directory "${DIR}"..."
files=$(find ${DIR} -name "*.po")
echo "Start build..."

for file in $files; do
  path=$(dirname $file)                                 # шлях до файла
  file_name=$(echo $file | rev | cut -d'/' -f1 | rev | cut -d'.' -f 1) # назва файла, без розширення

  echo "Compile $path/$file_name.po > $path/$file_name.mo"
  msgfmt -o "$path/$file_name.mo" "$path/$file_name.po"

done
line_msg

echo "Finish."
