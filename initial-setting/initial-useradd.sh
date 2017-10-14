#/bin/bash

########################
# - variable
#-----------------------

user1="stakamura"
PW1="stakamura"
gitacuser1="shou7sc"
gitmailuser1="shou7sc@yahoo.co.jp"
user2="skaneko"
PW2="skaneko"
gitacuser2="seinto1003"
gitmailuser2="seinto1003@gmail.com"
user3="kanon"
PW3="kanon"
gitacuser3="yadex205"
gitmailuser3="canon.kakuno@outlook.jp"
GIT_COM_HOSNAME="yadex205"
GIT_SSH_SECRET_KEY_NAME="id_rsa_kst_isucon7"
user3="isucon"
PW3="isucon"
gitacuser4="isucon-master"
gitmailuser4="isucon-master@example.co.jp"

########################

if [ "`id | grep root`" = "" ]
then
    echo "root de execute sitene!"
    exit 1
fi

if [ "`dpkg -l |grep expect`" = "" ]
then
    echo "expect install sitene!"
    echo "#------------------------------------------------------------------------"
    echo " apt-get -y install expect                                               "
    echo "#------------------------------------------------------------------------"
    exit 1
fi

ls /root/$GIT_SSH_SECRET_KEY_NAME

if [ $? = 0 ];then
    echo "#------------------------------------------------------------------------"
    echo " $GIT_SSH_SECRET_KEY が正常に /root に設置してあります \n"
    echo "#------------------------------------------------------------------------"
else
    echo "#------------------------------------------------------------------------"
    echo " GIT_SSH_SECRET_KEYが正常に /root に設置してありません。\n"
    echo " '/root'配下に$GIT_SSH_SECRET_KEY を設置して再度実行してください。\n"
    echo "#------------------------------------------------------------------------"
    exit 1
fi

#######################################################
# user1
########################################################

echo "#------------------------------------------------------------------------" &&
echo "# $user1を作成します" &&
echo "#------------------------------------------------------------------------" &&

expect -c "
set timeout 5
spawn adduser ${user1}
expect \"Enter new UNIX password:\"
send -- \"${PW1}\n\"
expect \"Retype new UNIX password:\"
send -- \"${PW1}\n\"
expect \"Full Name []:\"
send -- \"\n\"
expect \"Room Number []:\"
send -- \"\n\"
expect \"Work Phone []:\"
send -- \"\n\"
expect \"Home Phone []:\"
send -- \"\n\"
expect \"Other []:\"
send -- \"\n\"
expect \"Is the information correct?\"
send -- \"Y\n\"
expect \"$\"
exit 0
"
gpasswd -a "$user1" sudo

###############################################################
# ".ssh"ファイルを作成
###############################################################

echo "#------------------------------------------------------------------------" &&
echo "#.sshファイルを作成します" &&
echo "#------------------------------------------------------------------------" &&

cd /home/$user1/ &&
mkdir .ssh ; sleep 1s &&
sudo chown $user1:$user1 .ssh ; sleep 1s &&
chmod 700 .ssh ; sleep 1s &&
echo "#------------------------------------------------------------------------" &&
ls -al ".ssh" &&
echo "#------------------------------------------------------------------------" &&
echo "# drwx------ 2 $user1 $user1" &&
echo "#".ssh"ファイルが permission 700 own $user1:$user1 であること確認する " &&
echo "#------------------------------------------------------------------------" &&

###############################################################
# "GIT_SSH_SECRET"鍵を /home/$user1/.ssh/ に配布、権限付与
###############################################################

echo "#------------------------------------------------------------------------" &&
echo "#GIT_SSH_SECRET鍵を配布します " &&
echo "#------------------------------------------------------------------------" &&

