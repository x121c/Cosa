task.spawn(function() repeat task.wait() until game:IsLoaded() wait(1) local Amplitude = 200 local RandomValue = {-200,200} local RandomTime = {.1, 1} local floor = math.floor local cos = math.cos local sin = math.sin local acos = math.acos local pi = math.pi local Maxima = 0 while task.wait() do if gcinfo() >= Maxima then Maxima = gcinfo() else break end end task.wait(0.30) local OldGcInfo = gcinfo()+Amplitude local tick = 0 local function getreturn() local Formula = ((acos(cos(pi * (tick)))/pi * (Amplitude * 2)) + -Amplitude ) return floor(OldGcInfo + Formula) end local Old; Old = hookfunction(getrenv().gcinfo, function(...) return getreturn() end) local Old2; Old2 = hookfunction(getrenv().collectgarbage, function(arg, ...) local suc, err = pcall(Old2, arg, ...) if suc and arg == "count" then return getreturn() end return Old2(arg, ...) end) game:GetService("RunService").Stepped:Connect(function() local Formula = ((acos(cos(pi * (tick)))/pi * (Amplitude * 2)) + -Amplitude ) if Formula > ((acos(cos(pi * (tick)+.01))/pi * (Amplitude * 2)) + -Amplitude ) then tick = tick + .07 else tick = tick + 0.01 end end) local old1 = Amplitude for i,v in next, RandomTime do RandomTime[i] = v * 10000 end local RandomTimeValue = math.random(RandomTime[1],RandomTime[2])/10000 while wait(RandomTime) do Amplitude = math.random(old1+RandomValue[1], old1+RandomValue[2]) RandomTimeValue = math.random(RandomTime[1],RandomTime[2])/10000 end end)
task.spawn(function() repeat task.wait() until game:IsLoaded() wait(1) local RunService = cloneref(game:GetService("RunService")) local Stats = cloneref(game:GetService("Stats")) local CurrMem = Stats:GetTotalMemoryUsageMb() local Rand = 0 RunService.Stepped:Connect(function() local random = Random.new() Rand = random:NextNumber(-10, 10) end) local function GetReturn() return CurrMem + Rand end local _MemBypass _MemBypass = hookmetamethod(game, "__namecall", function(self,...) local method = getnamecallmethod() if not checkcaller() then if typeof(self) == "Instance" and (method == "GetTotalMemoryUsageMb" or method == "getTotalMemoryUsageMb") and self.ClassName == "Stats" then return GetReturn() end end return _MemBypass(self,...) end) local _MemBypassIndex; _MemBypassIndex = hookfunction(Stats.GetTotalMemoryUsageMb, function(self, ...) if not checkcaller() then if typeof(self) == "Instance" and self.ClassName == "Stats" then return GetReturn() end end end) end)
task.spawn(function() repeat task.wait() until game:IsLoaded() wait(1) local RunService = cloneref(game:GetService("RunService")) local Stats = cloneref(game:GetService("Stats")) local CurrMem = Stats:GetMemoryUsageMbForTag(Enum.DeveloperMemoryTag.Gui) local Rand = 0 RunService.Stepped:Connect(function() local random = Random.new() Rand = random:NextNumber(-0.1, 0.1) end) local function GetReturn() return CurrMem + Rand end local _MemBypass _MemBypass = hookmetamethod(game, "__namecall", function(self,...) local method = getnamecallmethod() if not checkcaller() then if typeof(self) == "Instance" and (method == "GetMemoryUsageMbForTag" or method == "getMemoryUsageMbForTag") and self.ClassName == "Stats" then return GetReturn() end end return _MemBypass(self,...) end) local _MemBypassIndex; _MemBypassIndex = hookfunction(Stats.GetMemoryUsageMbForTag, function(self, ...) if not checkcaller() then if typeof(self) == "Instance" and self.ClassName == "Stats" then return GetReturn() end end end) end)
local Content = cloneref(game:GetService("ContentProvider")) local CoreGui = cloneref(game:GetService("CoreGui")) local randomizedCoreGuiTable local randomizedGameTable local coreguiTable = {} game:GetService("ContentProvider"):PreloadAsync({CoreGui}, function(assetId) if not assetId:find("rbxassetid://") then table.insert(coreguiTable, assetId) end end) local gameTable = {} for i, v in pairs(game:GetDescendants()) do if v:IsA("ImageLabel") then if v.Image:find('rbxassetid://') and v:IsDescendantOf(CoreGui) then else table.insert(gameTable, v.Image) end end end function randomizeTable(t) local n = #t while n > 0 do local k = math.random(n) t[n], t[k] = t[k], t[n] n = n - 1 end return t end local ContentProviderBypass ContentProviderBypass = hookmetamethod(game, "__namecall", function(self, Instances, ...) local method = getnamecallmethod() local args = ... if not checkcaller() and (method == "preloadAsync" or method == "PreloadAsync") then if Instances and Instances[1] and self.ClassName == "ContentProvider" then if Instances ~= nil then if typeof(Instances[1]) == "Instance" and (table.find(Instances, CoreGui) or table.find(Instances, game)) then if Instances[1] == CoreGui then randomizedCoreGuiTable = randomizeTable(coreguiTable) return ContentProviderBypass(self, randomizedCoreGuiTable, ...) end if Instances[1] == game then randomizedGameTable = randomizeTable(gameTable) return ContentProviderBypass(self, randomizedGameTable, ...) end end end end end return ContentProviderBypass(self, Instances, ...) end) local preloadBypass; preloadBypass = hookfunction(Content.PreloadAsync, function(a, b, c) if not checkcaller() then if typeof(a) == "Instance" and tostring(a) == "ContentProvider" and typeof(b) == "table" then if (table.find(b, CoreGui) or table.find(b, game)) and not (table.find(b, true) or table.find(b, false)) then if b[1] == CoreGui then randomizedCoreGuiTable = randomizeTable(coreguiTable) return preloadBypass(a, randomizedCoreGuiTable, c) end if b[1] == game then randomizedGameTable = randomizeTable(gameTable) return preloadBypass(a, randomizedGameTable, c) end end end end return preloadBypass(a, b, c) end)
local _IsDescendantOf = game.IsDescendantOf local TextboxBypass TextboxBypass = hookmetamethod(game, "__namecall", function(self,...) local method = getnamecallmethod() local args = ... if not checkcaller() then if typeof(self) == "Instance" and method == "GetFocusedTextBox" and self.ClassName == "UserInputService" then local Textbox = TextboxBypass(self,...) if Textbox and typeof(Textbox) == "Instance" then local succ,err = pcall(function() _IsDescendantOf(Textbox, game) end) if err and err:match("The current identity") then return nil end end end end return TextboxBypass(self,...) end)
local TableNumbaor001 = {} local SomethingOld SomethingOld = hookfunction(getrenv().newproxy, function(...) local proxy = SomethingOld(...) table.insert(TableNumbaor001, proxy) return proxy end) local RunService = cloneref(game:GetService("RunService")) RunService.Stepped:Connect(function() for i,v in pairs(TableNumbaor001) do if v == nil then end end end)
local CoreGuiBypass CoreGuiBypass = hookmetamethod(game, "__namecall", function(self, ...) local method = getnamecallmethod() if not checkcaller() then if self == CoreGui and (method == "FindFirstChild" or method == "FindFirstChildOfClass" or method == "GetChildren" or method == "GetDescendants") then return {} end end return CoreGuiBypass(self, ...) end)
local InstanceBypass InstanceBypass = hookmetamethod(game, "__namecall", function(self, ...) local method = getnamecallmethod() if not checkcaller() then if method == "IsA" and tostring(self) == "Dex" then return false end end return InstanceBypass(self, ...) end)
local HookMetatableBypass HookMetatableBypass = hookmetamethod(game, "__index", function(self, key) if not checkcaller() and tostring(self) == "RobloxLock" then return nil end return HookMetatableBypass(self, key) end)
local GetObjectsBypass GetObjectsBypass = hookfunction(game.GetObjects, function(self, ...) if not checkcaller() then return {} end return GetObjectsBypass(self, ...) end)
local HttpServiceBypass HttpServiceBypass = hookmetamethod(game, "__namecall", function(self, ...) local method = getnamecallmethod() if not checkcaller() and self.ClassName == "HttpService" and (method == "GetAsync" or method == "PostAsync") then return nil end return HttpServiceBypass(self, ...) end)
local MessageBypass MessageBypass = hookmetamethod(game, "__namecall", function(self, ...) local method = getnamecallmethod() if not checkcaller() and method == "GetMessage" then return "" end return MessageBypass(self, ...) end)

