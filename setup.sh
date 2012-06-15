#!/bin/sh


if [ $# -eq 0 ]
then 
	echo "\033[0m"
	echo ----------------------------------------
	echo Setup Skript für Symfony2 Projekte "(v0.2)"
	echo ========================================
	echo "\033[1m"Ausführung:"\033[0m"
	echo chmod u+x setup.sh
	echo sudo ./setup.sh
	echo ===================================
	echo Folgende Optionen stehen zur Verfügung"\n"
	echo "\033[1m--init" "\033[0m \t"Folgende Befehle werden ausgeführt:
	echo "\t\t"-- Clear cache
	echo "\t\t"-- Clear logs
	echo "\t\t"-- Set permissions app/logs app/cache
	echo "\t\t"-- Install vendors
	echo "\t\t"-- Create database
	echo "\t\t"-- Update database schema
	echo "\t\t"-- Clear cache"\n"
	echo "\033[1m --update" "\033[0m \t"Folgende Befehle werden ausgeführt:
        echo "\t\t"-- Install vendors
        echo "\t\t"-- Update database schema
        echo "\t\t"-- Clear cache"\n"
        echo "\033[0m"
	exit 65
fi


if [[ "$1" =~ "--init" ]]
then
	echo "\033[31m"Clear cach..."\033[0m"
	rm -rf app/cache/*

        echo "\033[31m"Clear logs..."\033[0m"
	rm -rf app/logs/*

        echo "\033[31m"Set permissions..."\033[0m"
	chmod +a "www allow delete,write,append,file_inherit,directory_inherit" app/cache app/logs
	chmod +a "`whoami` allow delete,write,append,file_inherit,directory_inherit" app/cache app/logs

        echo "\033[31m"Install/update vendors..."\033[0m"
	php bin/vendors install


        echo "\033[31m"Create database..."\033[0m"
	php app/console doctrine:database:create


        echo "\033[31m"Update database schema..."\033[0m"
	php app/console doctrine:schema:update --force

        echo "\033[31m"Clear cache..."\033[0m"
        php app/console cache:clear

	exit 65
fi

if [[ "$1" =~ "--update" ]]
then

        echo "\033[31m"Install/update vendors..."\033[0m"
        php bin/vendors install

        echo "\033[31m"Update database schema..."\033[0m"
	php app/console doctrine:schema:update --force

        echo "\033[31m"Clear cache..."\033[0m"
	php app/console cache:clear

	exit 65
fi
