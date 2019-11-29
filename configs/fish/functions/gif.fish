function gif --description 'Converts .mov to .gif'
    ffmpeg -i $argv -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $argv.gif
end
