function pyground
    set dir (mktemp -d)

    cd $dir

    pipenv install --skip-lock

    touch main.py
    code $dir main.py

    pipenv install $argv --pre black flake8 flake8-bugbear
end
