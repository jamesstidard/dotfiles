function fish_prompt
	if not set -q VIRTUAL_ENV_DISABLE_PROMPT
        set -g VIRTUAL_ENV_DISABLE_PROMPT true
    end
    set_color yellow
    printf '%s' (whoami)
    set_color normal
    printf ' at '

    set_color magenta
    echo -n (prompt_hostname)
    set_color normal
    printf ' in '

    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal

    # Line 2
    echo
    if test $VIRTUAL_ENV
        printf "(%s) " (set_color blue)(basename $VIRTUAL_ENV)(set_color normal)
    end

    switch $fish_bind_mode
        case default
            set_color --dim red
            printf 'n '
        case insert
            set_color --dim white
            printf '$ '
        case replace_one
            set_color --dim green
            printf 'r '
        case visual
            set_color --dim brmagenta
            printf 'v '
        case '*'
            set_color --dim red
            printf '? '
    end

    set_color normal
end
