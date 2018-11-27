bosh delete-deployment -d paasta-portal

rm -rf dev_releases/

bosh delete-release paasta-portal-release/2.0
