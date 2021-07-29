#!/bin/bash
origfold=$PWD
# Record original Folder 
# 记录执行时的文件夹路径 
# 元のフォルダを記録する
baseurl="https://asn.ipinfo.app/api/download/ipset/AS"
# Edit this list before use
# 使用之前修改该列表
# 使う前にこのリストを編集します。
asnlist="123456
12345
1234"
# You must not input 13335, Because that url is using CloudFlare! the script will down!
# 绝对不要屏蔽13335,因为这个url是使用CloudFlare的！这样做会导致脚本失效！
# 絶対に13335を入力するな！このurlはCloudFlareを使っています。それならスクリプトが使えないです。
if [ "$1" == "--delall" ]; then
    for i in $asnlist;
    do
        iptables -D INPUT -m set --match-set "$i-4" src -j DROP 2>&1>/dev/null
        ip6tables -D INPUT -m set --match-set "$i-6" src -j DROP 2>&1>/dev/null
        ipset -X "$i-4" 2>&1>/dev/null
        ipset -X "$i-6" 2>&1>/dev/null
    done
elif [ "$1" == "-d" ]; then
    iptables -D INPUT -m set --match-set "$2-4" src -j DROP 2>&1>/dev/null
    ip6tables -D INPUT -m set --match-set "$2-6" src -j DROP 2>&1>/dev/null
    ipset -X "$2-4" 2>&1>/dev/null
    ipset -X "$2-6" 2>&1>/dev/null
elif [ "$1" == "-a" ]; then
    rm -rf /tmp/asnblock
    mkdir /tmp/asnblock
    cd /tmp/asnblock
    wget -qO "$2.sh" "$baseurl$2"
    chmod +x "$2.sh"
    sed -i 's/tables -A/tables -I/g' $2.sh
    # convert -A command to -I, add IP rule to the first of chain.
    # 转换脚本的-A命令为-I，让规则置顶，避免失效。
    # スクリプトの-Aパラメータは-Iにします。失効することのないよう、ルールを真上に置きます。。
    bash "$2.sh"
    echo "AS$2 has been blocked!"
    rm "$2.sh" -rf
else
    rm -rf /tmp/asnblock
    mkdir /tmp/asnblock
    cd /tmp/asnblock
# Delete rules first for pre-run.
# 执行之前删除旧规则
# 実行する前に古いルールを削除
    for init in $asnlist;
    do
        iptables -D INPUT -m set --match-set "$init-4" src -j DROP 2>&1>/dev/null
        ip6tables -D INPUT -m set --match-set "$init-6" src -j DROP 2>&1>/dev/null
        ipset -X "$init-4" 2>&1>/dev/null
        ipset -X "$init-6" 2>&1>/dev/null
    done
    for i in $asnlist;
    do
        wget -qO "$i.sh" "$baseurl$i"
        chmod +x "$i.sh"
        sed -i 's/tables -A/tables -I/g' $i.sh
        bash "$i.sh"
        echo "AS$i has been blocked!"
        rm "$i.sh" -rf
    done
fi
# return to original folder
# 返回原工作文件夹
# 元のフォルダに戻る
cd $origfold
exit 0
