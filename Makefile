DEBIAN_VERSIONS = wheezy jessie stretch

default: debian

dockerfiles: $(addprefix dockerfile-,$(DEBIAN_VERSIONS))

dockerfile-%:
	sed "s/%%VERSION%%/$*/" Dockerfile.template > $*/Dockerfile

debian: $(addprefix debian-,$(DEBIAN_VERSIONS))

debian-%:
	docker build -t dpirotte/postgres-dev:$* $*