cd .ssh &&
cp -ap /root/$GIT_SSH_SECRET_KEY_NAME /home/$user1/.ssh/ &&
sudo chown $user1:$user1 $GIT_SSH_SECRET_KEY_NAME ; sleep 1s &&
chmod 600 $GIT_SSH_SECRET_KEY_NAME ; sleep 1s &&
    ls -al $GIT_SSH_SECRET_KEY_NAME &&
    echo "#------------------------------------------------------------------------" &&
    echo "# $GIT_SSH_SECRET_KEY_NAME が permission 600 own $user1:$user1 であること確認する" &&
    echo "#------------------------------------------------------------------------" &&

###############################################################
# "config"作成 権限付与
###############################################################

echo "#------------------------------------------------------------------------" &&
echo "# config作成 及び 権限付与をします" &&
echo "#------------------------------------------------------------------------" &&

echo "Host git-$GIT_COM_HOSNAME" > config &&
echo " HostName github.com" >> config &&
echo " IdentityFile ~/.ssh/$GIT_SSH_SECRET_KEY_NAME" >> config &&
echo " User git" >> config &&
sudo chown $user1:$user1 config ; sleep 1s &&
chmod 600 config ; sleep 1s &&
ls -al config &&

echo "#------------------------------------------------------------------------" &&
echo "#"config"ファイルが permission 600 own $user1:$user1 であること確認する " &&
echo "#------------------------------------------------------------------------" &&

echo "#cat config" &&
cat config &&
echo "#------------------------------------------------------------------------" &&
echo "#"config"ファイルの設定が正しいことを確認する" &&
echo "#------------------------------------------------------------------------" &&

git config --global user.name "$gitacuser1" &&
git config --global user.email "$gitmailuser1"

#############################################################
# user2
############################################################

echo "#------------------------------------------------------------------------" &&
echo "# $user2を作成します" &&
echo "#------------------------------------------------------------------------" &&

expect -c "
set timeout 5
spawn adduser ${user2}
expect \"Enter new UNIX password:\"
send -- \"${PW2}\n\"
expect \"Retype new UNIX password:\"
send -- \"${PW2}\n\"
expect \"Full Name []:\"
send -- \"\n\"
expect \"Room Number []:\"
send -- \"\n\"
expect \"Work Phone []:\"
send -- \"\n\"
expect \"Home Phone []:\"
send -- \"\n\"
expect \"Other []:\"
send -- \"\n\"
expect \"Is the information correct?\"
send -- \"Y\n\"
expect \"$\"
exit 0
"
gpasswd -a "$user2" sudo

###############################################################
# ".ssh"ファイルを作成
###############################################################

echo "#------------------------------------------------------------------------" &&
echo "#.sshファイルを作成します" &&
echo "#------------------------------------------------------------------------" &&

cd /home/$user2/ &&
mkdir .ssh ; sleep 1s &&
sudo chown $user2:$user2 .ssh ; sleep 1s &&
chmod 700 .ssh ; sleep 1s &&
echo "#------------------------------------------------------------------------" &&
ls -al ".ssh" &&
echo "#------------------------------------------------------------------------" &&
echo "# drwx------ 2 $user2 $user2" &&
echo "#".ssh"ファイルが permission 700 own $user2:$user2 であること確認する " &&
echo "#------------------------------------------------------------------------" &&

###############################################################
# "GIT_SSH_SECRET"鍵を /home/$user2/.ssh/ に配布、権限付与
###############################################################

echo "#------------------------------------------------------------------------" &&
echo "#GIT_SSH_SECRET鍵を配布します " &&
echo "#------------------------------------------------------------------------" &&

cd .ssh &&
cp -ap /root/$GIT_SSH_SECRET_KEY_NAME /home/$user2/.ssh/ &&
sudo chown $user2:$user2 $GIT_SSH_SECRET_KEY_NAME ; sleep 1s &&
chmod 600 $GIT_SSH_SECRET_KEY_NAME ; sleep 1s &&
    ls -al $GIT_SSH_SECRET_KEY_NAME &&
    echo "#------------------------------------------------------------------------" &&
    echo "# $GIT_SSH_SECRET_KEY_NAME が permission 600 own $user2:$user2 であること確認する" &&
    echo "#------------------------------------------------------------------------" &&

