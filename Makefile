include ../../build/modules.mk

MODULE = jplayer
FILENAME = ${MODULE}.js
SOURCE_DIR = jquery.jplayer
SOURCE = ${SOURCE_DIR}/jquery.${MODULE}.js
PRODUCTION = ${PRODUCTION_DIR}/${FILENAME}
DEVELOPMENT = ${DEVELOPMENT_DIR}/${FILENAME}
PRODUCTION_FOLDER = ${PRODUCTION_DIR}/${MODULE}
DEVELOPMENT_FOLDER = ${DEVELOPMENT_DIR}/${MODULE}

all: premake body

premake:
	mkdir -p ${DEVELOPMENT_FOLDER}
	mkdir -p ${PRODUCTION_FOLDER}

body:
	${MODULARIZE} -jq -n "${MODULE}" ${SOURCE} > ${DEVELOPMENT}
	${UGLIFYJS} ${DEVELOPMENT} > ${PRODUCTION}
	cp ${SOURCE_DIR}/Jplayer.swf ${DEVELOPMENT_FOLDER}/
	cp ${SOURCE_DIR}/Jplayer.swf ${PRODUCTION_FOLDER}/

clean:
	rm -rf ${DEVELOPMENT}
	rm -rf ${DEVELOPMENT_FOLDER}
	rm -rf ${PRODUCTION}
	rm -rf ${PRODUCTION_FOLDER}