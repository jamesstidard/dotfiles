# mostly all set globally via ~fish/functions/set_fish_profile for quick loads

# iTerm shell integration
test -e ~/.iterm2_shell_integration.fish ; and source ~/.iterm2_shell_integration.fish ; or true

# asdf init
test -e /usr/local/opt/asdf/libexec/asdf.fish; and source /usr/local/opt/asdf/libexec/asdf.fish ; or true
test -e /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.fish ; and source /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.fish ; or true

# set 1password ssh agent
set -gx SSH_AUTH_SOCK ~/.1password/agent.sock
