#!/bin/sh

####################
# Show help message.
####################
show_help() {
  echo "./enumerate.sh ---- grab all information"
  echo "./enumerate.sh {host/users/groups/network/jobs} ---- specific information"
  echo "./enumerate.sh help ---- show help"
}

if [ "$#" -gt 1 ]; then
  echo "[-] invalid argument"
  show_help
  exit 1
fi

#####################
# Get host information.
#####################
get_host() {
  echo "[+] getting host information"
  uname -a
  cat /etc/*-release
  echo "release info:"
  lsb_release -a
}

#####################
# Get user information.
#####################
get_current_user_info() {
  echo "[+] getting user information"
  echo "ID  : $(id)"
  echo "Path: $PATH"
}

#####################
# Get all users list.
#####################
get_all_users() {
  echo "[+] all users"
  cat /etc/passwd
}

#####################
# Get login users list.
#####################
get_users() {
  echo "[+] login users"
  grep -vE "nologin|false" /etc/passwd | awk -F':' '{print $1}'
  echo ""
  echo "/home:"; ls /home
  echo ""
  echo "[+] getting sudoers"
  getent group sudo
}

###################
# Helper function to print all users info nicely.
###################
get_users_info() {
  get_current_user_info
  echo ""
  get_users
  echo ""
  get_all_users
}

#####################
# Get groups list.
#####################
get_groups() {
  echo "[+] groups"
  groups
}

####################
# Get network services.
####################
get_network_services() {
  echo "[+] network services"
  netstat -antup
}

####################
# Get cronjobs
####################
get_cronjobs() {
  echo "[+] list of cronjobs"
  crontab -l
}

# get all information
if [ "$#" -eq 0 ]; then
  get_host
  echo ""
  get_users_info
  echo ""
  get_groups
  echo ""
  get_network_services
  echo ""
  get_cronjobs
  exit 0
fi

# print help message
if [ $1 = "help" ]; then
  show_help
  exit 0
fi

# get specific information.
if [ $1 = "host" ]; then
  get_host
elif [ $1 = "users" ]; then
  get_users_info
elif [ $1 = "groups" ]; then
  get_groups
elif [ $1 = "network" ]; then
  get_network_services
elif [ $1 = "jobs" ]; then
  get_cronjobs
else
  echo "[-] invalid argument"
  show_help
  exit 1
fi
