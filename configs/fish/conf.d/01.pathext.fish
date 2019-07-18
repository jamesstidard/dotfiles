if test -d ~/.cargo/bin
    set -x PATH ~/.cargo/bin $PATH
end

if test -d ~/.pyenv/bin
    set -x PATH ~/.pyenv/bin $PATH
end

set -x PATH ~/.local/bin $PATH
