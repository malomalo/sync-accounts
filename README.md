SSH Key Managment
=================

These scripts allow you to manage ssh keys for users and apps

### Users

Users are listed in `permissions.yml`. Users are created and deleted on servers
to match the list in `permissions.yml`. SSH keys are retrieved from github (user
names are assumed to be the github usernames).

GitHub usernames may start with a digit, but Linux usernames must start with
a letter. When a `permissions.yml` entry begins with digits (e.g. `1password`),
the leading digits are stripped to derive the local system username.

### Apps

Each name under `apps` is an account on the server. If that account exists and
has a login shell (listed in `/etc/shells`), the keys for the users listed
under it are written to its `authorized_keys`, allowing those users to SSH in
and deploy the app on that server. Its UID and home don't matter, so app
accounts created as system users (e.g. by `systemd-sysusers`) work.

App accounts are never created. `root`, and accounts managed under `users`,
are skipped. An app listed with no users gets an empty `authorized_keys`,
revoking access.

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

### sshd

`sync-accounts` writes each user's keys to `/etc/ssh/authorized_keys/<user>`
(root-owned, outside the user's home, so it cannot be tampered with via
symlinks). Tell `sshd` to read them by adding to `/etc/ssh/sshd_config`:

    AuthorizedKeysFile /etc/ssh/authorized_keys/%u .ssh/authorized_keys

Then reload sshd. Drop the trailing `.ssh/authorized_keys` if you want
sync-accounts to be the sole source of authorized keys.

### Scripts

Install to `/usr/local/bin`:

    sudo make install

Install to `/usr/bin`:

    sudo make install prefix=/usr

Uninstall:

    sudo make uninstall

### Cron

You can set up cron to auto updated the ssh keys. Eg:

`0 * * * * /usr/local/bin/sync-accounts http://domain.com/permissions.yml`

Or place a executable file in `/etc/cron.hourly`:

``` bash
sudo tee /etc/cron.hourly/sync-accounts <<'EOF'
/usr/local/bin/sync-accounts http://domain.com/permissions.yml
EOF

sudo chmod +x /etc/cron.hourly/sync-accounts
```