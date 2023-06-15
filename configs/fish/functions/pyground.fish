function pyground
    argparse --name=pyground 'd/directory=' -- $argv
    or return

    set --local dir

    if set -q _flag_directory
        eval set dir "$_flag_directory"
        mkdir -p $dir
    else
        set dir (mktemp -d -t pyground.XXXXXXX)
    end

    set -l dir_files (ls -A $dir)
    if test -n "$dir_files"
        echo "directory not empty! probably mistake"
        return
    end

    cd $dir

    set --local --export PIPENV_VENV_IN_PROJECT 1
    set --local --export PIPENV_IGNORE_VIRTUALENVS 1
    pipenv --bare install $argv

    mkdir .vscode

    set --local launch \
'{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Current File",
            "type": "python",
            "request": "launch",
            "program": "${file}",
            "console": "integratedTerminal"
        },
    ]
}'
    echo $launch > .vscode/launch.json

    set --local settings \
'{
    "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python",
    "python.envFile": "${workspaceFolder}/.env",
    //"python.analysis.typeCheckingMode": "strict",
    "terminal.integrated.cwd": "${workspaceFolder}",
    // "terminal.integrated.profiles.linux": {
    //     "fish": {
    //         "path": "/usr/local/bin/fish",
    //         "args": [
    //             "-l",
    //             "-c",
    //             "pipenv shell"
    //         ],
    //     }
    // },
    // "terminal.integrated.profiles.osx": {
    //     "fish": {
    //         "path": "/usr/local/bin/fish",
    //         "args": [
    //             "-l",
    //             "-c",
    //             "pipenv shell"
    //         ],
    //     }
    // },
    // "terminal.integrated.profiles.windows": {
    //     "PowerShell -NoProfile": {
    //         "source": "PowerShell",
    //         "args": [
    //             "-NoExit",
    //             "-Command",
    //             "pipenv shell"
    //         ]
    //     }
    // },
}'
    echo $settings > .vscode/settings.json

    touch main.py

    set --local pyproject \
'
[tool.isort]
profile = "black"
length_sort = true
include_trailing_comma = true
known_first_party = ["my_module1", "my_module2"]
'
    echo $pyproject > pyproject.toml

    set --local vars \
'PYTHONPATH=.'
    echo $vars > .env

    gitignore macos windows linux python
    read -z basegitignore < .gitignore
    set --local extragitignore \
'.vscode
.venv
.idea'
    echo $extragitignore > .gitignore
    echo $basegitignore >> .gitignore

    git init
    git add .
    git commit -m "init"

    code $dir main.py

    cd -
end
