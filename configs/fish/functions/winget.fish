function winget --description 'Makes winget available from WSL'
    cmd.exe /c "winget $argv"
end
