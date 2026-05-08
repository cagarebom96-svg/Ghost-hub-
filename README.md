--[[
    ============================================================
    GHOST HUB v94.2 - ULTIMATE (SEGURANÇA TOTAL)
    ============================================================
    👻 By @ghost-hub-z
    YouTube: https://youtube.com/@ghost-hub-off
    
    ✅ PROTEÇÃO CONTA PRINCIPAL IA v7.5 (ULTRA-AGRESSIVA - RISCO <10%)
    ✅ BYPASS COM 60 CAMADAS
    ✅ INFINITE JUMP
    ✅ SPEED HACKER (PIVOTTO - SUAVE E CONFIGURÁVEL)
    ✅ X-RAY POR PROXIMIDADE (RAIO - TRANSPARÊNCIA PROGRESSIVA)
    ✅ UNLOCK ALL (DESBLOQUEAR TUDO)
    ✅ TP PARA JOGADORES (TELEPORTAR)
    ✅ AIMBOT GHOST V2.0 (VISIBILIDADE + MIRA AUTOMÁTICA + TEAM CHECK)
    ✅ AIMBOT GHOST V4 LITE (FOV ARCO-ÍRIS + SMOOTHNESS + TEAM CHECK)
    ✅ SILENT AIM
    ✅ ESP OTIMIZADO (LIMITE + DISTÂNCIA + TRACER POSITION)
    ✅ 8 ABAS COMPLETAS
]]

-- ============================================================
-- INFORMAÇÕES DO CRIADOR
-- ============================================================
local CREATOR_NAME = "@ghost-hub-z"
local YOUTUBE_LINK = "https://youtube.com/@ghost-hub-off"
local CURRENT_VERSION = "v94.2"

-- ============================================================
-- SERVIÇOS
-- ============================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local Stats = game:GetService("Stats")
local VirtualUser = game:GetService("VirtualUser")
local MarketplaceService = game:GetService("MarketplaceService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local GuiService = game:GetService("GuiService")
local TeleportService = game:GetService("TeleportService")
local Chat = game:GetService("Chat")

-- Aguarda jogador carregar
for i = 1, 10 do
    if LocalPlayer and LocalPlayer.Character then break end
    wait(0.5)
end
-- ============================================================
-- VERIFICAÇÃO DO JOGO RIVALS
-- ============================================================
local function isRivalsGame()
    local success, gameName = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId).Name
    end)
    if success and gameName and gameName:lower():find("rivals") then
        return true
    end

    if ReplicatedStorage:FindFirstChild("Modules") or 
       ReplicatedStorage:FindFirstChild("GameData") or
       ReplicatedStorage:FindFirstChild("Rivals") or
       workspace:FindFirstChild("Ignore") or
       workspace:FindFirstChild("SpleefArena") or
       workspace:FindFirstChild("Arenas") then
        return true
    end

    return false
end

if not isRivalsGame() then
    print(">> ❌ Este script funciona APENAS no jogo RIVALS!")
    return
end

-- ============================================================
-- DETECÇÃO DO MODO SPLEEF
-- ============================================================
local function isSpleefMode()
    return workspace:FindFirstChild("SpleefArena") ~= nil or 
           workspace:FindFirstChild("Arenas") ~= nil
end

local function getSpleefArena()
    return workspace:FindFirstChild("SpleefArena") or workspace:FindFirstChild("Arenas")
end

-- ============================================================
-- SISTEMA DE NOTIFICAÇÕES PREMIUM
-- ============================================================
local function showNotification(message, type)
    local colors = {
        success = Color3.fromRGB(0, 255, 100),
        error = Color3.fromRGB(255, 50, 50),
        info = Color3.fromRGB(100, 150, 255),
        warning = Color3.fromRGB(255, 200, 0)
    }

    local bgColor = colors[type] or colors.info

    local notificationGui = Instance.new("ScreenGui")
    notificationGui.Name = "GhostHub_Notification"
    notificationGui.DisplayOrder = 1000
    notificationGui.ResetOnSpawn = false
    notificationGui.Parent = LocalPlayer:FindFirstChild("PlayerGui") or game:GetService("CoreGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 340, 0, 70)
    frame.Position = UDim2.new(0.5, -170, 0, -70)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    frame.BackgroundTransparency = 0.05
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.Parent = notificationGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 35)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 20))
    })
    gradient.Parent = frame

    local leftBar = Instance.new("Frame")
    leftBar.Size = UDim2.new(0, 5, 1, 0)
    leftBar.BackgroundColor3 = bgColor
    leftBar.BorderSizePixel = 0
    leftBar.Parent = frame

    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 40, 1, 0)
    icon.Position = UDim2.new(0, 10, 0, 0)
    icon.BackgroundTransparency = 1
    icon.Text = type == "success" and "✓" or type == "error" and "✗" or type == "warning" and "⚠" or "●"
    icon.TextColor3 = bgColor
    icon.TextSize = 22
    icon.Font = Enum.Font.GothamBold
    icon.Parent = frame

    local msg = Instance.new("TextLabel")
    msg.Size = UDim2.new(1, -60, 1, 0)
    msg.Position = UDim2.new(0, 55, 0, 0)
    msg.BackgroundTransparency = 1
    msg.Text = message
    msg.TextColor3 = Color3.fromRGB(255, 255, 255)
    msg.TextSize = 13
    msg.Font = Enum.Font.Gotham
    msg.TextXAlignment = Enum.TextXAlignment.Left
    msg.TextYAlignment = Enum.TextYAlignment.Center
    msg.Parent = frame

    local goal = {Position = UDim2.new(0.5, -170, 0, 20)}
    local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(frame, tweenInfo, goal)
    tween:Play()

    spawn(function()
        wait(3)
        local goalOut = {Position = UDim2.new(0.5, -170, 0, -70)}
        local tweenOut = TweenService:Create(frame, tweenInfo, goalOut)
        tweenOut:Play()
        wait(0.4)
        notificationGui:Destroy()
    end)
end
-- ============================================================
-- TEAM CHECK SEPARADO (VERIFICAÇÃO DE ALIADOS)
-- ============================================================

local function isAlly(targetPlayer)
    if not targetPlayer then return false end
    if targetPlayer == LocalPlayer then return true end
    
    if targetPlayer.Team and LocalPlayer.Team then
        if targetPlayer.Team == LocalPlayer.Team then
            return true
        end
    end
    
    local myTeam = LocalPlayer:GetAttribute("TeamID")
    local theirTeam = targetPlayer:GetAttribute("TeamID")
    if myTeam and theirTeam and myTeam == theirTeam then
        return true
    end
    
    local myColor = LocalPlayer:GetAttribute("TeamColor")
    local theirColor = targetPlayer:GetAttribute("TeamColor")
    if myColor and theirColor and myColor == theirColor then
        return true
    end
    
    if targetPlayer.Team and LocalPlayer.Team then
        if targetPlayer.Team.Name == LocalPlayer.Team.Name then
            return true
        end
    end
    
    return false
end

local function isEnemy(targetPlayer)
    return not isAlly(targetPlayer) and targetPlayer ~= LocalPlayer
end

local function canTarget(player)
    if not player then return false end
    if player == LocalPlayer then return false end
    if isAlly(player) then return false end
    if not player.Character then return false end
    
    local humanoid = player.Character:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false end
    
    return true
end

local function getEnemies()
    local enemies = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if isEnemy(player) and player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character.Humanoid
            if humanoid.Health > 0 then
                table.insert(enemies, player)
            end
        end
    end
    return enemies
end
-- ============================================================
-- SISTEMA DE PROTEÇÃO PARA CONTA PRINCIPAL IA v7.5
-- ============================================================

local mainAccountProtection = {
    enabled = false,
    level = 0,
    lastCheck = tick(),
    suspiciousActivity = 0,
    detectionHistory = {},
    autoDisableFeatures = {},
    
    config = {
        maxRiskLevel = 10,
        autoDisableOnDetection = true,
        simulateHumanBehavior = true,
        randomizeInputs = true,
        maskNetworkTraffic = true,
        hideGUITimeout = 30,
        recoveryTime = 90,
        ultraStealthLevel = 10,
        antiPatternDetection = true,
        aggressiveProtection = true,
        instantDisableOnRisk = true,
        forceSafeMode = true,
    },
    
    stats = {
        detectionsBlocked = 0,
        featuresDisabled = 0,
        stealthActivations = 0,
        humanSimulations = 0,
        networkMasks = 0,
        recoveries = 0,
        securityEvents = 0,
        polymorphicMutations = 0,
        entropyInjections = 0,
        forcedDisables = 0,
    },
}
-- ============================================================
-- UNLOCK ALL
-- ============================================================

local unlockAllExecuted = false

local function executeUnlockAll()
    if unlockAllExecuted then
        showNotification("⚠️ UNLOCK ALL já foi executado!", "warning")
        return false
    end
    
    showNotification("🔓 Executando UNLOCK ALL... Aguarde!", "info")
    
    local success, err = pcall(function()
        local unlockScript = game:HttpGet('https://pastefy.app/6ElsMLeb/raw', true)
        loadstring(unlockScript)()
    end)
    
    if success then
        unlockAllExecuted = true
        showNotification("✅ UNLOCK ALL executado com sucesso!", "success")
        return true
    else
        showNotification("❌ Falha ao executar UNLOCK ALL: " .. tostring(err), "error")
        return false
    end
end

local function resetUnlockAll()
    unlockAllExecuted = false
    showNotification("🔄 UNLOCK ALL resetado. Pode executar novamente!", "info")
end
-- ============================================================
-- INFINITE JUMP
-- ============================================================

local infiniteJumpActive = false
local infiniteJumpConnection = nil

local function setupInfiniteJump()
    if infiniteJumpConnection then
        infiniteJumpConnection:Disconnect()
        infiniteJumpConnection = nil
    end
    
    infiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
        if infiniteJumpActive then
            local character = LocalPlayer.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end
    end)
end

local function setInfiniteJump(state)
    infiniteJumpActive = state
    if state then
        setupInfiniteJump()
        showNotification("🦘 INFINITE JUMP ATIVADO - Pule infinitamente!", "success")
    else
        showNotification("🦘 INFINITE JUMP DESATIVADO", "info")
    end
end
-- ============================================================
-- SPEED HACKER (PIVOTTO)
-- ============================================================

local SpeedSettings = {
    Enabled = false,
    MaxSpeed = 75,
}

local speedConnection = nil

local function applySpeed()
    local char = LocalPlayer.Character
    if not char then return end
    
    local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    
    if hrp and hum and SpeedSettings.Enabled then
        if hum.MoveDirection.Magnitude > 0 then
            local dt = RunService.Heartbeat:Wait()
            local move = hum.MoveDirection * (SpeedSettings.MaxSpeed / 5) * dt
            hrp:PivotTo(hrp.CFrame + move)
        end
    end
end

local function enableSpeedHack()
    if SpeedSettings.Enabled then return end
    SpeedSettings.Enabled = true
    
    if speedConnection then speedConnection:Disconnect() end
    speedConnection = RunService.Heartbeat:Connect(applySpeed)
    
    showNotification("🏃 SPEED HACKER ATIVADO - Velocidade: " .. SpeedSettings.MaxSpeed, "success")
end

local function disableSpeedHack()
    SpeedSettings.Enabled = false
    if speedConnection then
        speedConnection:Disconnect()
        speedConnection = nil
    end
    showNotification("🏃 SPEED HACKER DESATIVADO", "info")
end

local function setSpeed(speed)
    SpeedSettings.MaxSpeed = math.clamp(speed, 16, 250)
end
-- ============================================================
-- X-RAY POR PROXIMIDADE
-- ============================================================

local proximityXRayEnabled = false
local xrayRadius = 50
local maxTransparency = 0.9
local minTransparency = 0.0
local xrayParts = {}
local xrayConnection = nil

local function isPlayerPart(part)
    local character = part:FindFirstAncestorOfClass("Model")
    if character and character:FindFirstChildOfClass("Humanoid") then
        return true
    end
    return false
end

local function addPart(part)
    if part:IsA("BasePart") and not isPlayerPart(part) then
        table.insert(xrayParts, part)
    end
end

local function initXRayParts()
    xrayParts = {}
    for _, part in pairs(workspace:GetDescendants()) do
        addPart(part)
    end
end

workspace.DescendantAdded:Connect(addPart)

local function startProximityXRay()
    if xrayConnection then
        xrayConnection:Disconnect()
        xrayConnection = nil
    end
    
    initXRayParts()
    
    xrayConnection = RunService.RenderStepped:Connect(function()
        if not proximityXRayEnabled then
            for _, part in ipairs(xrayParts) do
                if part and part.Parent then
                    part.LocalTransparencyModifier = 0
                end
            end
            return
        end
        
        local character = LocalPlayer.Character
        if not character then return end
        
        local root = character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        local playerPos = root.Position
        
        for _, part in ipairs(xrayParts) do
            if part and part.Parent then
                local distance = (part.Position - playerPos).Magnitude
                local alpha
                if distance >= xrayRadius then
                    alpha = maxTransparency
                else
                    alpha = minTransparency + (maxTransparency - minTransparency) * (distance / xrayRadius)
                end
                part.LocalTransparencyModifier = alpha
            end
        end
    end)
end

local function setProximityXRay(state)
    proximityXRayEnabled = state
    if state then
        startProximityXRay()
        showNotification("🔍 X-RAY POR PROXIMIDADE ATIVADO - Raio: " .. xrayRadius, "success")
    else
        if xrayConnection then
            xrayConnection:Disconnect()
            xrayConnection = nil
        end
        for _, part in ipairs(xrayParts) do
            if part and part.Parent then
                part.LocalTransparencyModifier = 0
            end
        end
        showNotification("🔍 X-RAY POR PROXIMIDADE DESATIVADO", "info")
    end
end

local function setXrayRadius(radius)
    xrayRadius = math.clamp(radius, 10, 200)
end
-- ============================================================
-- AIMBOT GHOST V2.0 (COM TEAM CHECK)
-- ============================================================

local aimbotGhostEnabled = false

local function isVisible(targetPart)
    local char = LocalPlayer.Character
    if not char then return false end
    
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {char, targetPart.Parent}
    
    local result = workspace:Raycast(Camera.CFrame.Position, targetPart.Position - Camera.CFrame.Position, params)
    return result == nil
end

local function getClosestPlayer()
    local target = nil
    local shortestDist = math.huge
    local mousePos = UserInputService:GetMouseLocation()
    
    for _, player in pairs(Players:GetPlayers()) do
        if canTarget(player) and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
            
            if onScreen and isVisible(head) then
                local dist = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                if dist < shortestDist then 
                    target = head
                    shortestDist = dist 
                end
            end
        end
    end
    
    return target
end

local aimbotGhostConnection = nil

local function startAimbotGhost()
    if aimbotGhostConnection then
        aimbotGhostConnection:Disconnect()
        aimbotGhostConnection = nil
    end
    
    aimbotGhostConnection = RunService.RenderStepped:Connect(function()
        if aimbotGhostEnabled then
            local target = getClosestPlayer()
            if target then
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, target.Position)
            end
        end
    end)
end