###############################################################
# "config"作成 権限付与
###############################################################

echo "#------------------------------------------------------------------------" &&
echo "# config作成 及び 権限付与をします" &&
echo "#------------------------------------------------------------------------" &&

echo "Host git-$GIT_COM_HOSNAME" > config &&
echo " HostName github.com" >> config &&
echo " IdentityFile ~/.ssh/$GIT_SSH_SECRET_KEY_NAME" >> config &&
echo " User git" >> config &&
sudo chown $user2:$user2 config ; sleep 1s &&
chmod 600 config ; sleep 1s &&
ls -al config &&

echo "#------------------------------------------------------------------------" &&
echo "#"config"ファイルが permission 600 own $user2:$user2 であること確認する " &&
echo "#------------------------------------------------------------------------" &&

echo "#cat config" &&
cat config &&
echo "#------------------------------------------------------------------------" &&
echo "#"config"ファイルの設定が正しいことを確認する" &&
echo "#------------------------------------------------------------------------" &&

git config --global user.name "$gitacuser2" &&
git config --global user.email "$gitmailuser2"

############################################################
# user3
############################################################

echo "#------------------------------------------------------------------------" &&
echo "# $user3を作成します" &&
echo "#------------------------------------------------------------------------" &&


expect -c "
set timeout 5
spawn adduser ${user3}
expect \"Enter new UNIX password:\"
send -- \"${PW3}\n\"
expect \"Retype new UNIX password:\"
send -- \"${PW3}\n\"
expect \"Full Name []:\"
send -- \"\n\"
expect \"Room Number []:\"
send -- \"\n\"
expect \"Work Phone []:\"
send -- \"\n\"
expect \"Home Phone []:\"
send -- \"\n\"
expect \"Other []:\"
send -- \"\n\"
expect \"Is the information correct?\"
send -- \"Y\n\"
expect \"$\"
exit 0
"
gpasswd -a "$user3" sudo

###############################################################
# ".ssh"ファイルを作成
###############################################################

echo "#------------------------------------------------------------------------" &&
echo "#.sshファイルを作成します" &&
echo "#------------------------------------------------------------------------" &&

cd /home/$user3/ &&
mkdir .ssh ; sleep 1s &&
sudo chown $user3:$user3 .ssh ; sleep 1s &&
chmod 700 .ssh ; sleep 1s &&
echo "#------------------------------------------------------------------------" &&
ls -al ".ssh" &&
echo "#------------------------------------------------------------------------" &&
echo "# drwx------ 2 $user3 $user3" &&
echo "#".ssh"ファイルが permission 700 own $user3:$user3 であること確認する " &&
echo "#------------------------------------------------------------------------" &&

###############################################################
# "GIT_SSH_SECRET"鍵を /home/$user3/.ssh/ に配布、権限付与
###############################################################

echo "#------------------------------------------------------------------------" &&
echo "#GIT_SSH_SECRET鍵を配布します " &&
echo "#------------------------------------------------------------------------" &&

cd .ssh &&
cp -ap /root/$GIT_SSH_SECRET_KEY_NAME /home/$user3/.ssh/ &&
sudo chown $user3:$user3 $GIT_SSH_SECRET_KEY_NAME ; sleep 1s &&
chmod 600 $GIT_SSH_SECRET_KEY_NAME ; sleep 1s &&
    ls -al $GIT_SSH_SECRET_KEY_NAME &&
    echo "#------------------------------------------------------------------------" &&
    echo "# $GIT_SSH_SECRET_KEY_NAME が permission 600 own $user3:$user3 であること確認する" &&
    echo "#------------------------------------------------------------------------" &&

###############################################################
# "config"作成 権限付与
###############################################################

