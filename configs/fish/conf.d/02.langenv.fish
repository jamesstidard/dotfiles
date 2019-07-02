if type -q pyenv
    status --is-interactive; and source (pyenv init -|psub)
    set -x PYENV_ROOT (pyenv root)
end

if type -q nodenv
status --is-interactive; and source (nodenv init -|psub)
set -x NOENV_ROOT (nodenv root)
end

if type -q rbenv
    status --is-interactive; and source (rbenv init -|psub)
    set -x RBENV_ROOT (rbenv root)
end

if type -q goenv
    status --is-interactive; and source (goenv init -|psub)
    set -x GOENV_ROOT (goenv root)
end
