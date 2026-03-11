--[[
    ============================================================
    GHOST HUB v91.4 - PREMIUM EDITION (240x350)
    ============================================================
    👻 By @ghost-hub-z
    Discord: https://discord.gg/sNUcy5yGd
    
    ✅ PAINEL 240x350 (MAIS COMPACTO)
    ✅ DESIGN PREMIUM: Gradientes, sombras, bordas arredondadas
    ✅ 10 ABAS COMPLETAS
    ✅ TODAS AS FUNÇÕES PRESERVADAS
    ✅ ARRASTÁVEL
]]

-- ============================================================
-- INFORMAÇÕES DO CRIADOR
-- ============================================================
local CREATOR_NAME = "@ghost-hub-z"
local DISCORD_LINK = "https://discord.gg/sNUcy5yGd"
local CURRENT_VERSION = "v91.4"

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

-- Aguarda jogador carregar
for i = 1, 10 do
    if LocalPlayer and LocalPlayer.Character then break end
    wait(0.5)
end

-- ============================================================
-- VERIFICAÇÃO DO JOGO RIVALS
-- ============================================================
local function isRivalsGame()
    local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    if gameName and gameName:lower():find("rivals") then
        return true
    end
    
    if ReplicatedStorage:FindFirstChild("Modules") or 
       ReplicatedStorage:FindFirstChild("GameData") or
       workspace:FindFirstChild("Ignore") then
        return true
    end
    
    return false
end

if not isRivalsGame() then
    print(">> ❌ Este script funciona APENAS no jogo RIVALS!")
    return
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
    frame.Size = UDim2.new(0, 280, 0, 55)
    frame.Position = UDim2.new(0.5, -140, 0, -55)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    frame.BackgroundTransparency = 0.05
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.Parent = notificationGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 35)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 20))
    })
    gradient.Parent = frame

    local leftBar = Instance.new("Frame")
    leftBar.Size = UDim2.new(0, 4, 1, 0)
    leftBar.BackgroundColor3 = bgColor
    leftBar.BorderSizePixel = 0
    leftBar.Parent = frame

    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 35, 1, 0)
    icon.Position = UDim2.new(0, 8, 0, 0)
    icon.BackgroundTransparency = 1
    icon.Text = type == "success" and "✓" or type == "error" and "✗" or type == "warning" and "⚠" or "●"
    icon.TextColor3 = bgColor
    icon.TextSize = 20
    icon.Font = Enum.Font.GothamBold
    icon.Parent = frame

    local msg = Instance.new("TextLabel")
    msg.Size = UDim2.new(1, -55, 1, 0)
    msg.Position = UDim2.new(0, 45, 0, 0)
    msg.BackgroundTransparency = 1
    msg.Text = message
    msg.TextColor3 = Color3.fromRGB(255, 255, 255)
    msg.TextSize = 12
    msg.Font = Enum.Font.Gotham
    msg.TextXAlignment = Enum.TextXAlignment.Left
    msg.TextYAlignment = Enum.TextYAlignment.Center
    msg.Parent = frame

    local goal = {Position = UDim2.new(0.5, -140, 0, 15)}
    local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(frame, tweenInfo, goal)
    tween:Play()

    spawn(function()
        wait(2.5)
        local goalOut = {Position = UDim2.new(0.5, -140, 0, -55)}
        local tweenOut = TweenService:Create(frame, tweenInfo, goalOut)
        tweenOut:Play()
        wait(0.4)
        notificationGui:Destroy()
    end)
end

-- ============================================================
-- CONFIGURAÇÕES (MANTIDAS)
-- ============================================================
local settings = {
    -- ESP
    enabled = false,
    teamCheck = true,
    showBox = false,
    showTracer = false,
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

    -- Aimbot
    aimbotEnabled = false,
    aimFOV = 200,
    aimPart = "Head",
    smoothness = 0.15,
    prediction = 0.2,
    showFOVCircle = false,
    fovColor = Color3.fromRGB(255, 255, 255),
    aimlockEnabled = false,

    -- RIVALS
    silentAim = false,
    magicBullet = false,
    noSpread = false,
    noRecoil = false,
    bulletVelocity = 2000,
    aimkillEnabled = false,
    
    -- Caixa 3D de dano
    hitbox3DEnabled = false,
    hitbox3DSize = 8.0,
    hitbox3DDamage = 999999,
    hitbox3DAlwaysHeadshot = true,

    -- Movimento
    noclipEnabled = false,
    flyEnabled = false,
    flySpeed = 50,

    -- Arco-íris
    rainbowMode = false,
    rainbowSpeed = 0.1,

    -- VOID
    voidUnlocked = false,
    voidProtectionEnabled = false,
    voidFloatEnabled = false,
    voidBlocksEnabled = false,
    voidTeleportEnabled = false,
    voidBlockSize = 10,
    voidBlockTransparency = 0.5,
    voidSafeY = 50,
    
    -- PROTEÇÃO
    mainAccountMode = false,
    riskAnalysisEnabled = true,
    autoBackupEnabled = true,
    antiBanProfileEnabled = true,
}

