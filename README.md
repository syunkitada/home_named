# home_bind

自宅用DNSの設定ファイル群です。

## 環境
* ubuntu14
* bind9

## 使い方
``` bash
# インストール
$ ./install.sh

# 設定の変更
$ vim bind/...

# 設定の反映
$ ./update_bind.sh
```


## リゾルバの設定
### 現在の設定を確認
``` bash
# digでデフォルトのリゾルバを見てみる
$ dig
...
;; SERVER: 192.168.11.1#53(192.168.11.1)

# localhostをリゾルバにしてdigすると、設定したipがとれる
$ dig dev01.vagrant.mydns.jp @localhost

;; ANSWER SECTION:
test01.vagrant.mydns.jp. 86400  IN      A       192.168.11.50

;; SERVER: 127.0.0.1#53(127.0.0.1)
```

### リゾルバを変更する
#### CentOS 6,7
/etc/resolv.conf を編集します。
```
nameserver 127.0.1.1
nameserver 192.168.11.50
nameserver 192.168.11.1
```

編集したら完了。

#### Ubuntu 14
/etc/network/interfaces を編集します。
```
# interfaces(5) file used by ifup(8) and ifdown(8)
auto lo
iface lo inet loopback

> dns-nameservers 192.168.11.50,192.168.11.1
```

編集後、ネットワークを再接続する。


#### Windows 7,10
Windowsだと各ネットワークデバイスのプロパティを編集する必要がある。

* プログラムとファイルの検索から"ネットワーク接続の表示"を開く
* ネットワークデバイスのプロパティを開く
* 接続項目から"インターネット プロトコル バージョン 4"の選択肢プロパティを開く
* "次のDNSサーバのアドレスを使う"にチェックを入れて、DNSサーバのIPを設定する
    * 優先DNSサーバ: 127.168.11.50
    * 代替DNSサーバ: 192.168.11.1
* 設定したらネットワークを再接続する

設定後にdigをすると、デフォルトのリゾルバが192.168.11.50となっていることが確認できる。
``` bash
$ dig dev01.vagrant.mydns.jp

;; ANSWER SECTION:
test01.vagrant.mydns.jp. 86400  IN      A       192.168.11.50

;; SERVER: 127.0.0.1#53(127.0.0.1)
```


## 参考
* http://www.zelazny.mydns.jp/archives/002787.php
* http://www.bit-drive.ne.jp/support/technical/dns/pdf/dns_dnsserver_guide.pdf
* http://hirataofficenet.jp/home/modules/xpress/?p=42
