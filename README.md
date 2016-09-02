# ServerSetup

none

## Description

none

## Usage

Server Initialize

0. ssh -i ****** -lroot ***.***.***.***

1. get script.

    wget https://raw.githubusercontent.com/takeshifurusato/server_setup/master/server_init.sh

2. settings

    export OPE_USER_NAME='username'
    
    export OPE_USER_PASS='userpass'
    
    export PWD_MYSQL='mysqlpass'

3. Run script.

    sh server_init.sh

Make vHosts

0. ssh -lusername ***.***.***.***

1. get script.

    wget https://raw.githubusercontent.com/takeshifurusato/server_setup/master/make_vhosts.sh
    
2. settings

    export OPE_USER_NAME='username'
    
    export PWD_MYSQL='mysqlpass'
    
    export VHOST_FQDN='VHOST_FQDN'
    
    export DB_NAME='dbname'
    
    export DB_USER='dbuser'
    
    export DB_PASS='dbpass'

3. Run script.

    sudo sh make_vhosts.sh

## Anything Else

Draft!!

## Author

[takeshi.furusato](https://www.facebook.com/takeshi.furusato)

## License

[MIT](http://b4b4r07.mit-license.org)
