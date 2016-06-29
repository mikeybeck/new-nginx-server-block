#!/bin/bash

#Set these first!  Make sure to set config values in other file also
NEWSITE=""   # Enter new site url
SUDOPASS=""  # Remote sudo password
GROUP=""     # New site group 
OWNER=""     # New site owner
INSTALLWP="" # If "1" then will also install Wordpress


ls;
echo $SUDOPASS | sudo -S mkdir -p /var/www/$NEWSITE/htdocs;

cd /var/www/;

sudo chown -R $USER:$USER /var/www/$NEWSITE/htdocs

sudo chmod -R 755 /var/www/$NEWSITE/htdocs

echo "<html><head><title>Welcome to $NEWSITE!</title></head><body><h1>Success!  The $NEWSITE server block is working!</h1></body></html>" > /var/www/$NEWSITE/htdocs/index.html

sudo cp /etc/nginx/sites-available/newsitetemplate /etc/nginx/sites-available/$NEWSITE

sudo sed -i "s/NEWSITENAME/$NEWSITE/g" /etc/nginx/sites-available/$NEWSITE

sudo ln -s /etc/nginx/sites-available/$NEWSITE /etc/nginx/sites-enabled/

sudo service nginx restart


if [ "$INSTALLWP" == '1' ]; then
    echo "Installing Wordpress..."

	cd /var/www/$NEWSITE/htdocs/

	wget http://wordpress.org/latest.tar.gz

	tar xfz latest.tar.gz

	mv wordpress/* ./

	echo "Wordpress installed; removing zip file.."

	rmdir ./wordpress/
	rm -f latest.tar.gz

fi

sudo chgrp -R $GROUP /var/www/$NEWSITE/htdocs

sudo chmod -R g+w /var/www/$NEWSITE/htdocs

sudo chown -R $OWNER:$GROUP /var/www/$NEWSITE/htdocs

echo "Done!"






