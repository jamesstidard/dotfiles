
if status is-login
    source (brew --prefix asdf)/asdf.fish
    # asdf bin is already in brew linked PATH
    # don't need a second clutering up my PATH
    set -gx PATH (string match -v /usr/local/opt/asdf/bin $PATH)
end
