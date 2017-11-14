FROM gcr.io/google-appengine/php71

RUN apt-get update

# Installations
RUN apt-get autoremove -y

RUN apt-get install -y \
	nginx \
	git \
	#mysql-server \
	mysql-client

COPY ./DockerAssets/nginx.conf /etc/nginx/conf.d/hive.conf
COPY ./DockerAssets/nginx_perf.conf /etc/nginx/conf.d/perf.conf

RUN mkdir -p /var/www/platform
ADD platform/ /var/www/platform/
RUN chmod -R a+r /var/www/platform
RUN chown -R www-data:www-data /var/www/platform

# Finally, all static assets.
#ADD www/ /usr/share/nginx/www/
#RUN chmod -R a+r /usr/share/nginx/www

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN curl -sL https://deb.nodesource.com/setup | bash - && \
	apt-get install -yq nodejs build-essential
	
RUN npm install -g npm

RUN cd /var/www/platform \
	npm run dev \
	composer install




