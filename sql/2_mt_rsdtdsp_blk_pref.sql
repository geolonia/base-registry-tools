CREATE TABLE mt_rsdtdsp_blk_pref (
  全国地方公共団体コード text,
  町字id text,
  街区id text,
  市区町村名 text,
  政令市区名 text,
  大字・町名 text,
  丁目名 text,
  小字名 text,
  街区符号 text,
  住居表示フラグ text,
  住居表示方式コード text,
  大字・町外字フラグ text,
  小字外字フラグ integer,
  状態フラグ integer,
  効力発生日 text,
  廃止日 text,
  原典資料コード text,
  備考 text
);

CREATE TABLE mt_rsdtdsp_blk_pos_pref (
  全国地方公共団体コード text,
  町字id text,
  街区id text,
  住居表示フラグ integer,
  住居表示方式コード text,
  代表点_経度 text,
  代表点_緯度 text,
  代表点_座標参照系 text,
  代表点_地図情報レベル text,
  ポリゴン_ファイル名 text,
  ポリゴン_キーコード text,
  ポリゴン_データ_フォーマット text,
  ポリゴン_座標参照系 text,
  ポリゴン_地図情報レベル text,
  位置参照情報_都道府県名 text,
  位置参照情報_市区町村名 text,
  位置参照情報_大字・町丁目名 text,
  位置参照情報_小字・通称名 text,
  位置参照情報_街区符号・地番 text,
  位置参照情報_データ整備年度 text,
  住居表示住所_住所コード text,
  住居表示住所_データ整備日 text
);

CREATE MATERIALIZED VIEW mt_rsdtdsp_blk_combined_pref AS
SELECT
  ST_Transform(ST_GeomFromText('POINT(' || p."代表点_経度" || ' ' || p."代表点_緯度" || ')', ltrim(p."代表点_座標参照系", 'EPSG:')::integer), 4326) AS geom,
  addr.*,
  p."代表点_地図情報レベル",
  p."住居表示住所_住所コード",
  p."住居表示住所_データ整備日"
FROM
  mt_rsdtdsp_blk_pref addr
LEFT JOIN mt_rsdtdsp_blk_pos_pref p ON 
  addr."全国地方公共団体コード" = p."全国地方公共団体コード"
  AND addr."町字id" = p."町字id"
  AND addr."街区id" = p."街区id"
WITH NO DATA;
