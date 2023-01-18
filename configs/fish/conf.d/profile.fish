# mostly all set globally via ~fish/functions/set_fish_profile for quick loads

# 1PASSWORD
set -gx SSH_AUTH_SOCK ~/.1password/agent.sock

# iTerm shell integration
test -e ~/.iterm2_shell_integration.fish ; and source ~/.iterm2_shell_integration.fish ; or true

# asdf init
# set in set_fish_profile
# test -e $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.fish; and source $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.fish ; or true
