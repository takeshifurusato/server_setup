# ServerSetup

none

## Description

none

## Usage

### Server Initialize

    ssh -i ****** -lroot ***.***.***.***

    curl https://raw.githubusercontent.com/takeshifurusato/server_setup/master/host_config.sh > host_config.sh
    vi host_config.sh
    curl https://raw.githubusercontent.com/takeshifurusato/server_setup/master/server_init.sh > server_init.sh
    sh server_init.sh

### Make vHosts

    ssh -lusername ***.***.***.***

    curl https://raw.githubusercontent.com/takeshifurusato/server_setup/master/host_config.sh > host_config.sh
    vi host_config.sh
    curl https://raw.githubusercontent.com/takeshifurusato/server_setup/master/make_vhosts.sh > make_vhosts.sh
    sh make_vhosts.sh

## Anything Else

Draft!!

## Author

[takeshi.furusato](https://www.facebook.com/takeshi.furusato)

## License

[MIT](http://b4b4r07.mit-license.org)
