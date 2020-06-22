source $BYOBU_PREFIX/share/byobu/keybindings/f-keys.tmux.disable

unbind-key -n C-a
set -g prefix ^A
set -g prefix2 ^A
bind a send-prefix

# move x clipboard into tmux paste buffer
bind C-p run "xclip -o | tmux load-buffer - ; tmux paste-buffer"
# move tmux copy buffer into x clipboard
bind C-y run "tmux save-buffer - | xclip -i"
