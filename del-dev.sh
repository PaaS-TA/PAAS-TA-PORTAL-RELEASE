echo "################################### Delete deployment :: "
bosh delete deployment paas-ta-portal-dev --force
echo "################################### Delete deployment :: "

echo "################################### Delete release :: "
bosh delete release paas-ta-portal-release-dev
echo "################################### Delete release :: "

echo "################################### Delete dev_releases/* :: "
sudo rm -rf dev_releases
echo "################################### Delete dev_releases/* :: "



