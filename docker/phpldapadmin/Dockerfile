# Use mbasri/phpldapadmin
# sources: https://github.com/mbasri/phpldapadmin
FROM osixia/phpldapadmin:0.9.0
LABEL MAINTAINER="Mohamed BASRI <mbasri@outlook.fr>"

ENV PHPLDAPADMIN_LDAP_HOSTS="ldap.kibadex.net"
ENV PHPLDAPADMIN_SERVER_ADMIN="mbasri@outlook.fr"

# Transport Layer Security
ENV PHPLDAPADMIN_HTTPS_CA_CRT_FILENAME="kibadex.net.crt"
ENV PHPLDAPADMIN_HTTPS_CRT_FILENAME="phpldapadmin.kibadex.net.crt"
ENV PHPLDAPADMIN_HTTPS_KEY_FILENAME="phpldapadmin.kibadex.net.key"