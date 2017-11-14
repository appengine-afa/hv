docker run --name="ire" -p 80:80 -it -d -v /vagrant/ire/platform/git:/var/www/ireplatform/ -v /usr/backups:/usr/backups ire/dev
docker exec ire /bin/sh -c "service nginx start; service php7.0-fpm start; service mysql start"
