# Description
Configuration files for mutt and offlineimap.

Add your own ~/.offlineimaprc file
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
remoteuser = EMAIL_ADDRESS
remotepasseval = keyring.get_password("offlineimap","EMAIL_ADDRESS")
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
