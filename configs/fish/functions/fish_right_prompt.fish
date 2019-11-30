function fish_right_prompt
    # Don't run in itelij terminal
    if set -q JEDITERM_SOURCE
        return
    end

    # Dont run if not installed
    if not functions -q git_is_repo
        return
    end

    # Only run in git versioned directories
    if git_is_repo
        if test (git_untracked_files) -gt 0
            set_color brwhite
            printf '•'
        else
            set_color brblack
            printf '◦'
        end

        if git_is_dirty
            set_color brblue
            printf '•'
        else
            set_color brblack
            printf '◦'
        end

        if git_is_staged
            set_color brgreen
            printf '◦'
        else
            set_color brblack
            printf '◦'
        end

        if test (count (git_ahead)) -gt 0
            switch (git_ahead)
            case +
                set_color brgreen
                printf ' •'
            case ±
                set_color bryellow
                printf ' •'
            case -
                set_color brblue
                printf ' •'
            case '*'
                set_color brblack
                printf ' ◦'
            end
        end

        set_color normal
        printf ' %s' (git_branch_name)
    end
end
