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
        }
    ]
}'
    echo $launch > .vscode/launch.json

    set --local settings \
'{
    "python.pythonPath": "'(pipenv --py)'",
    "python.envFile": "${workspaceFolder}/.env"
}'
    echo $settings > .vscode/settings.json

    touch main.py

    echo "PYTHONPATH=." > .env

    gitignore macos windows linux python
    echo ".vscode" >> .gitignore

    git init
    git add .
    git commit -m "init"

    code $dir main.py

    cd -
end
