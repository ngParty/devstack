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

dist: clean
	${NODE_MODULES_BIN}/tsc
	${NODE_MODULES_BIN}/broccoli build dist
	${NODE_MODULES_BIN}/jspm bundle-sfx index dist/index.js --minify

clean:
	- ${NODE_MODULES_BIN}/rimraf dist

.PHONY: all setup serve dist clean
