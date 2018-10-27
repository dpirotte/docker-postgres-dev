VERSIONS = jessie stretch trusty xenial bionic

TEST_TIMEOUT_SECONDS = 120

default: build

dockerfiles: $(addprefix dockerfile-,$(VERSIONS))

dockerfile-%:
	mkdir -p $* && sed "s/%%VERSION%%/$*/" Dockerfile.template > $*/Dockerfile

build: $(addprefix build-,$(VERSIONS))

build-%:
	docker build -t dpirotte/postgres-dev:$* $*

test-%: test_deps
	@env GOSS_VARS="goss_vars.yaml" \
		GOSS_OPTS="--max-concurrent 1 --color" \
		dgoss run dpirotte/postgres-dev:$* sleep ${TEST_TIMEOUT_SECONDS}
test: $(addprefix test-,$(VERSIONS))

.PHONY: test_deps
test_deps: ${HOME}/bin/goss ${HOME}/bin/dgoss

${HOME}/bin/goss:
	@curl -L https://github.com/aelsabbahy/goss/releases/download/v0.3.6/goss-linux-amd64 -o ${HOME}/bin/goss
	@chmod +rx ${HOME}/bin/goss

${HOME}/bin/dgoss:
	@curl -L https://raw.githubusercontent.com/aelsabbahy/goss/v0.3.6/extras/dgoss/dgoss -o ${HOME}/bin/dgoss
	@chmod +rx ${HOME}/bin/dgoss

