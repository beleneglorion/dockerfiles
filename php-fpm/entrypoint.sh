#!/bin/sh
# Recupération de l'utilisateur et groupe courant
uid=$(stat -c %u /srv)
gid=$(stat -c %g /srv)

# Ajout d'une fonction a executer au démarrage de la VM, qui peut mettre à jour la BDD
# et les assets si spécifié dans la variable d'environnement.
function beforeStart () {
    if [ "enabled" == "$APP_AUTO_UPDATE" -a -d vendor  ]; then
        bin/console d:m:m --no-interaction --allow-no-migration
        bin/console assets:install
    fi
}

# Si on a activé 'utilisation de XDEBUG on le configure pour PHP
if [ "enabled" == "$APP_XDEBUG" ]; then
    # Enable xdebug
    ln -sf /xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
    echo 'Xdebug  is enabled'
else
    # Disable xdebug
    if [ -e /usr/local/etc/php/conf.d/xdebug.ini ]; then
        rm -f /usr/local/etc/php/conf.d/xdebug.ini
    fi
    echo 'Xdebug  is disabled'
fi

if [ $uid == 0 ] && [ $gid == 0 ]; then
    if [ $# -eq 0 ]; then
        beforeStart
    	chmod -R 777 /srv/var
        php-fpm --allow-to-run-as-root
    else
        echo "$@"
        exec "$@"
    fi
fi

echo 'Environnement is :'$APP_ENV
sed -i -r "s/foo:x:\d+:\d+:/foo:x:$uid:$gid:/g" /etc/passwd
sed -i -r "s/bar:x:\d+:/bar:x:$gid:/g" /etc/group

sed -i "s/user = www-data/user = foo/g" /usr/local/etc/php-fpm.d/www.conf
sed -i "s/group = www-data/group = bar/g" /usr/local/etc/php-fpm.d/www.conf

user=$(grep ":x:$uid:" /etc/passwd | cut -d: -f1)


if [ $# -eq 0 ]; then
	beforeStart
	chown -R $user /srv/var
    chmod -R 777 /srv/var
    php-fpm
else
    echo gosu $user "$@"
    exec gosu $user "$@"
fi