-- Main Aimbot Script
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/x121c/Cosa/refs/heads/main/Library/src.lua"))()
local run = game:GetService("RunService")
local players = game:GetService("Players")
local camera = workspace.CurrentCamera
local uis = game:GetService("UserInputService")
local guiService = game:GetService("GuiService")
local player = players.LocalPlayer
local mouse = player:GetMouse()

local toggles = {
    abk = Enum.UserInputType.MouseButton2,
    iag = false,
    teamcheck = false,
    wallcheck = false,
    tracers = false,
    hESP = false,
    skellyESP = false,
    aimbot = false,
    showfov = false,
    fov = 50,
    abp = "Head",
    smoothness = 1,
    -- Triggerbot settings
    triggerbot = false,
    triggerTeamCheck = false,
    triggerWallCheck = false,
    triggerDelay = 0
}

local traced = {}
local guiInset = guiService:GetGuiInset()
local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
local tracerStart = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)

-- Create UI
local combat = library:CreateWindow('Aimbot')
local visuals = library:CreateWindow('Visuals')
local triggerbotTab = library:CreateWindow('Triggerbot') -- New Triggerbot tab

-- Aimbot Section
combat:Section('Aimbot')
combat:Toggle('Aimbot', {location = toggles, flag = 'aimbot'})
combat:Bind('Aimbot Hotkey', {location = toggles, flag = 'abk', kbonly = false, default = Enum.UserInputType.MouseButton2}, function(k, b) toggles.iag = b end)
combat:Dropdown('Aimpart', {location = toggles, flag = 'abp', list = {"Head", "UpperTorso", "LowerTorso", "HumanoidRootPart"}})
combat:Slider('Smoothness', {location = toggles, flag = 'smoothness', precise = true, default = 1, min = 1, max = 10})
combat:Toggle('Team Check', {location = toggles, flag = "teamcheck"})
combat:Toggle('Wall Check', {location = toggles, flag = "wallcheck"})
combat:Toggle('Draw FOV', {location = toggles, flag = "showfov"})
combat:Slider('FOV', {location = toggles, flag = 'fov', precise = false, default = 50, min = 50, max = 500})

