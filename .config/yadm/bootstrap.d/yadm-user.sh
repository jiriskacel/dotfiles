#!/bin/bash
SCRIPT=$(basename $0)
YADM=$HOME/bin/yadm

echo "⚡ $SCRIPT"

$YADM gitconfig user.name "Jiří Skácel"
$YADM gitconfig user.email "jiriskacel@seznam.cz"
$YADM gitconfig remote.origin.url "https://jiriskacel@github.com/jiriskacel/dotfiles"
$YADM gitconfig commit.gpgSign false

echo "✔  $SCRIPT"
