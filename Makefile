VERSIONS = jessie stretch trusty xenial bionic

TEST_TIMEOUT_SECONDS = 120

GOSS_PATH = .tmp/goss
DGOSS_PATH = .tmp/dgoss

default: build

dockerfiles: $(addsuffix /Dockerfile,$(VERSIONS))

%/Dockerfile: Dockerfile.template
	@mkdir -p $* && sed "s/%%VERSION%%/$*/" Dockerfile.template > $*/Dockerfile

build: $(addprefix build-,$(VERSIONS))

build-%: %/Dockerfile
	docker build -t dpirotte/postgres-dev:$* $*

test-%: test_deps
	@env \
		GOSS_PATH=${GOSS_PATH} \
		GOSS_VARS="goss_vars.yaml" \
		GOSS_OPTS="--max-concurrent 1 --color" \
		${DGOSS_PATH} run dpirotte/postgres-dev:$* sleep ${TEST_TIMEOUT_SECONDS}
test: $(addprefix test-,$(VERSIONS))

.PHONY: test_deps
test_deps: ${GOSS_PATH} ${DGOSS_PATH}

${GOSS_PATH}:
	@mkdir -p .tmp
	@curl -fsSL https://github.com/aelsabbahy/goss/releases/download/v0.3.6/goss-linux-amd64 -o ${GOSS_PATH}
	@chmod +rx ${GOSS_PATH}

${DGOSS_PATH}:
	@mkdir -p .tmp
	@curl -fsSL https://raw.githubusercontent.com/aelsabbahy/goss/v0.3.6/extras/dgoss/dgoss -o ${DGOSS_PATH}
	@chmod +rx ${DGOSS_PATH}

