SSH Key Managment
=================

These scripts allow you to manage ssh keys for users and groups of users

### Users

User keys are placed in a file with the users name in the `users`
directory. This file contains ssh keys for that user. Each line is one
SSH key and blank lines are ignored.

### Groups

Group files are placed in file with the group name in the `groups`
directory. This file contains the names of users belonging to the
group. Each line contains the one username. Blank lines are ignored.

Commands
========

### Package

To package the `users` and `groups` for distribution run the `ssh-package
outputfile` script. This will generate a file that can be placed at a
location where other clients can download.

### Extract

`ssh-extract inputfile outputdir` will extract the keys to outputdir.

### Install

`ssh-install http://url/file` will download the file produced by `package` and
go through all the system users. If the username matches one of the user files
then the ssh keys will be placed into authorized_keys. If the username matches
a group name all the ssh keys for that group will be added to authorized_keys

Installing
==========

### Scripts

`make install` will install the scripts into `/usr/loca/bin`

`make uninstall` will remove the scripts from `/usr/loca/bin` 

### Cron

You can set up cron to auto updated the ssh keys. Eg:

`0 * * * * /usr/local/bin/ssh-install http://domain.com/keysfile`
