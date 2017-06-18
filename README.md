# Description
Configuration files for mutt and offlineimap.

## private files
### .offlineimaprc
Add your own ~/.offlineimaprc file
```
[general]
ui = ttyui
accounts = gmail_account_name1, gmail_account_name2
pythonfile = ~/.offlineimap.py

[Account gmail_account_name1]
localrepository = gmail_account_name1-local
remoterepository = gmail_account_name1-remote
status_backend = sqlite

[Repository gmail_account_name1-local]
type = Maildir
localfolders = ~/mail/archive/gmail_account_name1
nametrans = lambda folder: {'drafts':    '[Gmail]/Drafts',
                            'sent':      '[Gmail]/Sent Mail',
                            'flagged':   '[Gmail]/Starred',
                            'trash':     '[Gmail]/Trash',
                            'archive':   '[Gmail]/All Mail',
                            'important': '[Gmail]/Important',
                            'spam':      '[Gmail]/Spam',
                            }.get(folder, folder)

[Repository gmail_account_name1-remote]
type = Gmail
folderfilter = lambda foldername: foldername not in ['[Gmail]/All Mail','[Gmail]/Important']
remoteuser = EMAIL_ADDRESS1
remotepasseval = keyring.get_password("offlineimap","EMAIL_ADDRESS1")
maxconnections = 3
sslcacertfile = /etc/ssl/certs/ca-certificates.crt
nametrans = lambda folder: {'[Gmail]/Drafts':    'drafts',
                            '[Gmail]/Sent Mail': 'sent',
                            '[Gmail]/Starred':   'flagged',
                            '[Gmail]/Trash':     'trash',
                            '[Gmail]/All Mail':  'archive',
                            '[Gmail]/Important': 'important',
                            '[Gmail]/Spam':      'spam',
                            }.get(folder, folder)

[Account gmail_account_name2]
localrepository = gmail_account_name2-local
remoterepository = gmail_account_name2-remote
status_backend = sqlite
...
...

```

### .mutt/muttrc.local
muttrc.local can contain something like this:

```
set folder=~/mail/archive
set spoolfile=+gmail_account_name1/INBOX

set my_rpass=`get_password.py offlineimap EMAIL_ADDRESS1`
set my_gpass=`get_password.py offlineimap EMAIL_ADDRESS2`

alternates EMAIL_ADDRESS1 EMAIL_ADDRESS2

mailboxes   `find ~/mail/archive -type d -regex '.*\/new$' -printf "+'%P' " |sed -e 's/\/new//g'`
```

# Dependencies
 - curl
 - mutt
 - procmail
 - offlineimap
 - gnupg
 - formail

# External repositories
 Read the external repositories README
 - git://github.com/roxell/keyring-password.git
 - git://github.com/terabyte/mutt-filters.git

# Usage
$ ./install.sh
