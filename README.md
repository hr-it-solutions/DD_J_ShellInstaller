# DD_J_ShellInstaller
A shell script to install Joomla directly from the command line.

## Which steps are taken by the script
- Collect user inputs like Joomla version, installation directory etc.
- Get the Joomla you wished from the offical gitHub repository.
- Create installation directory where the installation should be placed.
- Unzip Joomla.
- Add jinstaller.sql a sql with custom querys to default joomla joomla.sql.
    - You can place your own sql querys to the jinstaller.sql which should be executed during installtion.
    - By default create SuperUser with Super user ACL is placed there.
- Collect user inputs like database host, username, password, prefixe etc.
- Installation Process for Database.
- Set and place configuration.php.
- Remove installation folder.

## Configuration
config.cfg (Set your own web directory path there)<br>
jinstaller.sql (Setup your querys which should be executed during installtion)
**NOTE:** Change the default SuperUser login details at jinstaller.sql. The default username is *admin* abd the password ist *adminpwd*

## To get it running
Just download and unzip this files to your servers shell script folder e.g. /bin etc..<br>
Setup the config.cfg.<br>
Adjust the jinstaller.sql

And run the script

    sh jinstaller.sh

That's all ;)

# DD_ Namespace
DD_ stands for  **D**idl**d**u e.K. | HR IT-Solutions (Brand recognition)                   <br>
It is a namespace prefix, provided to avoid element name conflicts.

<br>
Author: Didldu e.K. Florian Häusler https://www.hr-it-solution.com                          <br>
Copyright: (C) 2011 - 2017 Didldu e.K. | HR IT-Solutions                                    <br>
http://www.gnu.org/licenses/gpl-2.0.html GNU/GPLv2 only