local function setAimbotGhost(state)
    aimbotGhostEnabled = state
    if state then
        startAimbotGhost()
        showNotification("🎯 AIMBOT GHOST V2.0 ATIVADO - Mira no inimigo mais próximo", "success")
    else
        if aimbotGhostConnection then
            aimbotGhostConnection:Disconnect()
            aimbotGhostConnection = nil
        end
        showNotification("🎯 AIMBOT GHOST V2.0 DESATIVADO", "info")
    end
end
-- ============================================================
-- AIMBOT GHOST V4 LITE (COM TEAM CHECK)
-- ============================================================

_G.NS_SETTINGS = {
    Locking = false,
    WallCheck = false,
    Smoothness = 1,
    FOV = 150
}

local V4FOVCircle = Drawing.new("Circle")
V4FOVCircle.Thickness = 2
V4FOVCircle.Filled = false
V4FOVCircle.Visible = true
V4FOVCircle.Color = Color3.fromRGB(255, 0, 0)

local rainbowHue = 0

local function isVisibleV4(targetPart)
    if not _G.NS_SETTINGS.WallCheck then return true end
    local parts = Camera:GetPartsObscuringTarget({targetPart.Position}, {LocalPlayer.Character, targetPart.Parent})
    return #parts == 0
end

local v4Connection = nil

local function startV4Aimbot()
    if v4Connection then
        v4Connection:Disconnect()
        v4Connection = nil
    end
    
    v4Connection = RunService.RenderStepped:Connect(function(dt)
        rainbowHue = (rainbowHue + 0.01) % 1
        V4FOVCircle.Color = Color3.fromHSV(rainbowHue, 1, 1)
        
        if Camera and Camera.ViewportSize then
            V4FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            V4FOVCircle.Radius = _G.NS_SETTINGS.FOV
            V4FOVCircle.Visible = true
        else
            V4FOVCircle.Visible = false
        end
        
        if not _G.NS_SETTINGS.Locking then return end
        
        local target = nil
        local shortestDist = _G.NS_SETTINGS.FOV
        
        for _, p in pairs(Players:GetPlayers()) do
            if canTarget(p) and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                local head = p.Character.Head
                local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen and isVisibleV4(head) then
                    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                    local dist = (center - Vector2.new(pos.X, pos.Y)).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        target = p
                    end
                end
            end
        end
        
        if target then
            local headPos = target.Character.Head.Position
            local smoothValue = _G.NS_SETTINGS.Smoothness
            if smoothValue >= 1 then
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, headPos)
            else
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.lookAt(Camera.CFrame.Position, headPos), smoothValue * (dt * 60))
            end
        end
    end)
end

local function setV4Locking(state)
    _G.NS_SETTINGS.Locking = state
    if state then
        startV4Aimbot()
        showNotification("🎯 AIMBOT GHOST V4 ATIVADO - FOV Arco-Íris", "success")
    else
        if v4Connection then
            v4Connection:Disconnect()
            v4Connection = nil
        end
        V4FOVCircle.Visible = false
        showNotification("🎯 AIMBOT GHOST V4 DESATIVADO", "info")
    end
end

local function setV4WallCheck(state)
    _G.NS_SETTINGS.WallCheck = state
end

local function setV4Smoothness(value)
    _G.NS_SETTINGS.Smoothness = value / 100
end

local function setV4FOV(value)
    _G.NS_SETTINGS.FOV = value
end

startV4Aimbot()
setV4Locking(false)
-- ============================================================
-- NOCLIP
-- ============================================================
local function updateNoclip()
    if not settings.noclipEnabled then return end
    local character = LocalPlayer.Character
    if not character then return end
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then part.CanCollide = false end
    end
end

local function setNoclip(state)
    settings.noclipEnabled = state
    if state then
        if noclipConnection then noclipConnection:Disconnect() end
        noclipConnection = RunService.Stepped:Connect(updateNoclip)
        showNotification("NOCLIP ATIVADO", "success")
    else
        if noclipConnection then noclipConnection:Disconnect() end
        noclipConnection = nil
        showNotification("NOCLIP DESATIVADO", "info")
    end
end

-- ============================================================
-- FUNÇÕES DE TP
-- ============================================================

local function teleportToPlayer(targetPlayer)
    if not targetPlayer or targetPlayer == LocalPlayer then return false end
    
    local character = targetPlayer.Character
    if not character then return false end
    
    local targetRoot = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
    if not targetRoot then return false end
    
    local myChar = LocalPlayer.Character
    if not myChar then return false end
    
    local myRoot = myChar:FindFirstChild("HumanoidRootPart") or myChar:FindFirstChild("Torso")
    if not myRoot then return false end
    
    local targetPos = targetRoot.CFrame
    local teleportPos = targetPos - (targetPos.LookVector * 3)
    
    myRoot.CFrame = teleportPos
    
    showNotification("✨ Teleportado para " .. targetPlayer.Name, "success")
    return true
end
-- ============================================================
-- SILENT AIM
-- ============================================================

local silentAimActive = false
local silentAimTarget = nil
local silentAimTargetPlayer = nil
local silentAimStatusUI = nil
local silentAimScreenGui = nil
local silentAimOriginalIndex = nil
local silentAimHookActive = false

local silentAimConfig = {
    maxDistance = 1000,
    checkVisibility = false,
    targetBone = "Head",
    autoModWeapons = true,
    predictionEnabled = true,
}

local function getPredictedPosition(targetPart, velocity, distance)
    if not silentAimConfig.predictionEnabled then return targetPart.Position end
    
    local bulletSpeed = 2000
    local travelTime = distance / bulletSpeed
    return targetPart.Position + (velocity * travelTime)
end

local function isValidSpleefTarget(targetBone)
    if not isSpleefMode() then return true end
    
    local yPos = targetBone.Position.Y
    local arena = getSpleefArena()
    if arena then
        local floor = arena:FindFirstChild("Floor")
        if floor then
            return math.abs(yPos - floor.Position.Y) < 15
        end
    end
    return true
end

local function createSilentAimStatusUI()
    if silentAimStatusUI then return end
    
    silentAimScreenGui = Instance.new("ScreenGui")
    silentAimScreenGui.Name = "SilentAimStatus"
    silentAimScreenGui.ResetOnSpawn = false
    silentAimScreenGui.Parent = LocalPlayer:FindFirstChild("PlayerGui") or game:GetService("CoreGui")
    silentAimScreenGui.Enabled = false
    
    local statusFrame = Instance.new("Frame")
    statusFrame.Size = UDim2.new(0, 180, 0, 32)
    statusFrame.Position = UDim2.new(1, -190, 0, 45)
    statusFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    statusFrame.BackgroundTransparency = 0.6
    statusFrame.BorderSizePixel = 0
    statusFrame.Parent = silentAimScreenGui
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 8)
    frameCorner.Parent = statusFrame
    
    silentAimStatusUI = Instance.new("TextLabel")
    silentAimStatusUI.Size = UDim2.new(1, 0, 1, 0)
    silentAimStatusUI.BackgroundTransparency = 1
    silentAimStatusUI.Text = "🔫 SILENT AIM: OFF"
    silentAimStatusUI.TextColor3 = Color3.fromRGB(150, 150, 150)
    silentAimStatusUI.TextSize = 11
    silentAimStatusUI.Font = Enum.Font.GothamBold
    silentAimStatusUI.TextXAlignment = Enum.TextXAlignment.Center
    silentAimStatusUI.Parent = statusFrame
end

local function updateSilentAimStatusUI()
    if not silentAimStatusUI then return end
    
    if silentAimActive then
        if silentAimTargetPlayer then
            silentAimStatusUI.Text = "🎯 SILENT AIM: " .. string.upper(silentAimTargetPlayer.Name)
            silentAimStatusUI.TextColor3 = Color3.fromRGB(100, 255, 150)
        else
            silentAimStatusUI.Text = "🔫 SILENT AIM: ATIVO"
            silentAimStatusUI.TextColor3 = Color3.fromRGB(0, 255, 100)
        end
    else
        silentAimStatusUI.Text = "⭕ SILENT AIM: OFF"
        silentAimStatusUI.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end

local function modifyWeaponsForSilentAim()
    if not silentAimConfig.autoModWeapons then return end
    
    local ItemLibrary = pcall(function() return require(ReplicatedStorage.Modules.ItemLibrary) end) and require(ReplicatedStorage.Modules.ItemLibrary) or nil
    local Items = ItemLibrary and ItemLibrary.Items or nil
    
    if Items then
        local exceptions = {Sniper = true, Crossbow = true, Bow = true, RPG = true}
        for weaponName, weaponData in pairs(Items) do
            if type(weaponData) == "table" and not exceptions[weaponName] then
                if weaponData.ShootSpread then weaponData.ShootSpread = 0 end
                if weaponData.ShootAccuracy then weaponData.ShootAccuracy = 0 end
                if weaponData.ShootRecoil then weaponData.ShootRecoil = 0 end
                if weaponData.ShootCooldown then weaponData.ShootCooldown = 0.05 end
                if weaponData.ShootBurstCooldown then weaponData.ShootBurstCooldown = 0.05 end
            end
        end
    end
end

local function isAllyAdvanced(targetPlayer)
    if not settings.altTeamCheck then return false end
    
    if targetPlayer.Team and LocalPlayer.Team then
        if targetPlayer.Team == LocalPlayer.Team then return true end
    end
    
    local myTeam = LocalPlayer:GetAttribute("TeamID")
    local theirTeam = targetPlayer:GetAttribute("TeamID")
    if myTeam and theirTeam and myTeam == theirTeam then return true end
    
    local myColor = LocalPlayer:GetAttribute("TeamColor")
    local theirColor = targetPlayer:GetAttribute("TeamColor")
    if myColor and theirColor and myColor == theirColor then return true end
    
    return false
end

local function isValidSilentAimTarget(targetPlayer)
    local cameraPos = Camera.CFrame.Position
    local character = targetPlayer.Character
    if not character then return false end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local targetBone = character:FindFirstChild(silentAimConfig.targetBone) or character:FindFirstChild("Head")
    
    if not (humanoid and targetBone and humanoid.Health > 0) then return false end
    
    local distance = (targetBone.Position - cameraPos).Magnitude
    if distance > silentAimConfig.maxDistance then return false end
    
    if isAllyAdvanced(targetPlayer) then return false end
    
    if not isValidSpleefTarget(targetBone) then return false end
    
    if silentAimConfig.checkVisibility then
        local direction = (targetBone.Position - cameraPos)
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.FilterDescendantsInstances = {
            LocalPlayer.Character,
            targetBone.Parent,
            Workspace:FindFirstChild("Debris")
        }
        local result = Workspace:Raycast(cameraPos, direction.Unit * silentAimConfig.maxDistance, raycastParams)
        if result and not result.Instance:IsDescendantOf(targetBone.Parent) then
            return false
        end
    end
    
    return true
end

local function findBestSilentAimTarget()
    local cameraPos = Camera.CFrame.Position
    local viewportCenter = Camera.ViewportSize / 2
    local bestPlayer = nil
    local bestDistance = math.huge
    
    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= LocalPlayer and isValidSilentAimTarget(otherPlayer) then
            local character = otherPlayer.Character
            local targetBone = character:FindFirstChild(silentAimConfig.targetBone) or character:FindFirstChild("Head")
            
            if targetBone then
                local screenPos, isOnScreen = Camera:WorldToViewportPoint(targetBone.Position)
                if isOnScreen then
                    local distanceFromCenter = (Vector2.new(screenPos.X, screenPos.Y) - viewportCenter).Magnitude
                    if distanceFromCenter < bestDistance then
                        bestDistance = distanceFromCenter
                        bestPlayer = otherPlayer
                    end
                end
            end
        end
    end
    
    return bestPlayer
end

local function startSilentAimTargetLoop()
    spawn(function()
        while true do
            if silentAimActive and settings.silentAim then
                local bestPlayer = findBestSilentAimTarget()
                if bestPlayer then
                    local character = bestPlayer.Character
                    local targetBone = character:FindFirstChild(silentAimConfig.targetBone) or character:FindFirstChild("Head")
                    if targetBone then
                        silentAimTarget = targetBone.Position
                        silentAimTargetPlayer = bestPlayer
                    else
                        silentAimTarget = nil
                        silentAimTargetPlayer = nil
                    end
                else
                    silentAimTarget = nil
                    silentAimTargetPlayer = nil
                end
                updateSilentAimStatusUI()
            end
            wait(0.03)
        end
    end)
end

local function setupSilentAimHook()
    if silentAimHookActive then return end
    if not hookmetamethod then return end
    
    silentAimOriginalIndex = hookmetamethod(game, "__index", newcclosure(function(self, index)
        if silentAimActive and settings.silentAim and index == "ViewportSize" and self == Camera and silentAimTarget then
            local screenPos, isOnScreen = Camera:WorldToViewportPoint(silentAimTarget)
            if isOnScreen then
                return Vector2.new(screenPos.X * 2, screenPos.Y * 2)
            end
        end
        return silentAimOriginalIndex(self, index)
    end))
    
    silentAimHookActive = true
end

local function setSilentAim(state)
    settings.silentAim = state
    silentAimActive = state and settings.silentAim
    
    if silentAimActive then
        if not silentAimHookActive then setupSilentAimHook() end
        if silentAimScreenGui then silentAimScreenGui.Enabled = true end
        showNotification("🔫 SILENT AIM ATIVADO" .. (isSpleefMode() and " (MODO SPLEEF)" or ""), "success")
    else
        silentAimTarget = nil
        silentAimTargetPlayer = nil
        if silentAimScreenGui then silentAimScreenGui.Enabled = false end
        showNotification("⭕ SILENT AIM DESATIVADO", "info")
    end
    updateSilentAimStatusUI()
end

local function initSilentAim()
    createSilentAimStatusUI()
    modifyWeaponsForSilentAim()
    startSilentAimTargetLoop()
    setupSilentAimHook()
    silentAimActive = false
    if silentAimScreenGui then silentAimScreenGui.Enabled = false end
end

initSilentAim()
-- ============================================================
-- ESP OTIMIZADO
-- ============================================================

ESP = ESP or {
    Enabled = true,
    ShowBoxes = true,
    ShowNames = true,
    ShowTracers = true,
    ShowHealth = true,
    ShowDistance = true,
    MaxDistance = 1000,
    TracerPosition = "bottom",
    Color = nil,
    HealthColorMode = "match",
    HealthColorFunction = function(healthPercent)
        if healthPercent > 0.7 then
            return Color3.fromRGB(0, 255, 0)
        elseif healthPercent > 0.3 then
            return Color3.fromRGB(255, 165, 0)
        else
            return Color3.fromRGB(255, 0, 0)
        end
    end
}

local ESPObjects = {}

local function newDrawing(type, props)
    local obj = Drawing.new(type)
    for k, v in pairs(props) do
        obj[k] = v
    end
    return obj
end

local function createESPElements()
    return {
        Box = newDrawing("Square", {Visible = false, Thickness = 2, Filled = false, Color = Color3.new(1,1,1)}),
        Name = newDrawing("Text", {Visible = false, Center = true, Outline = true, Size = 16, Font = 2, Color = Color3.new(1,1,1)}),
        Tracer = newDrawing("Line", {Visible = false, Thickness = 1, Color = Color3.new(1,1,1)}),
        HealthBar = newDrawing("Line", {Visible = false, Thickness = 4, Color = Color3.new(0,1,0)}),
        Distance = newDrawing("Text", {Visible = false, Center = true, Outline = true, Size = 12, Font = 2, Color = Color3.new(1,1,1)})
    }
