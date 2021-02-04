FROM centos:7

# Install Apache
#RUN yum -y update
RUN yum -y install httpd -y


# Install EPEL Repo
RUN yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
RUN yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y


# Install PHP
RUN yum install yum-utils -y
RUN yum-config-manager --enable remi-php56   [Install PHP 5.6]
RUN yum install php php-mbstring php-intl php-simplexml php-PDO php-mysql -y


# Update Apache Configuration
RUN sed -E -i -e '/<Directory "\/var\/www\/html">/,/<\/Directory>/s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
RUN sed -E -i -e 's/DirectoryIndex (.*)$/DirectoryIndex index.php \1/g' /etc/httpd/conf/httpd.conf
COPY ./anspsoftware /var/www/html/

RUN chown -R apache:apache /var/www/html
RUN chmod -R 777 /var/www/html

EXPOSE 8181



# Start Apache
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]
