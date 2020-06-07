#! /bin/bash 
#A simple bash script to install most used penetration testing and hacking tools on Manjaro Linux.
#colors used in script:
#1 red
#3 yellow
#7 white
#tput setaf [1-7] - Set the foreground colour using ANSI escape
#tput sgr0 - Reset text format to the terminal's default

echo -e "$(tput setaf 7)Following tools will be installed$(tput sgr 0)\n"

echo "$(tput setaf 3)1. Nmap"
echo "2. Metasploit"
echo "3. Wireshark"
echo "4. wifite2"
echo "5. aircrack-ng"
echo "6. OWASP ZAP (Zed Attack Proxy)"
echo "7. Burpsuite $(tput sgr 0)"

echo -e "\n$(tput setaf 1)Please make sure AUR (ARCH User Repositry) is enabled on your system" 

echo -e "\n$(tput setaf 7)Note1:$(tput setaf 1) You will need to setup Metasploit database manually$(tput sgr 0)"
echo -e "$(tput setaf 7)Note2:$(tput setaf 1) Neither I'm the creater nor the maintainer of these tools$(tput sgr 0)\n"
 
all=(nmap wireshark-qt aircrack-ng zaproxy) #burpsuite wifite2-git

echo -e "$(tput setaf 3)Installing \n$(tput setaf 7)${all[@]}$(tput sgr 0)"
pamac install ${all[@]}

echo -e "\n$(tput setaf 3)Installing Metasploit$(tput sgr 0)"
pamac install metasploit

echo -e "$(tput setaf 7)\nVisit the following link to learn how to setup Metasploit database on Manajro linux:$(tput setaf 3)\nhttps://cybsploit.com/2020/04/20/how-to-install-metasploit-5-and-armitage-on-arch-linux-YmNkZ0RrTU56QTVkQ0RnN1pIaFNIUT09$(tput sgr 0)"

echo -e "\n$(tput setaf 1)Installing following tools from AUR(ARCH User Repo):\n$(tput setaf 7)wifite2 burpsuite$(tput sgr 0)\n"
#read -p is used to take input from the use in variable called 'var'
read -p 'Do you want to continue with the installation [Y/N] : ' var
# Below is an if else check so that if the user enter 'Y' then programs should be installed
if [ "$var" = "Y" ]
then
pamac install wifite2-git
echo -e "\n$(tput setaf 7)Run wifite using following command >$(tput setaf 3)sudo wifite2\n$(tput sgr 0)"
pamac install burpsuite
echo -e "\n$(tput setaf 7)Installation complete.$(tput sgr 0)"
exit
fi
echo -e "\n$(tput setaf 7)Installation complete.$(tput sgr 0)"
