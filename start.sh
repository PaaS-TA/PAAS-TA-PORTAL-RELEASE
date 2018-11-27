bosh create-release --sha2 --force --tarball ./paas-ta-portal-release-2.0.tgz --name paas-ta-portal-release --version 2.0


bosh upload-release ./paas-ta-portal-release-2.0.tgz
