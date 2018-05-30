#!/bin/bash
pass=$(gpg2 -d -q ~/.config/neomutt/mail_credentials.gpg)
echo set smtp_pass=\"$pass\"
echo set imap_pass=\"$pass\"
