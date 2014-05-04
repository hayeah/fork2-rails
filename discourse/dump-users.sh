HOST=root@d.fork2.com

ssh $HOST <<HERE
sh /var/docker/dump-users.sh
HERE

rsync -Paz $HOST:/var/docker/shared/dusers.json .