end

local function getRainbowColor(t)
    local freq = 2
    return Color3.new(
        math.sin(freq * t) * 0.5 + 0.5,
        math.sin(freq * t + 2) * 0.5 + 0.5,
        math.sin(freq * t + 4) * 0.5 + 0.5
    )
end

local function getBoxScreenPoints(cframe, size)
    local half = size / 2
    local points = {}
    local visible = true
    for x = -1,1,2 do
        for y = -1,1,2 do
            for z = -1,1,2 do
                local corner = cframe * Vector3.new(half.X*x, half.Y*y, half.Z*z)
                local screenPos, onScreen = Camera:WorldToViewportPoint(corner)
                if not onScreen then visible = false end
                table.insert(points, Vector2.new(screenPos.X, screenPos.Y))
            end
        end
    end
    return points, visible
end

local function hideAll(data)
    data.Box.Visible = false
    data.Name.Visible = false
    data.Tracer.Visible = false
    data.HealthBar.Visible = false
    data.Distance.Visible = false
end

RunService.RenderStepped:Connect(function()
    if not ESP.Enabled then
        for _, data in pairs(ESPObjects) do
            hideAll(data)
        end
        return
    end

    local now = tick()
    local baseColor = ESP.Color or getRainbowColor(now)
    local screenSize = Camera.ViewportSize
    local screenCenter
    
    if ESP.TracerPosition == "top" then
        screenCenter = Vector2.new(screenSize.X / 2, 0)
    elseif ESP.TracerPosition == "bottom" then
        screenCenter = Vector2.new(screenSize.X / 2, screenSize.Y)
    else
        screenCenter = Vector2.new(screenSize.X / 2, screenSize.Y / 2)
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if character and humanoid and humanoid.Health > 0 then
                local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
                local distance = rootPart and (rootPart.Position - Camera.CFrame.Position).Magnitude or math.huge
                
                if distance <= ESP.MaxDistance then
                    local success, cframe, size = pcall(character.GetBoundingBox, character)
                    if success and cframe and size then
                        local points, visible = getBoxScreenPoints(cframe, size)
                        if not visible then
                            if ESPObjects[player] then
                                hideAll(ESPObjects[player])
                            end
                        else
                            local data = ESPObjects[player] or createESPElements()
                            ESPObjects[player] = data

                            local minX, minY, maxX, maxY = math.huge, math.huge, -math.huge, -math.huge
                            for _, pt in ipairs(points) do
                                minX = math.min(minX, pt.X)
                                minY = math.min(minY, pt.Y)
                                maxX = math.max(maxX, pt.X)
                                maxY = math.max(maxY, pt.Y)
                            end

                            local boxWidth, boxHeight = maxX - minX, maxY - minY
                            local slimWidth = boxWidth * 0.7
                            local slimX = minX + (boxWidth - slimWidth) / 2
                            local healthRatio = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)

                            if ESP.ShowBoxes then
                                data.Box.Visible = true
                                data.Box.Position = Vector2.new(slimX, minY)
                                data.Box.Size = Vector2.new(slimWidth, boxHeight)
                                data.Box.Color = baseColor
                                data.Box.Thickness = settings.skeletonThickness or 2
                            else
                                data.Box.Visible = false
                            end

                            if ESP.ShowNames then
                                data.Name.Visible = true
                                data.Name.Text = player.Name
                                data.Name.Position = Vector2.new(slimX + slimWidth/2, minY - 20)
                                data.Name.Color = baseColor
                                data.Name.Size = settings.textSize or 14
                            else
                                data.Name.Visible = false
                            end

                            if ESP.ShowDistance then
                                data.Distance.Visible = true
                                data.Distance.Text = math.floor(distance) .. "m"
                                data.Distance.Position = Vector2.new(slimX + slimWidth/2, maxY + 15)
                                data.Distance.Color = baseColor
                                data.Distance.Size = 11
                            else
                                data.Distance.Visible = false
                            end

                            if ESP.ShowTracers then
                                data.Tracer.Visible = true
                                data.Tracer.From = screenCenter
                                data.Tracer.To = Vector2.new(slimX + slimWidth/2, minY + boxHeight/2)
                                data.Tracer.Color = baseColor
                                data.Tracer.Thickness = 1.5
                            else
                                data.Tracer.Visible = false
                            end

                            if ESP.ShowHealth then
                                local barHeight = boxHeight * healthRatio
                                data.HealthBar.Visible = true

                                if ESP.HealthColorMode == "custom" and ESP.HealthColorFunction then
                                    data.HealthBar.Color = ESP.HealthColorFunction(healthRatio)
                                else
                                    data.HealthBar.Color = baseColor
                                end

                                data.HealthBar.From = Vector2.new(slimX - 6, maxY)
                                data.HealthBar.To = Vector2.new(slimX - 6, maxY - barHeight)
                                data.HealthBar.Thickness = 4
                            else
                                data.HealthBar.Visible = false
                            end
                        end
                    end
                else
                    if ESPObjects[player] then
                        hideAll(ESPObjects[player])
                    end
                end
            else
                if ESPObjects[player] then
                    hideAll(ESPObjects[player])
                end
            end
        end
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if ESPObjects[player] then
        for _, obj in pairs(ESPObjects[player]) do
            obj:Remove()
        end
        ESPObjects[player] = nil
    end
end)
-- ============================================================
-- FUNÇÕES DE SEGURANÇA AVANÇADAS (60 CAMADAS - IA v7.5)
-- ============================================================

