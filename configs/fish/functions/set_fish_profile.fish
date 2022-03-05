function set_fish_profile
    # UTILS
    function add_path
        if set -l index (contains -i $argv[1] $PATH)
            set --erase --universal fish_user_paths[$index]
        end
        set -U fish_user_paths $argv[1] $fish_user_paths
    end

    function add_manpath
        set -l OLDPATH $MANPATH
        set --erase MANPATH
        if set -l INDEX (contains -i $argv[1] $OLDPATH)
            set --erase OLDPATH[$INDEX]
        end
        set -Ux MANPATH $argv[1] $OLDPATH
    end

    function add_infopath
        set -l OLDPATH $INFOPATH
        set --erase INFOPATH
        if set -l INDEX (contains -i $argv[1] $OLDPATH)
            set --erase OLDPATH[$INDEX]
        end
        set -Ux INFOPATH $argv[1] $OLDPATH
    end

    function add_fish_function_path
        set -l OLDPATH $fish_function_path
        set --erase fish_function_path
        if set -l INDEX (contains -i $argv[1] $OLDPATH)
            set --erase OLDPATH[$INDEX]
        end
        set -U fish_function_path $argv[1] $OLDPATH
    end

    function add_fish_complete_path
        set -l OLDPATH $fish_complete_path
        set --erase fish_complete_path
        if set -l INDEX (contains -i $argv[1] $OLDPATH)
            set --erase OLDPATH[$INDEX]
        end
        set -U fish_complete_path $argv[1] $OLDPATH
    end

    # CLEAR ABBRIVIATIONS
    for a in (abbr --list)
        abbr --erase $a
    end

    # Global
    set -Ux EDITOR code

    # Fish
    set fish_greeting
    add_manpath "/usr/share/man"
    add_infopath "/usr/share/info"
    abbr -a up update
    abbr -a kp killport
    abbr -a pg pyground
    abbr -a hm cd ~
    abbr -a dt cd ~/Desktop
    abbr -a dv cd ~/Development
    abbr -a js cd ~/Development/James-Stidard
    abbr -a wv cd ~/Development/Wave-Venture
    abbr -a dl cd ~/Downloads
    fish_vi_key_bindings
    set -U fish_cursor_insert line
    set -U fish_cursor_default block

    # FISHER
    set -Ux fisher_path ~/.config/fish/fisher

    add_fish_function_path $fisher_path/functions
    add_fish_complete_path $fisher_path/completions

    for file in $fisher_path/conf.d/*.fish
        builtin source $file 2> /dev/null
    end

    if not functions -q fisher
        set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
        curl https://git.io/fisher --create-dirs -sLo $fisher_path/functions/fisher.fish
        fish -c fisher
    end

    # HOMEBREW
    if test (uname) = "Darwin"
        set -Ux HOMEBREW_PREFIX "/usr/local"
    else if test (uname) = "Linux"
        set -Ux HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
    else
        echo "unknown brew path"
        exit 1
    end

    set -Ux HOMEBREW_CELLAR $HOMEBREW_PREFIX/Cellar
    set -Ux HOMEBREW_REPOSITORY $HOMEBREW_PREFIX/Homebrew
    add_path $HOMEBREW_PREFIX/sbin
    add_path $HOMEBREW_PREFIX/bin
    add_manpath "$HOMEBREW_PREFIX/share/man"
    add_infopath "$HOMEBREW_PREFIX/share/info"
    abbr -a brwe brew
    abbr -a bs brew search
    abbr -a bi brew install
    abbr -a bu brew rmtree
    abbr -a bci brew cask install
    abbr -a bcu brew cask uninstall

    # ASDF
    # moved to conf.d/profile
    # set -Ux ASDF_DIR $HOMEBREW_PREFIX/opt/asdf/libexec/lib
    # add_path ~/.asdf/shims
    abbr -a ai asdf install
    abbr -a au asdf uninstall
    abbr -a al asdf list
    abbr -a as asdf current

    # PIPX
    add_path ~/.local/bin
    abbr -a px pipx
    abbr -a pxl pipx list --include-injected
    abbr -a pxr pipx run
    abbr -a pxi pipx install
    abbr -a pxu pipx uninstall

    # Pipenv
    set -Ux PIPENV_VENV_IN_PROJECT true
    set -Ux PIPENV_IGNORE_VIRTUALENVS true
    set -Ux PIPENV_SHELL_FANCY
    set -Ux PIPENV_INSTALL_TIMEOUT 1800  # 30mins
    set -Ux PIPENV_TIMEOUT 1800  # 30mins
    abbr -a pe pipenv
    abbr -a pei pipenv install
    abbr -a peu pipenv update
    abbr -a perm pipenv uninstall
    abbr -a pel pipenv lock
    abbr -a per pipenv run
    abbr -a perp pipenv run python
    abbr -a pes pipenv sync --dev
    abbr -a peo pipenv open

    # COMPILER FLAGS
    set -Ux CPPFLAGS ""
    set -Ux LDFLAGS ""
    set -Ux PKG_CONFIG_PATH ""
    for lib in sqlite libpng libjpg zlib hdf5
        set --append CPPFLAGS "-I"(brew --prefix $lib)"/include"
        set --append LDFLAGS "-L"(brew --prefix $lib)"/lib"
        set --append PKG_CONFIG_PATH (brew --prefix $lib)"/lib/pkgconfig"
    end
    set -Ux OPENBLAS (brew --prefix openblas)

    # GIT
    abbr -a gcl git clone
    abbr -a gs git status
    abbr -a gx git pull
    abbr -a gp git push
    abbr -a ga git add
    abbr -a gc git commit
    abbr -a gca git commit --all --message
    abbr -a gf git fetch
    abbr -a gco git checkout
    abbr -a gl git log
    abbr -a gu git reset --soft HEAD~1
    abbr -a gr git reset --hard HEAD
    abbr -a gsm git submodule
    abbr -a gsmi git submodule init
    abbr -a gsms git submodule sync
    abbr -a gsmu git submodule update --recursive

    # iTerm
    abbr -a iterm open -a iTerm
    abbr -a term open -a iTerm

    # Marta
    abbr -a mta marta

    # Xcode
    abbr -a xc xcode

    # VSCode
    abbr -a c code
    abbr -a asp "code --add (pipenv --venv)/lib/python*/site-packages --add (pipenv --venv)/src"

    # Sublime Merge
    abbr -a sm smerge
    abbr -a smd smerge mergetool

    # Docker
    abbr -a dnl "docker node ls -q | xargs docker node inspect -f '{{ .ID }} [{{ .Description.Hostname }}] ({{ .Status.State }}): {{ range \$k, \$v := .Spec.Labels }}{{ \$k }}={{ \$v }} {{end}}'"
    abbr -a dc docker-compose

    # Keybase
    abbr -a kb keybase

    # Miscellaneous
    abbr -a ipscan 'nmap -sP "10.1.62.*"'
    abbr -a md "pbpaste | pandoc --highlight-style kate --standalone --metadata pagetitle=\"...\" --from gfm --to html | textutil -stdin -format html -convert rtf -stdout | pbcopy"
    add_path ~/.bin
end
