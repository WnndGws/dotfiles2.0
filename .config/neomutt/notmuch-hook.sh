#!/usr/bin/zsh
## A hook to send emails to virtual mailboxes using notmuch

notmuch new
# retag all "new" messages "inbox" and "unread"
notmuch tag +inbox +unread -new -- tag:new
# tag all messages from "me" as sent and remove tags inbox and unread
notmuch tag -new -inbox +sent -- from:wynand
# tag uni
notmuch tag +uni -inbox +unread -new -- to:uwa.edu.au

#-----------------------#
##NEWSLETTER MANAGEMENT##
#-----------------------#
notmuch tag -inbox +trash -- 'from:"donotreply@jora.com" date:"2017-01-01..yesterday" tag:inbox'
notmuch tag -inbox +trash -- 'from:".*@inside.com" date:"2017-01-01..yesterday" tag:inbox'
notmuch tag -inbox +trash -- 'from:".*@.*element14.com" date:"2017-01-01..today" tag:inbox'
notmuch tag -inbox +trash -- 'from:".*@.*dev.to" date:"2017-01-01..yesterday" tag:inbox'
notmuch tag -inbox +trash -- 'from:"morningcupofcoding@human.*" date:"2017-01-01..yesterday" tag:inbox'
notmuch tag -inbox +trash -- 'from:".*@daveyrealestate.com.au" date:"2017-01-01..today" tag:inbox'
notmuch tag -inbox +trash -- 'from:".*@.*stackcommerce.com" date:"2017-01-01..today" tag:inbox'
notmuch tag -inbox +trash -- 'from:".*@scottscheapflights.com" date:"2017-01-01..yesterday" tag:inbox'
notmuch tag -inbox +trash -- 'from:"store-news@amazon.com" date:"2017-01-01..today" tag:inbox'
