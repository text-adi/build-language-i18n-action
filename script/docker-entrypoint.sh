#!/usr/bin/env sh

clear
# shellcheck disable=SC2112
function title_msg() {

  echo "    ____      _                                     _                                 ____            _   _       _"
  echo "   |  _ \    (_)   __ _   _ __     __ _    ___     | |       __ _   _ __     __ _    | __ )   _   _  (_) | |   __| |   ___   _ __"
  echo "   | | | |   | |  / _' | | '_ \   / _' |  / _ \    | |      / _' | | '_ \   / _' |   |  _ \  | | | | | | | |  / _' |  / _ \ | '__|"
  echo "   | |_| |   | | | (_| | | | | | | (_| | | (_) |   | |___  | (_| | | | | | | (_| |   | |_) | | |_| | | | | | | (_| | |  __/ | |"
  echo "   |____/   _/ |  \__,_| |_| |_|  \__, |  \___/    |_____|  \__,_| |_| |_|  \__, |   |____/   \__,_| |_| |_|  \__,_|  \___| |_|"
  echo "           |__/                   |___/                                     |___/ "

}
function line_msg() {
  echo '-----------------------------'
}

title_msg
line_msg
echo "Build language files..."
line_msg

files=$(find . -name "*.po")

for file in $files; do
  path=$(echo $file | cut -d'/' -f -5) # шлях до файла
  file_name=$(echo $file | rev | cut -d'/' -f1 | rev |  cut -d'.' -f 1) # назва файла, без розширення

  echo "Compile $path/$file_name.po > $path/$file_name.mo"
  msgfmt -o "$path/$file_name.mo" "$path/$file_name.po"

done
line_msg

echo "Finish."
