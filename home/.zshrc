# Use ko_KR except for messages
unset LC_ALL
export LANG=ko_KR.UTF-8
export LC_CTYPE=ko_KR.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_RESPONSE=en_US.UTF-8

export EDITOR=vim

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

if [[ -d ~/bin ]]; then
    export PATH=~/bin:$PATH
fi

# brew is probably installed via boxen rather than into /usr/local
if [[ -d /opt/boxen/homebrew ]]; then
    export PATH=/opt/boxen/homebrew/sbin:/opt/boxen/homebrew/bin:$PATH
fi

if [[ -f ~/.dircolors ]]; then
    if [[ (( $+commands[gdircolors] )) ]]; then
        eval "$(gdircolors -b ~/.dircolors)" || eval "$(gdircolors -b)"
    elif [[ (( $+commands[dircolors] )) ]]; then
        eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    fi
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/pmrowla/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# use antigen for package management
source ~/.zsh-antigen/antigen.zsh

antigen use oh-my-zsh

# General plugins
antigen bundle git
antigen bundle heroku
antigen bundle vagrant
antigen bundle zsh-users/zsh-syntax-highlighting

# Python plugins
antigen bundle pip
antigen bundle python
antigen bundle virtualenv
antigen bundle virtualenvwrapper

# Ruby plugins
antigen bundle gem
antigen bundle rbenv
antigen bundle ruby

# OS specific plugins
if [[ $OSTYPE == 'darwin'* ]]; then
    antigen bundle brew
    antigen bundle brew-cask
    antigen bundle osx
else
    # zsh-completions is bundled with homebrew zsh by default, but we want it
    # on all other OS's
    antigen bundle zsh-users/zsh-completions
fi

# theme
antigen bundle therealklanni/purity

antigen apply
