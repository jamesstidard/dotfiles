function sshvnc --description 'Opens host in vnc viewer via ssh tunnel'
    # Ref: https://gist.github.com/scy/6781836
    ssh -f -o ExitOnForwardFailure=yes -L 5901:localhost:5900 $argv sleep 10
    open vnc://localhost:5901
end