-- Visuals Section
visuals:Section('ESP')
visuals:Toggle('Tracers', {location = toggles, flag = "tracers"})
visuals:Toggle('Box ESP', {location = toggles, flag = "hESP"})
visuals:Toggle('Skelly ESP', {location = toggles, flag = "skellyESP"})

-- Triggerbot Section
triggerbotTab:Section('Triggerbot')
triggerbotTab:Toggle('Triggerbot', {location = toggles, flag = 'triggerbot'})
triggerbotTab:Toggle('Team Check', {location = toggles, flag = "triggerTeamCheck"})
triggerbotTab:Toggle('Wall Check', {location = toggles, flag = "triggerWallCheck"})
triggerbotTab:Slider('Delay (ms)', {location = toggles, flag = 'triggerDelay', precise = false, default = 0, min = 0, max = 500})

local fovCircle
local drawingObjects = {}

-- Improved death check function
local function isAlive(character)
    if not character then return false end
    
    -- Check if character exists and has necessary parts
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head")
    
    if not humanoid or not rootPart then
        return false
    end
    
    -- Check health
    if humanoid.Health <= 0 then
        return false
    end
    
    -- Check if character is in a valid state
    if humanoid:GetState() == Enum.HumanoidStateType.Dead then
        return false
    end
    
    return true
end

-- Improved team check function
local function isInTeam(character, useTriggerbotCheck)
    local teamCheck = useTriggerbotCheck and toggles.triggerTeamCheck or toggles.teamcheck
    if not teamCheck then return false end
    
    local targetPlayer = players:GetPlayerFromCharacter(character)
    if not targetPlayer then return false end
    
    if player.Team and targetPlayer.Team then 
        return player.Team == targetPlayer.Team 
    end
    
    return false
end

