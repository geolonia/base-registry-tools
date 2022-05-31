CREATE TABLE mt_rsdtdsp_rsdt_pref (
  全国地方公共団体コード text,
  町字id text,
  街区id text,
  住居id text,
  住居2id text,
  市区町村名 text,
  政令市区名 text,
  大字・町名 text,
  丁目名 text,
  小字名 text,
  街区符号 text,
  住居番号 text,
  住居番号2 text,
  住居表示フラグ text,
  住居表示方式コード text,
  大字・町外字フラグ integer,
  小字外字フラグ integer,
  状態フラグ integer,
  効力発生日 text,
  廃止日 text,
  原典資料コード text,
  備考 text
);

CREATE TABLE mt_rsdtdsp_rsdt_pos_pref (
  全国地方公共団体コード text,
  町字id text,
  街区id text,
  住居id text,
  住居2id text,
  住居表示フラグ integer,
  住居表示方式コード text,
  代表点_経度 text,
  代表点_緯度 text,
  代表点_座標参照系 text,
  代表点_地図情報レベル text,
  住居表示住所_住所コード text,
  住居表示住所_データ整備日 text
);

CREATE MATERIALIZED VIEW mt_rsdtdsp_rsdt_combined_pref AS
SELECT
  ST_Transform(ST_GeomFromText('POINT(' || p."代表点_経度" || ' ' || p."代表点_緯度" || ')', ltrim(p."代表点_座標参照系", 'EPSG:')::integer), 4326) AS geom,
  addr.*,
  p."代表点_地図情報レベル",
  p."住居表示住所_住所コード",
  p."住居表示住所_データ整備日"
FROM
  mt_rsdtdsp_rsdt_pref addr
LEFT JOIN mt_rsdtdsp_rsdt_pos_pref p ON 
  addr."全国地方公共団体コード" = p."全国地方公共団体コード"
  AND addr."町字id" = p."町字id"
  AND addr."街区id" = p."街区id"
  AND addr."住居id" = p."住居id"
  AND ((addr."住居2id" IS NULL AND p."住居2id" IS NULL) OR addr."住居2id" = p."住居2id")
WITH NO DATA;
