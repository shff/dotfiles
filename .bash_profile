source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh

PS1="\$(__git_ps1 '[%s]')🦊 "

shopt -s checkwinsize   # Update window size after every command
shopt -s histappend     # Append to the history file, don't overwrite it
shopt -s cmdhist        # Save multi-line commands as one command
shopt -s cdspell        # Correct spelling errors in arguments supplied to cd

bind "set show-all-if-ambiguous on"       # Display matches for ambiguous patterns at first tab press
bind "set completion-ignore-case on"      # Perform file completion in a case insensitive fashion
bind "set completion-map-case on"         # Treat hyphens and underscores as equivalent
bind '"\e[A": history-search-backward'    # Prefix history search up
bind '"\e[B": history-search-forward'     # Prefix history search down

export EDITOR="nano"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history"
export HISTCONTROL="erasedups:ignoreboth"

set -o noclobber

alias urls="perl -pe 's|.*(https?:\/\/.*?)\".*|\1|'"
alias hostmaker="( head -n 10 /etc/hosts ; printf \"\\n\\n\\n\" ; (curl http://www.malwaredomainlist.com/hostslist/hosts.txt http://winhelp2002.mvps.org/hosts.txt http://someonewhocares.org/hosts/hosts http://hosts-file.net/download/hosts.txt \"http://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext\") | sed -e 's/127.0.0.1/0.0.0.0/' -e 's/ \+/ /' -e 's/#.*$//' | awk '{gsub(/\t+/,\" \");print}' | grep "0.0.0.0" | grep -v \"thepiratebay.\" | uniq | sort -u ) > ~/.hosts; sudo cp ~/.hosts /etc/hosts; rm ~/.hosts"
alias wback='wget -np -e robots=off --mirror --domains=staticweb.archive.org,web.archive.org '
alias wg='wget --recursive --page-requisites --convert-links --adjust-extension --no-clobber --random-wait -e robots=off -U mozilla '
alias wgmp3='wget -r --accept "*.mp3" -nd --level 2'
alias flac_to_mp3="find . -name \"*.flac\" -exec ffmpeg -i \"{}\" -acodec mp3 -b:a 320k \"{}.mp3\" \\;"
alias wma_to_mp3="find . -name \"*.wma\" -exec ffmpeg -i \"{}\" -acodec mp3 -b:a 320k \"{}.mp3\" \\;"
alias flac_to_wav="find . -name \"*.flac\" -exec ffmpeg -i \"{}\" \"{}.wav\" \\;"
alias aif_to_mp3="find . -name \"*.aif\" -exec ffmpeg -i \"{}\" -acodec mp3 -b:a 320k \"{}.mp3\" \\;"
alias shn_to_mp3="find . -name \"*.shn\" -exec ffmpeg -i \"{}\" -acodec mp3 -b:a 320k \"{}.mp3\" \\;"
alias ogg_to_mp3="find . -name \"*.ogg\" -exec ffmpeg -i \"{}\" -acodec mp3 -b:a 320k \"{}.mp3\" \\;"
alias add_cover_art="eyeD3 --add-image cover.jpg:FRONT_COVER *.mp3"
alias count="sort | uniq -c | sort"
alias chwat="stat -f \"%OLp\""
alias s="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias be='env $(cat .env | xargs) bundle exec'
alias r='env $(cat .env | xargs) bin/rails'
alias e='env $(cat .env | xargs) '
alias l='ls -lah'
alias ya='youtube-dl -x --audio-format wav '
alias sort-by-length="awk '{ print length, $0 }' | sort -n -s --reverse | cut -d' ' -f2-"
alias specs="be rspec \$(git diff --name-only master.. spec/ | grep _spec)"
alias remigrate="git diff --name-only master.. db/migrate | tail -r | cut -d'/' -f3- | cut -d'_' -f1 | xargs -n1 -I {} env \$(cat .env | xargs) bin/rails db:migrate:down VERSION={} ;  env \$(cat .env | xargs) bin/rails db:migrate"

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