local function isVisible(character, partName, useTriggerbotCheck)
    local wallCheck = useTriggerbotCheck and toggles.triggerWallCheck or toggles.wallcheck
    if not wallCheck then return true end
    
    local targetPart = character:FindFirstChild(partName)
    if not targetPart then return false end
    
    local origin = camera.CFrame.Position
    local target = targetPart.Position
    local direction = (target - origin).Unit
    local distance = (target - origin).Magnitude
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {player.Character, character}
    
    local raycastResult = workspace:Raycast(origin, direction * distance, raycastParams)
    
    return raycastResult == nil
end

local function createDrawing(className)
    local success, result = pcall(function() return Drawing.new(className) end)
    return success and result or nil
end

local function initializeFOV()
    if not fovCircle then
        fovCircle = createDrawing('Circle')
        if fovCircle then
            fovCircle.Transparency = 0.3
            fovCircle.Thickness = 1.5
            fovCircle.Visible = false
            fovCircle.Color = Color3.fromRGB(255, 255, 255)
            fovCircle.Filled = false
            table.insert(drawingObjects, fovCircle)
        end
    end
end

local function createLine()
    local line = createDrawing("Line")
    if line then
        line.Thickness = 1.5
        line.Transparency = 1
        line.Visible = false
        line.Color = Color3.fromRGB(255, 255, 255)
        line.From = tracerStart
        table.insert(drawingObjects, line)
    end
    return line
end

local function createSquare()
    local square = createDrawing('Square')
    if square then
        square.Transparency = 1
        square.Thickness = 1.5
        square.Visible = false
        square.Color = Color3.fromRGB(255, 255, 255)
        square.Filled = false
        table.insert(drawingObjects, square)
    end
    return square
end

local function createSkelly()
    local lines = {}
    for i = 1, 15 do
        local line = createDrawing("Line")
        if line then
            line.Thickness = 1.5
            line.Transparency = 1
            line.Visible = false
            line.Color = Color3.fromRGB(255, 255, 255)
            table.insert(drawingObjects, line)
            table.insert(lines, line)
        end
    end
    return lines
end

local function getCharacterBoundingBox(character)
    local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head")
    if not rootPart then return nil, nil end
    
    local cf = rootPart.CFrame
    local size = Vector3.new(4, 6, 4)
    
    local corners = {
        cf * CFrame.new(size.X/2, size.Y/2, size.Z/2),
        cf * CFrame.new(-size.X/2, size.Y/2, size.Z/2),
        cf * CFrame.new(size.X/2, -size.Y/2, size.Z/2),
        cf * CFrame.new(-size.X/2, -size.Y/2, size.Z/2),
        cf * CFrame.new(size.X/2, size.Y/2, -size.Z/2),
        cf * CFrame.new(-size.X/2, size.Y/2, -size.Z/2),
        cf * CFrame.new(size.X/2, -size.Y/2, -size.Z/2),
        cf * CFrame.new(-size.X/2, -size.Y/2, -size.Z/2)
    }
    
    local minX, minY = math.huge, math.huge
    local maxX, maxY = -math.huge, -math.huge
    
    for _, corner in pairs(corners) do
        local screenPos, onScreen = camera:WorldToScreenPoint(corner.Position)
        if onScreen then
            minX = math.min(minX, screenPos.X)
            minY = math.min(minY, screenPos.Y)
            maxX = math.max(maxX, screenPos.X)
            maxY = math.max(maxY, screenPos.Y)
        end
    end
    
    if minX == math.huge then return nil, nil end
    
    local position = Vector2.new(minX, minY + guiInset.Y)
    local size = Vector2.new(maxX - minX, maxY - minY)
    
    return position, size
end

local function getClosestPlayer(useTriggerbotCheck)
    local nearestDistance = math.huge
    local closestPlayer = nil
    
    for _, playerObj in pairs(players:GetPlayers()) do
        if playerObj ~= player and playerObj.Character then
            local character = playerObj.Character
            
            if isAlive(character) and not isInTeam(character, useTriggerbotCheck) then
                local targetPart = character:FindFirstChild(toggles.abp)
                if targetPart then
                    if isVisible(character, toggles.abp, useTriggerbotCheck) then
                        local screenPos, onScreen = camera:WorldToScreenPoint(targetPart.Position)
                        if onScreen then
                            local distance = (Vector2.new(screenPos.X, screenPos.Y + guiInset.Y) - screenCenter).Magnitude
                            if distance < nearestDistance and (not useTriggerbotCheck or distance < toggles.fov) then
                                nearestDistance = distance
                                closestPlayer = playerObj
                            end
                        end
                    end
                end
            end
        end
    end
    
    return closestPlayer
