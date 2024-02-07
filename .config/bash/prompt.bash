source ~/.config/git/git-prompt.sh

__my_git_ps1 ()
{
    local ps1pc_prefix="\[\033[00;90m\]\u\[\033[00m\]@\[\033[36m\]\h\[\033[00m\]:\[\033[34m\]\w\[\033[00m\] "
    local ps1pc_suffix="\\\$ "

    # special handling for yadm
    if [ "$PWD" = "$HOME" ]; then
        local gitstring=$(GIT_DIR=$HOME/.local/share/yadm/repo.git __posh_git_echo)
    else
        local gitstring=$(__posh_git_echo)
    fi
    PS1=$ps1pc_prefix$gitstring$ps1pc_suffix
}

PROMPT_COMMAND="__my_git_ps1; $PROMPT_COMMAND"
