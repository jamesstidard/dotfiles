function run --description 'Activates any found environments and calls command'
    set --function CMD ""

    # Pipenv
    if type -q pipenv; and pipenv --py &> /dev/null
        set --append CMD pipenv run
    end

    # Poetry
    if type -q poetry; and poetry env info --path &> /dev/null
        set --append CMD poetry run
    end

    # 1Password
    if type -q op
        set --append CMD op run --
    end

    set --append CMD $argv

    eval $CMD
end
