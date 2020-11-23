#!/usr/bin/env python
"""
    small script to check for unread count on imap inbox
"""
import imaplib

IMAPSERVER = 'imap.mailbox.org'
USER = 'USER'
PASSWORD = 'PW'

mail = imaplib.IMAP4_SSL(IMAPSERVER)
mail.login(USER, PASSWORD)
mail.select("inbox", True) # connect to inbox.
return_code, mail_ids = mail.search(None, 'ALL')
count = sum(1 for i in mail_ids[0].split(b" ") if i != b"")
print(count)
