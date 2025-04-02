APP_NAME = cmdFilter
LOVE_PATH_WINDOWS = C:/Program Files/LOVE
LOVE_WINDOWS = love.exe
SRC_DIR = src
BUILD_DIR = build

all: clean prepare copy-files-windows package fuse

prepare:
	mkdir -p $(BUILD_DIR)

copy-files-windows:
	cp "$(LOVE_PATH_WINDOWS)/love.exe" $(BUILD_DIR)/
	cp "$(LOVE_PATH_WINDOWS)/SDL2.dll" $(BUILD_DIR)/
	cp "$(LOVE_PATH_WINDOWS)/OpenAL32.dll" $(BUILD_DIR)/
	cp "$(LOVE_PATH_WINDOWS)/love.dll" $(BUILD_DIR)/
	cp "$(LOVE_PATH_WINDOWS)/lua51.dll" $(BUILD_DIR)/

package:
	cd $(SRC_DIR) && zip -9 -r ../$(BUILD_DIR)/$(APP_NAME).love . -x ".*" -x "__MACOSX"

fuse:
	cd $(BUILD_DIR) && cat "love.exe" $(APP_NAME).love > $(APP_NAME).exe

clean:
	rm -rf $(BUILD_DIR)
