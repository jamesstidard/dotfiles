if test -d ~/.cargo/bin
    set -x PATH ~/.cargo/bin $PATH
end

if test -d /home/linuxbrew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end
