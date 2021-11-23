#!/bin/bash
#Author: Raul Ricardo Santos Ruiz
#Student-ID: 1989971
RED='\033[0;31m'
NC='\033[0m'

#Script should be able to identify if the OS is CentOS v7 or CentOS v8


version=$(grep '^VERSION_ID' /etc/os-release)
#echo $version

if [[ $version = 'VERSION_ID="8"' ]] ;
then
  echo -e "${RED}Your OS version is CentOS v8${NC}"

elif [[ $version = 'VERSION_ID="7"' ]] ;
then
  echo -e "${RED}Your OS version is  CentOS v7${NC}"
fi

#Script should install clamav antivirus. If the antivirus is already installed or running, the script should sop and uninstall the software before it installs a fresh one

yum list -q installed > lista

condicionclamav=$(grep '^clamav' lista)
echo $condicionclamav

if [[ $condicionclamav = "" ]];
then
  echo -e "${RED}ClamAV AntiVirus is not installed in your system. The installation is going to begin${NC}"
  yum -y install clamav
  echo -e "${RED}ClamAV succesfully installed!${NC}"
else
  echo -e "${RED}ClamAV is already installed in the system. It will now be erased and installed again with a fresher version${NC}"
  yum -y erase clamav*
  echo -e "${RED}ClamAV succesfully erased. The new installation with a fresher version is going to begin${NC}"
  yum -y install clamav
  echo -e "${RED}ClamAV succesfully installed with a fresher version!${NC}"
fi

#Script should install EPEL repositories only for CentOS v7 servers

if [[ $version = 'VERSION_ID="7"' ]];
then
  echo -e "${RED}As your OS version is CentOS 7, the installation of EPEL will now begin.${NC}"
  yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
echo -e "${RED}EPEL succesfully installed!${NC}"
fi

#Script should be capable to update all packages having an available update in the repositories

updates=$(yum check-update)
echo $updates

if [[ $updates = "" ]];
then
  echo -e "${RED}There are not packages that need an update ${NC}"
else
  echo -e "${RED}The packages that need an update are:"
  echo -e "$updates ${NC}"
  yum -y update
fi
exit 0