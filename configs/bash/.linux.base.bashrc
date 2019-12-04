# Dont modify this script. instead extend ~/.bashrc

# linuxbrew
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"

# linux brew qt
# export PATH="/home/linuxbrew/.linuxbrew/opt/qt/bin:$PATH"
# export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/qt/lib"
# export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/qt/include"
# export PKG_CONFIG_PATH="/home/linuxbrew/.linuxbrew/opt/qt/lib/pkgconfig"

eval "$(hub alias -s)"

eval "$(pyenv init -)"

alias update="fish -c 'update'"
