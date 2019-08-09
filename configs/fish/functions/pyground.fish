function pyground
    set --local dir (mktemp -d)

    cd $dir

    set --local --export PIPENV_VENV_IN_PROJECT 1
    set --local --export PIPENV_IGNORE_VIRTUALENVS 1
    pipenv --bare install --skip-lock $argv
    pipenv --bare install --dev --pre black flake8 flake8-bugbear

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
            "console": "integratedTerminal",
            "envFile": "${workspaceFolder}/.env"
        }
    ]
}'
    echo $launch > .vscode/launch.json

    set --local settings \
'{
    "python.pythonPath": "'(pipenv --py)'"
}'
    echo $settings > .vscode/settings.json

    touch main.py

    echo "PYTHONPATH="$dir > .env

    gitignore macos windows linux python
    echo ".vscode" >> .gitignore

    git init
    git add .
    git commit -m "init"

    code $dir main.py

    cd -
end
