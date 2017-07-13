source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh

PS1="\$(__git_ps1 '[%s]')🌀  "

shopt -s checkwinsize   # Update window size after every command
shopt -s histappend     # Append to the history file, don't overwrite it
shopt -s cmdhist        # Save multi-line commands as one command
shopt -s cdspell        # Correct spelling errors in arguments supplied to cd

bind "set show-all-if-ambiguous on"       # Display matches for ambiguous patterns at first tab press
bind "set completion-ignore-case on"      # Perform file completion in a case insensitive fashion
bind "set completion-map-case on"         # Treat hyphens and underscores as equivalent

export C_INCLUDE_PATH=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk/usr/include/:/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/6.0/include:/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include:/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk/System/Library/Frameworks
export EDITOR="nano"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history"
export HISTCONTROL="erasedups:ignoreboth"

set -o noclobber

alias urls="perl -pe 's|.*(https?:\/\/.*?)\".*|\1|'"
alias hostmaker="( head -n 10 /etc/hosts ; printf \"\\n\\n\\n\" ; (curl http://www.malwaredomainlist.com/hostslist/hosts.txt http://winhelp2002.mvps.org/hosts.txt http://someonewhocares.org/hosts/hosts http://hosts-file.net/download/hosts.txt \"http://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext\") | sed -e 's/127.0.0.1/0.0.0.0/' -e 's/ \+/ /' -e 's/#.*$//' | awk '{gsub(/\t+/,\" \");print}' | grep "0.0.0.0" | grep -v \"thepiratebay.\" | uniq | sort -u ) > ~/.hosts; sudo cp ~/.hosts /etc/hosts; rm ~/.hosts"
alias wback='wget -np -e robots=off --mirror --domains=staticweb.archive.org,web.archive.org '
alias wg='wget --recursive --page-requisites --convert-links --adjust-extension --no-clobber --random-wait -e robots=off -U mozilla '
alias count="sort | uniq -c | sort"
alias chwat="stat -f \"%OLp\""
alias s="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias be="bundle exec"

alias wgmp3='wget -r --accept "*.mp3" -nd --level 2'
alias flac_to_mp3="find . -name \"*.flac\" -exec ffmpeg -i \"{}\" -acodec mp3 -b:a 320k \"{}.mp3\" \\;"
alias aif_to_mp3="find . -name \"*.aif\" -exec ffmpeg -i \"{}\" -acodec mp3 -b:a 320k \"{}.mp3\" \\;"
alias shn_to_mp3="find . -name \"*.shn\" -exec ffmpeg -i \"{}\" -acodec mp3 -b:a 320k \"{}.mp3\" \\;"
alias ogg_to_mp3="find . -name \"*.ogg\" -exec ffmpeg -i \"{}\" -acodec mp3 -b:a 320k \"{}.mp3\" \\;"
alias add_cover_art="eyeD3 --add-image cover.jpg:FRONT_COVER *.mp3"

mono_bundler()
{
  NAME=$(basename "$1");
  CC="gcc -lobjc -liconv -framework CoreFoundation" mkbundle -o ${NAME%.exe} --deps --static -z $1
}

dmg()
{
  NAME=$(basename "$1");
  hdiutil create -puppetstrings -fs HFS+ -srcfolder "$1" -volname "$1" "${NAME/\.app/}.dmg" | while read line; do printf "$line\r"; done
}

concat_mp3()
{
  TMPDIR=$(mktemp)
  IFS='|'
  ffmpeg -i "concat:$*" -c:a copy $TMPDIR.mp3
  mp3val -f $TMPDIR.mp3
  mv $TMPDIR.mp3 .
}

set_track_numbers()
{
  ls *.mp3 | sed 's/^\(\([0-9][0-9] \)\(.*\).mp3\)$/eyeD3 -n \2 -t "\3" "\1"/' | sh
}

rhyme()
{
  curl -s "http://rhymebrain.com/talk?function=getRhymes&word=$1" | jq -r '.[] | select(.score == 300) | .word' | sort | column
}

cep()
{
  curl -s "http://viacep.com.br/ws/$(echo $1 | tr -dc '0-9')/json/" | jq -r '.logradouro, .bairro, .localidade, .uf'
}

cleanup_mac()
{
  rm -r ~/Library/Caches/*
  rm -r ~/Library/Logs/*
  rm -r ~/Library/Safari/LocalStorage/http*
  rm -r ~/Library/Safari/Databases/___IndexedDB/http*
  rm -r ~/Library/Safari/Databases/http*
  rm -r ~/Library/Safari/History*
  rm -r ~/Library/Application\ Support/Sublime\ Text\ 3/Cache/
  rm -r ~/Music/iTunes/Album\ Artwork/Cache/
  rm -r ~/Library/Containers/com.apple.siri.media-indexer/
  rm -r ~/Library/Application\ Support/Sublime\ Text\ 3/Cache/
  rm -r ~/Library/Application\ Support/Sublime\ Text\ 3/Index/
  rm -r ~/Library/Google
  rm -r ~/Library/Application\ Support/Google
  rm ~/Library/Cookies/com.apple.Safari.cookies
  rm ~/Library/Cookies/Cookies.binarycookies
  find ~/Library/Containers/ -name 'Caches' | xargs rm -r
  find ~/Library/Containers/ -name 'Logs' | xargs rm -r
  find ~/ -name .DS_Store -delete
}

(find ~/ -name .DS_Store -delete &)

eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/bin:$PATH"

