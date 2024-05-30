#!/bin/bash
SCRIPT=$(basename $0)
YADM=$HOME/bin/yadm

if [ -n "$WINDIR" ]; then
    echo "⚡ $SCRIPT"

    $YADM config yadm.auto-alt false
    $YADM config yadm.alt-copy true
    $YADM gitconfig alias.alt-back '!f() { cp() { git cat-file blob :.${2#$PWD} > $2.BASE; git merge-file -L common -L base -L local $2 $2.BASE $3; [ $? -gt 0 ] && echo ""There were conflits on $2"" >&2; rm -f $2.BASE; }; export -f cp; yadm alt >/dev/null; }; f'

    echo "✔  $SCRIPT"
fi
