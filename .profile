if [ -d $HOME/opt/bin ]; then export PATH="$HOME/opt/bin:$PATH"; fi
if [ -d $HOME/.local/bin ]; then export PATH="$HOME/.local/bin:$PATH"; fi

if command -v nvim &> /dev/null; then
    export EDITOR=nvim
else
    export EDITOR=vi
fi

if command -v rg &> /dev/null; then
    export GREP=rg
fi

# bind caps to ctrl
if [ -f ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi
