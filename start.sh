bosh create-release --sha2 --force --tarball ./paasta-portal-release-2.0.tgz --name paas-ta-portal-release --version 2.0


bosh upload-release ./paasta-portal-release-2.0.tgz
