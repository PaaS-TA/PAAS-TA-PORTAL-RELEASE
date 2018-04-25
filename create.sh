echo "################################### Create release :: s"
bosh create release --force --with-tarball --name paas-ta-portal-release --version 1.0
echo "################################### Create release :: e"


echo "################################### Upload release :: s"
bosh upload release dev_releases/paas-ta-portal-release/paas-ta-portal-release-1.0.tgz
echo "################################### Create release :: e"


echo "################################### bosh deployment :: s"
bosh deployment deployment/paas-ta-portal-vsphere-2.0.yml
echo "################################### bosh deployment :: e"

echo "################################### bosh deploy :: s"
bosh deploy --no-redact
echo "################################### bosh deploy :: e"

echo "################################### bosh deploy Check:: s"
bosh releases
bosh deployments
bosh vms paas-ta-portal
echo "################################### bosh deploy Check:: e"