end

local function calculateCameraMovement(targetPosition)
    local currentCFrame = camera.CFrame
    local targetCFrame = CFrame.lookAt(currentCFrame.Position, targetPosition)
    
    local smoothFactor = toggles.smoothness / 10
    local smoothedCFrame = currentCFrame:Lerp(targetCFrame, smoothFactor)
    
    return smoothedCFrame
end

-- Triggerbot function
local lastTriggerTime = 0
local function triggerbot()
    if not toggles.triggerbot then return end
    
    local currentTime = tick()
    if currentTime - lastTriggerTime < (toggles.triggerDelay / 1000) then
        return
    end
    
    local closestPlayer = getClosestPlayer(true)
    if closestPlayer and closestPlayer.Character then
        local character = closestPlayer.Character
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        
        if humanoid and humanoid.Health > 0 then
            -- Simulate mouse click
            mouse1click()
            lastTriggerTime = currentTime
        end
    end
end

local function updateSkellyESP(playerObj, character, skellyLines)
    if not skellyLines then return end
    local parts = {
        Head = character:FindFirstChild("Head"),
        LeftUpperArm = character:FindFirstChild("LeftUpperArm"),
        RightUpperArm = character:FindFirstChild("RightUpperArm"),
        LeftLowerArm = character:FindFirstChild("LeftLowerArm"),
        RightLowerArm = character:FindFirstChild("RightLowerArm"),
        LeftHand = character:FindFirstChild("LeftHand"),
        RightHand = character:FindFirstChild("RightHand"),
        UpperTorso = character:FindFirstChild("UpperTorso"),
        LowerTorso = character:FindFirstChild("LowerTorso"),
        LeftUpperLeg = character:FindFirstChild("LeftUpperLeg"),
        RightUpperLeg = character:FindFirstChild("RightUpperLeg"),
        LeftLowerLeg = character:FindFirstChild("LeftLowerLeg"),
        RightLowerLeg = character:FindFirstChild("RightLowerLeg"),
        LeftFoot = character:FindFirstChild("LeftFoot"),
        RightFoot = character:FindFirstChild("RightFoot")
    }
    local connections = {
        {parts.Head, parts.UpperTorso},
        {parts.UpperTorso, parts.LeftUpperArm},
        {parts.UpperTorso, parts.RightUpperArm},
        {parts.LeftUpperArm, parts.LeftLowerArm},
        {parts.RightUpperArm, parts.RightLowerArm},
        {parts.LeftLowerArm, parts.LeftHand},
        {parts.RightLowerArm, parts.RightHand},
        {parts.UpperTorso, parts.LowerTorso},
        {parts.LowerTorso, parts.LeftUpperLeg},
        {parts.LowerTorso, parts.RightUpperLeg},
        {parts.LeftUpperLeg, parts.LeftLowerLeg},
        {parts.RightUpperLeg, parts.RightLowerLeg},
        {parts.LeftLowerLeg, parts.LeftFoot},
        {parts.RightLowerLeg, parts.RightFoot}
    }
    for i, connection in ipairs(connections) do
        if skellyLines[i] then
            if connection[1] and connection[2] then
                local pos1, onScreen1 = camera:WorldToScreenPoint(connection[1].Position)
                local pos2, onScreen2 = camera:WorldToScreenPoint(connection[2].Position)
                if onScreen1 and onScreen2 then
                    skellyLines[i].Visible = true
                    skellyLines[i].From = Vector2.new(pos1.X, pos1.Y + guiInset.Y)
                    skellyLines[i].To = Vector2.new(pos2.X, pos2.Y + guiInset.Y)
                else
                    skellyLines[i].Visible = false
                end
            else
                skellyLines[i].Visible = false
            end
        end
    end
end

