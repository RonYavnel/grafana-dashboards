# Grafana Dashboards (exported JSON)

Grafana Dashboard Export System — User Manual
Version: 1.0
Author: Ron Yavnel
Last updated: February 2026
1. Overview
This system provides a secure version-controlled backup of all Grafana dashboards.
It exports dashboards via the Grafana API, stores them in /srv/grafana-dashboards/
and allows manual git commits to a GitHub repo.
2. Directory Structure
/srv/grafana-dashboards/
 export_all_dashboards.sh # Safe export script
 *.json # Dashboard files
 README.md
Private environment file:
/srv/grafana.env (contains the GRAFANA_TOKEN)
3. Authentication
The Grafana API token is stored in /srv/grafana.env and loaded using:
 source /srv/grafana.env
The token is not stored in git.
4. Running the Export Script
 source /srv/grafana.env
 cd /srv/grafana-dashboards
 ./export_all_dashboards.sh
5. Reviewing Changes
 git status
 git diff
6. Committing and Pushing
 git add .
 git commit -m "Update dashboards"
 git push
7. Updating the Token
Regenerate via Grafana > Administration > Service Accounts > grafana-export.
Update /srv/grafana.env accordingly.
8. Restoring Dashboards
In Grafana: Dashboard > New > Import > Paste JSON from GitHub.
9. Workflow Summary
 source /srv/grafana.env
 ./export_all_dashboards.sh
 git status
 git commit -m "..."
 git push
This completes the dashboard export and version control workflow.
