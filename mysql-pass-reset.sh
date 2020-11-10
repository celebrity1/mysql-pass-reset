#!/bin/bash
# This is a bash snippet to quickly reset mysql/mariadb root password
# This software is release as it is, you agree to bea the liability
# that may arise from the use of this software.
echo "
_________        .__        ___.         .__  __          
\_   ___ \  ____ |  |   ____\_ |_________|__|/  |_ ___.__.
/    \  \/_/ __ \|  | _/ __ \| __ \_  __ \  \   __<   |  |
\     \___\  ___/|  |_\  ___/| \_\ \  | \/  ||  |  \___  |
 \______  /\___  >____/\___  >___  /__|  |__||__|  / ____|
        \/     \/          \/    \/                \/     
"
echo "Mysql/Mariadb password reset tool"

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  sudo su
fi

read -sp 'New Root Password: ' passvar

echo "Stopping Mysql service"

service mysql stop

#kill all mysql instance running
killall mysqld


mysqld_safe --skip-grant-tables &

sleep 5

mysql mysql -e "UPDATE user SET Password=PASSWORD('$passvar') WHERE User='$DB_ROOT_USER';FLUSH PRIVILEGES;"

service mysql stop

killall mysqld

service mysql start

echo "Root password reset done successfully"

exit

