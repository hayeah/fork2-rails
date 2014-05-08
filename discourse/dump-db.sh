HOST=root@d.fork2.com

ssh $HOST <<HERE
sh /var/docker/dump-db.sh
HERE

rsync -Paz $HOST:/var/docker/shared/discourse-dump.sql .