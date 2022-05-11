# mostly all set globally via ~fish/functions/set_fish_profile for quick loads

# iTerm shell integration
test -e ~/.iterm2_shell_integration.fish ; and source ~/.iterm2_shell_integration.fish ; or true

# asdf init
source /usr/local/opt/asdf/libexec/asdf.fish

# set 1password ssh agent
set -gx SSH_AUTH_SOCK ~/.1password/agent.sock
