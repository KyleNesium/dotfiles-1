if [ -r ~/.profile ]; then
   . ~/.profile
fi

case "$-" in
  *i*)
    if [ -r ~/.bashrc ]; then
      . ~/.bashrc
    fi
    ;;
esac

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