local function updateESP()
    for playerName, espData in pairs(traced) do
        if not players:FindFirstChild(playerName) then
            if espData.line then espData.line.Visible = false end
            if espData.box then espData.box.Visible = false end
            if espData.skelly then
                for _, line in ipairs(espData.skelly) do
                    line.Visible = false
                end
            end
            traced[playerName] = nil
        end
    end
    
    for _, playerObj in pairs(players:GetPlayers()) do
        if playerObj ~= player and playerObj.Character then
            local character = playerObj.Character
            if isAlive(character) and not isInTeam(character, false) then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local rootPos, onScreen = camera:WorldToScreenPoint(rootPart.Position)
                    
                    if not traced[playerObj.Name] then
                        traced[playerObj.Name] = {
                            line = createLine(),
                            box = createSquare(),
                            skelly = createSkelly()
                        }
                    end
                    local espData = traced[playerObj.Name]
                   
                    if toggles.tracers and espData.line then
                        espData.line.Visible = onScreen
                        if onScreen then
                            espData.line.To = Vector2.new(rootPos.X, rootPos.Y + guiInset.Y)
                        end
                    elseif espData.line then
                        espData.line.Visible = false
                    end
                   
                    if toggles.hESP and espData.box then
                        local boxPos, boxSize = getCharacterBoundingBox(character)
                        if boxPos and boxSize then
                            espData.box.Visible = true
                            espData.box.Position = boxPos
                            espData.box.Size = boxSize
                        else
                            espData.box.Visible = false
                        end
                    elseif espData.box then
                        espData.box.Visible = false
                    end
                   
                    if toggles.skellyESP and espData.skelly then
                        updateSkellyESP(playerObj, character, espData.skelly)
                    elseif espData.skelly then
                        for _, line in ipairs(espData.skelly) do
                            if line then
                                line.Visible = false
                            end
                        end
                    end
                end
            else
                if traced[playerObj.Name] then
                    if traced[playerObj.Name].line then traced[playerObj.Name].line.Visible = false end
                    if traced[playerObj.Name].box then traced[playerObj.Name].box.Visible = false end
                    if traced[playerObj.Name].skelly then
                        for _, line in ipairs(traced[playerObj.Name].skelly) do
                            line.Visible = false
                        end
                    end
                end
            end
        else
            if traced[playerObj.Name] then
                if traced[playerObj.Name].line then traced[playerObj.Name].line.Visible = false end
                if traced[playerObj.Name].box then traced[playerObj.Name].box.Visible = false end
                if traced[playerObj.Name].skelly then
                    for _, line in ipairs(traced[playerObj.Name].skelly) do
                        line.Visible = false
                    end
                end
            end
        end
    end
end

local function updateFOV()
    if fovCircle and toggles.showfov then
        fovCircle.Visible = true
        fovCircle.Position = Vector2.new(mouse.X, mouse.Y + guiInset.Y)
        fovCircle.Radius = toggles.fov
    elseif fovCircle then
        fovCircle.Visible = false
    end
end

local function cleanupPlayerESP(playerName)
    if traced[playerName] then
        if traced[playerName].line then
            traced[playerName].line:Remove()
        end
        if traced[playerName].box then
            traced[playerName].box:Remove()
        end
        if traced[playerName].skelly then
            for _, line in ipairs(traced[playerName].skelly) do
                if line then
                    line:Remove()
                end
            end
        end
        traced[playerName] = nil
    end
end

run.Stepped:Connect(function()
    pcall(function()
        updateFOV()
        updateESP()
        setfpscap(999)
        
        -- Aimbot
        if toggles.aimbot and toggles.iag then
            local closestPlayer = getClosestPlayer(false)
            if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild(toggles.abp) then
                local targetPart = closestPlayer.Character[toggles.abp]
                local targetPosition = targetPart.Position
                local newCFrame = calculateCameraMovement(targetPosition)
                camera.CFrame = newCFrame
            end
        end
        
        -- Triggerbot
        triggerbot()
    end)
end)

players.PlayerRemoving:Connect(function(leavingPlayer)
    pcall(function()
        cleanupPlayerESP(leavingPlayer.Name)
    end)
end)

player:GetPropertyChangedSignal("Team"):Connect(function() end)
initializeFOV()
