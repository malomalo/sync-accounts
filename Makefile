install:
	cp ssh-install /usr/local/bin/
	cp ssh-package /usr/local/bin/
	cp ssh-extract /usr/local/bin/

uninstall:
	rm /usr/local/bin/ssh-install
	rm /usr/local/bin/ssh-package 
	rm /usr/local/bin/ssh-extract 
