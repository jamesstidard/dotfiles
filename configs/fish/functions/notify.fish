function notify
    argparse --max-args=2 's/silent' -- $argv
    or return

    set --local title
    set --local message
    if set -q argv[1]; and set -q argv[2]
        set title $argv[1]
        set message $argv[2]
    else if set -q argv[1]
        set title "Notify"
        set message $argv[1]
    else
        set title "Notify"
        set message "complete"
    end

    set --local sound ''
    if not set -q _flag_silent
        set sound ' sound name "Bell"'
    end

    osascript -e 'display notification "'$message'" with title "'$title'"'$sound
end
