# sensorgraph/openldap

![Docker Pulls](https://img.shields.io/docker/pulls/sensorgraph/openldap.svg)
![Image size](https://images.microbadger.com/badges/image/sensorgraph/openldap.svg)

**A docker image to run OpenLDAP.**

> * Docker base image: [github.com/osixia/docker-openldap](github.com/osixia/docker-openldap)
> * OpenLDAP website: [www.openldap.org](http://www.openldap.org/)

## Prerequisites

* [docker](https://www.google.com/search?q=how+to+install+docker)

## Usage

```bash
git clone https://github.com/sensorgraph/openldap.git ~/openldap
cd ~/openldap
./build
```

> Make sure that the `build` file can be executed via '`chmod +x ~/openldap/build`'

### Volumes

* Persistent data :
  * /etc/ldap/sldap.d
  * /var/lib/ldap
* Transport Layer Security
  * /container/service/slapd/assets/certs

### Port

* LDAP : 389
* LDAPS : 636

## Author

* [**Mohamed BASRI**](https://github.com/mbasri)

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details
