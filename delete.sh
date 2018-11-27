bosh delete-deployment -d paasta-portal

rm -rf dev_releases/

rm -rf paas-ta-portal-release-2.0.tgz

bosh delete-release paasta-portal-release/2.0