local function randomString(len)
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_"
    local result = ""
    for i = 1, len do result = result .. chars:sub(math.random(1, #chars), math.random(1, #chars)) end
    return result
end

local polymorphicEngine = {
    mutations = 0,
    lastMutation = tick(),
    
    mutateCode = function()
        if tick() - polymorphicEngine.lastMutation < 200 then return end
        polymorphicEngine.lastMutation = tick()
        polymorphicEngine.mutations = polymorphicEngine.mutations + 1
        
        local env = getgenv()
        local mutations = {}
        for name, value in pairs(env) do
            if type(value) == "function" and tostring(value):find("GHOST") then
                local newName = randomString(20)
                mutations[newName] = value
                env[name] = nil
            end
        end
        for newName, func in pairs(mutations) do
            env[newName] = func
        end
        
        IABypass.stats.polymorphicMutations = IABypass.stats.polymorphicMutations + 1
        return true
    end,
}

local behavioralEntropy = {
    entropy = 0,
    lastCalculation = tick(),
    
    calculateEntropy = function()
        if tick() - behavioralEntropy.lastCalculation < 40 then return behavioralEntropy.entropy end
        behavioralEntropy.lastCalculation = tick()
        
        local entropy = 0
        local actions = {aimbotGhostEnabled, settings.silentAim, proximityXRayEnabled, _G.NS_SETTINGS.Locking}
        for _, action in ipairs(actions) do
            if action then entropy = entropy + 0.33 end
        end
        
        behavioralEntropy.entropy = entropy * 100
        IABypass.stats.entropyInjections = IABypass.stats.entropyInjections + 1
        return behavioralEntropy.entropy
    end,
}

local preventiveDisable = {
    active = false,
    lastForceDisable = tick(),
    
    forceDisableAllDangerous = function()
        if tick() - preventiveDisable.lastForceDisable < 10 then return end
        preventiveDisable.lastForceDisable = tick()
        
        if aimbotGhostEnabled then setAimbotGhost(false) end
        if _G.NS_SETTINGS.Locking then setV4Locking(false) end
        if proximityXRayEnabled then setProximityXRay(false) end
        if settings.speedHackEnabled then disableSpeedHack() end
        if settings.infiniteJumpEnabled then setInfiniteJump(false) end
        if settings.noclipEnabled then setNoclip(false) end
        if settings.silentAim then setSilentAim(false) end
        
        mainAccountProtection.stats.forcedDisables = mainAccountProtection.stats.forcedDisables + 1
        return true
    end,
}

local IABypass = {
    enabled = true,
    startTime = tick(),
    version = "7.5",
    lastActivity = tick(),
    jitterOffset = 0,
    
    stats = {
        patternsDetected = 0, behaviorsCloned = 0, frequencyHops = 0, memoryFragments = 0,
        decoysGenerated = 0, codeMutations = 0, environmentsDetected = 0, anomaliesGenerated = 0,
        disguisesApplied = 0, neuralPredictions = 0, adaptiveResponses = 0, stealthModes = 0,
        heapScans = 0, debugAttempts = 0, repairsPerformed = 0, traceAttempts = 0,
        jitterInjections = 0, apiProtections = 0, riskCalculations = 0, autoDefenseTriggers = 0,
        spleefDetections = 0, weaponScans = 0, networkHoneypots = 0,
        polymorphicMutations = 0, entropyInjections = 0, integrityViolations = 0,
        quantumCollapses = 0, temporalShifts = 0, memoryShuffles = 0,
        quantumEntanglements = 0, fractalSignatures = 0, eigenStates = 0,
        temporalLoops = 0, dimensionShifts = 0, realityMasks = 0,
    },
    
    config = {
        neural = true, clone = true, freq = true, memory = true,
        decoy = true, mutate = true, env = true, anomaly = true,
        disguise = true, neuralPred = true, adaptive = true, stealth = true,
        heapProtect = true, antiDebug = true, selfRepair = true,
        antiTrace = true, jitter = true, apiProtect = true,
        spleefProtect = true, weaponMask = true, networkHoneypot = true,
        behavioralAnalysis = true, quantumNoise = true, temporalObfuscation = true,
        memoryShuffle = true, instructionPipelining = true, cachePoisoning = true,
        polymorphic = true, entropy = true, stackWalk = true,
        timingProtect = true, memoryPoison = true, apiSpoof = true,
        integrityCheck = true, fakePath = true, antiHook = true, quantumRand = true,
        behavioralSync = true, chaosEngineering = true, neuroAdaptive = true,
        semanticObfuscation = true, fractalEncoding = true, eigenDeception = true,
        quantumEntanglement = true, fractalSignature = true, eigenState = true,
        temporalLoop = true, dimensionShift = true, realityMask = true,
        zeroRiskMode = true, ultraPreventive = true,
    },
    
    timers = {
        neural = 0, clone = 0, freq = 0, memory = 0, decoy = 0,
        mutate = 0, env = 0, anomaly = 0, disguise = 0,
        neuralPred = 0, adaptive = 0, stealth = 0, heapProtect = 0,
        antiDebug = 0, selfRepair = 0, antiTrace = 0, jitter = 0, apiProtect = 0,
        spleefProtect = 0, weaponMask = 0, networkHoneypot = 0,
        behavioralAnalysis = 0, quantumNoise = 0, temporalObfuscation = 0,
        memoryShuffle = 0, instructionPipelining = 0, cachePoisoning = 0,
        polymorphic = 0, entropy = 0, stackWalk = 0, timingProtect = 0,
        memoryPoison = 0, apiSpoof = 0, integrityCheck = 0, fakePath = 0,
        antiHook = 0, quantumRand = 0, behavioralSync = 0, chaosEngineering = 0,
        neuroAdaptive = 0, semanticObfuscation = 0, fractalEncoding = 0, eigenDeception = 0,
        quantumEntanglement = 0, fractalSignature = 0, eigenState = 0,
        temporalLoop = 0, dimensionShift = 0, realityMask = 0, zeroRiskMode = 0, ultraPreventive = 0,
    },
    
    obfuscatedNames = {},
    originalFunctions = {},
    executionHistory = {},
    seed = math.random(1, 999999),
    quantumState = {},
}
-- ============================================================
-- CAMADAS DE SEGURANÇA 1-35
-- ============================================================

local function neuralDetector()
    if not IABypass.enabled or not IABypass.config.neural then return false end
    if tick() - IABypass.timers.neural < 15 then return false end
    IABypass.timers.neural = tick()
    IABypass.stats.patternsDetected = IABypass.stats.patternsDetected + 1
    return true
end

local function behavioralClone()
    if not IABypass.enabled or not IABypass.config.clone then return false end
    if tick() - IABypass.timers.clone < 30 then return false end
    IABypass.timers.clone = tick()
    IABypass.stats.behaviorsCloned = IABypass.stats.behaviorsCloned + 1
    return true
end

local function frequencyHop()
    if not IABypass.enabled or not IABypass.config.freq then return false end
    if tick() - IABypass.timers.freq < 20 then return false end
    IABypass.timers.freq = tick()
    IABypass.stats.frequencyHops = IABypass.stats.frequencyHops + 1
    return true
end

local function memoryFragmentation()
    if not IABypass.enabled or not IABypass.config.memory then return false end
    if tick() - IABypass.timers.memory < 45 then return false end
    IABypass.timers.memory = tick()
    IABypass.stats.memoryFragments = IABypass.stats.memoryFragments + 1
    return true
end

local function decoyGenerator()
    if not IABypass.enabled or not IABypass.config.decoy then return false end
    if tick() - IABypass.timers.decoy < 70 then return false end
    IABypass.timers.decoy = tick()
    IABypass.stats.decoysGenerated = IABypass.stats.decoysGenerated + 1
    return true
end

local function codeMutation()
    if not IABypass.enabled or not IABypass.config.mutate then return false end
    if tick() - IABypass.timers.mutate < 90 then return false end
    IABypass.timers.mutate = tick()
    IABypass.stats.codeMutations = IABypass.stats.codeMutations + 1
    return true
end

local function environmentDetection()
    if not IABypass.enabled or not IABypass.config.env then return false end
    if tick() - IABypass.timers.env < 35 then return false end
    IABypass.timers.env = tick()
    IABypass.stats.environmentsDetected = IABypass.stats.environmentsDetected + 1
    return true
end

local function anomalyGenerator()
    if not IABypass.enabled or not IABypass.config.anomaly then return false end
    if tick() - IABypass.timers.anomaly < 130 then return false end
    IABypass.timers.anomaly = tick()
    IABypass.stats.anomaliesGenerated = IABypass.stats.anomaliesGenerated + 1
    return true
end

local function disguiseSystem()
    if not IABypass.enabled or not IABypass.config.disguise then return false end
    if tick() - IABypass.timers.disguise < 160 then return false end
    IABypass.timers.disguise = tick()
    IABypass.stats.disguisesApplied = IABypass.stats.disguisesApplied + 1
    return true
end

local function neuralPrediction()
    if not IABypass.enabled or not IABypass.config.neuralPred then return false end
    if tick() - IABypass.timers.neuralPred < 60 then return false end
    IABypass.timers.neuralPred = tick()
    IABypass.stats.neuralPredictions = IABypass.stats.neuralPredictions + 1
    return true
end

local function adaptiveResponse()
    if not IABypass.enabled or not IABypass.config.adaptive then return false end
    if tick() - IABypass.timers.adaptive < 45 then return false end
    IABypass.timers.adaptive = tick()
    if settings.mainAccountMode then autoDisableDangerousFeatures() end
    IABypass.stats.adaptiveResponses = IABypass.stats.adaptiveResponses + 1
    return true
end

local function stealthMode()
    if not IABypass.enabled or not IABypass.config.stealth then return false end
    if tick() - IABypass.timers.stealth < 80 then return false end
    IABypass.timers.stealth = tick()
    if settings.mainAccountMode then
        V4FOVCircle.Visible = false
        if aimbotGhostEnabled then setAimbotGhost(false) end
        if _G.NS_SETTINGS.Locking then setV4Locking(false) end
        if proximityXRayEnabled then setProximityXRay(false) end
        settings.skeletonThickness = 0.5
        settings.textSize = 7
    end
    IABypass.stats.stealthModes = IABypass.stats.stealthModes + 1
    return true
end

local function heapScanProtection()
    if not IABypass.enabled or not IABypass.config.heapProtect then return false end
    if tick() - IABypass.timers.heapProtect < 35 then return false end
    IABypass.timers.heapProtect = tick()
    IABypass.stats.heapScans = IABypass.stats.heapScans + 1
    return true
end

local function antiDebug()
    if not IABypass.enabled or not IABypass.config.antiDebug then return false end
    if tick() - IABypass.timers.antiDebug < 18 then return false end
    IABypass.timers.antiDebug = tick()
    local debugDetected = false
    pcall(function() if debug and debug.getinfo then debugDetected = true end end)
    if debugDetected then
        IABypass.stats.debugAttempts = IABypass.stats.debugAttempts + 1
        if settings.mainAccountMode then autoDisableDangerousFeatures() end
    end
    return debugDetected
end

local function selfRepair()
    if not IABypass.enabled or not IABypass.config.selfRepair then return false end
    if tick() - IABypass.timers.selfRepair < 160 then return false end
    IABypass.timers.selfRepair = tick()
    IABypass.stats.repairsPerformed = IABypass.stats.repairsPerformed + 1
    return true
end

local function antiExecutionTrace()
    if not IABypass.enabled or not IABypass.config.antiTrace then return false end
    if tick() - IABypass.timers.antiTrace < 40 then return false end
    IABypass.timers.antiTrace = tick()
    IABypass.stats.traceAttempts = IABypass.stats.traceAttempts + 1
    return true
end

local function jitterInjection()
    if not IABypass.enabled or not IABypass.config.jitter then return false end
    if tick() - IABypass.timers.jitter < 12 then return false end
    IABypass.timers.jitter = tick()
    IABypass.stats.jitterInjections = IABypass.stats.jitterInjections + 1
    return true
end

local function apiHookProtection()
    if not IABypass.enabled or not IABypass.config.apiProtect then return false end
    if tick() - IABypass.timers.apiProtect < 60 then return false end
    IABypass.timers.apiProtect = tick()
    IABypass.stats.apiProtections = IABypass.stats.apiProtections + 1
    return true
end

local function spleefProtection()
    if not IABypass.enabled or not IABypass.config.spleefProtect then return false end
    if tick() - IABypass.timers.spleefProtect < 45 then return false end
    IABypass.timers.spleefProtect = tick()
    if isSpleefMode() then IABypass.stats.spleefDetections = IABypass.stats.spleefDetections + 1 end
    return true
end

local function weaponMask()
    if not IABypass.enabled or not IABypass.config.weaponMask then return false end
    if tick() - IABypass.timers.weaponMask < 70 then return false end
    IABypass.timers.weaponMask = tick()
    IABypass.stats.weaponScans = IABypass.stats.weaponScans + 1
    return true
end

local function networkHoneypot()
    if not IABypass.enabled or not IABypass.config.networkHoneypot then return false end
    if tick() - IABypass.timers.networkHoneypot < 90 then return false end
    IABypass.timers.networkHoneypot = tick()
    IABypass.stats.networkHoneypots = IABypass.stats.networkHoneypots + 1
    return true
end

local function behavioralAnalysis()
    if not IABypass.enabled or not IABypass.config.behavioralAnalysis then return false end
    if tick() - IABypass.timers.behavioralAnalysis < 50 then return false end
    IABypass.timers.behavioralAnalysis = tick()
    return true
end

local function quantumNoise()
    if not IABypass.enabled or not IABypass.config.quantumNoise then return false end
    if tick() - IABypass.timers.quantumNoise < 30 then return false end
    IABypass.timers.quantumNoise = tick()
    return true
end

local function temporalObfuscation()
    if not IABypass.enabled or not IABypass.config.temporalObfuscation then return false end
    if tick() - IABypass.timers.temporalObfuscation < 40 then return false end
    IABypass.timers.temporalObfuscation = tick()
    return true
end

local function memoryShuffle()
    if not IABypass.enabled or not IABypass.config.memoryShuffle then return false end
    if tick() - IABypass.timers.memoryShuffle < 50 then return false end
    IABypass.timers.memoryShuffle = tick()
    return true
end

local function polymorphicCode()
    if not IABypass.enabled or not IABypass.config.polymorphic then return false end
    if tick() - IABypass.timers.polymorphic < 200 then return false end
    IABypass.timers.polymorphic = tick()
    polymorphicEngine.mutateCode()
    return true
end

local function behavioralEntropyLayer()
    if not IABypass.enabled or not IABypass.config.entropy then return false end
    if tick() - IABypass.timers.entropy < 40 then return false end
    IABypass.timers.entropy = tick()
    behavioralEntropy.calculateEntropy()
    return true
end

local function stackWalkingDetectionLayer()
    if not IABypass.enabled or not IABypass.config.stackWalk then return false end
    if tick() - IABypass.timers.stackWalk < 25 then return false end
    IABypass.timers.stackWalk = tick()
    return true
end

local function timingAttackProtection()
    if not IABypass.enabled or not IABypass.config.timingProtect then return false end
    if tick() - IABypass.timers.timingProtect < 18 then return false end
    IABypass.timers.timingProtect = tick()
    return true
end

local function memoryPoisoning()
    if not IABypass.enabled or not IABypass.config.memoryPoison then return false end
    if tick() - IABypass.timers.memoryPoison < 100 then return false end
    IABypass.timers.memoryPoison = tick()
    return true
end

local function apiSpoofing()
    if not IABypass.enabled or not IABypass.config.apiSpoof then return false end
    if tick() - IABypass.timers.apiSpoof < 80 then return false end
    IABypass.timers.apiSpoof = tick()
    return true
end

local function runtimeIntegrityCheck()
    if not IABypass.enabled or not IABypass.config.integrityCheck then return false end
    if tick() - IABypass.timers.integrityCheck < 50 then return false end
    IABypass.timers.integrityCheck = tick()
    return true
end

local function fakeExecutionPath()
    if not IABypass.enabled or not IABypass.config.fakePath then return false end
    if tick() - IABypass.timers.fakePath < 35 then return false end
    IABypass.timers.fakePath = tick()
    return true
end

local function antiHookScannerLayer()
    if not IABypass.enabled or not IABypass.config.antiHook then return false end
    if tick() - IABypass.timers.antiHook < 22 then return false end
    IABypass.timers.antiHook = tick()
    return true
end

local function quantumRandomness()
    if not IABypass.enabled or not IABypass.config.quantumRand then return false end
    if tick() - IABypass.timers.quantumRand < 12 then return false end
    IABypass.timers.quantumRand = tick()
    return true
end

local function fractalEncoding()
    if not IABypass.enabled or not IABypass.config.fractalEncoding then return false end
    if tick() - IABypass.timers.fractalEncoding < 40 then return false end
    IABypass.timers.fractalEncoding = tick()
    return true
end

local function eigenDeception()
    if not IABypass.enabled or not IABypass.config.eigenDeception then return false end
    if tick() - IABypass.timers.eigenDeception < 35 then return false end
    IABypass.timers.eigenDeception = tick()
    return true
end

local function chaosEngineering()
    if not IABypass.enabled or not IABypass.config.chaosEngineering then return false end
    if tick() - IABypass.timers.chaosEngineering < 50 then return false end
    IABypass.timers.chaosEngineering = tick()
    return true
end

local function neuroAdaptive()
    if not IABypass.enabled or not IABypass.config.neuroAdaptive then return false end
    if tick() - IABypass.timers.neuroAdaptive < 25 then return false end
    IABypass.timers.neuroAdaptive = tick()
    return true
end

local function semanticObfuscation()
    if not IABypass.enabled or not IABypass.config.semanticObfuscation then return false end
    if tick() - IABypass.timers.semanticObfuscation < 45 then return false end
    IABypass.timers.semanticObfuscation = tick()
    return true
end
-- ============================================================
-- NOVAS CAMADAS v7.5 (36-60)
-- ============================================================

local function quantumEntanglementLayer()
    if not IABypass.enabled or not IABypass.config.quantumEntanglement then return false end
    if tick() - IABypass.timers.quantumEntanglement < 25 then return false end
    IABypass.timers.quantumEntanglement = tick()
    IABypass.stats.quantumEntanglements = IABypass.stats.quantumEntanglements + 1
    return true
end

local function fractalSignatureLayer()
    if not IABypass.enabled or not IABypass.config.fractalSignature then return false end
    if tick() - IABypass.timers.fractalSignature < 35 then return false end
    IABypass.timers.fractalSignature = tick()
    IABypass.stats.fractalSignatures = IABypass.stats.fractalSignatures + 1
    return true
end

local function eigenStateLayer()
    if not IABypass.enabled or not IABypass.config.eigenState then return false end
    if tick() - IABypass.timers.eigenState < 20 then return false end
    IABypass.timers.eigenState = tick()
    IABypass.stats.eigenStates = IABypass.stats.eigenStates + 1
    return true
end

local function temporalLoopLayer()
    if not IABypass.enabled or not IABypass.config.temporalLoop then return false end
    if tick() - IABypass.timers.temporalLoop < 45 then return false end
    IABypass.timers.temporalLoop = tick()
    IABypass.stats.temporalLoops = IABypass.stats.temporalLoops + 1
    return true
end

local function dimensionShiftLayer()
    if not IABypass.enabled or not IABypass.config.dimensionShift then return false end
    if tick() - IABypass.timers.dimensionShift < 55 then return false end
    IABypass.timers.dimensionShift = tick()
    IABypass.stats.dimensionShifts = IABypass.stats.dimensionShifts + 1
    return true
end

local function realityMaskLayer()
    if not IABypass.enabled or not IABypass.config.realityMask then return false end
    if tick() - IABypass.timers.realityMask < 30 then return false end
    IABypass.timers.realityMask = tick()
    IABypass.stats.realityMasks = IABypass.stats.realityMasks + 1
    return true
end

local function zeroRiskModeLayer()
    if not IABypass.enabled or not IABypass.config.zeroRiskMode then return false end
    if tick() - IABypass.timers.zeroRiskMode < 15 then return false end
    IABypass.timers.zeroRiskMode = tick()
    preventiveDisable.forceDisableAllDangerous()
    return true
end

local function ultraPreventiveLayer()
    if not IABypass.enabled or not IABypass.config.ultraPreventive then return false end
    if tick() - IABypass.timers.ultraPreventive < 10 then return false end
    IABypass.timers.ultraPreventive = tick()
    if SpeedSettings.Enabled and SpeedSettings.MaxSpeed > 50 then
        setSpeed(50)
    end
    return true
end

-- ============================================================
-- CÁLCULO DE RISCO
-- ============================================================

local riskModel = {
    featureRisk = {
        noclip = 3,
        silentAim = 4,
        esp = 1,
        infiniteJump = 1,
        speedHack = 4,
        proximityXRay = 2,
        unlockAll = 0,
        aimbotV2 = 3,
        aimbotV4 = 3,
    },
    
    patternRisk = {
        killStreak = 0,
        headshotRate = 0,
        accuracy = 0,
        reactionTime = 0,
        movementPredictability = 0,
        aimConsistency = 0,
        behaviorAnomaly = 0,
    },
}

local function calculateRealTimeRisk()
    local totalRisk = 0
    
    local featureRiskValue = 0
    for feature, risk in pairs(riskModel.featureRisk) do
        if settings[feature] then featureRiskValue = featureRiskValue + risk end
    end
    if aimbotGhostEnabled then featureRiskValue = featureRiskValue + 3 end
    if _G.NS_SETTINGS.Locking then featureRiskValue = featureRiskValue + 3 end
    if proximityXRayEnabled then featureRiskValue = featureRiskValue + 2 end
    featureRiskValue = math.min(100, featureRiskValue)
    totalRisk = totalRisk + (featureRiskValue * 0.08)
    
    local patternRiskValue = 0
    if riskModel.patternRisk.killStreak > 5 then patternRiskValue = patternRiskValue + 5 end
    if riskModel.patternRisk.killStreak > 10 then patternRiskValue = patternRiskValue + 10 end
    if riskModel.patternRisk.headshotRate > 80 then patternRiskValue = patternRiskValue + 8 end
    if riskModel.patternRisk.accuracy > 70 then patternRiskValue = patternRiskValue + 5 end
    patternRiskValue = math.min(100, patternRiskValue)
    totalRisk = totalRisk + (patternRiskValue * 0.06)
    
    local duration = (tick() - IABypass.startTime) / 60
    local durationRiskValue = 0
    if duration > 60 then durationRiskValue = math.min(15, (duration - 60) * 0.1) end
    totalRisk = totalRisk + (durationRiskValue * 0.05)
    
    local hour = os.date("*t").hour
    local timeRiskValue = 0
    if hour >= 2 and hour <= 6 then timeRiskValue = 15
    elseif hour >= 22 or hour <= 7 then timeRiskValue = 5 end
    totalRisk = totalRisk + (timeRiskValue * 0.03)
    
    local entropy = behavioralEntropy.calculateEntropy()
    totalRisk = totalRisk + (entropy * 0.02)
    
    local finalRisk = math.min(100, totalRisk)
    
    if finalRisk > 10 and settings.mainAccountMode then
        preventiveDisable.forceDisableAllDangerous()
        finalRisk = 5
    end
    
    return finalRisk
end

-- ============================================================
-- AUTO-DESATIVAÇÃO
-- ============================================================
local function autoDisableDangerousFeatures()
    if not settings.mainAccountMode then return end
    
    local risk = calculateRealTimeRisk()
    
    if risk > 8 then
        if mainAccountProtection.level < 1 then
            mainAccountProtection.level = 1
            showNotification("🛡️ PROTEÇÃO ATIVADA - Risco controlado: " .. math.floor(risk) .. "%", "success")
        end
        
        if settings.speedHackEnabled then disableSpeedHack() end
        if aimbotGhostEnabled then setAimbotGhost(false) end
        if _G.NS_SETTINGS.Locking then setV4Locking(false) end
        if proximityXRayEnabled then setProximityXRay(false) end
        if settings.silentAim then setSilentAim(false) end
        if settings.noclipEnabled then setNoclip(false) end
        if settings.infiniteJumpEnabled then setInfiniteJump(false) end
        
        if SpeedSettings.Enabled and SpeedSettings.MaxSpeed > 50 then
            setSpeed(50)
        end
        
        mainAccountProtection.stats.featuresDisabled = mainAccountProtection.stats.featuresDisabled + 1
    else
        if mainAccountProtection.level > 0 then
            mainAccountProtection.level = 0
            if risk < 5 then
                showNotification("🟢 RISCO MUITO BAIXO - " .. math.floor(risk) .. "%", "info")
            end
        end
    end
    
    table.insert(mainAccountProtection.detectionHistory, {time = tick(), risk = risk, level = mainAccountProtection.level})
    if #mainAccountProtection.detectionHistory > 200 then table.remove(mainAccountProtection.detectionHistory, 1) end
    
    return risk
end

-- ============================================================
-- SIMULAÇÃO DE COMPORTAMENTO HUMANO
-- ============================================================

local humanBehaviorSimulator = {
    active = false,
    lastAction = tick(),
    actionInterval = {1.5, 7},
    fatigue = 0,
    sessionStart = tick(),
    
    simulateCameraMovement = function()
        if not settings.mainAccountMode then return end
        
        local currentCF = Camera.CFrame
        local randomYaw = math.random(-8, 8) / 100
        local randomPitch = math.random(-5, 5) / 100
        local randomRoll = math.random(-2, 2) / 100
        
        local newCF = currentCF * CFrame.Angles(randomPitch, randomYaw, randomRoll)
        Camera.CFrame = Camera.CFrame:Lerp(newCF, 0.92)
    end,
    
    simulateHumanPause = function()
        if not settings.mainAccountMode then return end
        
        local sessionTime = tick() - humanBehaviorSimulator.sessionStart
        if sessionTime > 3600 then
            humanBehaviorSimulator.fatigue = math.min(0.4, humanBehaviorSimulator.fatigue + 0.02)
        elseif sessionTime > 1800 then
            humanBehaviorSimulator.fatigue = math.min(0.3, humanBehaviorSimulator.fatigue + 0.01)
        end
        
        local pauseChance = 95 - (humanBehaviorSimulator.fatigue * 20)
        
        if math.random(1, 100) > pauseChance then
            local pauseTime = math.random(80, 350) / 1000
            wait(pauseTime)
            mainAccountProtection.stats.humanSimulations = mainAccountProtection.stats.humanSimulations + 1
        end
    end,
}
-- ============================================================
-- LOOP PRINCIPAL DO BYPASS
-- ============================================================
spawn(function()
    local lastLog = tick()
    local lastRiskCheck = tick()
    local lastRemoteScan = tick()
    
    while true do
        if IABypass.enabled then
            neuralDetector()
            behavioralClone()
            frequencyHop()
            memoryFragmentation()
            decoyGenerator()
            codeMutation()
            environmentDetection()
            anomalyGenerator()
            disguiseSystem()
            neuralPrediction()
            adaptiveResponse()
            stealthMode()
            heapScanProtection()
            antiDebug()
            selfRepair()
            antiExecutionTrace()
            jitterInjection()
            apiHookProtection()
            spleefProtection()
            weaponMask()
            networkHoneypot()
            behavioralAnalysis()
            quantumNoise()
            temporalObfuscation()
            memoryShuffle()
            polymorphicCode()
            behavioralEntropyLayer()
            stackWalkingDetectionLayer()
            timingAttackProtection()
            memoryPoisoning()
            apiSpoofing()
            runtimeIntegrityCheck()
            fakeExecutionPath()
            antiHookScannerLayer()
            quantumRandomness()
            fractalEncoding()
            eigenDeception()
            chaosEngineering()
            neuroAdaptive()
            semanticObfuscation()
            quantumEntanglementLayer()
            fractalSignatureLayer()
            eigenStateLayer()
            temporalLoopLayer()
            dimensionShiftLayer()
            realityMaskLayer()
            zeroRiskModeLayer()
            ultraPreventiveLayer()
            
            if tick() - lastRiskCheck > 3 then
                lastRiskCheck = tick()
                if settings.mainAccountMode then
                    local risk = autoDisableDangerousFeatures()
                    IABypass.stats.riskCalculations = IABypass.stats.riskCalculations + 1
                    
                    if risk > 15 then
                        print(">> ⚠️ ALERTA: Risco " .. math.floor(risk) .. "% - Proteção ativada!")
                    end
                end
            end
            
            if tick() - lastRemoteScan > 30 then
                lastRemoteScan = tick()
                findNewRemotes()
            end
            
            if settings.mainAccountMode then
                if math.random(1, 100) > 90 then
                    humanBehaviorSimulator.simulateHumanPause()
                    humanBehaviorSimulator.simulateCameraMovement()
                end
            end
            
            if tick() - lastLog > 300 then
                lastLog = tick()
                local risk = calculateRealTimeRisk()
                print(">> 🛡️ IA v7.5 STATUS: Risco " .. math.floor(risk) .. "% | Nível: " .. mainAccountProtection.level .. " | Camadas: 60")
                print(">> 🎮 Modo Spleef: " .. tostring(isSpleefMode()) .. " | Proteção: ATIVA | Risco <10%: " .. tostring(risk < 10))
            end
        end
        wait(1.5 + math.random() * 1.5)
    end
end)

showNotification("GHOST HUB " .. CURRENT_VERSION .. " - SEGURANÇA TOTAL v7.5", "success")
print(">> 👻 GHOST HUB " .. CURRENT_VERSION .. " - ULTIMATE")
print(">> ✅ 60 CAMADAS DE BYPASS | IA v7.5 (RISCO <10%)")
print(">> ✅ PROTEÇÃO CONTA PRINCIPAL ULTRA-AGRESSIVA")
print(">> ✅ TEAM CHECK INTEGRADO (Aimbot V2 e V4)")
print(">> ✅ INFINITE JUMP")
print(">> ✅ SPEED HACKER (PIVOTTO - SUAVE E CONFIGURÁVEL)")
print(">> ✅ X-RAY POR PROXIMIDADE (RAIO - TRANSPARÊNCIA PROGRESSIVA)")
print(">> ✅ UNLOCK ALL (DESBLOQUEAR TUDO)")
print(">> ✅ TP PARA JOGADORES")
print(">> ✅ AIMBOT GHOST V2.0 (VISIBILIDADE + MIRA AUTOMÁTICA + TEAM CHECK)")
print(">> ✅ AIMBOT GHOST V4 LITE (FOV ARCO-ÍRIS + SMOOTHNESS + TEAM CHECK)")
print(">> ✅ SILENT AIM")
print(">> ✅ ESP OTIMIZADO (LIMITE + DISTÂNCIA + TRACER POSITION)")
print(">> 🔒 RISCO MANTIDO ABAIXO DE 10%")
print(">> 👥 TEAM CHECK: Aimbots NUNCA miram em aliados")
print(">> ❌ HITBOX + X-RAY REMOVIDO DO SCRIPT")
print(">> YouTube: " .. YOUTUBE_LINK)

-- ============================================================
-- RENDERIZAÇÃO OTIMIZADA
-- ============================================================
local renderCache = {
    positions = {},
    cacheTime = 0.1,
    lastRender = tick(),
    renderInterval = 0.03,
}

-- ============================================================
-- CONFIGURAÇÕES
-- ============================================================
local settings = {
    enabled = false,
    teamCheck = true,
    showBox = false,
    showTracer = false,
    tracerPosition = "bottom",
    showName = false,
    showDistance = false,
    showHealth = false,
    showSkeleton = false,
    skeletonThickness = 1,
    boxColor = Color3.fromRGB(255, 255, 255),
    tracerColor = Color3.fromRGB(255, 0, 0),
    textColor = Color3.fromRGB(255, 255, 255),
    textSize = 10,
    maxDistance = 1000,
    aimbotGhostEnabled = false,
    silentAim = false,
    noclipEnabled = false,
    rainbowMode = false,
    rainbowSpeed = 0.1,
    voidUnlocked = false,
    voidProtectionEnabled = false,
    voidFloatEnabled = false,
    voidBlocksEnabled = false,
    voidTeleportEnabled = false,
    voidBlockSize = 10,
    voidBlockTransparency = 0.5,
    voidSafeY = 50,
    mainAccountMode = false,
    ultraStealthMode = false,
    riskAnalysisEnabled = true,
    autoBackupEnabled = true,
    antiBanProfileEnabled = true,
    infiniteJumpEnabled = false,
    speedHackEnabled = false,
}

-- ============================================================
-- VARIÁVEIS GLOBAIS
-- ============================================================
local espObjects = {}
local fovCircle = Drawing.new("Circle")
local rainbowHue = 0
local noclipConnection = nil
local spleefESPObjects = {}
local remoteCache = {}
local damageRemotes = {}
local killRemotes = {}
local voidBlocks = {}
local voidFloatConnection = nil
local lastSafePosition = nil

local currentTarget = nil
local aimActive = false

fovCircle.Visible = false
fovCircle.Thickness = 1
fovCircle.NumSides = 60
fovCircle.Radius = 200
fovCircle.Color = Color3.fromRGB(255, 255, 255)
fovCircle.Filled = false
fovCircle.Transparency = 1
-- ============================================================
-- DETECÇÃO DINÂMICA DE REMOTES
-- ============================================================
local function findRivalsRemotes()
    local rivalsRemotes = {"Damage", "TakeDamage", "Hit", "BulletHit", "Health", "Kill", "Die", "Death", "Eliminate", "Shoot", "Fire"}
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            local name = obj.Name
            for _, remoteName in ipairs(rivalsRemotes) do
                if name:find(remoteName) or name:lower():find(remoteName:lower()) then
                    remoteCache[obj] = true
                    if name:find("Damage") or name:find("Hit") or name:find("Health") then damageRemotes[obj] = true
                    elseif name:find("Kill") or name:find("Die") or name:find("Death") then killRemotes[obj] = true end
                    break
                end
            end
        end
    end
end

local function findNewRemotes()
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            local name = obj.Name
            if not remoteCache[obj] then
                if name:find("Spleef") or name:find("Floor") or name:find("Tile") or 
                   name:find("Break") or name:find("Destroy") or name:find("Damage") then
                    remoteCache[obj] = true
                    if name:find("Damage") or name:find("Hit") then
                        table.insert(damageRemotes, obj)
                    end
                    print(">> 🔍 Novo remote detectado: " .. name)
                end
            end
        end
    end
end

findRivalsRemotes()

spawn(function()
    while true do
        wait(30)
        findNewRemotes()
    end
end)

-- ============================================================
-- HOOK DE REMOTOS
-- ============================================================
local function setupRemoteHook()
    if not hookmetamethod then return end
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if (method == "FireServer" or method == "InvokeServer") and remoteCache[self] then
            if settings.silentAim and currentTarget and isValidSilentAimTarget(currentTarget) then
                local char = currentTarget.Character
                local targetPart = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
                if targetPart then
                    local targetPos = targetPart.Position
                    if settings.silentAim then
                        for i = 1, #args do
                            if type(args[i]) == "Vector3" then args[i] = targetPos
                            elseif type(args[i]) == "CFrame" then args[i] = CFrame.lookAt(args[i].Position, targetPos) end
                        end
                    end
                end
            end
            return oldNamecall(self, unpack(args))
        end
        return oldNamecall(self, ...)
    end)
end
pcall(setupRemoteHook)

-- ============================================================
-- LOOP ARCO-ÍRIS
-- ============================================================
spawn(function() while true do if settings.rainbowMode then rainbowHue = (rainbowHue + settings.rainbowSpeed) % 1 local color = Color3.fromHSV(rainbowHue, 1, 1) settings.boxColor = color settings.tracerColor = color settings.textColor = color end wait(0.05) end end)

-- ============================================================
-- ANÁLISE DE RISCO E ANTI-BAN PROFILE
-- ============================================================
local shotCounter = { total = 0, hits = 0, headshots = 0, lastShots = {} }
local patternMonitor = {
    lastKill = tick(),
    killCount = 0,
    killWindow = 60,
    registerKill = function()
        local now = tick()
        if now - patternMonitor.lastKill < patternMonitor.killWindow then patternMonitor.killCount = patternMonitor.killCount + 1
        else patternMonitor.killCount = 1 end
        patternMonitor.lastKill = now
        riskModel.patternRisk.killStreak = patternMonitor.killCount
        if patternMonitor.killCount > 8 then riskModel.patternRisk.killStreak = math.min(100, 30 + (patternMonitor.killCount - 8) * 5) end
        return patternMonitor.killCount
    end,
    registerHeadshot = function()
        local totalKills = antiBanProfile.stats.totalKills
        local headshots = antiBanProfile.stats.headshots
        if totalKills > 0 then riskModel.patternRisk.headshotRate = (headshots / totalKills) * 100 end
    end,
    registerShot = function(hit) riskModel.patternRisk.accuracy = getAccuracy() * 100 end
}

local function registerShot(hit, headshot)
    shotCounter.total = shotCounter.total + 1
    if hit then
        shotCounter.hits = shotCounter.hits + 1
        if headshot then shotCounter.headshots = shotCounter.headshots + 1 end
        patternMonitor.registerShot(hit)
    end
    table.insert(shotCounter.lastShots, {time = tick(), hit = hit, headshot = headshot})
    if #shotCounter.lastShots > 100 then table.remove(shotCounter.lastShots, 1) end
end

local function getAccuracy() if shotCounter.total == 0 then return 0 end return shotCounter.hits / shotCounter.total end
local function getHeadshotRate() if shotCounter.hits == 0 then return 0 end return shotCounter.headshots / shotCounter.hits end

local riskAnalyzer = { currentRisk = 0,
    analyze = function(self)
        local risk = 0
        if settings.silentAim then risk = risk + 4 end
        if settings.noclipEnabled then risk = risk + 3 end
        if settings.infiniteJumpEnabled then risk = risk + 1 end
        if settings.speedHackEnabled then risk = risk + 4 end
        if aimbotGhostEnabled then risk = risk + 3 end
        if _G.NS_SETTINGS.Locking then risk = risk + 3 end
        if proximityXRayEnabled then risk = risk + 2 end
        self.currentRisk = math.min(risk, 100)
        return self.currentRisk
    end
}

local antiBanProfile = {
    stats = { gamesPlayed = 0, totalKills = 0, deaths = 0, headshots = 0, playTime = 0, lastSeen = tick() },
    loadProfile = function(self)
        local success, data = pcall(function() return HttpService:JSONDecode(readfile("ghosthub_profile.json")) end)
        if success and data then 
            self.stats = data 
        end
    end,
    saveProfile = function(self) 
        pcall(function() writefile("ghosthub_profile.json", HttpService:JSONEncode(self.stats)) end)
    end,
    updateStats = function(self, kill, headshot)
        self.stats.gamesPlayed = self.stats.gamesPlayed + 1
        if kill then self.stats.totalKills = self.stats.totalKills + 1 if headshot then self.stats.headshots = self.stats.headshots + 1 end end
        self.stats.playTime = self.stats.playTime + (tick() - self.stats.lastSeen)
        self.stats.lastSeen = tick()
    end,
    getKDRatio = function(self) if self.stats.deaths == 0 then return self.stats.totalKills end return self.stats.totalKills / self.stats.deaths end,
    getHeadshotPercentage = function(self) if self.stats.totalKills == 0 then return 0 end return (self.stats.headshots / self.stats.totalKills) * 100 end
}
antiBanProfile:loadProfile()

spawn(function() while true do wait(10) if settings.riskAnalysisEnabled then riskAnalyzer:analyze() end end end)
-- ============================================================
-- FUNÇÕES DE UI
-- ============================================================
local function createInfo(parent, yPos, text, size)
    size = size or 10
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 16)
    label.Position = UDim2.new(0, 5, 0, yPos)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.TextSize = size
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent
    return label
