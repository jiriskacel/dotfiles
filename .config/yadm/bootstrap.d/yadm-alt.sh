#!/bin/bash
SCRIPT=$(basename $0)
YADM=$HOME/bin/yadm

if [ -n "$WINDIR" ]; then
    echo "⚡ $SCRIPT"

    $YADM config yadm.auto-alt false
    $YADM config yadm.alt-copy true

    echo "✔  $SCRIPT"
fi
