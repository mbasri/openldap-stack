# Use mbasri/openldap
# sources: https://github.com/mbasri/openldap
FROM osixia/openldap-backup:1.3.0

ENV HOSTNAME="ldap.kibadex.net"
ENV LDAP_ORGANISATION="Kibadex"
ENV LDAP_DOMAIN="kibadex.net"
ENV LDAP_READONLY_USER="true"

# Transport Layer Security
ENV LDAP_TLS_CA_CRT_FILENAME="kibadex.net.crt"
ENV LDAP_TLS_CRT_FILENAME="ldap.kibadex.net.crt"
ENV LDAP_TLS_KEY_FILENAME="ldap.kibadex.net.key"