VERSIONS = wheezy jessie stretch

default: dockerfiles
	for v in ${VERSIONS}; do \
		docker build -t dpirotte/postgres-dev:$$v $$v/ ; \
	done; \

dockerfiles:
	for v in ${VERSIONS}; do \
		mkdir -p $$v; \
		sed "s/%%VERSION%%/$$v/" Dockerfile.template > $$v/Dockerfile ;\
	done; \
