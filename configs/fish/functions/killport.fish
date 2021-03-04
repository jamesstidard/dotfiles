function killport
    kill (lsof -t -i:$argv[1] -sTCP:LISTEN)
end
