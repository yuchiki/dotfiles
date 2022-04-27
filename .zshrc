export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="mytheme"
plugins=(git)

_kube_prompt_info () {
    if ! which kubectl > /dev/null 2>&1; then
        KUBE_PS1_CONTEXT=""
    elif ! kubectl config current-context > /dev/null 2>&1; then
        KUBE_PS1_CONTEXT=""
    else
        KUBE_PS1_CONTEXT="%{${fg_bold[blue]%}%}⎈:(%{$fg_bold[magenta]%}$(kubectl config current-context)%{$fg_bold[blue]%})%{$reset_color%}"
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _kube_prompt_info

source $ZSH/oh-my-zsh.sh

alias k=kubectl
alias gs="git status"
alias la="ls -la"

if which wslpath > /dev/null 2>&1; then # only in WSL
    # https://code.visualstudio.com/docs/remote/containers#:~:text=Service%20ssh%2Dagent-,Linux,-%3A

    if [ -z "$SSH_AUTH_SOCK" ]; then
        # Check for a currently running instance of the agent
        RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
        if [ "$RUNNING_AGENT" = "0" ]; then
            # Launch a new instance of the agent
            ssh-agent -s &> $HOME/.ssh/ssh-agent
        fi
        eval `cat $HOME/.ssh/ssh-agent`
    fi
fi

