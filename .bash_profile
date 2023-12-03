# Load common login shell settings
if [ -f "$HOME/.profile" ]; then
        . "$HOME/.profile"
fi

# Load aliases and functions if bash is running
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
