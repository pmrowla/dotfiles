#!/bin/sh
# remote irssi notifications in osx
irssi_notifier() {
    ssh tralus.pmrowla.com 'echo -n "" > ~/.irssi/fnotify; tail -f ~/.irssi/fnotify' | \
            while read heading message; do
            url=`echo \"$message\" | grep -Eo 'https?://[^ >]+' | head -1`;

            if [ ! "$url" ]; then
                /opt/boxen/homebrew/bin/terminal-notifier -title "\"$heading\"" -message "\"$message\"" -activate com.google.iterm2;
            else
                /opt/boxen/homebrew/bin/terminal-notifier -title "\"$heading\"" -message "\"$message\"" -open "\"$url\"";
            fi;
        done
}

irssi_notifier;
