function sshvnc --description 'Opens host in vnc viewer via ssh tunnel'
    ssh -f -o ExitOnForwardFailure=yes -L 5901:localhost:5900 $argv sleep 10
    open vnc://localhost:5901
end
