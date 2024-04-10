function rsground
    argparse --name=rsground 'd/directory=' -- $argv
    or return

    set --local dir

    if set -q _flag_directory
        eval set dir "$_flag_directory"
        mkdir -p $dir
    else
        set dir (mktemp -d -t rsground.XXXXXXX)
    end

    set -l dir_files (ls -A $dir)
    if test -n "$dir_files"
        echo "directory not empty! probably mistake"
        return
    end

    cd $dir

    cargo init --name rsground

    if count $argv > /dev/null
        cargo add $argv
    end

    mkdir .vscode

    set --local launch \
'{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
    ]
}'
    echo $launch > .vscode/launch.json

    set --local settings \
'{
    "rust-analyzer.runnables.command": "mise exec -- cargo",
}'
    echo $settings > .vscode/settings.json

    set --local mise \
'[env]
HELLO = "WORLD"

[tools]
rust = "'(mise latest rust)'"
'
    echo $mise > mise.toml

    set --local mise \
'[env]
HELLO = "WORLD"
'
    echo $mise > mise.local.toml

    gitignore macos windows linux rust
    read -z basegitignore < .gitignore
    set --local extragitignore \
'.vscode
.idea
target/
mise.local.toml
mise.*.local.toml
'
    echo $extragitignore > .gitignore
    echo $basegitignore >> .gitignore

    git init
    git add .
    git commit -m "init"

    code $dir main.py

    cd -
end
