$CONFIG = "install-win.conf.yaml"
$DOTBOT_DIR = "dotbot"

$DOTBOT_BIN = "bin/dotbot"

cd "$PSScriptRoot"
git -C "$DOTBOT_DIR" submodule sync --quiet --recursive
git submodule update --init --recursive "$DOTBOT_DIR"

& python "$PSScriptRoot\$DOTBOT_DIR\$DOTBOT_BIN" -d "$PSScriptRoot" -c "$CONFIG" $args
