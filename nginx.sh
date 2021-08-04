#!/bin/bash
origfold=$PWD
baseurl="https://asn.ipinfo.app/api/download/nginx/AS"
nginx_conf="/etc/nginx/conf"
# modify this and point to your nginx
# 将其修改为nginx的配置文件路径
# これをNginxセッティングファイルのパスに指定
# Edit this list before use
# 使用之前先修改
# 使う前にこれを編集します
asnlist="13335
1234
12345"
if [ "$1" == "--delall" ]; then
    for i in $asnlist;
    do
        echo "" >$nginx_conf/asnblock$i.conf
    done
elif [ "$1" == "-d" ]; then
    echo "" >$nginx_conf/asnblock$2.conf
    /usr/bin/nginx -s reload
elif [ "$1" == "-a" ]; then
    wget -qO "$nginx_conf/asnblock$2.conf" "$baseurl$2"
    /usr/bin/nginx -s reload
else
    rm -rf $nginx_conf/asnblock*.conf
    for i in $asnlist;
    do
        wget -qO "$nginx_conf/asnblock$i.conf" "$baseurl$i"
        echo "AS$i has been banned!"
    done
fi
/usr/bin/nginx -s reload
# return to original folder
# 返回原文件夹
# 元のフォルダに戻る
cd $origfold
exit 0
