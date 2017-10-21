#!/bin/bash

####################################################
# - variable
#---------------------------------------------------

user1="isucon"
PW1="isucon"
gitacuser1="isucon-master"
gitmailuser1="isucon-master@example.co.jp"
GIT_COM_HOSNAME="yadex205"
GIT_SSH_SECRET_KEY_NAME="id_rsa_kst_isucon7"

#####################################################
#
#
# 0.initial - checking
#
#
#####################################################

if [ "`id | grep root`" = "" ]
then
    echo "root de execute sitene!"
    exit 1
fi

echo "------------------------------------------------------------------------" 
echo "                                                                        "
echo "                                                                        "
echo " 0-1./root/$GIT_SSH_SECRET_KEY_NAME が設置されているか確認します        " 
echo "                                                                        "
echo "                                                                        "
echo "------------------------------------------------------------------------" ; sleep 2

ls /root/$GIT_SSH_SECRET_KEY_NAME 

if [ $? = 0 ];then
    echo "------------------------------------------------------------------------"
    echo "                                                                        "
    echo "                                                                        "
    echo -e " [result]  === \033[0;32msuccess\033[0;39m                           "
    echo " $GIT_SSH_SECRET_KEY が正常に /root に設置してあります                  "
    echo "                                                                        "
    echo "                                                                        "
    echo "------------------------------------------------------------------------" ; sleep 2
else
    echo "-------------------------------------------------------------------------"
    echo "                                                                         "
    echo "                                                                         "
    echo -e " [result]  === \033[0;31mfail\033[0;39m                               "
    echo " $GIT_SSH_SECRET_KEY が正常に /root に設置してありません。               "
    echo " '/root'配下に$GIT_SSH_SECRET_KEY を設置して再度実行してください。       "
    echo "                                                                         "
    echo "                                                                         "
    echo "-------------------------------------------------------------------------"
    exit 1
fi

echo "------------------------------------------------------------------------" 
echo "                                                                        "
echo " 0-2 $user1 が存在するか確認します                                          " 
echo "                                                                        "
echo "------------------------------------------------------------------------" ; sleep 2

grep -w "$user1" /etc/passwd

if [ $? = 0 ];then
    echo "------------------------------------------------------------------------"
    echo "                                                                        "
    echo "                                                                        "
    echo -e " [result]  === \033[0;32msuccess\033[0;39m                           "
    echo " $user1 が存在します。各種設定を実行していきます.......                 "
    echo "                                                                        "
    echo "                                                                        "
    echo "------------------------------------------------------------------------" ; sleep 2
else
    echo "-------------------------------------------------------------------------"
    echo "                                                                         "
    echo "                                                                         "
    echo -e " [result]  === \033[0;31mfail\033[0;39m                               "
    echo " $user1 が存在しません。                                                 "
    echo " 再度実行してください。                                                  "
    echo "                                                                         "
    echo "                                                                         "
    echo "-------------------------------------------------------------------------"
    exit 1
fi

#######################################################
#
# 1.$user1にsudo権限を付与します
#
#######################################################

echo "------------------------------------------------------------------------" 
echo "                                                                        "
echo " 1.$user1 のsudo権限を付与します                                         " 
echo "                                                                        "
echo "------------------------------------------------------------------------" ; sleep 2

gpasswd -a "$user1" sudo
getent group |grep sudo

if [ $? = 0 ];then
    echo "                                                                        "
    echo "                                                                        "
    echo -e " [result]  === \033[0;32msuccess\033[0;39m                           "
    echo "                                                                        "
    echo " $user1の sudo権限が正常にを付与されました..                            "
    echo "                                                                        "
    echo "------------------------------------------------------------------------" ; sleep 2
else
    echo "                                                                        "
    echo "                                                                        "
    echo -e " [result]  === \033[0;31mfail\033[0;39m                              "
    echo "                                                                        "
    echo " $user1 にsudo権限を付与できませんでした..                              "
    echo " 再度実行してください。                                                 "
    echo "                                                                        "
    echo "------------------------------------------------------------------------"
    exit 1
fi

#######################################################
#
# 2.$user1の .sshファイルを作成します
#
#######################################################

echo "------------------------------------------------------------------------" 
echo "                                                                        "
echo " 2.$user1 の.sshファイルを作成します                                     " 
echo "                                                                        "
echo "------------------------------------------------------------------------" ; sleep 2

cd /home/$user1/ &&
mkdir .ssh ; sleep 1s &&
sudo chown $user1:$user1 .ssh ; sleep 1s &&
chmod 700 .ssh ; sleep 1s 

echo "------------------------------------------------------------------------" 

ls -al ".ssh" 

if [ $? = 0 ];then
    echo "------------------------------------------------------------------------" 
    echo "                                                                        "
    echo "                                                                        "
    echo -e " [result]  === \033[0;32msuccess\033[0;39m                           "
    echo "                                                                        "
    echo " $user1 の.ssh/ファイルが正常に作成されました                           "
    echo "                                                                        "
    echo "------------------------------------------------------------------------" ; sleep 2
