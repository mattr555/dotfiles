#.dotfiles

##Powerline

1. `pip install --user git+git://github.com/Lokaltog/powerline`
2. `ln -s powerline_mine.py ~/.local/lib/python2.7/powerline_mine.py`
3. Configure

##Vim

1. Install [Vundle](https://github.com/gmarik/Vundle.vim)
2. .vimrc-private (github access token)
3. `:PluginInstall`

##Mutt

1. .mutt/*.account
	
	For Gmail:

	```
	set imap_user = 'emailaddy'
	set imap_pass = 'pword'
	set smtp_url = "smtp://addy@smtp.gmail.com:587/"
	set smtp_pass = "pword"
	set from = "emailaddy"
	set realname = "name"
	set spoolfile = imaps://imap.gmail.com:993/INBOX
	set folder = imaps://imap.gmail.com:993
	set postponed="imaps://imap.gmail.com/[Gmail]/Drafts"
	set trash = "imaps://imap.gmail.com/[Gmail]/Trash"
	```

##Tmux

should work out of the box

##Irssi

1. Config
2. Scripts (.irssi/scripts/autorun): 
	- adv_windowlist.pl
	- bitlbee_status_notice.pl
	- bitlbee_typing_notice.pl
	- nicklist.pl
	- notify.pl
	- xchatnickcolor.pl
3. xchat.theme

##Pianobar

.config/pianobar: control-pianobar.sh + pianobar-notify.sh + config

##Bash

should Just Work<sup>TM</sup>