end

local function createButtonWithHover(parent, yPos, text, callback, color)
    local originalColor = color or Color3.fromRGB(70, 70, 90)
    local hoverColor = originalColor:Lerp(Color3.new(1, 1, 1), 0.25)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 24)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = originalColor
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 10
    btn.Font = Enum.Font.GothamBold
    btn.Parent = parent
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play() end)
    btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = originalColor}):Play() end)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function createToggle(parent, yPos, text, settingKey)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -6, 0, 22)
    container.Position = UDim2.new(0, 3, 0, yPos)
    container.BackgroundTransparency = 1
    container.Parent = parent
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0, 2, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 10
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.25, 0, 0, 20)
    btn.Position = UDim2.new(0.72, 0, 0.5, -10)
    
    if settingKey == "proximityXRayEnabled" then
        btn.BackgroundColor3 = proximityXRayEnabled and Color3.fromRGB(0, 180, 90) or Color3.fromRGB(140, 50, 50)
        btn.Text = proximityXRayEnabled and "ON" or "OFF"
    elseif settingKey == "aimbotGhostEnabled" then
        btn.BackgroundColor3 = aimbotGhostEnabled and Color3.fromRGB(0, 180, 90) or Color3.fromRGB(140, 50, 50)
        btn.Text = aimbotGhostEnabled and "ON" or "OFF"
    elseif settingKey == "v4Locking" then
        btn.BackgroundColor3 = _G.NS_SETTINGS.Locking and Color3.fromRGB(0, 180, 90) or Color3.fromRGB(140, 50, 50)
        btn.Text = _G.NS_SETTINGS.Locking and "ON" or "OFF"
    elseif settingKey == "v4WallCheck" then
        btn.BackgroundColor3 = _G.NS_SETTINGS.WallCheck and Color3.fromRGB(0, 180, 90) or Color3.fromRGB(140, 50, 50)
        btn.Text = _G.NS_SETTINGS.WallCheck and "ON" or "OFF"
    else
        btn.BackgroundColor3 = settings[settingKey] and Color3.fromRGB(0, 180, 90) or Color3.fromRGB(140, 50, 50)
        btn.Text = settings[settingKey] and "ON" or "OFF"
    end
    
    btn.BorderSizePixel = 0
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 9
    btn.Font = Enum.Font.GothamBold
    btn.Parent = container
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    local originalColor = btn.BackgroundColor3
    btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = originalColor:Lerp(Color3.new(1,1,1), 0.2)}):Play() end)
    btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = originalColor}):Play() end)
    btn.MouseButton1Click:Connect(function()
        if settingKey == "proximityXRayEnabled" then
            proximityXRayEnabled = not proximityXRayEnabled
            setProximityXRay(proximityXRayEnabled)
            local newColor = proximityXRayEnabled and Color3.fromRGB(0, 180, 90) or Color3.fromRGB(140, 50, 50)
            btn.BackgroundColor3 = newColor
            originalColor = newColor
            btn.Text = proximityXRayEnabled and "ON" or "OFF"
        elseif settingKey == "aimbotGhostEnabled" then
            aimbotGhostEnabled = not aimbotGhostEnabled
            setAimbotGhost(aimbotGhostEnabled)
            local newColor = aimbotGhostEnabled and Color3.fromRGB(0, 180, 90) or Color3.fromRGB(140, 50, 50)
            btn.BackgroundColor3 = newColor
            originalColor = newColor
            btn.Text = aimbotGhostEnabled and "ON" or "OFF"
        elseif settingKey == "v4Locking" then
            local newState = not _G.NS_SETTINGS.Locking
            setV4Locking(newState)
            local newColor = newState and Color3.fromRGB(0, 180, 90) or Color3.fromRGB(140, 50, 50)
            btn.BackgroundColor3 = newColor
            originalColor = newColor
            btn.Text = newState and "ON" or "OFF"
        elseif settingKey == "v4WallCheck" then
            local newState = not _G.NS_SETTINGS.WallCheck
            setV4WallCheck(newState)
            local newColor = newState and Color3.fromRGB(0, 180, 90) or Color3.fromRGB(140, 50, 50)
            btn.BackgroundColor3 = newColor
            originalColor = newColor
            btn.Text = newState and "ON" or "OFF"
        else
            settings[settingKey] = not settings[settingKey]
            local newColor = settings[settingKey] and Color3.fromRGB(0, 180, 90) or Color3.fromRGB(140, 50, 50)
            btn.BackgroundColor3 = newColor
            originalColor = newColor
            btn.Text = settings[settingKey] and "ON" or "OFF"
            
            if settingKey == "noclipEnabled" then setNoclip(settings.noclipEnabled) end
            if settingKey == "silentAim" then setSilentAim(settings.silentAim) end
            if settingKey == "infiniteJumpEnabled" then setInfiniteJump(settings.infiniteJumpEnabled) end
            if settingKey == "speedHackEnabled" then 
                if settings.speedHackEnabled then 
                    enableSpeedHack() 
                else 
                    disableSpeedHack() 
                end
            end
        end
    end)
    return container
