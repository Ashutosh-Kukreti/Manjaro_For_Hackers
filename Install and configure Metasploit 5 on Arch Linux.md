# HOW TO INSTALL METASPLOIT ON ARCH LINUX ?

The Metasploit Framework is already present in the Arch repository, but without additional preparation, it will not work properly. Metasploit requires Ruby along with PostgreSQL on the target system to work.

Update the System

The first thing to do is to update your system to be sure that all packages are installed to the latest version.

>sudo pacman -Syyu

Install Ruby

When you are ready you can now install the necessary Ruby packages using the below command.

>sudo pacman -S ruby ruby-rdoc

Install RVM

We will now install and setup RVM on our target system. Before moving further, I highly recommended you to visit the Metasploit Github Repository to check which version of Ruby is required by the framework. At the time I write this tutorial, Metasploit currently requires the version 2.6.6, but you will need to check it before to proceed.

>gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

>wget -O /tmp/rvm.sh https://get.rvm.io

>cd /tmp/

>bash rvm.sh stable

>echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc

>source ~/.rvm/scripts/rvm

>rvm install 2.6.6

>rvm use 2.6.6 --default

Install PostgreSQL

Metasploit can be used without a database, but cache operations like searching would be very slow. This section shows how to set up Metasploit with Postgresql database server. To do it, simply use the below commands.

>sudo pacman -S postgresql --noconfirm --needed

>sudo chown -R postgres:postgres /var/lib/postgres/

>sudo -Hiu postgres initdb --locale en_US.UTF-8 -E UTF8 -D '/var/lib/postgres/data'

>sudo systemctl start postgresql

>sudo systemctl enable postgresql

Create PostgreSQL User and Database

It's now time to create our PostgreSQL user and database. As you can see below, we will create a user named msf and a database named also msf. You can change it to whatever you want as long you also modify the database.yml as described in the below Clone Metasploit section. When you are prompted, enter the password you wish to create with your database. I choose to also use msf as the password to make everything easier.

>sudo -Hiu postgres createuser msf -P -S -R -D

>sudo -Hiu postgres createdb -O msf msf

Clone Metasploit

We did a lot already ! Next we will clone the Metasploit Framework from Github and configure it. As you can see below, we are creating a file called database.yml, in which we need to specify our database name, username, and password as created in the previous step.

>cd /opt/

>sudo git clone https://github.com/rapid7/metasploit-framework metasploit

>cd /opt/metasploit/

>gem install wirble sqlite3 bundler

>bundle install

>sudo touch /opt/metasploit/config/database.yml

>echo 'production:' | sudo tee -a /opt/metasploit/config/database.yml

>echo ' adapter: postgresql' | sudo tee -a /opt/metasploit/config/database.yml

>echo ' database: msf' | sudo tee -a /opt/metasploit/config/database.yml

>echo ' username: msf' | sudo tee -a /opt/metasploit/config/database.yml

>echo ' password: msf' | sudo tee -a /opt/metasploit/config/database.yml

>echo ' host: 127.0.0.1' | sudo tee -a /opt/metasploit/config/database.yml

>echo ' port: 5432' | sudo tee -a /opt/metasploit/config/database.yml

>echo ' pool: 75' | sudo tee -a /opt/metasploit/config/database.yml

>echo ' timeout: 5' | sudo tee -a /opt/metasploit/config/database.yml

>sudo sh -c "echo export MSF_DATABASE_CONFIG=/opt/metasploit/config/database.yml >> /etc/profile"

>sudo chown -R $USER:users /opt/metasploit

Launch Metasploit Framework

We are done with the installation of the Metasploit Framework. You can test it immediately using the below command.

>cd /opt/metasploit/

>./msfconsole

**Source: cybsploit.com**
