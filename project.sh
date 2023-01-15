!#/bin/bash
sudo apt update -y
#------Apache Installation Check-------
Required_PKG="apache2"
PKG_OK=$(dpkg-query -W --showformat='${status}\n' $Required_PKG | grep "install ok installed")
if [ "" = "$PKG_OK" ]
then
        echo "Apache is not available. Installing the Apache"
        sudo apt install apache2 -y
        echo "Apache Installed"
else
        echo "Apache is alreday installed"

fi
#--------------------------------------
#------Apache Installation Check-------
Required_PKG1="awscli"
PKG1_OK=$(dpkg-query -W --showformat='${status}\n' $Required_PKG1 | grep "install ok installed")
if [ "" = "$PKG1_OK" ]
then
        echo "awscli is not available. Installing the awscli"
        sudo apt install awscli
        echo "awscli Installed"
else
        echo "awscli is alreday installed"

fi
#--------------------------------------
if [ `service apache2 status | grep running | wc -l` == 1 ]
then
        echo "apache2 service running"
else
        sudo service apache2 start
        echo "service started now"

fi

#--To check for enabled apache2

if [ `service apache2 status | grep enabled | wc -l` == 1 ]
then
        echo "apache2 is enabled"
else
        sudo systemctl enable apache2
        echo "service enabled now"
fi

 timestamp=$(date '+%d%m%Y-%H%M%S')
cd /var/log/apache2/
tar -cvf /tmp/puneeth-httpd-logs-$(15%01%2023-11:07:00).tar *.log
aws s3 ls
aws s3 cp /tmp/puneeth-httpd-logs-$(15%01%2023-11:07:00).tar
s3://$(ndrinfotech-puneeth)/$(puneeth)-httpd-logs-$(15%01%2023-11:07:00).tar
