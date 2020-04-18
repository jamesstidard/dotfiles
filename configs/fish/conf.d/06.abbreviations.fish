if status is-login
    abbr -a up update

    abbr -a gcl git clone
    abbr -a gs git status
    abbr -a gx git pull
    abbr -a gp git push
    abbr -a ga git add
    abbr -a gc git commit
    abbr -a gca git commit -am
    abbr -a gf git fetch
    abbr -a gco git checkout
    abbr -a gl git log
    abbr -a gsm git submodule
    abbr -a gsmi git submodule init
    abbr -a gsms git submodule sync
    abbr -a gsmu git submodule update --recursive

    abbr -a mta marta

    abbr -a c code
    abbr -a xc xcode

    abbr -a sm smerge
    abbr -a smd smerge mergetool

    abbr -a dc docker-compose

    abbr -a hm cd ~
    abbr -a dt cd ~/Desktop
    abbr -a dv cd ~/Development
    abbr -a js cd ~/Development/James-Stidard
    abbr -a wv cd ~/Development/Wave-Venture
    abbr -a dl cd ~/Downloads

    abbr -a pg pyground

    abbr -a pe pipenv
    abbr -a pei pipenv install
    abbr -a peu pipenv update
    abbr -a perm pipenv uninstall
    abbr -a pel pipenv lock
    abbr -a per pipenv run
    abbr -a perp pipenv run python
    abbr -a pes pipenv sync --dev
    abbr -a peo pipenv open

    abbr -a bs brew search
    abbr -a bi brew install
    abbr -a bu brew rmtree
    abbr -a bci brew cask install
    abbr -a bcu brew cask uninstall

    abbr -a ai asdf install
    abbr -a au asdf uninstall
    abbr -a al asdf list
    abbr -a as asdf current

    abbr -a md "pbpaste | pandoc --highlight-style kate --standalone --metadata pagetitle=\"...\" --from gfm --to html | textutil -stdin -format html -convert rtf -stdout | pbcopy"
end