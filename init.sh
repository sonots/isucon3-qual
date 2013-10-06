#!/bin/sh
mysql -uroot -proot isucon -e 'create index user_create_at_index on memos (user, created_at);'
mysql -uroot -proot isucon -e 'create index user_is_private_created_at_index on memos (user, is_private, created_at);'
mysql -uroot -proot isucon -e 'alter table memos add column username varchar(255) NOT NULL;'
mysql -uroot -proot isucon -e 'alter table memos add column first_sentence text NOT NULL;'

