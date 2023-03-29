function set_fish_profile
    # UTILS
    function add_path
        if set -l index (contains -i $argv[1] $PATH)
            set --erase -U fish_user_paths[$index]
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

    # Global
    set -Ux EDITOR code

    # Fish
    set fish_greeting
    add_manpath "/usr/share/man"
    add_infopath "/usr/share/info"
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

    # ASDF
    # moved to conf.d/profile
    set -Ux ASDF_DIR $HOMEBREW_PREFIX/opt/asdf/libexec
    add_path ~/.asdf/shims

    # PIPX
    add_path ~/.local/bin

    # Pipenv
    set -Ux PIPENV_VENV_IN_PROJECT true
    set -Ux PIPENV_IGNORE_VIRTUALENVS true
    set -Ux PIPENV_SHELL_FANCY
    set -Ux PIPENV_INSTALL_TIMEOUT 1800  # 30mins
    set -Ux PIPENV_TIMEOUT 1800  # 30mins

    # Conda
    # NOTE: doesntt work here... but slow to put in profile start up...
    # eval /usr/local/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
    # # conda is horrible and injects its own environmpt prompt
    # # over the top of mine... roll that back...
    # if functions -q __fish_prompt_orig
    #     functions -e fish_prompt
    #     functions -c __fish_prompt_orig fish_prompt
    # end
    # if functions -q __fish_right_prompt_orig
    #     functions -e fish_right_prompt
    #     functions -c __fish_right_prompt_orig fish_right_prompt
    # end

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

    add_path ~/.bin
end