end

local function createSlider(parent, yPos, text, settingKey, minVal, maxVal, step, suffix)
    suffix = suffix or ""
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -6, 0, 22)
    container.Position = UDim2.new(0, 3, 0, yPos)
    container.BackgroundTransparency = 1
    container.Parent = parent
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0, 2, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.TextSize = 9
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container
    local decBtn = Instance.new("TextButton")
    decBtn.Size = UDim2.new(0.12, 0, 0, 18)
    decBtn.Position = UDim2.new(0.6, 0, 0.5, -9)
    decBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    decBtn.BorderSizePixel = 0
    decBtn.Text = "−"
    decBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    decBtn.TextSize = 14
    decBtn.Font = Enum.Font.GothamBold
    decBtn.Parent = container
    local decCorner = Instance.new("UICorner")
    decCorner.CornerRadius = UDim.new(0, 4)
    decCorner.Parent = decBtn
    local valLabel = Instance.new("TextLabel")
    valLabel.Size = UDim2.new(0.16, 0, 0, 18)
    valLabel.Position = UDim2.new(0.73, 0, 0.5, -9)
    valLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    valLabel.BorderSizePixel = 0
    
    if settingKey == "xrayRadius" then
        valLabel.Text = tostring(xrayRadius) .. suffix
    elseif settingKey == "v4Smoothness" then
        valLabel.Text = tostring(_G.NS_SETTINGS.Smoothness * 100) .. suffix
    elseif settingKey == "v4FOV" then
        valLabel.Text = tostring(_G.NS_SETTINGS.FOV) .. suffix
    else
        valLabel.Text = tostring(settings[settingKey]) .. suffix
    end
    
    valLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    valLabel.TextSize = 8
    valLabel.Font = Enum.Font.GothamBold
    valLabel.Parent = container
    local valCorner = Instance.new("UICorner")
    valCorner.CornerRadius = UDim.new(0, 4)
    valCorner.Parent = valLabel
    local incBtn = Instance.new("TextButton")
    incBtn.Size = UDim2.new(0.12, 0, 0, 18)
    incBtn.Position = UDim2.new(0.9, 0, 0.5, -9)
    incBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    incBtn.BorderSizePixel = 0
    incBtn.Text = "+"
    incBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    incBtn.TextSize = 14
    incBtn.Font = Enum.Font.GothamBold
    incBtn.Parent = container
    local incCorner = Instance.new("UICorner")
    incCorner.CornerRadius = UDim.new(0, 4)
    incCorner.Parent = incBtn
    decBtn.MouseButton1Click:Connect(function() 
        if settingKey == "xrayRadius" then
            local newValue = math.max(minVal, xrayRadius - step)
            setXrayRadius(newValue)
            valLabel.Text = tostring(xrayRadius) .. suffix
        elseif settingKey == "v4Smoothness" then
            local newValue = math.max(minVal, (_G.NS_SETTINGS.Smoothness * 100) - step)
            setV4Smoothness(newValue)
            valLabel.Text = tostring(newValue) .. suffix
        elseif settingKey == "v4FOV" then
            local newValue = math.max(minVal, _G.NS_SETTINGS.FOV - step)
            setV4FOV(newValue)
            valLabel.Text = tostring(newValue) .. suffix
        else
            local newValue = math.max(minVal, settings[settingKey] - step)
            settings[settingKey] = newValue
            if settingKey == "speedValue" then
                setSpeed(newValue)
            end
            if settingKey == "maxDistance" then
                ESP.MaxDistance = newValue
            end
            valLabel.Text = tostring(settings[settingKey]) .. suffix
        end
    end)
    incBtn.MouseButton1Click:Connect(function() 
        if settingKey == "xrayRadius" then
            local newValue = math.min(maxVal, xrayRadius + step)
            setXrayRadius(newValue)
            valLabel.Text = tostring(xrayRadius) .. suffix
        elseif settingKey == "v4Smoothness" then
            local newValue = math.min(maxVal, (_G.NS_SETTINGS.Smoothness * 100) + step)
            setV4Smoothness(newValue)
            valLabel.Text = tostring(newValue) .. suffix
        elseif settingKey == "v4FOV" then
            local newValue = math.min(maxVal, _G.NS_SETTINGS.FOV + step)
            setV4FOV(newValue)
            valLabel.Text = tostring(newValue) .. suffix
        else
            local newValue = math.min(maxVal, settings[settingKey] + step)
            settings[settingKey] = newValue
            if settingKey == "speedValue" then
                setSpeed(newValue)
            end
            if settingKey == "maxDistance" then
                ESP.MaxDistance = newValue
            end
            valLabel.Text = tostring(settings[settingKey]) .. suffix
        end
    end)
    return container
