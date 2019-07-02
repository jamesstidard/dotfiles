
function update
    function echo_header
        set_color blue --underline
        echo $argv
        set_color normal
    end

    if type -q fisher
        echo_header "Fisherman"
        fisher self-update
    end

    if type -q brew
        echo_header "Brew"
        brew update
        brew upgrade
        brew cask upgrade
    end

    if type -q pipsi
        echo_header "Pipsi"

        set PACKAGES (pipsi list | grep 'Package ' | cut -d\" -f2)

        for PACKAGE in $PACKAGES
            eval $PIPSI_HOME"/"$PACKAGE"/bin/pip" install --upgrade pip > /dev/null

            pipsi upgrade $PACKAGE | \
                string replace --regex " in .+/\.local/share/virtualenvs/.+/lib/python[2-3].[0-9]/site-packages" "" | \
                string match --invert --regex '^.+(from .+)$'
        end
    end

    echo_header "Purging Orphaned Venvs"
    for venv in ~/.local/share/virtualenvs/*/.project
        read proj < $venv
        if not test -e $proj
            set orphan (dirname $venv)
            echo "Purging orphaned venv: $orphan"
            rm $orphan
        end
    end
    echo "Purging complete"

    if type -q mas
        echo_header "App Store"
        mas upgrade
    end

    if type -q softwareupdate
        echo_header "macOS"
        softwareupdate --instal --all
    end

    if type -q apt
        echo_header "Apt"
        sudo apt update -y -qq
        sudo apt autoremove -y -qq
        sudo apt upgrade -y -qq
    end

    echo_header "Fish Auto Complete"
    fish_update_completions
end
