all: modularize-script minify-script copy-player skins

include ../../build/modules.mk

MODULE = jplayer
MODULARIZE_OPTIONS = -jq
SOURCE_SCRIPT_FOLDER = jquery.jplayer

SKIN_LESS_CONVERTER = sed 's/url("/url("@{foundry_uri}\/jplayer\/${SKIN_NAME}\//g'

copy-player: create-script-folder
	cp ${SOURCE_SCRIPT_FOLDER}/Jplayer.swf ${TARGET_SCRIPT_FOLDER}/

skins:
	make skin-blue.monday
	make skin-pink.flag

prep-skin-%:
	$(eval SKIN_NAME                = $*)
	$(eval SOURCE_STYLE_FOLDER      = skin/$*)
	$(eval SOURCE_STYLE_FILE        = skin/$*/jplayer.$*.css)
	$(eval TARGET_STYLE_FOLDER      = ${FOUNDRY_STYLES_FOLDER}/jplayer/$*)
	$(eval TARGET_STYLE_FILE_NAME   = style)
	$(eval SOURCE_ASSET_FILES       = skin/$*/*.png skin/$*/*.jpg skin/$*/*.gif)
	$(eval TARGET_ASSET_FOLDER_NAME = $*)
	$(eval TARGET_STYLE_LESS_CONVERTER = ${SKIN_LESS_CONVERTER})

skin-blue.monday: prep-skin-blue.monday copy-style minify-style lessify-style copy-assets

skin-pink.flag: prep-skin-blue.monday copy-style minify-style lessify-style copy-assets