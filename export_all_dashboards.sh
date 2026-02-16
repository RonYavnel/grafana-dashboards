#!/bin/bash
#
# Export all Grafana dashboards into /srv/grafana-dashboards
#

GRAFANA_URL="https://igum-zabbix.ece.technion.ac.il:3000"
TOKEN="${GRAFANA_TOKEN:?Please set GRAFANA_TOKEN environment variable}"
OUTDIR="/srv/grafana-dashboards"

echo "Fetching dashboard list..."
DASHBOARDS=$(curl -ks -H "Authorization: Bearer $TOKEN" \
  "$GRAFANA_URL/api/search?type=dash-db" \
  | jq -r '.[] | [.uid, .title] | @tsv')

echo "$DASHBOARDS" | while IFS=$'\t' read -r DASH_UID TITLE; do
  # Convert title to a safe filename
  SAFE_TITLE=$(echo "$TITLE" | tr ' ' '-' | tr -cd '[:alnum:]-_')

  echo "Exporting: $TITLE -> ${SAFE_TITLE}.json"

  curl -ks -H "Authorization: Bearer $TOKEN" \
    "$GRAFANA_URL/api/dashboards/uid/$DASH_UID" \
    -o "$OUTDIR/${SAFE_TITLE}.json"
done

echo "Done."
