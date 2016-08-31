# ServerSetup

none

## Description

none


## Usage

1. wget https://github.com/takeshifurusato/server_setup/archive/master.zip
2. yum -y install zip unzip
3. unzip master.zip
4. cd server_setup-master

5. vi server_init.sh
Edit parameters section of "server_init.sh" 
6. vi make_vhosts.sh
Edit parameters section of "make_vhosts.sh"

7. chmod +x ./*.sh
8. ./server_init.sh
9. ./make_vhosts.sh
10. ./selinux_off.sh
reboot!!


## Anything Else

Draft!!

## Author

[takeshi.furusato](https://www.facebook.com/takeshi.furusato)

## License

[MIT](http://b4b4r07.mit-license.org)