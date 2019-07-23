function gitzip --description 'Zips a git version controlled folder, respecting gitignore.'
    if not functions -q git_is_repo
        printf 'Not in git controlled directory'
        return
    end

    git ls-files | xargs zip $argv
end
