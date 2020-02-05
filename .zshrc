source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh

setopt PROMPT_SUBST
setopt +o nomatch

EMOJIS=🦊🐻🐯🦁🐨🐼🐰🐹🐱🐮
EMOJI=${EMOJIS:$(( RANDOM % ${#EMOJIS} )):1}
PS1="\$(__git_ps1 '[%s]')$EMOJI "

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
bindkey "^[[A" history-beginning-search-backward  # Prefix history search down
bindkey "^[[B" history-beginning-search-forward   # Prefix history search up

export EDITOR="nano"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history"
export HISTCONTROL="erasedups:ignoreboth"

set -o noclobber

git config --global user.name "Silvio Henrique Ferreira"
git config --global user.email "shferreira@me.com"
git config --global core.excludesfile '~/.gitignore'
git config --global --replace alias.l "log"
git config --global --replace alias.s "show"
git config --global --replace alias.ca 'commit --amend --no-edit'
git config --global --replace alias.prom 'pull --rebase origin master'
git config --global --replace alias.rir 'rebase -i --root'
git config --global --replace alias.ra 'rebase --abort'
git config --global --replace alias.rc 'rebase --continue'
git config --global --replace alias.c 'commit -am'
git config --global --replace alias.wip 'commit -am "[WIP]"'
git config --global format.pretty "format:%Cred%h%Creset %s %Cgreen(%cr) %C(yellow)<%ae>%Creset"
[ -x "$(command -v diff-so-fancy)" ] && git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

alias urls="perl -pe 's|.*(https?:\/\/.*?)\".*|\1|'"
alias hostmaker="( head -n 20 /etc/hosts ; printf \"\\n\\n\\n\" ; (curl https://www.malwaredomainlist.com/hostslist/hosts.txt http://winhelp2002.mvps.org/hosts.txt https://someonewhocares.org/hosts/zero/hosts https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts \"https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext\" https://raw.githubusercontent.com/shff/hosts/master/hosts) | sed -e 's/127.0.0.1/0.0.0.0/' -e 's/  / /' -e 's/ \+/ /' -e 's/#.*$//' | tr -d '\r' | awk '{gsub(/\t+/,\" \");print}' | grep "0.0.0.0" | grep -v \"thepiratebay.\" | sort -fu | uniq -i ) > ~/.hosts; sudo cp ~/.hosts /etc/hosts; rm ~/.hosts"
alias wback='wget -np -e robots=off --mirror --domains=staticweb.archive.org,web.archive.org '
alias wg='wget --recursive --page-requisites --convert-links --adjust-extension --no-clobber --random-wait -e robots=off -U mozilla '
alias wgmp3='wget -r --accept "*.mp3" -nd --level 2'
alias flac_to_mp3="find . -name \"*.flac\" -exec ffmpeg -i \"{}\" -acodec mp3 -b:a 320k \"{}.mp3\" \\;"
alias flac_to_alac="find . -name \"*.flac\" -exec ffmpeg -i \"{}\" -acodec alac -b:a 320k \"{}.m4a\" \\;"
alias wav_to_mp3="find . -name \"*.wav\" -exec ffmpeg -i \"{}\" -acodec mp3 -b:a 320k \"{}.mp3\" \\;"
alias wma_to_mp3="find . -name \"*.wma\" -exec ffmpeg -i \"{}\" -acodec mp3 -b:a 320k \"{}.mp3\" \\;"
alias flac_to_wav="find . -name \"*.flac\" -exec ffmpeg -i \"{}\" \"{}.wav\" \\;"
alias aif_to_mp3="find . -name \"*.aif\" -exec ffmpeg -i \"{}\" -acodec mp3 -b:a 320k \"{}.mp3\" \\;"
alias shn_to_mp3="find . -name \"*.shn\" -exec ffmpeg -i \"{}\" -acodec mp3 -b:a 320k \"{}.mp3\" \\;"
alias ogg_to_mp3="find . -name \"*.ogg\" -exec ffmpeg -i \"{}\" -acodec mp3 -b:a 320k \"{}.mp3\" \\;"
alias add_cover_art="eyeD3 --add-image cover.jpg:FRONT_COVER *.mp3"
alias chwat="stat -f \"%OLp\""
alias s="/Applications/Instalados/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias be='env $(cat .env | xargs) bundle exec'
alias r='env $(cat .env | xargs) bin/rails'
alias e='env $(cat .env | xargs) '
alias l='ls -lah'
alias f='find . -name'
alias ya='youtube-dl -x --audio-format wav '
alias ya3='youtube-dl -x --audio-format mp3 '
alias sort-by-length="awk '{ print length, $0 }' | sort -n -s --reverse | cut -d' ' -f2-"
alias specs="be rspec \$(git diff --name-only master.. spec/ | grep _spec)"
alias remigrate="git diff --name-only master.. db/migrate | tail -r | cut -d'/' -f3- | cut -d'_' -f1 | xargs -n1 -I {} env \$(cat .env | xargs) bin/rails db:migrate:down VERSION={} ;  env \$(cat .env | xargs) bin/rails db:migrate"

# Map Reduce
alias map='xargs -n1 -I $'
alias count="sort | uniq -c | sort"
filter() { while read it; do if $(eval $1); then echo $it; fi; done }     # Example: `ls | filter '[ "$l" = "Desktop" ]'`

# Git Aliases
alias ga='git add'
alias gaa='git add .'
alias gaaa='git add --all'
alias gau='git add --update'
alias gb='git branch'
alias gbd='git branch --delete '
alias gc='git commit'
alias gcm='git commit --message'
alias gcf='git commit --fixup'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gcos='git checkout staging'
alias gcod='git checkout develop'
alias gd='git diff'
alias gda='git diff HEAD'
alias gi='git init'
alias gl='git log'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gm='git merge --no-ff'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gp='git pull'
alias gpr='git pull --rebase'
alias gprom='git pull --rebase origin master'
alias gr='git rebase'
alias grim='git rebase -i origin/master'
alias gra='git rebase --abort'
alias gs='git status'
alias gss='git status --short'
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash save'
alias gwip='git commit -am "[WIP]"'

g() {
  grep -R $1 .
}

m() {
  mkdir $1 && cd $1
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
  curl -s "https://viacep.com.br/ws/$(echo $1 | tr -dc '0-9')/json/" | jq -r '.logradouro, .bairro, .localidade, .uf'
}

getsub() {
  curl -H "User-Agent: SubDB/1.0 (One-line Bash script)" "http://api.thesubdb.com/?action=download&language=en%2Cpt&hash=$((head -c 65536 "$1"; tail -c 65536 "$1") | md5)" > "${1%%.*}.srt"
}

mono_bundler()
{
  NAME=$(basename "$1");
  CC="gcc -lobjc -liconv -framework CoreFoundation" mkbundle -o ${NAME%.exe} --deps --static -z $1
}

rebase()
{
  git checkout $1
  git pull --rebase origin master
  git rebase --abort
  git push -f
  git checkout -
}

restore_db() {
  database=$1 psql <<EOF
SELECT PG_TERMINATE_BACKEND(pid) FROM pg_stat_activity WHERE pid <> PG_BACKEND_PID() AND datname = '$database';
DROP DATABASE IF EXISTS "$database";
CREATE DATABASE "$database";
EOF

  pg_restore -d $1 --no-acl --no-owner $2
}

cleanup()
{
  echo 'Cleaning up...'

  echo ' - Bash History'
  rm -rf ~/.bash_history

  echo ' - Bash Sessions'
  rm -rf ~/.bash_sessions

  echo ' - Gem Cache'
  gem cleanup > /dev/null

  echo ' - Yarn Cache'
  yarn cache clean > /dev/null

  echo ' - NPM Cache and Logs'
  rm -rf ~/.npm
  rm -f ~/.node_repl_history
  rm -f ~/.config/configstore/update-notifier-npm.json

  echo ' - Cargo Cache'
  rm -rf ~/.cargo/registry
  rm -rf ~/.cargo/git

  echo ' - Language temp files'
  rm ~/.v8flags*
  rm ~/.babel.json
  rm ~/.python_history

  echo ' - Browser data'
  rm -rf ~/Library/Safari/LocalStorage/http*
  rm -rf ~/Library/Safari/Databases/___IndexedDB/http*
  rm -rf ~/Library/Safari/Databases/http*
  rm -rf ~/Library/Google
  rm -rf ~/Library/Application\ Support/Firefox
  rm -rf ~/Library/Application\ Support/Google
  rm -rf ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV2*
  # rm -rf ~/Library/Safari/History*
  # rm -rf ~/Library/Cookies/com.apple.Safari.cookies
  # rm -rf ~/Library/Cookies/Cookies.binarycookies

  echo ' - Local caches'
  rm -r ~/.cache
  find ~/Library/Caches/ -not -name AudioUnitCache -not -name com.apple.audiounits.cache -delete 2> /dev/null
  find ~/Library/Containers/ -name 'Caches' 2> /dev/null | xargs rm -rf

  echo ' - Application specific caches'
  rm -rf ~/Music/iTunes/Album\ Artwork/Cache/
  rm -rf ~/Library/Containers/com.apple.siri.media-indexer/
  rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Cache/
  rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Index/

  echo ' - iOS Device Backups'
  rm -rf ~/Library/Application\ Support/MobileSync/Backup/

  echo ' - XCode Derived Data and Archives'
  rm -rf ~/Library/Developer/Xcode/DerivedData/
  rm -rf ~/Library/Developer/Xcode/Archives/

  echo ' - Homebrew Cache'
  rm -rf /Library/Caches/Homebrew/
  rm -rf ~/Library/Caches/Homebrew/

  echo ' - Local logs'
  rm -rf ~/Library/Logs/
  rm -rf ~/Library/Logs/CoreSimulator/
  rm -rf ~/Library/Containers/com.apple.mail/Data/Library/Logs/Mail/
  rm -rf ~/Library/Application\ Support/Firefox/Crash\ Reports/
  find ~/Library/Containers/ -name 'Logs' 2> /dev/null | xargs rm -rf

  echo ' - Application specific temporary files'
  rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Backup
  rm -rf ~/Library/Application\ Support/Pixelmator\ Pro/History
  rm -rf ~/Library/Application\ Support/CrashReporter

  echo ' - Remove empty folders'
  sudo find ~/ -name .DS_Store -delete 2> /dev/null
  sudo find ~/Library -depth -empty -delete 2> /dev/null

  echo ' - Clean trash on all volumes'
  sudo rm -rf ~/.Trash/*

  echo ' - System Log Files'
  sudo rm -rf /Library/Logs/DiagnosticReports/*
  sudo rm -rf /Library/Logs/CrashReporter/*
  sudo rm -rf /Library/Logs/Adobe/*
  sudo rm -rf /var/log/asl/*.asl
  sudo rm -rf /var/log/wifi.log*
  sudo rm -rf /var/log/system.log*
  sudo rm -rf /var/log/install.log*
  sudo rm -rf /var/log/*.out
  sudo rm -rf /var/log/fsck*

  echo ' - Shared user data'
  sudo rm -rf /Users/Shared/* &> /dev/null

  echo ' - System Caches'
  sudo rm -rf /Library/Caches/*
  # sudo rm -rf /System/Library/Caches/* &> /dev/null

  echo ' - System diagnostics'
  sudo rm -rf /var/db/diagnostics/*
  sudo rm -rf /private/var/log/DiagnosticMessages/*

  echo ' - Adobe Cache Files'
  sudo rm -rf ~/Library/Application\ Support/Adobe/Common/Media\ Cache\ Files/*

  echo ' - Run periodic scripts'
  sudo periodic daily weekly monthly

  echo ' - User temp and cache dirs'
  # find $(getconf DARWIN_USER_CACHE_DIR) -delete
  # find $(getconf DARWIN_USER_TEMP_DIR) -delete

  echo ' - Clear DNS Cache'
  sudo killall -HUP mDNSResponder
  sudo dscacheutil -flushcache

  echo ' - Purge inactive memory'
  sudo purge
}

(find ~/ -name .DS_Store -delete &>/dev/null &)

export NODE_PATH=/usr/local/lib/node_modules
export TZ=Brazil

# (rbenv rehash &)
# export PATH="~/.rbenv/shims:${PATH}"

export PATH=~/.cargo/bin:${PATH}
