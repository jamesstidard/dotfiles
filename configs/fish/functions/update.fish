
function update
    function echo_header
        set_color blue --underline
        echo $argv
        set_color normal
    end

    if test -d ~/.dotfiles
        echo_header "dotfiles"
        git -C ~/.dotfiles pull --rebase --autostash
    end

    if type -q fisher
        echo_header "Fisherman"
        fisher update
    end

    if type -q mise
        echo_header "Mise"
        if type -q brew
            mise up
        else
            mise up
        end
    end

    if type -q brew
        echo_header "Brew"
        brew update
        brew upgrade
    end

    if type -q pipx
        echo_header "pipx"
        pipx upgrade-all --include-injected
        if test $status -eq 1
            pipx reinstall-all
        end

    end

    echo_header "Purging Orphaned Venvs"
    for venv in ~/.local/share/virtualenvs/*/.project
        read directory < $venv
        if not test -e "$directory/Pipfile"
            set orphan (dirname $venv)
            echo "Purging orphaned venv: $orphan"
            rm -rf $orphan
        end
    end
    echo "Purging complete"

    if type -q mas
        echo_header "App Store"
        mas upgrade
    end

    if type -q softwareupdate
        echo_header "macOS"
        softwareupdate --install --all
    end

    if type -q apt-get
        echo_header "Apt"
        sudo apt-get update -y -qq
        sudo apt-get autoremove -y -qq
        sudo apt-get upgrade -y -qq
    end

    echo_header "Fish Config"
    set_fish_profile
    fish_update_completions
end
