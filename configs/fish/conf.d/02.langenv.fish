
source (brew --prefix asdf)/asdf.fish

if type -q pyenv
    status --is-interactive; and source (pyenv init -|psub)
    set -x PYENV_ROOT (pyenv root)
end
