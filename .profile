if command -v nvim &> /dev/null; then
    export EDITOR=nvim
else
    export EDITOR=vi
fi