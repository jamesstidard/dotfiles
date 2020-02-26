function clear_cache
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
    echo cache flushed
end
