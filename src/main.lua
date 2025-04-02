local love = require("love");

local offset = arg[1] == "." and 1 or 0 -- account for debugging ig

local shaders = {
    ["dither"] = {
        args = 0,
        load = function (arg)
            local shader = love.graphics.newShader("shaders/dither.glsl");
    
            return shader;
        end
    },
    ["tax-dither"] = {
        args = 0,
        load = function (arg)
            local shader = love.graphics.newShader("shaders/tax-dither.glsl");
    
            return shader;
        end
    },
    ["chromatic-abberation"] = {
        args = 2,
        load = function (arg)
            local shader = love.graphics.newShader("shaders/chromatic-abberation.glsl");
            shader:send("shift", {arg[3 + offset], arg[4 + offset]})
    
            return shader;
        end
    },
    ["pers-chromatic-abberation"] = {
        args = 1,
        load = function (arg)
            local shader = love.graphics.newShader("shaders/pers-chromatic-abberation.glsl");
            shader:send("shift", arg[3 + offset])
    
            return shader;
        end
    },
    ["invert"] = {
        args = 2,
        load = function (arg)
            local shader = love.graphics.newShader("shaders/invert.glsl");
    
            return shader;
        end
    },
}

local function getCurrentWorkingDirectory()
    local currentDir = io.popen("cd"):read("*l")
    return currentDir
end

function love.load()
    love.window.setMode(1, 1, { resizable = false })

    local inputPath = arg[1 + offset] or "input.png"
    local outputPath = getCurrentWorkingDirectory() .. "\\output.png"

    local shaderOption = shaders[arg[2 + offset]]

    if not shaderOption then
        print('\nFilter "' .. arg[2 + offset] .. '" does not exist.')
        love.event.quit()
        return
    end

    print("\nLoading image...")

    local file = assert(io.open(inputPath, "rb"))
    local fileData = love.filesystem.newFileData(file:read("a"), "input.png")
    file.close(file)

    -- load the image, check if it exists
    local success, imageData = pcall(love.image.newImageData, fileData)
    if not success then
        print("\nFailed to load image: " .. inputPath .. "\nThis may be a file path issue. Does the image exist, or is the file path correct?")
        love.event.quit()
        return
    end

    local success, image = pcall(love.graphics.newImage, imageData)
    if not success then
        print("\nFailed to load image:" .. inputPath)
        love.event.quit()
        return
    else
        print("Loaded image successfully!")
    end

    print("Initializing shaders...")
    local shader = shaderOption.load(arg)
    local canvas = love.graphics.newCanvas(image:getWidth(), image:getHeight())

    -- shader:send("screen_size", { image:getWidth(), image:getHeight() })

    print("Processing image...")
    -- apply the shader
    love.graphics.setShader(shader)
    love.graphics.setCanvas(canvas)
    love.graphics.draw(image, 0, 0)
    love.graphics.setCanvas()
    love.graphics.setShader()

    print("Encoding...")
    -- encode the processed image
    local imageData = canvas:newImageData()
    local success, encodedImage = pcall(function()
        return imageData:encode("png"):getString()
    end)

    if success then
        print("Encoded image successfully!\nSaving image...")

        local file = io.open(outputPath, "wb")
        if file then
            file:write(encodedImage)
            file:close()
            print("\nSuccess! Image saved at: " .. outputPath .. "\r");
            love.event.quit();
            return
        else
            print("\nFailed to write image file." .. "\r")
            love.event.quit();
            return
        end
    else
        print("\nFailed to encode image." .. "\r")
        love.event.quit();
        return
    end

    love.event.quit()
end
