# ServerSetup

none

## Description

none

## Usage

### Server Initialize

    ssh -i ****** -lroot ***.***.***.***

    curl https://raw.githubusercontent.com/takeshifurusato/server_setup/master/server_init.sh > server_init.sh

    export OPE_USER_NAME='username'
    export OPE_USER_PASS='userpass'
    export PWD_MYSQL='mysqlpass'

    sh server_init.sh

### Make vHosts

    ssh -lusername ***.***.***.***

    curl https://raw.githubusercontent.com/takeshifurusato/server_setup/master/make_vhosts.sh > make_vhosts.sh
    
    export OPE_USER_NAME='username'
    export PWD_MYSQL='mysqlpass'
    export VHOST_FQDN='www.example.com'
    export DB_NAME='dbname'
    export DB_USER='dbuser'
    export DB_PASS='dbpass'

    sh make_vhosts.sh

## Anything Else

Draft!!

## Author

[takeshi.furusato](https://www.facebook.com/takeshi.furusato)

## License

[MIT](http://b4b4r07.mit-license.org)
