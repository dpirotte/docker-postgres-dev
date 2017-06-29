DEBIAN_VERSIONS = wheezy jessie stretch
UBUNTU_VERSIONS = trusty xenial

default: debian

dockerfiles: $(addprefix dockerfile-,$(DEBIAN_VERSIONS))

dockerfile-%:
	sed "s/%%VERSION%%/$*/" Dockerfile.template > $*/Dockerfile

debian: $(addprefix debian-,$(DEBIAN_VERSIONS))
ubuntu: $(addprefix ubuntu-,$(UBUNTU_VERSIONS))

ubuntu-% debian-%:
	docker build -t dpirotte/postgres-dev:$* $*