merge_audio()
{
  TMP_FILE=$(mktemp)
  IFS='|'
  ffmpeg -i "concat:$*" -c:a copy $TMP_FILE.mp3
  mp3val -f $TMP_FILE.mp3
  mv $TMP_FILE.mp3 .
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

rebase()
{
  git checkout $1
  git pull --rebase origin master
  git rebase --abort
  git push -f
  git checkout -
}

cleanup()
{
  echo 'Cleaning up...'

  echo ' - iOS Device Backups...'
  rm -rf ~/Library/Application\ Support/MobileSync/Backup/*

  echo ' - XCode Derived Data and Archives...'
  rm -rf ~/Library/Developer/Xcode/DerivedData/*
  rm -rf ~/Library/Developer/Xcode/Archives/*

  echo ' - Homebrew Cache...'
  #brew cleanup -s
  rm -rf /Library/Caches/Homebrew/*
  rm -rf $(brew --cache)

  echo ' - Old versions of gems'
  gem cleanup

  echo ' - Yarn cache'
  yarn cache clean

  echo ' - Browser data...'
  rm -rf ~/Library/Safari/LocalStorage/http*
  rm -rf ~/Library/Safari/Databases/___IndexedDB/http*
  rm -rf ~/Library/Safari/Databases/http*
  # rm -rf ~/Library/Safari/History*
  rm -rf ~/Library/Google
  rm -rf ~/Library/Application\ Support/Firefox
  rm -rf ~/Library/Application\ Support/Google
  # rm -rf ~/Library/Cookies/com.apple.Safari.cookies
  # rm -rf ~/Library/Cookies/Cookies.binarycookies

  echo ' - Local caches...'
  rm -rf ~/Library/Caches/*
  rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Cache/
  rm -rf ~/Music/iTunes/Album\ Artwork/Cache/
  rm -rf ~/Library/Containers/com.apple.siri.media-indexer/
  rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Cache/
  rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Index/
  find ~/Library/Containers/ -name 'Caches' | xargs rm -rf

  echo ' - Local logs...'
  rm -rf ~/Library/Containers/com.apple.mail/Data/Library/Logs/Mail/*
  rm -rf ~/Library/Logs/CoreSimulator/*
  rm -rf ~/Library/Logs/*
  rm -rf ~/Library/Application\ Support/Firefox/Crash\ Reports/*
  find ~/Library/Containers/ -name 'Logs' | xargs rm -rf

  echo ' - Application specific temporary files...'
  rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Backup
  rm -rf ~/Library/Application\ Support/Pixelmator\ Pro/History
  rm -rf ~/Library/Application\ Support/CrashReporter

  echo ' - System Log Files...'
  sudo rm -rf /private/var/log/asl/*.asl
  sudo rm -rf /Library/Logs/DiagnosticReports/*
  sudo rm -rf /Library/Logs/Adobe/*

  echo ' - System Caches'
  sudo rm -rf /Library/Caches/*
  sudo rm -rf /System/Library/Caches/*
  sudo rm -rf /Users/Shared/*

  echo ' - Adobe Cache Files...'
  sudo rm -rf ~/Library/Application\ Support/Adobe/Common/Media\ Cache\ Files/*

  echo ' - Empty folders...'
  sudo find ~/ -name .DS_Store -delete
  sudo find ~/Library -depth -empty -delete

  echo ' - Cleaning trash on all mounted volumes and the main HDD...'
  sudo rm -rf ~/.Trash/*

  echo ' - DNS Cache'
  sudo killall -HUP mDNSResponder
  sudo dscacheutil -flushcache

  echo ' - Running periodic scripts'
  sudo periodic daily weekly monthly

  echo ' - Purge inactive memory...'
  sudo purge
}

restore_db() {
  database=$1 psql <<EOF
SELECT PG_TERMINATE_BACKEND(pid) FROM pg_stat_activity WHERE pid <> PG_BACKEND_PID() AND datname = '$database';
DROP DATABASE IF EXISTS "$database";
CREATE DATABASE "$database";
EOF

  pg_restore -d $1 --no-acl --no-owner $2
}

getsub() {
  curl -H "User-Agent: SubDB/1.0 (One-line Bash script)" "http://api.thesubdb.com/?action=download&language=en%2Cpt&hash=$((head -c 65536 "$1"; tail -c 65536 "$1") | md5)" > "${1%%.*}.srt"
}

(find ~/ -name .DS_Store -delete &>/dev/null &)

eval "$(rbenv init -)"

export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export GPG_TTY=$(tty)
export PKG_CONFIG_PATH=/usr/local/Cellar/openssl@1.1/1.1.0h/lib/pkgconfig

. $(brew --prefix)/etc/bash_completion
