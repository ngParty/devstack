NODE_MODULES_BIN=node_modules/.bin

all: serve

setup:
	npm install
	- mkdir app/jspm_packages
	${NODE_MODULES_BIN}/jspm install
	${NODE_MODULES_BIN}/tsd reinstall -r -o

serve:
	${NODE_MODULES_BIN}/tsc
	${NODE_MODULES_BIN}/broccoli serve

static-dist: clean
	${NODE_MODULES_BIN}/tsc
	${NODE_MODULES_BIN}/broccoli build dist

dist: static-dist
	${NODE_MODULES_BIN}/jspm bundle index dist/index.js --minify
	${NODE_MODULES_BIN}/http-server dist -o

sfx-dist:
	${NODE_MODULES_BIN}/jspm bundle-sfx index dist/index-sfx.js --minify

clean:
	- ${NODE_MODULES_BIN}/rimraf dist

.PHONY: all setup serve static-dist dist sfx-dist clean
