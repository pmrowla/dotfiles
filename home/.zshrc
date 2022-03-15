unset LC_ALL
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_COLLATE=ko_KR.UTF-8

export EDITOR=vim

# use homebrew zsh-completion
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

if [[ -d /usr/local/sbin ]]; then
    export PATH=/usr/local/sbin:$PATH
fi

if [[ -d ~/bin ]]; then
    export PATH=~/bin:$PATH
fi

if [[ -f ~/.dircolors ]] then
    if (( $+commands[gdircolors] )); then
        eval "$(gdircolors -b ~/.dircolors)" || eval "$(gdircolors -b)"
    elif (( $+commands[dircolors] )); then
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
if [[ -f ~/.zsh-antigen/antigen.zsh ]]; then
    source ~/.zsh-antigen/antigen.zsh
elif [[ -f /usr/local/share/antigen/antigen.zsh ]]; then
    source /usr/local/share/antigen/antigen.zsh
fi

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

# gpg
antigen bundle gpg-agent

# OS specific plugins
if [[ $OSTYPE == 'darwin'* ]]; then
    antigen bundle brew
    antigen bundle brew-cask
    antigen bundle macos

    export VIRTUALENVWRAPPER_PYTHON="$(brew --prefix)/opt/python/libexec/bin/python"

    # catalina and later don't allow the creation of /usr/include, set CPATH so
    # certain compilers can still find system headers
    export CPATH=`xcrun --show-sdk-path`/usr/include
else
    # zsh-completions is bundled with homebrew zsh by default, but we want it
    # on all other OS's
    antigen bundle zsh-users/zsh-completions
fi

# theme
antigen bundle pmrowla/purity

antigen apply

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export LESS="-R"

# added by travis gem
[ -f /Users/pmrowla/.travis/travis.sh ] && source /Users/pmrowla/.travis/travis.sh