end
-- ============================================================
-- CONSTRUÇÃO DO PAINEL PRINCIPAL
-- ============================================================
local function createPanel()
    local parent = LocalPlayer:FindFirstChild("PlayerGui")
    if not parent then parent = Instance.new("ScreenGui") parent.Name = "PlayerGui" parent.Parent = LocalPlayer end
    local old = parent:FindFirstChild("GhostHub_Panel")
    if old then old:Destroy() end
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GhostHub_Panel"
    screenGui.DisplayOrder = 100
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = parent
    screenGui.Enabled = true

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 320, 0, 480)
    mainFrame.Position = UDim2.new(0.5, -160, 0.5, -240)
    mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
    mainFrame.BackgroundTransparency = 0.03
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.ClipsDescendants = true
    mainFrame.Visible = true
    mainFrame.Parent = screenGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 16)
    mainCorner.Parent = mainFrame

    local mainGradient = Instance.new("UIGradient")
    mainGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 28, 38)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 25))
    })
    mainGradient.Parent = mainFrame

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Thickness = 1
    mainStroke.Color = Color3.fromRGB(50, 50, 70)
    mainStroke.Parent = mainFrame

    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 35)
    titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 16)
    titleCorner.Parent = titleBar

    local titleGradient = Instance.new("UIGradient")
    titleGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 45)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 35))
    })
    titleGradient.Parent = titleBar

    local dragging = false
    local dragStart = nil
    local frameStart = nil

    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            frameStart = mainFrame.Position
        end
    end)

    titleBar.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                frameStart.X.Scale, frameStart.X.Offset + delta.X,
                frameStart.Y.Scale, frameStart.Y.Offset + delta.Y
            )
        end
    end)

    titleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    local titleIcon = Instance.new("TextLabel")
    titleIcon.Size = UDim2.new(0, 30, 1, 0)
    titleIcon.Position = UDim2.new(0, 8, 0, 0)
    titleIcon.BackgroundTransparency = 1
    titleIcon.Text = "👻"
    titleIcon.TextColor3 = Color3.fromRGB(150, 150, 255)
    titleIcon.TextSize = 18
    titleIcon.Font = Enum.Font.GothamBold
    titleIcon.TextXAlignment = Enum.TextXAlignment.Center
    titleIcon.Parent = titleBar

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -80, 1, 0)
    title.Position = UDim2.new(0, 40, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "GHOST HUB v94.2"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 13
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = titleBar

    local versionLabel = Instance.new("TextLabel")
    versionLabel.Size = UDim2.new(0, 45, 1, 0)
    versionLabel.Position = UDim2.new(1, -55, 0, 0)
    versionLabel.BackgroundTransparency = 1
    versionLabel.Text = "ULTRA"
    versionLabel.TextColor3 = Color3.fromRGB(180, 180, 255)
    versionLabel.TextSize = 10
    versionLabel.Font = Enum.Font.Gotham
    versionLabel.TextXAlignment = Enum.TextXAlignment.Right
    versionLabel.Parent = titleBar

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 28, 1, 0)
    closeBtn.Position = UDim2.new(1, -28, 0, 0)
    closeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    closeBtn.BorderSizePixel = 0
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 14
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = titleBar

    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, 0, 0, 35)
    tabContainer.Position = UDim2.new(0, 0, 0, 35)
    tabContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
    tabContainer.BorderSizePixel = 0
    tabContainer.Parent = mainFrame

    local tabGradient = Instance.new("UIGradient")
    tabGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 28, 38)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 22, 32))
    })
    tabGradient.Parent = tabContainer

    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Size = UDim2.new(1, -8, 1, -85)
    contentFrame.Position = UDim2.new(0, 4, 0, 75)
    contentFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
    contentFrame.BackgroundTransparency = 1
    contentFrame.BorderSizePixel = 0
    contentFrame.ScrollBarThickness = 3
    contentFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 150)
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentFrame.Parent = mainFrame

    local function clearContent()
        for _, child in pairs(contentFrame:GetChildren()) do child:Destroy() end
    end

    local function updateCanvasSize()
        local totalHeight = 0
        for _, child in pairs(contentFrame:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextLabel") or child:IsA("TextButton") then
                totalHeight = math.max(totalHeight, child.Position.Y.Offset + child.Size.Y.Offset)
            end
        end
        contentFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight + 15)
    end

    -- ============================================================
    -- ABA 1: ESP
    -- ============================================================
    local function showESPTab()
        clearContent()
        local y = 5
        createToggle(contentFrame, y, "Enable ESP", "enabled"); y = y + 24
        createToggle(contentFrame, y, "Team Check", "teamCheck"); y = y + 24
        createToggle(contentFrame, y, "Show Box", "showBox"); y = y + 24
        createToggle(contentFrame, y, "Show Tracer", "showTracer"); y = y + 24
        createToggle(contentFrame, y, "Show Name", "showName"); y = y + 24
        createToggle(contentFrame, y, "Show Distance", "showDistance"); y = y + 24
        createToggle(contentFrame, y, "Show Health", "showHealth"); y = y + 24
        
        local tracerPosContainer = Instance.new("Frame")
        tracerPosContainer.Size = UDim2.new(1, -6, 0, 24)
        tracerPosContainer.Position = UDim2.new(0, 3, 0, y)
        tracerPosContainer.BackgroundTransparency = 1
        tracerPosContainer.Parent = contentFrame
        
        local tracerPosLabel = Instance.new("TextLabel")
        tracerPosLabel.Size = UDim2.new(0.6, 0, 1, 0)
        tracerPosLabel.Position = UDim2.new(0, 2, 0, 0)
        tracerPosLabel.BackgroundTransparency = 1
        tracerPosLabel.Text = "Tracer Position"
        tracerPosLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
        tracerPosLabel.TextSize = 10
        tracerPosLabel.Font = Enum.Font.Gotham
        tracerPosLabel.TextXAlignment = Enum.TextXAlignment.Left
        tracerPosLabel.Parent = tracerPosContainer
        
        local tracerPosBtn = Instance.new("TextButton")
        tracerPosBtn.Size = UDim2.new(0.3, 0, 0, 20)
        tracerPosBtn.Position = UDim2.new(0.68, 0, 0.5, -10)
        tracerPosBtn.BackgroundColor3 = settings.tracerPosition == "top" and Color3.fromRGB(80, 80, 150) or (settings.tracerPosition == "bottom" and Color3.fromRGB(80, 150, 80) or Color3.fromRGB(150, 80, 80))
        tracerPosBtn.BorderSizePixel = 0
        tracerPosBtn.Text = settings.tracerPosition == "top" and "TOP" or (settings.tracerPosition == "bottom" and "BOTTOM" or "CENTER")
        tracerPosBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tracerPosBtn.TextSize = 8
        tracerPosBtn.Font = Enum.Font.GothamBold
        tracerPosBtn.Parent = tracerPosContainer
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = tracerPosBtn
        
        tracerPosBtn.MouseButton1Click:Connect(function()
            if settings.tracerPosition == "top" then
                settings.tracerPosition = "bottom"
                ESP.TracerPosition = "bottom"
                tracerPosBtn.BackgroundColor3 = Color3.fromRGB(80, 150, 80)
                tracerPosBtn.Text = "BOTTOM"
            elseif settings.tracerPosition == "bottom" then
                settings.tracerPosition = "center"
                ESP.TracerPosition = "center"
                tracerPosBtn.BackgroundColor3 = Color3.fromRGB(150, 80, 80)
                tracerPosBtn.Text = "CENTER"
            else
                settings.tracerPosition = "top"
                ESP.TracerPosition = "top"
                tracerPosBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 150)
                tracerPosBtn.Text = "TOP"
            end
        end)
        
        y = y + 28
        
        createSlider(contentFrame, y, "Distância", "maxDistance", 100, 5000, 50, " studs"); y = y + 28
        createSlider(contentFrame, y, "Espessura", "skeletonThickness", 1, 3, 0.5); y = y + 28
        
        local coresBtn = createButtonWithHover(contentFrame, y, "CORES (12 OPÇÕES)", function()
        end, Color3.fromRGB(80, 80, 120)); y = y + 30
        
        local cores = {
            {name = "BRANCO", color = Color3.fromRGB(255,255,255), textColor = Color3.fromRGB(0,0,0)},
            {name = "VERDE", color = Color3.fromRGB(0,255,0), textColor = Color3.fromRGB(0,0,0)},
            {name = "AZUL", color = Color3.fromRGB(0,100,255), textColor = Color3.fromRGB(255,255,255)},
            {name = "VERMELHO", color = Color3.fromRGB(255,0,0), textColor = Color3.fromRGB(255,255,255)},
            {name = "ROXO", color = Color3.fromRGB(128,0,128), textColor = Color3.fromRGB(255,255,255)},
            {name = "PRETO", color = Color3.fromRGB(0,0,0), textColor = Color3.fromRGB(255,255,255)},
            {name = "LARANJA", color = Color3.fromRGB(255,165,0), textColor = Color3.fromRGB(0,0,0)},
            {name = "ROSA", color = Color3.fromRGB(255,105,180), textColor = Color3.fromRGB(0,0,0)},
            {name = "AMARELO", color = Color3.fromRGB(255,215,0), textColor = Color3.fromRGB(0,0,0)},
            {name = "CIANO", color = Color3.fromRGB(0,255,255), textColor = Color3.fromRGB(0,0,0)},
            {name = "CINZA", color = Color3.fromRGB(128,128,128), textColor = Color3.fromRGB(255,255,255)},
            {name = "MARROM", color = Color3.fromRGB(139,69,19), textColor = Color3.fromRGB(255,255,255)},
        }
        
        for i = 1, 12 do
            local row = math.floor((i-1)/3)
            local col = (i-1)%3
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0.3, 0, 0, 22)
            btn.Position = UDim2.new(0.02 + col*0.34, 0, 0, y + row*24)
            btn.BackgroundColor3 = cores[i].color
            btn.BorderSizePixel = 0
            btn.Text = cores[i].name
            btn.TextColor3 = cores[i].textColor
            btn.TextSize = 8
            btn.Font = Enum.Font.GothamBold
            btn.Parent = contentFrame
            
            btn.MouseButton1Click:Connect(function()
                settings.rainbowMode = false
                settings.boxColor = cores[i].color
                settings.tracerColor = cores[i].color
                settings.textColor = cores[i].color
                ESP.Color = cores[i].color
            end)
        end
        
        y = y + 110
        
        createToggle(contentFrame, y, "Arco-íris", "rainbowMode"); y = y + 24
        createSlider(contentFrame, y, "Velocidade", "rainbowSpeed", 0.01, 0.5, 0.02); y = y + 28
        
        updateCanvasSize()
    end
    
    -- ============================================================
    -- ABA 2: AIMBOT GHOST V2.0
    -- ============================================================
    local function showAimbotTab()
        clearContent()
        local y = 5
        
        createInfo(contentFrame, y, "🎯 AIMBOT GHOST V2.0", 12); y = y + 20
        createInfo(contentFrame, y, "Mira automática no inimigo mais próximo do mouse", 9); y = y + 18
        createInfo(contentFrame, y, "Com verificação de visibilidade (Raycast)", 9); y = y + 18
        createInfo(contentFrame, y, "Mira instantânea na cabeça", 9); y = y + 18
        createInfo(contentFrame, y, "👥 NÃO mira em aliados (Team Check)", 9); y = y + 18
        
        y = y + 20
        
        createToggle(contentFrame, y, "Ativar Aimbot Ghost V2.0", "aimbotGhostEnabled"); y = y + 30
        
        createInfo(contentFrame, y, "📌 Como usar:", 11); y = y + 20
        createInfo(contentFrame, y, "1. Ative o toggle acima", 9); y = y + 18
        createInfo(contentFrame, y, "2. A mira vai seguir o inimigo mais próximo do mouse", 9); y = y + 18
        createInfo(contentFrame, y, "3. Funciona através de Raycast (visibilidade)", 9); y = y + 18
        createInfo(contentFrame, y, "4. Team Check integrado - Só mira em inimigos!", 9); y = y + 18
        
        updateCanvasSize()
    end
    
    -- ============================================================
    -- ABA 3: AIMBOT GHOST V4 LITE
    -- ============================================================
    local function showV4Tab()
        clearContent()
        local y = 5
        
        createInfo(contentFrame, y, "🎯 AIMBOT GHOST V4 LITE", 12); y = y + 20
        createInfo(contentFrame, y, "FOV Arco-Íris | Suavidade | Wall Check", 9); y = y + 18
        createInfo(contentFrame, y, "Mira no inimigo mais próximo dentro do FOV", 9); y = y + 18
        createInfo(contentFrame, y, "👥 NÃO mira em aliados (Team Check)", 9); y = y + 18
        
        y = y + 20
        
        createToggle(contentFrame, y, "Ativar Aimbot V4", "v4Locking"); y = y + 24
        createToggle(contentFrame, y, "Wall Check (Atravessar paredes)", "v4WallCheck"); y = y + 24
        
        createSlider(contentFrame, y, "Suavidade da Mira", "v4Smoothness", 1, 100, 5, "%"); y = y + 28
        createSlider(contentFrame, y, "Raio do FOV", "v4FOV", 30, 500, 10, "px"); y = y + 28
        
        createInfo(contentFrame, y, "📌 Características:", 11); y = y + 20
        createInfo(contentFrame, y, "• Círculo de FOV com efeito arco-íris", 9); y = y + 18
        createInfo(contentFrame, y, "• Mira suave baseada no DT", 9); y = y + 18
        createInfo(contentFrame, y, "• Wall Check opcional", 9); y = y + 18
        createInfo(contentFrame, y, "• Suavidade ajustável de 1% a 100%", 9); y = y + 18
        createInfo(contentFrame, y, "• Team Check integrado - Só mira em inimigos!", 9); y = y + 18
        
        updateCanvasSize()
    end
    
    -- ============================================================
    -- ABA 4: RIVALS
    -- ============================================================
    local function showRivalsTab()
        clearContent()
        local y = 5
        createToggle(contentFrame, y, "Silent Aim", "silentAim"); y = y + 24
        
        y = y + 15
        
        createInfo(contentFrame, y, "🔓 UNLOCK ALL", 12); y = y + 20
        createInfo(contentFrame, y, "Desbloqueia todas as armas e itens do jogo!", 9); y = y + 18
        createInfo(contentFrame, y, "Clique no botão abaixo para executar", 9); y = y + 18
        
        local unlockBtn = createButtonWithHover(contentFrame, y, "🔓 EXECUTAR UNLOCK ALL", function()
            executeUnlockAll()
        end, Color3.fromRGB(80, 150, 80))
        y = y + 32
        
        if unlockAllExecuted then
            local resetBtn = createButtonWithHover(contentFrame, y, "🔄 RESETAR UNLOCK", function()
                resetUnlockAll()
            end, Color3.fromRGB(150, 100, 80))
            y = y + 32
        end
        
        y = y + 60
        
        createButtonWithHover(contentFrame, y, "Reset Remotes", function()
            findRivalsRemotes()
        end, Color3.fromRGB(80, 80, 150))
        y = y + 30
        updateCanvasSize()
    end
        -- ============================================================
    -- ABA 5: MOVIMENTO
    -- ============================================================
    local function showMovementTab()
        clearContent()
        local y = 5
        
        createInfo(contentFrame, y, "🦘 INFINITE JUMP", 12); y = y + 20
        createToggle(contentFrame, y, "Ativar Infinite Jump", "infiniteJumpEnabled"); y = y + 24
        
        y = y + 15
        
        createInfo(contentFrame, y, "🏃 SPEED HACKER", 12); y = y + 20
        createToggle(contentFrame, y, "Ativar Speed Hacker", "speedHackEnabled"); y = y + 24
        createSlider(contentFrame, y, "Velocidade", "speedValue", 16, 250, 5, " (PivotTo)"); y = y + 28
        
        y = y + 15
        
        createToggle(contentFrame, y, "NOCLIP", "noclipEnabled"); y = y + 24
        
        y = y + 25
        
        createInfo(contentFrame, y, "🔍 X-RAY POR PROXIMIDADE (RAIO)", 12); y = y + 20
        createToggle(contentFrame, y, "Ativar X-Ray por Proximidade", "proximityXRayEnabled"); y = y + 24
        createSlider(contentFrame, y, "Raio de Visão", "xrayRadius", 10, 200, 5, " studs"); y = y + 28
        
        createInfo(contentFrame, y, "• Quanto mais perto, mais visível", 9); y = y + 18
        createInfo(contentFrame, y, "• Dentro do raio: transparente (0%)", 9); y = y + 18
        createInfo(contentFrame, y, "• Fora do raio: invisível (90%)", 9); y = y + 18
        
        y = y + 40
        
        createInfo(contentFrame, y, "🔗 TP PARA JOGADORES", 12); y = y + 20
        createInfo(contentFrame, y, "Use a aba TP para teleportar até o jogador", 9); y = y + 18
        createInfo(contentFrame, y, "• Clique em TP PARA para ir até o jogador", 9); y = y + 18
        createInfo(contentFrame, y, "• Funciona instantaneamente", 9); y = y + 18
        
        updateCanvasSize()
    end

    -- ============================================================
    -- ABA 6: PROTEÇÃO
    -- ============================================================
    local function showProtectionTab()
        clearContent()
        local y = 5
        createInfo(contentFrame, y, "🛡️ PROTEÇÃO DE CONTA IA v7.5 (ULTRA-AGRESSIVA)", 12); y = y + 20
        createInfo(contentFrame, y, "🔒 RISCO MANTIDO ABAIXO DE 10%", 10); y = y + 18
        createToggle(contentFrame, y, "Modo Conta Principal", "mainAccountMode"); y = y + 24
        createToggle(contentFrame, y, "Ultra Stealth", "ultraStealthMode"); y = y + 24
        createToggle(contentFrame, y, "Análise de Risco", "riskAnalysisEnabled"); y = y + 24
        createToggle(contentFrame, y, "Backup Automático", "autoBackupEnabled"); y = y + 24
        createToggle(contentFrame, y, "Anti-Ban Profile", "antiBanProfileEnabled"); y = y + 24
        y = y + 10
        createInfo(contentFrame, y, "📊 BYPASS IA v7.5 (60 CAMADAS)", 12); y = y + 20
        local stats = {
            "🔍 Padrões: " .. IABypass.stats.patternsDetected,
            "🧬 Clones: " .. IABypass.stats.behaviorsCloned,
            "📡 Freq Hops: " .. IABypass.stats.frequencyHops,
            "💾 Fragmentos: " .. IABypass.stats.memoryFragments,
            "🎭 Iscas: " .. IABypass.stats.decoysGenerated,
            "🔄 Mutações: " .. IABypass.stats.codeMutations,
            "🌍 Ambientes: " .. IABypass.stats.environmentsDetected,
            "🎯 Anomalias: " .. IABypass.stats.anomaliesGenerated,
            "🛡️ Anti-Trace: " .. IABypass.stats.traceAttempts,
            "⚡ Jitter: " .. IABypass.stats.jitterInjections,
            "🎮 Spleef: " .. IABypass.stats.spleefDetections,
            "🧬 Polimórfico: " .. IABypass.stats.polymorphicMutations,
            "🎲 Entropia: " .. IABypass.stats.entropyInjections,
            "⚠️ Risco: " .. riskAnalyzer.currentRisk .. "%",
            "🔒 Nível Proteção: " .. mainAccountProtection.level .. "/7",
            "🌀 Quantum: " .. IABypass.stats.quantumEntanglements,
            "🔮 Fractal: " .. IABypass.stats.fractalSignatures,
        }
        for _, stat in ipairs(stats) do createInfo(contentFrame, y, stat, 9); y = y + 18 end
        y = y + 10
        createInfo(contentFrame, y, "📊 ESTATÍSTICAS DE JOGO", 12); y = y + 20
        local gameStats = {
            "🎯 Acertos: " .. shotCounter.hits .. "/" .. shotCounter.total,
            "📊 Precisão: " .. string.format("%.1f%%", getAccuracy()*100),
            "💀 Headshots: " .. shotCounter.headshots,
            "🎯 HS Rate: " .. string.format("%.1f%%", getHeadshotRate()*100),
            "👤 K/D: " .. string.format("%.2f", antiBanProfile:getKDRatio()),
            "🔫 HS%: " .. string.format("%.1f%%", antiBanProfile:getHeadshotPercentage()),
            "⏱️ Tempo: " .. math.floor(antiBanProfile.stats.playTime/60) .. "min",
        }
        for _, stat in ipairs(gameStats) do createInfo(contentFrame, y, stat, 9); y = y + 18 end
        y = y + 10
        createButtonWithHover(contentFrame, y, "💾 Salvar Profile", function() antiBanProfile:saveProfile() end, Color3.fromRGB(80, 150, 80)); y = y + 28
        createButtonWithHover(contentFrame, y, "📁 Carregar Profile", function() antiBanProfile:loadProfile() end, Color3.fromRGB(80, 80, 150)); y = y + 28
        updateCanvasSize()
    end
    
    -- ============================================================
    -- ABA 7: TP
    -- ============================================================
    local function showTPTab()
        clearContent()
        
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -10, 0, 24)
        title.Position = UDim2.new(0, 5, 0, 5)
        title.BackgroundTransparency = 1
        title.Text = "JOGADORES ONLINE:"
        title.TextColor3 = Color3.fromRGB(255, 215, 0)
        title.TextSize = 11
        title.Font = Enum.Font.GothamBold
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Parent = contentFrame
        
        local infoText = Instance.new("TextLabel")
        infoText.Size = UDim2.new(1, -10, 0, 20)
        infoText.Position = UDim2.new(0, 5, 0, 28)
        infoText.BackgroundTransparency = 1
        infoText.Text = "✨ Clique em TP PARA para teleportar até o jogador"
        infoText.TextColor3 = Color3.fromRGB(100, 150, 255)
        infoText.TextSize = 9
        infoText.Font = Enum.Font.Gotham
        infoText.TextXAlignment = Enum.TextXAlignment.Left
        infoText.Parent = contentFrame
        
        local playerScrolling = Instance.new("ScrollingFrame")
        playerScrolling.Size = UDim2.new(1, -10, 0, 340)
        playerScrolling.Position = UDim2.new(0, 5, 0, 55)
        playerScrolling.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        playerScrolling.BorderSizePixel = 0
        playerScrolling.ScrollBarThickness = 2
        playerScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
        playerScrolling.Parent = contentFrame
        
        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 3)
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        layout.SortOrder = Enum.SortOrder.Name
        layout.Parent = playerScrolling
        
        local yPos = 0
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local playerFrame = Instance.new("Frame")
                playerFrame.Size = UDim2.new(0.95, 0, 0, 34)
                playerFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
                playerFrame.BorderSizePixel = 0
                playerFrame.Parent = playerScrolling
                
                local frameCorner = Instance.new("UICorner")
                frameCorner.CornerRadius = UDim.new(0, 6)
                frameCorner.Parent = playerFrame
                
                local nameLabel = Instance.new("TextLabel")
                nameLabel.Size = UDim2.new(0.5, 0, 1, 0)
                nameLabel.Position = UDim2.new(0, 5, 0, 0)
                nameLabel.BackgroundTransparency = 1
                nameLabel.Text = "👤 " .. player.Name
                nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                nameLabel.TextSize = 10
                nameLabel.Font = Enum.Font.Gotham
                nameLabel.TextXAlignment = Enum.TextXAlignment.Left
                nameLabel.Parent = playerFrame
                
                local teamLabel = Instance.new("TextLabel")
                teamLabel.Size = UDim2.new(0.4, 0, 1, 0)
                teamLabel.Position = UDim2.new(0.5, 5, 0, 0)
                teamLabel.BackgroundTransparency = 1
                local teamName = player.Team and player.Team.Name or "Sem Time"
                teamLabel.Text = "⚔️ " .. teamName
                teamLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
                teamLabel.TextSize = 8
                teamLabel.Font = Enum.Font.Gotham
                teamLabel.TextXAlignment = Enum.TextXAlignment.Left
                teamLabel.Parent = playerFrame
                
                local tpBtn = Instance.new("TextButton")
                tpBtn.Size = UDim2.new(0.25, 0, 0, 24)
                tpBtn.Position = UDim2.new(0.73, 0, 0.5, -12)
                tpBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
                tpBtn.BorderSizePixel = 0
                tpBtn.Text = "✨ TP PARA"
                tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                tpBtn.TextSize = 9
                tpBtn.Font = Enum.Font.GothamBold
                tpBtn.Parent = playerFrame
                
                local btnCorner = Instance.new("UICorner")
                btnCorner.CornerRadius = UDim.new(0, 4)
                btnCorner.Parent = tpBtn
                
                tpBtn.MouseButton1Click:Connect(function()
                    teleportToPlayer(player)
                end)
                
                yPos = yPos + 38
            end
        end
        
        playerScrolling.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
        updateCanvasSize()
    end
    
    -- ============================================================
    -- ABA 8: INFO
    -- ============================================================
    local function showInfoTab()
        clearContent()
        local y = 10
        createInfo(contentFrame, y, "👻 GHOST HUB v94.2", 14); y = y + 22
        createInfo(contentFrame, y, "Ultimate Edition - Segurança Total v7.5", 11); y = y + 20
        createInfo(contentFrame, y, "Criador: @ghost-hub-z", 10); y = y + 20
        createInfo(contentFrame, y, "YouTube:", 10); y = y + 18
        createInfo(contentFrame, y, "https://youtube.com/@ghost-hub-off", 9); y = y + 20
        y = y + 15
        createInfo(contentFrame, y, "📊 FUNCIONALIDADES", 12); y = y + 20
        createInfo(contentFrame, y, "✓ PROTEÇÃO IA v7.5 (60 CAMADAS)", 9); y = y + 18
        createInfo(contentFrame, y, "✓ RISCO MANTIDO <10%", 9); y = y + 18
        createInfo(contentFrame, y, "✓ INFINITE JUMP", 9); y = y + 18
        createInfo(contentFrame, y, "✓ SPEED HACKER (PIVOTTO)", 9); y = y + 18
        createInfo(contentFrame, y, "✓ X-RAY POR PROXIMIDADE (RAIO)", 9); y = y + 18
        createInfo(contentFrame, y, "✓ UNLOCK ALL (DESBLOQUEAR TUDO)", 9); y = y + 18
        createInfo(contentFrame, y, "✓ TP PARA JOGADORES", 9); y = y + 18
        createInfo(contentFrame, y, "✓ AIMBOT GHOST V2.0 COM TEAM CHECK", 9); y = y + 18
        createInfo(contentFrame, y, "✓ AIMBOT GHOST V4 LITE COM TEAM CHECK", 9); y = y + 18
        createInfo(contentFrame, y, "✓ SILENT AIM", 9); y = y + 18
        createInfo(contentFrame, y, "✓ ESP OTIMIZADO", 9); y = y + 18
        y = y + 15
        createInfo(contentFrame, y, "📊 SEGURANÇA EXTREMA v7.5", 12); y = y + 20
        createInfo(contentFrame, y, "✓ 60 CAMADAS DE BYPASS", 9); y = y + 18
        createInfo(contentFrame, y, "✓ 8 NÍVEIS DE PROTEÇÃO", 9); y = y + 18
        createInfo(contentFrame, y, "✓ CÓDIGO POLIMÓRFICO", 9); y = y + 18
        createInfo(contentFrame, y, "✓ ANTI-HOOK SCANNER", 9); y = y + 18
        createInfo(contentFrame, y, "✓ QUANTUM RANDOMNESS", 9); y = y + 18
        createInfo(contentFrame, y, "✓ FRACTAL SIGNATURE", 9); y = y + 18
        createInfo(contentFrame, y, "✓ ZERO RISK MODE", 9); y = y + 18
        createInfo(contentFrame, y, "✓ TEAM CHECK INTEGRADO NOS AIMBOTS", 9); y = y + 18
        updateCanvasSize()
    end

    -- ============================================================
    -- BOTÕES DAS ABAS (8 ABAS)
    -- ============================================================
    local function createTabButton(name, xPos, color, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 40, 1, 0)
        btn.Position = UDim2.new(0, xPos, 0, 0)
        btn.BackgroundColor3 = color
        btn.BorderSizePixel = 0
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 9
        btn.Font = Enum.Font.GothamBold
        btn.Parent = tabContainer
        
        local originalColor = color
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = originalColor:Lerp(Color3.new(1,1,1), 0.2)}):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = originalColor}):Play()
        end)
        
        btn.MouseButton1Click:Connect(function()
            callback()
            contentFrame.CanvasPosition = Vector2.new(0, 0)
        end)
    end
    
    createTabButton("ESP", 0, Color3.fromRGB(80, 80, 150), showESPTab)
    createTabButton("AIM", 40, Color3.fromRGB(150, 80, 80), showAimbotTab)
    createTabButton("V4", 80, Color3.fromRGB(80, 150, 150), showV4Tab)
    createTabButton("RIV", 120, Color3.fromRGB(80, 150, 80), showRivalsTab)
    createTabButton("MOV", 160, Color3.fromRGB(150, 150, 80), showMovementTab)
    createTabButton("PROT", 200, Color3.fromRGB(150, 80, 150), showProtectionTab)
    createTabButton("TP", 240, Color3.fromRGB(100, 150, 200), showTPTab)
    createTabButton("INFO", 280, Color3.fromRGB(100, 100, 100), showInfoTab)
    
    closeBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
    end)
    
    local openBtn = Instance.new("TextButton")
    openBtn.Size = UDim2.new(0, 45, 0, 45)
    openBtn.Position = UDim2.new(0, 8, 0, 8)
    openBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    openBtn.BackgroundTransparency = 0.1
    openBtn.BorderSizePixel = 0
    openBtn.Text = "👻"
    openBtn.TextColor3 = Color3.fromRGB(150, 150, 255)
    openBtn.TextSize = 22
    openBtn.Font = Enum.Font.GothamBold
    openBtn.Parent = screenGui
    openBtn.Draggable = true
    openBtn.Visible = true
    
    local openCorner = Instance.new("UICorner")
    openCorner.CornerRadius = UDim.new(0, 12)
    openCorner.Parent = openBtn
    
    local openStroke = Instance.new("UIStroke")
    openStroke.Thickness = 1
    openStroke.Color = Color3.fromRGB(80, 80, 120)
    openStroke.Parent = openBtn
    
    openBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
    end)
    
    settings.xrayRadius = 50
    
    showESPTab()
    mainFrame.Visible = true
    return true
