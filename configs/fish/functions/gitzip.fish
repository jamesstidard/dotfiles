function gitzip --description 'Zips a git version controlled folder, respecting gitignore.'
    if not git_is_repo
        printf 'Not in git controlled directory'
        return
    end

    git ls-files | xargs zip $argv
end
