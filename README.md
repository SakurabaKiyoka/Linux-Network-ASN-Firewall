# Linux Network ASN Firewall

---
[中文说明](#中文说明)

[日本語説明](#日本語説明)

---

ASN number based Linux system IP block tools.

Requirement: Linux(with iptables, IPset)

This script was tested in Debian 10. Others system might be work but I can't ensure it will be work properly. Please test before use.

# Summary

It can block by ASN number. Just like CloudFlare's firewall do. Now you can block by ASN number without CloudFlare's firewall.

# Usage

Just edit the script, One ASN number per line in script's asnlist variable.

Command args: 
- [-d] number. delete some ASN which you have already blocked by this script. Just input number. Example: AS 13335, just input 13335 here.
- [--delall] remove all rules.
- [-a] number. add some ASN which you want block.

# Others

Autoupdate: Just add `/bin/bash path of this script` to crontab. When this script running, It will be delete all exist rules and re-block with new list.

---

# 中文说明

可通过ASN来批量屏蔽IP的Linux系统网络安全脚本。 

依赖: Linux系统(需要iptables, IPset)

该脚本测试于Debian 10，其他系统应该也可以使用，但未经测试，不一定能用。使用前请首先测试。

# 概述

可以根据ASN屏蔽IP，就像CloudFlare防火墙一样。但是现在可以不使用CloudFlare防火墙，在自己的机器上就可以是实现这个功能。

# 使用方法

只需要修改脚本里面的asnlist变量，每行一个ASN号码（只输入号码，不要加AS）。

参数: 
- [-d] 数字. 解除屏蔽某个由本脚本添加的ASN的访问限制。例如AS 13335，只需要输入13335即可。
- [--delall] 清除所有规则。
- [-a] 数字. 屏蔽某个ASN。 

# 其他内容

自动更新：只需要把`/bin/bash 脚本完整路径`放到crontab，设置好时间就可以定期自动更新。当脚本运行的时候，会首先删除旧的规则，然后自动把新的规则加入进去进行屏蔽。

---


# 日本語説明

ASNによる大量の不正なIPをアクセス拒否のスクリプト。

要件: Linuxシステム(iptables, IPsetが必要)

このスクリプトはDebian 10のテストが完了しました。ほかのシステムも使えると思いますが、使わない場合もあります。使い始めにテストをおきましょう。

# 概要

ASNによるIPを遮断し、CloudFlareファイアウォールと同じもの。しかしCloudFlareを利用したくない場合はこのスクリプトに使って自分のサーバーでも使えます。

# 使い方法

スクリプトにあったasnlist変数を編集して、毎行につきASN番号の数字部分を挿入する。

パラメータ: 
- [-d] 数字. 指定のASNの遮断を解除する。例えばAS 13335は13335だけを指定する。
- [--delall] すべてのルールをクリア。
- [-a] 数字. 指定のASNを遮断。 

# そのほか

自動更新：`/bin/bash スクリプトのパス`をcrontabにおいて、実行時間を設定すると、自動更新ができます。スクリプトが実行する時に、まずすべてのルールを削除してから、新しいルールが自動に挿入されています。
