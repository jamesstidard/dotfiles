function xcode
    if count $argv > /dev/null
        set dir $argv
    else
        set dir $PWD
    end

    for file in {$dir}/*.xcworkspace
        open -a Xcode $file
        return
    end
    for file in {$dir}/*.xcodeproj
        open -a Xcode $file
        return
    end
    if test -e $argv
        open -a Xcode $argv
        return
    end

    echo 'No *.xcworkspace or *.xcodeproj found in directory'
end
