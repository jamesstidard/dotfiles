function pyground
    set --local dir (mktemp -d)

    cd $dir

    pipenv --bare install --skip-lock

    touch main.py
    code $dir main.py

    pipenv install $argv --pre black flake8 flake8-bugbear

    cd -
end
