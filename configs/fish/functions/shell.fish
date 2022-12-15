function shell --description 'Activates any found environments'
    # Poetry / Pipenv
    if type -q poetry; and poetry env info --path &> /dev/null
        poetry shell
    else if type -q pipenv; and pipenv --py &> /dev/null
        pipenv shell
    end
end
