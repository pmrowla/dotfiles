# ~/.bash_aliases: sourced in ~/.bashrc

# irssi doesn't work right in tmux if term isn't set properly
if [ -n "$TMUX" ]; then
    case "$TERM" in
    xterm)
        alias irssi='TERM=screen irssi'
        ;;
    xterm-256color)
        alias irssi='TERM=screen-256color irssi'
        ;;
    esac
fi
