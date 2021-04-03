function pyground
    set --local dir (mktemp -d -t pyground.XXXXXXX)

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
    "python.pythonPath": "${workspaceFolder}/.venv/bin/python",
    "python.envFile": "${workspaceFolder}/.env",
    "terminal.integrated.shellArgs.linux": [
        "-l", "-c", "pipenv shell"
    ],
    "terminal.integrated.shellArgs.osx": [
        "-l", "-c", "pipenv shell"
    ],
    "terminal.integrated.shellArgs.windows": [
        "-NoExit", "-Command", "pipenv shell"
    ],
}'
    echo $settings > .vscode/settings.json

    touch main.py

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
