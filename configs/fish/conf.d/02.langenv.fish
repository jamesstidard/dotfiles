status --is-interactive; and source (pyenv init -|psub)
set -x PYENV_ROOT (pyenv root)

status --is-interactive; and source (nodenv init -|psub)
set -x NOENV_ROOT (nodenv root)

status --is-interactive; and source (rbenv init -|psub)
set -x RBENV_ROOT (rbenv root)

status --is-interactive; and source (goenv init -|psub)
set -x GOENV_ROOT (goenv root)