-- ============================================================
-- VARIÁVEIS GLOBAIS
-- ============================================================
local espObjects = {}
local aimActive = false
local currentTarget = nil
local fovCircle = Drawing.new("Circle")
local rainbowHue = 0
local noclipConnection = nil
local flyConnection = nil
local remoteCache = {}
local damageRemotes = {}
local killRemotes = {}
local aimkillBusy = false
local voidBlocks = {}
local voidFloatConnection = nil
local lastSafePosition = nil
local hitbox3DObjects = {}

fovCircle.Visible = false
fovCircle.Thickness = 1
fovCircle.NumSides = 60
fovCircle.Radius = settings.aimFOV
fovCircle.Color = settings.fovColor
fovCircle.Filled = false
fovCircle.Transparency = 1

-- ============================================================
-- FUNÇÕES DE TARGET
-- ============================================================
local function isValidTarget(player)
    if not settings.enabled and not settings.aimbotEnabled and not settings.hitbox3DEnabled then return false end
    if not player or player == LocalPlayer then return false end
    
    local char = player.Character
    if not char then return false end
    
    local hum = char:FindFirstChild("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    
    local root = char:FindFirstChild("HumanoidRootPart") or 
                char:FindFirstChild("Torso") or 
                char:FindFirstChild("UpperTorso") or 
                char:FindFirstChild("LowerTorso")
    
    if not root then return false end
    
    if settings.teamCheck and player.Team and LocalPlayer.Team then
        if player.Team == LocalPlayer.Team then
            return false
        end
    end
    
    local dist = (root.Position - Camera.CFrame.Position).Magnitude
    if dist > settings.maxDistance then return false end
    
    return true
end

local function getBestTargetFromCenter()
    if not settings.aimbotEnabled then return nil end
    
    local bestTarget = nil
    local bestDist = settings.aimFOV
    local center = Camera.ViewportSize / 2
    
    for _, player in pairs(Players:GetPlayers()) do
        if isValidTarget(player) then
            local char = player.Character
            local targetPart = char:FindFirstChild(settings.aimPart) or 
                              char:FindFirstChild("HumanoidRootPart") or 
                              char:FindFirstChild("Torso") or 
                              char:FindFirstChild("UpperTorso") or
                              char:FindFirstChild("Head")
            
            if targetPart then
                local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                    if dist < bestDist then
                        bestDist = dist
                        bestTarget = player
                    end
                end
            end
        end
    end
    
    return bestTarget
end

-- ============================================================
-- AIMBOT
-- ============================================================
UserInputService.TouchStarted:Connect(function()
    if not settings.aimbotEnabled then return end
    aimActive = true
    currentTarget = getBestTargetFromCenter()
    if currentTarget then
        showNotification("Mirando em " .. currentTarget.Name, "info")
    end
end)

UserInputService.TouchEnded:Connect(function()
    aimActive = false
    if not settings.aimlockEnabled then 
        currentTarget = nil
    end
end)

RunService.RenderStepped:Connect(function()
    if settings.showFOVCircle and settings.aimbotEnabled then
        fovCircle.Visible = true
        fovCircle.Position = Camera.ViewportSize / 2
        fovCircle.Radius = settings.aimFOV
        fovCircle.Color = settings.fovColor
    else
        fovCircle.Visible = false
    end

    if settings.aimbotEnabled and aimActive and currentTarget and isValidTarget(currentTarget) then
        local char = currentTarget.Character
        local targetPart = char:FindFirstChild(settings.aimPart) or 
                          char:FindFirstChild("HumanoidRootPart") or 
                          char:FindFirstChild("Torso") or 
                          char:FindFirstChild("UpperTorso") or
                          char:FindFirstChild("Head")
        
        if targetPart then
            local camPos = Camera.CFrame.Position
            local dir = (targetPart.Position - camPos).Unit
            local targetCF = CFrame.lookAt(camPos, camPos + dir)
            Camera.CFrame = Camera.CFrame:Lerp(targetCF, 1 - settings.smoothness)
        end
    end
end)

-- ============================================================
-- DETECÇÃO DE REMOTES
-- ============================================================
local function findRivalsRemotes()
    print(">> 🔍 Escaneando remotes...")
    
    local rivalsRemotes = {
        "Damage", "TakeDamage", "Hit", "BulletHit", "Health",
        "Kill", "Die", "Death", "Eliminate", "Shoot", "Fire"
    }
    
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            local name = obj.Name
            for _, remoteName in ipairs(rivalsRemotes) do
                if name:find(remoteName) or name:lower():find(remoteName:lower()) then
                    remoteCache[obj] = true
                    if name:find("Damage") or name:find("Hit") or name:find("Health") then
                        damageRemotes[obj] = true
                    elseif name:find("Kill") or name:find("Die") or name:find("Death") then
                        killRemotes[obj] = true
                    end
                    break
                end
            end
        end
    end
end

findRivalsRemotes()

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
            if (settings.silentAim or settings.magicBullet or settings.hitbox3DEnabled) and currentTarget and isValidTarget(currentTarget) then
                local char = currentTarget.Character
                local targetPart = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
                
                if targetPart then
                    local targetPos = targetPart.Position
                    
                    if settings.silentAim or settings.hitbox3DEnabled then
                        for i = 1, #args do
                            if type(args[i]) == "Vector3" then
                                args[i] = targetPos
                            elseif type(args[i]) == "CFrame" then
                                args[i] = CFrame.lookAt(args[i].Position, targetPos)
                            end
                        end
                    end
                    
                    if settings.magicBullet or settings.hitbox3DEnabled then
                        for damRemote, _ in pairs(damageRemotes) do
                            pcall(function()
                                damRemote:FireServer(char, settings.hitbox3DDamage)
                                if settings.hitbox3DAlwaysHeadshot and char:FindFirstChild("Head") then
                                    damRemote:FireServer(char.Head, settings.hitbox3DDamage)
                                end
                            end)
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
-- CAIXA 3D DE DANO
-- ============================================================
local function create3DHitbox(player)
    if not settings.hitbox3DEnabled then return end
    if not player or not player.Character then return end
    
    local char = player.Character
    local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
    if not root then return end
    
    if hitbox3DObjects[player] and hitbox3DObjects[player].Parent then
        hitbox3DObjects[player].CFrame = root.CFrame
        return
    end
    
    local hitbox = Instance.new("Part")
    hitbox.Size = Vector3.new(settings.hitbox3DSize, settings.hitbox3DSize * 2, settings.hitbox3DSize)
    hitbox.CFrame = root.CFrame
    hitbox.Anchored = false
    hitbox.CanCollide = false
    hitbox.Transparency = 0.7
    hitbox.BrickColor = BrickColor.new("Bright red")
    hitbox.Material = Enum.Material.Neon
    hitbox.Name = "3DHitbox_" .. player.Name
    hitbox.Parent = workspace
    
    hitbox3DObjects[player] = hitbox
    Debris:AddItem(hitbox, 10)
end

-- ============================================================
-- AIMKILL
-- ============================================================
local function aimkill()
    if not settings.aimkillEnabled then 
        showNotification("AIMKILL desativado", "error")
        return false 
    end
    if aimkillBusy then 
        showNotification("Já em execução", "warning")
        return false 
    end
    if not currentTarget or not isValidTarget(currentTarget) then 
        showNotification("Nenhum alvo", "error")
        return false 
    end

    aimkillBusy = true
    local char = currentTarget.Character
    local hum = char and char:FindFirstChild("Humanoid")
    
    showNotification("Executando AIMKILL", "warning")
    
    spawn(function()
        local killed = false
        
        for remote, _ in pairs(killRemotes) do
            pcall(function() remote:FireServer(char) wait(0.05) killed = true end)
        end
        
        if not killed then
            for remote, _ in pairs(damageRemotes) do
                pcall(function() remote:FireServer(char, 999999) wait(0.05) killed = true end)
            end
        end
        
        if not killed and hum then
            pcall(function() hum.Health = 0 char:BreakJoints() killed = true end)
        end
        
        showNotification(killed and "✅ Eliminado!" or "❌ Falhou", killed and "success" or "error")
        wait(0.5)
        aimkillBusy = false
    end)
    
    return true
end

-- ============================================================
-- NOCLIP
-- ============================================================
local function updateNoclip()
    if not settings.noclipEnabled then return end
    local character = LocalPlayer.Character
    if not character then return end
    
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

local function setNoclip(state)
    settings.noclipEnabled = state
    if state then
        if noclipConnection then noclipConnection:Disconnect() end
        noclipConnection = RunService.Stepped:Connect(updateNoclip)
        showNotification("NOCLIP ATIVADO", "success")
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        showNotification("NOCLIP DESATIVADO", "info")
    end
end

-- ============================================================
-- FLY
-- ============================================================
local function updateFly()
    if not settings.flyEnabled then return end
    local character = LocalPlayer.Character
    if not character then return end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
    if not rootPart then return end
    
    local moveDir = Vector3.new(0, 0, 0)
    local cameraDir = Camera.CFrame.LookVector
    local cameraRight = Camera.CFrame.RightVector
    
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cameraDir end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cameraDir end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cameraRight end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cameraRight end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
    
    if moveDir.Magnitude > 0 then
        rootPart.Velocity = moveDir.Unit * settings.flySpeed
    else
        rootPart.Velocity = Vector3.new(0, 0, 0)
    end
end

local function setFly(state)
    settings.flyEnabled = state
    if state then
        if flyConnection then flyConnection:Disconnect() end
        flyConnection = RunService.Heartbeat:Connect(updateFly)
        showNotification("FLY ATIVADO", "success")
    else
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
      
