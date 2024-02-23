#!/bin/bash
YADM=$HOME/bin/yadm

while getopts c:o: name
do
    case $name in
    c)    CLASS="$CLASS $OPTARG";;
    o)    OS="$OPTARG";;
    ?)   printf "Usage: %s: [-o <os_override>] [-c <class>...]\n" $0
          exit 2;;
    esac
done

# install yadm
mkdir -p $HOME/bin
wget "https://github.com/TheLocehiliosan/yadm/raw/master/yadm" -qO $YADM
chmod 755 $YADM

# clone dotfiles
$YADM clone https://github.com/jiriskacel/dotfiles -b yadm/linux --no-bootstrap
$YADM checkout HEAD -- $HOME
for class in $CLASS; do
    $YADM config --add local.class $class
done
if [ -n "$OS" ]; then
    $YADM config local.os $OS
fi
$YADM alt
$YADM bootstrap
