# Dont modify this script. instead extend ~/.bashrc

# linuxbrew
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"

eval "$(hub alias -s)"

If you need to have qt first in your PATH run:
  echo 'export PATH="/home/linuxbrew/.linuxbrew/opt/qt/bin:$PATH"' >> ~/.bash_profile

For compilers to find qt you may need to set:
  export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/qt/lib"
  export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/qt/include"

For pkg-config to find qt you may need to set:
  export PKG_CONFIG_PATH="/home/linuxbrew/.linuxbrew/opt/qt/lib/pkgconfig"
