#! /bin/bash 
#A simple bash script to install most used penetration testing and hacking tools on Manjaro Linux.
#colors used in script:
#1 red
#3 yellow
#7 white
#tput setaf [1-7] - Set the foreground colour using ANSI escape
#tput sgr0 - Reset text format to the terminal's default
# Through out the script case command is used for Yes/No prompt

echo -e "$(tput setaf 7)Following tools will be installed$(tput sgr 0)\n"

echo "$(tput setaf 3)1. Nmap"
echo "2. Metasploit"
echo "3. Wireshark"
echo "4. wifite2"
echo "5. aircrack-ng"
echo "6. OWASP ZAP (Zed Attack Proxy)"
echo "7. Burpsuite $(tput sgr 0)"

#Printing important requirements of the script
echo -e "\n$(tput setaf 1)Please make sure AUR (ARCH User Repositry) is enabled on your system" 

echo -e "\n$(tput setaf 7)Note1:$(tput setaf 1) You will need to setup Metasploit database manually if the script does not work$(tput sgr 0)"
echo -e "$(tput setaf 7)Note2:$(tput setaf 1) Neither I'm the creater nor the maintainer of these tools$(tput sgr 0)\n"

#taking user's permission for starting the script
read -p "$(tput setaf 7)Do you want to continue [Y/n] : $(tput sgr 0)" input1
case  $input1 in
        [yY][eE][sS]|[yY])

# creating a variable 's_tools' to install some tools
s_tools=(nmap wireshark-qt aircrack-ng zaproxy) 
#Installing tools defined in 's_toolsl'
echo -e "\n$(tput setaf 3)Installing \n$(tput setaf 7)${s_tools[@]}$(tput sgr 0)\n"
pamac install ${s_tools[@]}

;;
        [nN][oO]|[nN])
echo -e "$(tput setaf 7)\nExiting Script$(tput sgr 0)"
exit
;;
*)
esac

#Fixing ugly fonts in Java apps
echo -e "$(tput setaf 7)\nDo you want to enable anti-aliasing of font in JAVA Apps (like ZAP,Burp) for better font rendering? "
read -p "[Yes/no] : $(tput sgr 0)" userinput
case $userinput in
#input variable  will accept small y or Y or Yes or yes
    [yY][eE][sS]|[yY])
echo -e "$(tput setaf 3)\nEditing $(tput setaf 1)/etc/environment$(tput setaf 3) and adding variable$(tput setaf 7)"
echo "_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'" | sudo tee -a /etc/environment
echo -e "$(tput setaf 1)\nReboot is required for changes to take place.$(tput sgr 0)"
 ;;
 #input variable will accept n or N or No or no
    [nN][oO]|[nN])
;;
*)
esac

#Metasploit installation and configuration
echo -e "\n$(tput setaf 3)Installing Metasploit$(tput sgr 0)"
pamac install metasploit
echo -e "\n$(tput setaf 7)Do you want to configure metasploit database automatically"
read -p "[Y/n] : $(tput sgr 0)" var1
case  $var1 in
        [yY][eE][sS]|[yY])
echo -e "$(tput setaf 1)Use Internet to troubleshoot the errors$(tput sgr 0)"
echo -e "\n$(tput setaf 3)Installing and configuring PostgreSQL$(tput setaf 1)-requires root$(tput sgr 0)"
sudo pacman -S postgresql --noconfirm --needed
sudo chown -R postgres:postgres /var/lib/postgres/
sudo -Hiu postgres initdb --locale en_US.UTF-8 -E UTF8 -D '/var/lib/postgres/data'
sudo systemctl start postgresql
sudo systemctl enable postgresql

echo -e "$(tput setaf 3)\nCreating PostgreSQL User and Database$(tput sgr 0)"
sudo -Hiu postgres createuser msf -P -S -R -D
sudo -Hiu postgres createdb -O msf msf

echo -e "$(tput setaf 3)\nCreating and configuring Metasploit database$(tput sgr 0)"

cd /opt/metasploit/
sudo touch /opt/metasploit/config/database.yml
echo 'production:' | sudo tee -a /opt/metasploit/config/database.yml
echo ' adapter: postgresql' | sudo tee -a /opt/metasploit/config/database.yml
echo ' database: msf' | sudo tee -a /opt/metasploit/config/database.yml
echo ' username: msf' | sudo tee -a /opt/metasploit/config/database.yml
echo ' password: msf' | sudo tee -a /opt/metasploit/config/database.yml
echo ' host: 127.0.0.1' | sudo tee -a /opt/metasploit/config/database.yml
echo ' port: 5432' | sudo tee -a /opt/metasploit/config/database.yml
echo ' pool: 75' | sudo tee -a /opt/metasploit/config/database.yml
echo ' timeout: 5' | sudo tee -a /opt/metasploit/config/database.yml
sudo sh -c "echo export MSF_DATABASE_CONFIG=/opt/metasploit/config/database.yml >> /etc/profile"
sudo chown -R $USER:users /opt/metasploit
cd ~
echo -e "\n$(tput setaf 7)Database created sucessfully$(tput sgr 0)\n"
echo -e "\n$(tput setaf 3)Priniting Database Information$(tput sgr 0)\n"
cat /opt/metasploit/config/database.yml
echo -e "\n$(tput setaf 7)Special thanks to cybsploit.com for the commands$(tput sgr 0)"
;;
        [nN][oO]|[nN])
;;
*)
esac

echo -e "$(tput setaf 7)\nVisit the following link to learn how to setup Metasploit database on Manajro linux:$(tput setaf 3)\nhttps://cybsploit.com/2020/04/20/how-to-install-metasploit-5-and-armitage-on-arch-linux-YmNkZ0RrTU56QTVkQ0RnN1pIaFNIUT09$(tput sgr 0)"

#User permissions for installing tools from AUR
echo -e "\n$(tput setaf 1)Installing following tools from AUR(ARCH User Repo):\n$(tput setaf 7)wifite2 burpsuite$(tput sgr 0)"
#read -p is used to take input from the use in variable called 'var2'
echo -e "\n$(tput setaf 7)Do you want to continue with the installation" 
read -p "[Y/n] : $(tput sgr 0) " var2

case  $var2 in
        [yY][eE][sS]|[yY])
pamac install wifite2-git
echo -e "\n$(tput setaf 7)Run wifite using following command >$(tput setaf 3)sudo wifite2\n$(tput sgr 0)"
pamac install burpsuite
echo -e "\n$(tput setaf 7)Installation complete.$(tput sgr 0)"
exit
;;
        [nN][oO]|[nN])
;;
*)
esac

echo -e "\n$(tput setaf 7)Installation complete.$(tput sgr 0)"

