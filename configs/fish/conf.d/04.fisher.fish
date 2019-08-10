
if status is-login
    # Install fisher package manager if not installed
    # and set install path outside of user paths
    set -g fisher_path ~/.config/fish/fisher

    set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
    set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]

    for file in $fisher_path/conf.d/*.fish
        builtin source $file 2> /dev/null
    end

    if not functions -q fisher
        curl https://git.io/fisher --create-dirs -sLo $fisher_path/functions/fisher.fish
        fish -c fisher
    end
end
