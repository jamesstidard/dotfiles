# mostly all set globally via ~fish/functions/set_fish_profile for quick loads

# 1PASSWORD
set -gx SSH_AUTH_SOCK ~/.1password/agent.sock

# iTerm shell integration
test -e ~/.iterm2_shell_integration.fish ; and source ~/.iterm2_shell_integration.fish ; or true

# asdf init
# set in set_fish_profile
# test -e $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.fish; and source $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.fish ; or true

abbr --erase (abbr --list)

# FISH
function last_history_item
    echo $history[1]
end
abbr --add !! --position anywhere --function last_history_item
abbr --add up update
abbr --add kp killport
abbr --add pg pyground
abbr --add hm cd ~
abbr --add dt cd ~/Desktop
abbr --add dv cd ~/Development
abbr --add js cd ~/Development/James-Stidard
abbr --add wv cd ~/Development/Wave-Venture
abbr --add dl cd ~/Downloads

# BREW
abbr --add brwe brew
abbr --add bs brew search
abbr --add bi brew install
abbr --add bu brew uninstall
abbr --add brm brew rmtree
abbr --add bic brew install --cask
abbr --add buc brew uninstall --cask

# # ASDF
# abbr --add ai asdf install
# abbr --add au asdf uninstall
# abbr --add al asdf list
# abbr --add as asdf current

# MISE
abbr --add mi mise install
abbr --add mu mise uninstall
abbr --add ml mise list
abbr --add ms mise current
abbr --add mx mise exec --

# PIPX
abbr --add px pipx
abbr --add pxl pipx list --include-injected
abbr --add pxr pipx run
abbr --add pxi pipx install
abbr --add pxu pipx uninstall

# PIPENV
abbr --add pe pipenv
abbr --add pei pipenv install
abbr --add peu pipenv update
abbr --add perm pipenv uninstall
abbr --add pel pipenv lock
abbr --add per pipenv run
abbr --add perp pipenv run python
abbr --add pes pipenv sync --dev
abbr --add peo pipenv open

# POETRY
abbr --add po poetry
abbr --add poi poetry install
abbr --add poa poetry add
abbr --add peu poetry update
abbr --add porm poetry remove
abbr --add pol poetry lock
abbr --add por poetry run
abbr --add pos poetry shell
abbr --add porp poetry run python

# RUST CARGO
abbr --add cg cargo
abbr --add cn cargo new
abbr --add ci cargo init
abbr --add cb cargo build
abbr --add cr cargo run

# GIT
abbr --add gcl git clone
abbr --add gs git status
abbr --add gx git pull
abbr --add gp git push
abbr --add ga git add
abbr --add gc git commit
abbr --add gca git commit --all --message
abbr --add gf git fetch
abbr --add gco git checkout
abbr --add gl git log
abbr --add gb git browse --
abbr --add gu git reset --soft HEAD~1
abbr --add gr git reset --hard HEAD
abbr --add gsm git submodule
abbr --add gsmi git submodule init
abbr --add gsms git submodule sync
abbr --add gsmu git submodule update --recursive
abbr --add gsmc "git submodule foreach --recursive git clean -xfd; and git submodule foreach --recursive git reset --hard; and git submodule update --init --recursive"

# iTerm
abbr --add iterm open -a iTerm
abbr --add term open -a iTerm

# Marta
abbr --add mta marta

# Xcode
abbr --add xc xcode

# VSCode
abbr --add c code
abbr --add asp "code --add (pipenv --venv)/lib/python*/site-packages --add (pipenv --venv)/src"

# Sublime Merge
abbr --add sm smerge
abbr --add smt smerge mergetool

# Docker
abbr --add dnl "docker node ls -q | xargs docker node inspect -f '{{ .ID }} [{{ .Description.Hostname }}] ({{ .Status.State }}): {{ range \$k, \$v := .Spec.Labels }}{{ \$k }}={{ \$v }} {{end}}'"
abbr --add dc docker-compose

# K8
abbr --add k8 kubectl

# Keybase
abbr --add kb keybase

# Miscellaneous
abbr --add ipscan 'nmap -sP "10.1.62.*"'
abbr --add wol wakeonlan
abbr --add md "pbpaste | pandoc --highlight-style kate --standalone --metadata pagetitle=\"...\" --from gfm --to html | textutil -stdin -format html -convert rtf -stdout | pbcopy"
