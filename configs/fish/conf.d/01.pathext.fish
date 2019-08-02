if test -d ~/.cargo/bin
    set -x PATH ~/.cargo/bin $PATH
end

if test -d ~/.pyenv/bin
    set -x PATH ~/.pyenv/bin $PATH
end

set -x PATH ~/.local/bin $PATH

if test -d /home/linuxbrew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end
