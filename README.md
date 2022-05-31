# base-registry-tools

ベースレジストリのデータを操作するツール

## 初期設定

`.tool-versions` に入っているPythonのバージョンをインストールし、virtualenvを設定します

```
python -m venv .venv
```

そして、virtualenvを有効にする

```
. .venv/bin/activate
```

pip のバージョンを最新にして、requirements.txtに入っている依存をインストール

```
pip install --upgrade pip
pip install -r requirements.txt
```

## スクリプト

* `download_mt_rsdtdsp.py` - 全都道府県、全自治体の「住居表示・住居マスター」データをダウンロードする
* `download_mt_rsdtdsp_pos.py` - 全都道府県、全自治体の「住居表示－住居マスター位置参照拡張」データをダウンロードする
* `download_mt_rsdtdsp_blk.py` - 全都道府県、全自治体の「住居表示・街区マスター」データをダウンロードする
* `download_mt_rsdtdsp_blk_pos.py` - 全都道府県、全自治体の「住居表示－街区マスター位置参照拡張」データをダウンロードする