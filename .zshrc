source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh

setopt PROMPT_SUBST
setopt +o nomatch

EMOJIS=🦊🐻🐯🦁🐨🐼🐰🐹🐱🐮
EMOJI=${EMOJIS:$(( RANDOM % ${#EMOJIS} )):1}
PS1="\$(__git_ps1 '[%s]')🦊 "

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
bindkey "^[[A" history-beginning-search-backward  # Prefix history search down
bindkey "^[[B" history-beginning-search-forward   # Prefix history search up

# Edit command line
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

export EDITOR="nano"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history"
export HISTCONTROL="erasedups:ignoreboth"

set -o noclobber

git config --global user.name "Silvio Henrique Ferreira"
git config --global user.email "shferreira@me.com"
git config --global core.excludesfile '~/.gitignore'
git config --global --replace alias.l 'log'
git config --global --replace alias.s 'show'
git config --global --replace alias.rir 'rebase -i --root'
git config --global --replace alias.wip 'commit -am "[WIP]"'
git config --global format.pretty "format:%Cred%h%Creset %s %Cgreen(%cr) %C(yellow)<%ae>%Creset"
[ -x "$(command -v diff-so-fancy)" ] && git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

alias urls="perl -pe 's|.*(https?:\/\/.*?)\".*|\1|'"
alias hostmaker="( head -n 20 /etc/hosts ; printf \"\\n\\n\\n\" ; (curl http://winhelp2002.mvps.org/hosts.txt https://someonewhocares.org/hosts/zero/hosts https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts \"https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext\" https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/hosts.txt https://raw.githubusercontent.com/jmdugan/blocklists/master/corporations/facebook/all-but-whatsapp https://raw.githubusercontent.com/notracking/hosts-blocklists/master/hostnames.txt https://raw.githubusercontent.com/shff/hosts/master/hosts https://raw.githubusercontent.com/shff/hosts/master/anti-reddity https://raw.githubusercontent.com/dotspencer/block-admiral/master/hosts https://raw.githubusercontent.com/tumatanquang/simple-filters/main/hosts) | sed -e 's/127.0.0.1/0.0.0.0/' -e 's/  / /' -e 's/ \+/ /' -e 's/#.*$//' | tr -d '\r' | awk '{gsub(/\t+/,\" \");print}' | egrep "^0.0.0.0" | grep -v \"thepiratebay.\" | sort -fu | uniq -i ) > ~/.hosts; sudo cp ~/.hosts /etc/hosts; rm ~/.hosts"
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
alias s="code"
alias l='ls -lah'
alias f='find . -name'
alias ya='youtube-dl -x --audio-format wav '
alias ya3='youtube-dl -o "%(playlist_index)s - %(title)s.%(ext)s" -x --audio-format mp3 '
alias sort-by-length="awk '{ print length, $0 }' | sort -n -s --reverse | cut -d' ' -f2-"

# Map Reduce
alias map='xargs -L 1 -I $'
alias count="sort | uniq -c | sort"
filter() { while read it; do if $(eval $1); then echo $it; fi; done }     # Example: `ls | filter '[ "$l" = "Desktop" ]'`

# Git Aliases
alias ga='git add'
alias gaa='git add .'
alias gaaa='git add --all'
alias gap='git add . -p'
alias gau='git add --update'
alias gb='git branch'
alias gbd='git branch --delete '
alias gc='git commit'
alias gca='git commit --amend --no-edit'
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
alias gprom='git pull --rebase origin develop'
alias gr='git rebase'
alias grim='git rebase -i origin/master'
alias grid='git rebase -i origin/develop'
alias grir='git rebase -i --root'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gs='git status'
alias gss='git status --short'
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash save'
alias gsui='git submodule update --init'
alias gwip='git commit -am "[WIP]"'
alias gfmm='git fetch origin master:master'
alias gbb='git checkout $(git branch | grep -v \* | fzf --height=10 --info=hidden)'
alias gfdev='git fetch origin develop:develop'

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
  ls *.mp3 | sed 's/^\(\([0-9]* \)\(.*\).mp3\)$/eyeD3 -n \2 -t "\3" "\1"/' | sh
}

pkg_util() {
  local options=( $(pkgutil --pkgs | grep -v com.apple | sort | xargs -n 1) )
  select opt in "${options[@]}" "Quit"; do
    local name=$options[$REPLY]
    local volume=$(pkgutil --pkg-info $name | grep volume | sed -e 's/volume: //')
    local location=$(pkgutil --pkg-info $name | grep location | sed -e 's/location: //')
    local dirs=$(pkgutil --only-files --files $name | while read line; do echo "$volume$location/$line"; done)
    local dirs_that_exist=$(echo $dirs | sed -e 's/ /\\ /g' | xargs ls 2>/dev/null | wc -l)

    if [ $dirs_that_exist -eq 0 ]; then
      echo "The package has no files. Forgetting..."
      sudo pkgutil --forget $name
    else
      echo "The package is in use. Directories:"
      echo $dirs
    fi
  done
}

cleanup()
{
  echo 'Cleaning up...'

  echo ' - Shell History'
  rm -rf ~/.bash_history
  rm -rf ~/.zsh_history

  echo ' - Shell Sessions'
  rm -rf ~/.bash_sessions
  rm -rf ~/.zsh_sessions

  echo ' - Gem Cache'
  [ -x "$(command -v gem)" ] && gem cleanup > /dev/null

  echo ' - Yarn Cache'
  [ -x "$(command -v yarn)" ] && yarn cache clean > /dev/null
  rm -f ~/.yarnrc

  echo ' - NPM Cache and Logs'
  [ -x "$(command -v gem)" ] && npm cache clean --force &>/dev/null
  rm -rf ~/.npm
  rm -f ~/.node_repl_history
  rm -f ~/.config/configstore/update-notifier-npm.json
  rm -f ~/.npmrc
  rm -f ~/.config/configstore/nodemon.json
  rm -f ~/.config/configstore/update-notifier-nodemon.json

  echo ' - Cargo Cache'
  rm -rf ~/.cargo/registry
  rm -rf ~/.cargo/git

  echo ' - Docker Cache'
  [ -x "$(command -v docker)" ] && docker system prune -af &>/dev/null

  echo ' - Homebrew Cache'
  [ -x "$(command -v brew)" ] && brew cleanup -s &>/dev/null
  [ -x "$(command -v brew)" ] && rm -rfv "$(brew --cache)"

  echo ' - Language temp files'
  rm ~/.v8flags* 2> /dev/null
  rm ~/.babel.json 2> /dev/null
  rm ~/.python_history 2> /dev/null

  echo ' - Browser data'
  rm -rf ~/Library/Safari/LocalStorage/http*
  rm -rf ~/Library/Safari/Databases/___IndexedDB/http*
  rm -rf ~/Library/Safari/Databases/http*
  rm -rf ~/Library/Google
  rm -rf ~/Library/Application\ Support/Firefox
  rm -rf ~/Library/Application\ Support/Google
  rm -rf ~/Library/Application\ Support/TorBrowser-Data
  rm -rf ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV2*
  # rm -rf ~/Library/Safari/History*
  # rm -rf ~/Library/Cookies/com.apple.Safari.cookies
  # rm -rf ~/Library/Cookies/Cookies.binarycookies

  echo ' - Local caches'
  rm -r ~/.cache 2> /dev/null
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

  echo ' - VSCode Caches'
  rm -rf ~/Library/Application\ Support/Code/CachedData
  rm -rf ~/Library/Application\ Support/Code/CrashpadMetrics-active.pma
  rm -rf ~/Library/Application\ Support/Code/CrashpadMetrics.pma
  rm -rf ~/Library/Application\ Support/Code/GPUCache
  rm -rf ~/Library/Application\ Support/Code/CachedExtensions
  rm -rf ~/Library/Application\ Support/Code/Cache
  rm -rf ~/Library/Application\ Support/Code/logs
  rm -rf ~/Library/Application\ Support/Code/Backups
  rm -rf ~/Library/Application\ Support/Code/Code\ Cache
  rm -rf ~/Library/Application\ Support/Code/Crashpad

  echo ' - Adobe Cache'
  rm -rf ~/Library/Application\ Support/Adobe/Common/Media\ Cache\ Files/

  echo ' - Native Instruments Cache'
  rm -rf ~/Library/Application\ Support/Native\ Instruments/Kontakt/LibrariesCache

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
  find ~/ -name .DS_Store -delete 2> /dev/null
  find ~/Library -depth -empty -delete 2> /dev/null
  rm -rf ~/.config

  # echo ' - System Log Files'
  # sudo rm -rf /Library/Logs/DiagnosticReports/*
  # sudo rm -rf /Library/Logs/CrashReporter/*
  # sudo rm -rf /Library/Logs/Adobe/*
  # sudo rm -rf /var/log/asl/*.asl
  # sudo rm -rf /var/log/wifi.log*
  # sudo rm -rf /var/log/system.log*
  # sudo rm -rf /var/log/install.log*
  # sudo rm -rf /var/log/*.out
  # sudo rm -rf /var/log/fsck*

  # echo ' - Shared user data'
  # sudo rm -rf /Users/Shared/* &> /dev/null

  # echo ' - System Caches'
  # sudo rm -rf /Library/Caches/*
  # sudo rm -rf /System/Library/Caches/* &> /dev/null

  # echo ' - System diagnostics'
  # sudo rm -rf /var/db/diagnostics/*
  # sudo rm -rf /private/var/log/DiagnosticMessages/*

  # echo ' - User temp and cache dirs'
  # find $(getconf DARWIN_USER_CACHE_DIR) -delete
  # find $(getconf DARWIN_USER_TEMP_DIR) -delete

  echo ' - Run periodic scripts'
  sudo periodic daily weekly monthly

  echo ' - Clear DNS Cache'
  sudo killall -HUP mDNSResponder
  sudo dscacheutil -flushcache

  echo ' - Purge inactive memory'
  sudo purge
}

# Node
export NODE_PATH=/usr/local/lib/node_modules

# Rust, RVM, RBENV, DotNet and Deno
export PATH=~/.cargo/bin:~/.rvm/bin:~/.dotnet:~/.deno:~/.rbenv/shims:${PATH}
