function browse
    set target $argv[1]

    if test -d $target; and test -e $target/index.html
        # folder with a index .html in it
        set target (realpath $target)
        open file://$target/index.html
    else if test -d $target
        # open folder in browser
        set target (realpath $target)
        open file://$target
    else if test -e $target
        # open file in browser
        set target (realpath $target)
        open file://$target
    else
        open https://$target
    end
end
