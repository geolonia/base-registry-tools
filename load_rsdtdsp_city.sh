#!/bin/bash -e

find './out/mt_rsdtdsp_rsdt/city/' -name '*.csv.zip' -print0 | \
  xargs -I '{}' -0 bash -c "unzip -cp '{}' | psql -c '\copy mt_rsdtdsp_rsdt_city FROM stdin with header csv'"

find './out/mt_rsdtdsp_rsdt_pos/city/' -name '*.csv.zip' -print0 | \
  xargs -I '{}' -0 bash -c "unzip -cp '{}' | psql -c '\copy mt_rsdtdsp_rsdt_pos_city FROM stdin with header csv'"

psql -c 'refresh materialized view "mt_rsdtdsp_rsdt_combined_city";'
