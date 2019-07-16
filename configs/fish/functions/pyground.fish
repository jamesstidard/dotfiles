function pyground
    set dir (mktemp -d)

    cd $dir

    pipenv install --pre black flake8 flake8-bugbear $argv --skip-lock

    touch main.py
    code $dir main.py
end
