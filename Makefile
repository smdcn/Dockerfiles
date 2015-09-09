pull:
	docker pull nginx:1.9.0
	docker pull php:5.6-fpm
	docker pull mysql:5.6
	docker pull memcached:1.4
	docker pull node:0.12

dl:
	wget https://pecl.php.net/get/yaf-2.3.5.tgz	-O php/yaf.tgz
	wget https://pecl.php.net/get/memcached-2.2.0.tgz -O php/memcached.tgz
	wget https://pecl.php.net/get/xdebug-2.3.2.tgz -O php/xdebug.tgz
	wget https://pecl.php.net/get/memcache-2.2.7.tgz -O php/memcache.tgz
	wget https://pecl.php.net/get/xhprof-0.9.4.tgz -O php/xhprof.tgz
	wget https://getcomposer.org/composer.phar -O php/composer.phar

build:
	make build-nginx
	make build-mysql
	make build-php
	make build-node

build-nginx:
	docker build -t dev/nginx ./nginx

run-nginx:
	docker run -i -d -p 80:80 -v ~/opt:/opt -t dev/nginx

in-nginx:
	docker run -i -p 80:80 -v ~/opt:/opt -t dev/nginx /bin/bash

build-php:
	docker build -t dev/php ./php

run-php:
	docker run -i -d -p 9000:9000 -v ~/opt:/opt -t dev/php

in-php:
	docker run -i -p 9000:9000 -v ~/opt:/opt -t dev/php /bin/bash

build-mysql:
	docker build -t dev/mysql ./mysql

run-mysql:
	docker run -i -d -p 3306:3306 -v ~/opt/data/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -t dev/mysql

in-mysql:
	docker run -i -p 3306:3306  -v ~/data/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -t dev/mysql /bin/bash

build-node:
	docker build -t dev/node ./node

run-node:
	docker run -i -d -p 8001:8001 -v ~/opt:/opt -t dev/node

in-node:
	docker run -i -p 8001:8001 -v ~/opt:/opt -t dev/node /bin/bash

clean:
	docker rmi -f $(shell docker images | grep "<none>" | awk "{print \$3}")