else
    echo "------------------------------------------------------------------------" 
    echo "                                                                        "
    echo "                                                                        "
    echo -e " [result]  === \033[0;31mfail\033[0;39m                              "
    echo " $user1 の.ssh/ファイルが作成されませんでした。                         "
    echo " 再度実行してください。                                                 "
    echo "                                                                        "
    echo "------------------------------------------------------------------------" 
    exit 1
fi

########################################################################
#
# 3."GIT_SSH_SECRET"鍵を /home/$user1/.ssh/ に配布、権限付与
#
#########################################################################

echo "------------------------------------------------------------------------" 
echo "                                                                        "
echo " 3.GIT_SSH_SECRET鍵を配布します。                                       " 
echo "                                                                        "
echo "------------------------------------------------------------------------" 

cd .ssh &&
cp -ap /root/$GIT_SSH_SECRET_KEY_NAME /home/$user1/.ssh/ 
sudo chown $user1:$user1 $GIT_SSH_SECRET_KEY_NAME ; sleep 1s 
chmod 600 $GIT_SSH_SECRET_KEY_NAME ; sleep 1s 

ls -al $GIT_SSH_SECRET_KEY_NAME 

if [ $? = 0 ];then
    echo "------------------------------------------------------------------------" 
    echo "                                                                        "
    echo "                                                                        "
    echo -e " [result]  === \033[0;32msuccess\033[0;39m                           "
    echo " $user1 の.ssh/配下に $GIT_SSH_SECRET_KEY_NAME が正常に配布されました   "
    echo " $GIT_SSH_SECRET_KEY_NAME が permission 600 own $user1:$user1 であること確認しましょう"
    echo "                                                                        "
    echo "                                                                        "
    echo "------------------------------------------------------------------------" ;sleep 2
else
    echo "------------------------------------------------------------------------" 
    echo "                                                                        "
    echo "                                                                        "
    echo -e " [result]  === \033[0;31mfail\033[0;39m                              "
    echo " $user1 の.ssh/配下に $GIT_SSH_SECRET_KEY_NAME が正常に配布されませんでした。"
    echo " 再度実行してください。                                                 "
    echo "                                                                        "
    echo "                                                                        "
    echo "------------------------------------------------------------------------"
    exit 1
fi

########################################################################
#
# 4.Gitにユーザー名とE-mailアドレスを設定します。
#
#########################################################################

echo "------------------------------------------------------------------------" 
echo "                                                                        "
echo "                                                                        "
echo "4.Gitにユーザー名とE-mailアドレスを設定します。" 
echo "                                                                        "
echo "                                                                        "
echo "------------------------------------------------------------------------" ;sleep 2

git config --global user.name "$gitacuser1" 
git config --global user.email "$gitmailuser1"

if [ $? = 0 ];then
    git config --list
    echo "------------------------------------------------------------------------" 
    echo "                                                                        "
    echo "                                                                        "
    echo -e " [result]  === \033[0;32msuccess\033[0;39m                           "
    echo " Gitに正常にユーザー名とE-mailアドレスを設定されました。                "
    echo "                                                                        "
    echo "                                                                        "
    echo "------------------------------------------------------------------------" ;sleep 2
else
    git config --list
    echo "------------------------------------------------------------------------" 
    echo "                                                                        "
    echo "                                                                        "
    echo -e " [result]  === \033[0;31mfail\033[0;39m                              "
    echo " Gitに正常にユーザー名とE-mailアドレスを設定されませんでした。          "
    echo " 再度実行してください。                                                 "
    echo "                                                                        "
    echo "                                                                        "
    echo "------------------------------------------------------------------------" 
    exit 1
fi

########################################################################
#
# 5."config"ファイルを作成、権限付与します。
#
#########################################################################

echo "------------------------------------------------------------------------" 
echo "                                                                        "
echo "5."config"ファイルを作成、権限付与します。                              " 
echo "                                                                        "
echo "------------------------------------------------------------------------" ;sleep 2

cd /home/$user1/.ssh/ &&
echo "Host git-$GIT_COM_HOSNAME" > config &&
echo " HostName github.com" >> config &&
echo " IdentityFile ~/.ssh/$GIT_SSH_SECRET_KEY_NAME" >> config &&
echo " User git" >> config &&
sudo chown $user1:$user1 config ; sleep 1s 
chmod 600 config ; sleep 1s 

if [ $? = 0 ];then
    cat config 
    echo "------------------------------------------------------------------------" 
    echo "                                                                        "
    echo "                                                                        "
    echo -e " [result]  === \033[0;32msuccess\033[0;39m                           "
    echo " git configファイルが正常に設定されました。                             "
    echo "                                                                        "
    echo "                                                                        "
    echo "------------------------------------------------------------------------" ;sleep 2
else
    cat config 
    echo "------------------------------------------------------------------------" 
    echo "                                                                        "
    echo "                                                                        "
    echo -e " [result]  === \033[0;31mfail\033[0;39m                              "
    echo " git configファイルが正常に設定されませんでした。                       "
    echo " 再度実行してください。                                                 "
    echo "                                                                        "
    echo "                                                                        "
    echo "------------------------------------------------------------------------" 
    exit 1
fi