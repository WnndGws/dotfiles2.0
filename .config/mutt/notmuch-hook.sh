#!/usr/bin/zsh
## A hook to send emails to virtual mailboxes using notmuch


notmuch new
# retag all "new" messages "inbox" and "unread"
notmuch tag +inbox +unread -new -- tag:new
# tag all messages from "me" as sent and remove tags inbox and unread
notmuch tag -new -inbox +sent -- from:wynand
# tag uni
notmuch tag +uni +inbox +unread -new -- to:uwa.edu.au
