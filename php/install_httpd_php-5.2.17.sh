#!/bin/bash
rm -rf php-5.2.17
rm -rf txtbgxGXAvz4N.txt
wget http://res1.coder4j.com/onekey/php/txtbgxGXAvz4N.txt
if [ ! -f php-5.2.17.tar.gz ];then
  wget http://res1.coder4j.com/onekey/php/php-5.2.17.tar.gz
fi
tar -zxvf php-5.2.17.tar.gz
cd php-5.2.17
./configure --prefix=/lnamp/server/php \
--with-config-file-path=/lnamp/server/php/etc \
--with-apxs2=/lnamp/server/httpd/bin/apxs \
--with-mysql=/lnamp/server/mysql \
--with-mysqli=/lnamp/server/mysql/bin/mysql_config \
--with-pdo-mysql=/lnamp/server/mysql \
--enable-static \
--enable-maintainer-zts \
--enable-zend-multibyte \
--enable-inline-optimization \
--enable-sockets \
--enable-wddx \
--enable-zip \
--enable-calendar \
--enable-bcmath \
--enable-soap \
--with-zlib \
--with-iconv \
--with-gd \
--with-xmlrpc \
--enable-mbstring \
--without-sqlite \
--with-curl \
--enable-ftp \
--with-mcrypt  \
--with-freetype-dir=/usr/local/freetype.2.1.10 \
--with-jpeg-dir=/usr/local/jpeg.6 \
--with-png-dir=/usr/local/libpng.1.2.50 \
--disable-ipv6 \
--disable-debug \
--disable-maintainer-zts \
--disable-safe-mode \
--disable-fileinfo

cp -p ../txtbgxGXAvz4N.txt  ./php-5.2.17.patch
patch -p0 -b < ./php-5.2.17.patch
sleep 3

make ZEND_EXTRA_LIBS='-liconv'

make install
cd ..
cp ./php-5.2.17/php.ini-recommended /lnamp/server/php/etc/php.ini
#adjust php.ini
sed -i 's#; extension_dir = \"\.\/\"#extension_dir = "/lnamp/server/php/lib/php/extensions/no-debug-non-zts-20060613/"#'  /lnamp/server/php/etc/php.ini
sed -i 's#extension_dir = \"\.\/\"#extension_dir = "/lnamp/server/php/lib/php/extensions/no-debug-non-zts-20060613/"#'  /lnamp/server/php/etc/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 64M/g' /lnamp/server/php/etc/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 64M/g' /lnamp/server/php/etc/php.ini
sed -i 's/;date.timezone =/date.timezone = PRC/g' /lnamp/server/php/etc/php.ini
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/g' /lnamp/server/php/etc/php.ini
sed -i 's/max_execution_time = 30/max_execution_time = 300/g' /lnamp/server/php/etc/php.ini
/etc/init.d/httpd restart
sleep 5
