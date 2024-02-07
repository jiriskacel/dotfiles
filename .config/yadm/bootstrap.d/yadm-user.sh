#!/bin/bash
SCRIPT=$(basename $0)

echo "⚡ $SCRIPT"

yadm gitconfig user.name "Jiří Skácel"
yadm gitconfig user.email "jiriskacel@seznam.cz"
yadm gitconfig commit.gpgSign false

echo "✔  $SCRIPT"
