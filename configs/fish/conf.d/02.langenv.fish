
source (brew --prefix asdf)/asdf.fish
# asdf bin is already in brew linked PATH
# don't need a second clustering up my PATH
set PATH (string match -v /usr/local/opt/asdf/bin $PATH)
