# sensorgraph/openldap

![Docker Pulls](https://img.shields.io/docker/pulls/mbasri/openldap-stack.svg)
![Image size](https://images.microbadger.com/badges/image/mbasri/openldap-stack.svg)

**A docker images to run OpenLDAP Stack.**

> * Docker base images:
>   * OpenLDAP: [https://github.com/osixia/docker-openldap](https://github.com/osixia/docker-openldap)
>   * PHPLDAPAdmin: [https://github.com/osixia/docker-phpLDAPadmin](https://github.com/osixia/docker-phpLDAPadmin)
>   * OpenLDAP Backup: [https://github.com/osixia/docker-openldap-backup](https://github.com/osixia/docker-openldap-backup)
> * OpenLDAP website: [www.openldap.org](http://www.openldap.org/)

## Prerequisites

* [docker](https://www.google.com/search?q=how+to+install+docker)
* [ansible](https://www.google.com/search?q=how+to+install+ansible)

## Usage

```bash
git clone https://github.com/mbasri/openldap-stack.git ~/openldap-stack
cd ~/openldap-stack
./build
```

> Make sure that the `build` file can be executed via '`chmod +x ~/openldap-stack/build`'

### Volumes

OpenLDAP:

* Persistent data :
  * /etc/ldap/sldap.d
  * /var/lib/ldap
* Transport Layer Security
  * /container/service/slapd/assets/certs

PHPLDAPAdmin:

* Transport Layer Security
  * /container/service/phpldapadmin/assets/apache2/certs

OpenLDAP Backup:

* None

### Ports

OpenLDAP:

* LDAP: 389
* LDAPS: 636

PHPLDAPAdmin:

* HTTP: 80
* HTTPS: 443

OpenLDAP Backup:

* None

### Create the entries on the LDAP

The [ansible](./ansible) folder content a playbook for initialize the entries on the LDAP, It will create the groups and users.
the informations related to the server is present of the following file [group_vars/net/kibadex/main.yml](./ansible//group_vars/net/kibadex/main.yml), about the variable `net.kibadex.ldap.bind_pw` you can set the server password directly as follows:

```yml
net:
  kibadex:
    ldap:
      bind_pw: MyPassword
```

Or generate a `vault password` and set the password encrypted as follows:

```bash
> ansible-vault encrypt_string MyPassword
New Vault password:
Confirm New Vault password:
!vault |
          $ANSIBLE_VAULT;1.1;AES256
          39386165353866333831613233353235656139613164663465313133623461653663663332346135
          6637306261313462633465386237313632656266646464630a356636363161326262623335646639
          39323866326335626333306137333236646564383737643461623564326338663962653164386361
          6662633064333062350a393030663364356266336361353730313463663437326337393337623031
          6335
Encryption successful
```

```yml
net:
  kibadex:
    ldap:
      bind_pw: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          39386165353866333831613233353235656139613164663465313133623461653663663332346135
          6637306261313462633465386237313632656266646464630a356636363161326262623335646639
          39323866326335626333306137333236646564383737643461623564326338663962653164386361
          6662633064333062350a393030663364356266336361353730313463663437326337393337623031
          6335
```

For run the playbook, start the following command:

```bash
# Without an encrypted datas on your ansible playbook
ansible-playbook playbook.yml

# With an encrypted datas on your ansible playbook
ansible-playbook playbook.yml --ask-vault
```

## Author

* [**Mohamed BASRI**](https://github.com/mbasri)

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details
