SSH Key Managment
=================

These scripts allow you to manage ssh keys for users and apps

### Users

Users are listed in `permissions.yml`. Users are created and deleted on servers
match the list in `permissions.yml`. SSH keys are retreived from github (user
names are assumed to be the github usernames).

### Apps

If an app user exist on a server the keys for the users listed under that app
are copied over allowing the users to SSH and deploy the app on that server.

Commands
========

### Install

`sync-accounts https://url/to/permissions.yml` will download the permissions
file and sync the users. If a user is in `permissions.yml` that is not on the
system that user will be created. If a user exist on the system but no in
`permissions.yml` that user will be deleated. If an user with the name of an app
exist the keys will be copied to that users `authorized_keys` file.

Installing
==========

### Scripts

`make install` will install the scripts into `/usr/loca/bin`

`make uninstall` will remove the scripts from `/usr/loca/bin` 

### Cron

You can set up cron to auto updated the ssh keys. Eg:

`0 * * * * /usr/local/bin/sync-accounts http://domain.com/permissions.yml`