echo "#------------------------------------------------------------------------" &&
echo "# config作成 及び 権限付与をします" &&
echo "#------------------------------------------------------------------------" &&

echo "Host git-$GIT_COM_HOSNAME" > config &&
echo " HostName github.com" >> config &&
echo " IdentityFile ~/.ssh/$GIT_SSH_SECRET_KEY_NAME" >> config &&
echo " User git" >> config &&
sudo chown $user3:$user3 config ; sleep 1s &&
chmod 600 config ; sleep 1s &&
ls -al config &&

echo "#------------------------------------------------------------------------" &&
echo "#"config"ファイルが permission 600 own $user3:$user3 であること確認する " &&
echo "#------------------------------------------------------------------------" &&

echo "#cat config" &&
cat config &&
echo "#------------------------------------------------------------------------" &&
echo "#"config"ファイルの設定が正しいことを確認する" &&
echo "#------------------------------------------------------------------------" 

git config --global user.name "$gitacuser3" &&
git config --global user.email "$gitmailuser3"

############################################################

$user4

############################################################

###############################################################
# ".ssh"ファイルを作成
###############################################################

echo "#------------------------------------------------------------------------" &&
echo "#.sshファイルを作成します" &&
echo "#------------------------------------------------------------------------" &&

cd /home/$user4/ &&
mkdir .ssh ; sleep 1s &&
sudo chown $user4:$user4 .ssh ; sleep 1s &&
chmod 700 .ssh ; sleep 1s &&
echo "#------------------------------------------------------------------------" &&
ls -al ".ssh" &&
echo "#------------------------------------------------------------------------" &&
echo "# drwx------ 2 $user4 $user4" &&
echo "#".ssh"ファイルが permission 700 own $user4:$user4 であること確認する " &&
echo "#------------------------------------------------------------------------" &&

###############################################################
# "GIT_SSH_SECRET"鍵を /home/$user3/.ssh/ に配布、権限付与
###############################################################

echo "#------------------------------------------------------------------------" &&
echo "#GIT_SSH_SECRET鍵を配布します " &&
echo "#------------------------------------------------------------------------" &&

cd .ssh &&
cp -ap /root/$GIT_SSH_SECRET_KEY_NAME /home/$user4/.ssh/ &&
sudo chown $user4:$user4 $GIT_SSH_SECRET_KEY_NAME ; sleep 1s &&
chmod 600 $GIT_SSH_SECRET_KEY_NAME ; sleep 1s &&
    ls -al $GIT_SSH_SECRET_KEY_NAME &&
    echo "#------------------------------------------------------------------------" &&
    echo "# $GIT_SSH_SECRET_KEY_NAME が permission 600 own $user4:$user4 であること確認する" &&
    echo "#------------------------------------------------------------------------" &&

###############################################################
# "config"作成 権限付与
###############################################################

echo "#------------------------------------------------------------------------" &&
echo "# config作成 及び 権限付与をします" &&
echo "#------------------------------------------------------------------------" &&

echo "Host git-$GIT_COM_HOSNAME" > config &&
echo " HostName github.com" >> config &&
echo " IdentityFile ~/.ssh/$GIT_SSH_SECRET_KEY_NAME" >> config &&
echo " User git" >> config &&
sudo chown $user4:$user4 config ; sleep 1s &&
chmod 600 config ; sleep 1s &&
ls -al config &&

echo "#------------------------------------------------------------------------" &&
echo "#"config"ファイルが permission 600 own $user4:$user4 であること確認する " &&
echo "#------------------------------------------------------------------------" &&

echo "#cat config" &&
cat config &&
echo "#------------------------------------------------------------------------" &&
echo "#"config"ファイルの設定が正しいことを確認する" &&
echo "#------------------------------------------------------------------------" 

git config --global user.name "$gitacuser4" &&
git config --global user.email "$gitmailuser4"