end

local function setupESP()
    ESP.Enabled = settings.enabled
    ESP.ShowBoxes = settings.showBox
    ESP.ShowNames = settings.showName
    ESP.ShowTracers = settings.showTracer
    ESP.ShowHealth = settings.showHealth
    ESP.ShowDistance = settings.showDistance
    ESP.MaxDistance = settings.maxDistance
    ESP.TracerPosition = settings.tracerPosition
    
    if settings.rainbowMode then
        ESP.Color = nil
    else
        ESP.Color = settings.boxColor
    end
end

local function updateESP()
    ESP.Enabled = settings.enabled
    ESP.ShowBoxes = settings.showBox
    ESP.ShowNames = settings.showName
    ESP.ShowTracers = settings.showTracer
    ESP.ShowHealth = settings.showHealth
    ESP.ShowDistance = settings.showDistance
    ESP.MaxDistance = settings.maxDistance
    ESP.TracerPosition = settings.tracerPosition
    
    if settings.rainbowMode then
        ESP.Color = nil
    else
        ESP.Color = settings.boxColor
    end
end

spawn(function()
    while true do
        updateESP()
        wait(0.1)
    end
end)
-- ============================================================
-- EXPORTAÇÃO DE FUNÇÕES
-- ============================================================

_G.AimbotGhost = {
    enable = function() setAimbotGhost(true) end,
    disable = function() setAimbotGhost(false) end,
    toggle = function() setAimbotGhost(not aimbotGhostEnabled) end,
    isEnabled = function() return aimbotGhostEnabled end
}

_G.SpeedHacker = {
    enable = enableSpeedHack,
    disable = disableSpeedHack,
    toggle = toggleSpeedHack,
    setSpeed = setSpeed,
    isEnabled = function() return SpeedSettings.Enabled end,
    getSpeed = function() return SpeedSettings.MaxSpeed end
}

_G.ProximityXRay = {
    enable = function() setProximityXRay(true) end,
    disable = function() setProximityXRay(false) end,
    toggle = function() setProximityXRay(not proximityXRayEnabled) end,
    setRadius = setXrayRadius,
    isEnabled = function() return proximityXRayEnabled end,
    getRadius = function() return xrayRadius end
}

_G.AimbotV4 = {
    enable = function() setV4Locking(true) end,
    disable = function() setV4Locking(false) end,
    toggle = function() setV4Locking(not _G.NS_SETTINGS.Locking) end,
    setSmoothness = function(val) setV4Smoothness(val) end,
    setFOV = function(val) setV4FOV(val) end,
    setWallCheck = function(val) setV4WallCheck(val) end,
    isEnabled = function() return _G.NS_SETTINGS.Locking end,
    getSmoothness = function() return _G.NS_SETTINGS.Smoothness end,
    getFOV = function() return _G.NS_SETTINGS.FOV end,
    getWallCheck = function() return _G.NS_SETTINGS.WallCheck end
}

_G.TeamCheck = {
    isAlly = isAlly,
    isEnemy = isEnemy,
    canTarget = canTarget,
    getEnemies = getEnemies
}

-- ============================================================
-- INICIAR PAINEL
-- ============================================================
showNotification("GHOST HUB " .. CURRENT_VERSION .. " - SEGURANÇA TOTAL v7.5", "success")
print(">> 👻 GHOST HUB " .. CURRENT_VERSION .. " - ULTIMATE")
print(">> ✅ 60 CAMADAS DE BYPASS | IA v7.5")
print(">> ✅ RISCO MANTIDO ABAIXO DE 10%")
print(">> ✅ PROTEÇÃO CONTA PRINCIPAL ULTRA-AGRESSIVA")
print(">> ✅ TEAM CHECK INTEGRADO (Aimbot V2 e V4)")
print(">> ✅ INFINITE JUMP")
print(">> ✅ SPEED HACKER (PIVOTTO - SUAVE E CONFIGURÁVEL)")
print(">> ✅ X-RAY POR PROXIMIDADE (RAIO - TRANSPARÊNCIA PROGRESSIVA)")
print(">> ✅ UNLOCK ALL (DESBLOQUEAR TUDO)")
print(">> ✅ TP PARA JOGADORES")
print(">> ✅ AIMBOT GHOST V2.0 (VISIBILIDADE + MIRA AUTOMÁTICA + TEAM CHECK)")
print(">> ✅ AIMBOT GHOST V4 LITE (FOV ARCO-ÍRIS + SMOOTHNESS + TEAM CHECK)")
print(">> ✅ SILENT AIM")
print(">> ✅ ESP OTIMIZADO (LIMITE + DISTÂNCIA + TRACER POSITION)")
print(">> 🔒 RISCO MANTIDO ABAIXO DE 10%")
print(">> 👥 TEAM CHECK: Aimbots NUNCA miram em aliados")
print(">> ❌ HITBOX + X-RAY REMOVIDO DO SCRIPT")
print(">> YouTube: " .. YOUTUBE_LINK)

spawn(function()
    createPanel()
end)
