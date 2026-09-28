-- ============================================
-- SCRIPT DA RAPAZIADA 🔥
-- Speed | Noclip | Jump | ESP | Hitbox | Aimbot
-- Abas: Movement | ESP | Combat | Visuals
-- ============================================

-- ============================================
-- PROTEÇÃO BÁSICA (SEGURA - NÃO QUEBRA RAYFIELD)
-- ============================================
pcall(function() getscriptbytecode = nil end)
pcall(function() getscripthash = nil end)
pcall(function() dumpstring = nil end)

-- Verificação de ambiente
local ALLOWED_EXECUTORS = {
    "Delta", "Solara", "Xeno", "Wave", "Arceus",
    "Codex", "Hydrogen", "Fluxus", "Krnl", "Synapse",
    "Script-Ware", "Vega", "Swift", "Cryptic"
}

local executorName = "Unknown"
pcall(function()
    if identifyexecutor then
        executorName = identifyexecutor()
    end
end)

local executorOk = false
for _, name in ipairs(ALLOWED_EXECUTORS) do
    if string.find(executorName, name, 1, true) then
        executorOk = true
        break
    end
end

if not executorOk then
    warn("[Script da Rapaziada] Executor não reconhecido: " .. executorName)
end

-- Watermark
local userName = "Usuário"
pcall(function()
    userName = game:GetService("Players").LocalPlayer.Name
end)

print("[Script da Rapaziada 🔥] Carregando para " .. userName)
print("[Script da Rapaziada] Executor: " .. executorName)

-- ============================================
-- CARREGA RAYFIELD (com pcall de segurança)
-- ============================================
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/gen2"))()
end)

if not success or not Rayfield then
    warn("[Script da Rapaziada] Falha ao carregar Rayfield!")
    return
end

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ============================================
-- JANELA PRINCIPAL
-- ============================================
local window = Rayfield:CreateWindow({
    name = "Script da Rapaziada 🔥",
    subtitle = "v1.0 | " .. userName,
    sidebarLayout = true,
    configuration = {
        autoSave = true,
        autoLoad = true,
        fileName = "RapaziadaConfig"
    }
})

-- ============================================
-- ABA 1: MOVEMENT
-- ============================================
local tabMovement = window:CreateTab({
    name = "Movement",
    icon = 93364949241311
})

local sectionMove = tabMovement:CreateSection("Movimento")

local speedEnabled = false
local speedValue = 16

tabMovement:CreateToggle({
    name = "Speed Hack",
    default = false,
    callback = function(value)
        speedEnabled = value
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = value and speedValue or 16
        end
    end
})

tabMovement:CreateSlider({
    name = "Velocidade",
    min = 16, max = 200, default = 16,
    callback = function(value)
        speedValue = value
        if speedEnabled then
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = value end
        end
    end
})

local jumpEnabled = false
local jumpValue = 50

tabMovement:CreateToggle({
    name = "Jump Power",
    default = false,
    callback = function(value)
        jumpEnabled = value
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.UseJumpPower = true
            hum.JumpPower = value and jumpValue or 50
        end
    end
})

tabMovement:CreateSlider({
    name = "Jump Power Value",
    min = 50, max = 500, default = 50,
    callback = function(value)
        jumpValue = value
        if jumpEnabled then
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then hum.JumpPower = value end
        end
    end
})

local noclipEnabled = false

tabMovement:CreateToggle({
    name = "Noclip",
    default = false,
    callback = function(value) noclipEnabled = value end
})

RunService.Stepped:Connect(function()
    if noclipEnabled then
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    if speedEnabled then
        char:WaitForChild("Humanoid").WalkSpeed = speedValue
    end
    if jumpEnabled then
        local hum = char:WaitForChild("Humanoid")
        hum.UseJumpPower = true
        hum.JumpPower = jumpValue
    end
end)

-- ============================================
-- ABA 2: ESP
-- ============================================
local tabESP = window:CreateTab({
    name = "ESP",
    icon = 0
})

local sectionESP = tabESP:CreateSection("ESP")

local espEnabled = false
local espObjects = {}

local ESP_COLOR = Color3.fromRGB(0, 255, 0)
local TRACER_COLOR = Color3.fromRGB(255, 255, 0)
local TEXT_COLOR = Color3.fromRGB(255, 255, 255)
local HEALTH_HIGH = Color3.fromRGB(0, 255, 0)
local HEALTH_LOW = Color3.fromRGB(255, 0, 0)
local MAX_DISTANCE = 1000

local hasDrawing = pcall(function() return Drawing.new("Square") end)

local function CreateESP(player)
    if not hasDrawing then return end
    if player == LocalPlayer then return end
    if espObjects[player] then return end

    local ok, box = pcall(function() return Drawing.new("Square") end)
    if not ok then return end

    box.Thickness = 1; box.Color = ESP_COLOR; box.Filled = false; box.Visible = false

    local tracer = Drawing.new("Line")
    tracer.Thickness = 1; tracer.Color = TRACER_COLOR; tracer.Visible = false

    local nameTag = Drawing.new("Text")
    nameTag.Size = 14; nameTag.Center = true; nameTag.Outline = true
    nameTag.Color = TEXT_COLOR; nameTag.Visible = false

    local distTag = Drawing.new("Text")
    distTag.Size = 12; distTag.Center = true; distTag.Outline = true
    distTag.Color = TEXT_COLOR; distTag.Visible = false

    local healthBar = Drawing.new("Line")
    healthBar.Thickness = 2; healthBar.Visible = false

    espObjects[player] = {
        Box = box, Tracer = tracer, NameTag = nameTag,
        DistTag = distTag, HealthBar = healthBar
    }
end

local function RemoveESP(player)
    local obj = espObjects[player]
    if not obj then return end
    for _, drawing in pairs(obj) do
        pcall(function() drawing:Remove() end)
    end
    espObjects[player] = nil
end

local function HideAllESP()
    for _, obj in pairs(espObjects) do
        for _, d in pairs(obj) do
            pcall(function() d.Visible = false end)
        end
    end
end

RunService.RenderStepped:Connect(function()
    if not espEnabled then HideAllESP() return end

    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local myPos = myRoot and myRoot.Position

    for player, obj in pairs(espObjects) do
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")

        if hrp and humanoid and humanoid.Health > 0 and myPos then
            local dist = (hrp.Position - myPos).Magnitude
            if dist <= MAX_DISTANCE then
                local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                if onScreen and pos.Z > 0 then
                    local scale = math.clamp(1000 / pos.Z, 20, 300)
                    local boxW = scale * 0.6
                    local boxH = scale
                    local cx, cy = pos.X, pos.Y

                    obj.Box.Size = Vector2.new(boxW, boxH)
                    obj.Box.Position = Vector2.new(cx - boxW/2, cy - boxH/2)
                    obj.Box.Visible = true

                    obj.Tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                    obj.Tracer.To = Vector2.new(cx, cy + boxH/2)
                    obj.Tracer.Visible = true

                    obj.NameTag.Text = player.Name
                    obj.NameTag.Position = Vector2.new(cx, cy - boxH/2 - 20)
                    obj.NameTag.Visible = true

                    obj.DistTag.Text = string.format("[%d m]", math.floor(dist))
                    obj.DistTag.Position = Vector2.new(cx, cy + boxH/2 + 5)
                    obj.DistTag.Visible = true

                    local hpPct = humanoid.Health / humanoid.MaxHealth
                    local barH = boxH * hpPct
                    obj.HealthBar.From = Vector2.new(cx - boxW/2 - 6, cy + boxH/2)
                    obj.HealthBar.To = Vector2.new(cx - boxW/2 - 6, cy + boxH/2 - barH)
                    obj.HealthBar.Color = HEALTH_LOW:Lerp(HEALTH_HIGH, hpPct)
                    obj.HealthBar.Visible = true
                else
                    for _, d in pairs(obj) do d.Visible = false end
                end
            else
                for _, d in pairs(obj) do d.Visible = false end
            end
        else
            for _, d in pairs(obj) do d.Visible = false end
        end
    end
end)

Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(RemoveESP)
for _, p in ipairs(Players:GetPlayers()) do CreateESP(p) end

tabESP:CreateToggle({
    name = "Enable ESP",
    default = false,
    callback = function(value)
        espEnabled = value
        if not value then HideAllESP() end
        if not hasDrawing then
            window:Notify({ title = "ESP", content = "Executor sem Drawing API" })
        end
    end
})

-- ============================================
-- ABA 3: COMBAT
-- ============================================
local tabCombat = window:CreateTab({
    name = "Combat",
    icon = 0
})

local sectionAimbot = tabCombat:CreateSection("Aimbot")

local AimbotConfig = {
    Enabled     = false,
    FOV         = 200,
    AimPart     = "Head",
    Smooth      = 0.25,
    TeamCheck   = true,
    WallCheck   = true,
    MaxDistance = 500,
    ShowFOV     = true,
    ShowTarget  = true,
}

local lockedTarget = nil

local aimScreen = Instance.new("ScreenGui")
aimScreen.Name = "RapaziadaAimbotVisual"
aimScreen.ResetOnSpawn = false
aimScreen.IgnoreGuiInset = true
aimScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
aimScreen.Parent = LocalPlayer:WaitForChild("PlayerGui")

local fovFrame = Instance.new("Frame")
fovFrame.AnchorPoint = Vector2.new(0.5, 0.5)
fovFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
fovFrame.Size = UDim2.fromOffset(AimbotConfig.FOV * 2, AimbotConfig.FOV * 2)
fovFrame.BackgroundTransparency = 1
fovFrame.BorderSizePixel = 0
fovFrame.Visible = false
fovFrame.ZIndex = 5
fovFrame.Parent = aimScreen

local fovCorner = Instance.new("UICorner")
fovCorner.CornerRadius = UDim.new(1, 0)
fovCorner.Parent = fovFrame

local fovStroke = Instance.new("UIStroke")
fovStroke.Color = Color3.fromRGB(255, 255, 255)
fovStroke.Thickness = 2
fovStroke.Transparency = 0.3
fovStroke.Parent = fovFrame

local targetDot = Instance.new("Frame")
targetDot.AnchorPoint = Vector2.new(0.5, 0.5)
targetDot.Size = UDim2.fromOffset(14, 14)
targetDot.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
targetDot.BorderSizePixel = 0
targetDot.Visible = false
targetDot.ZIndex = 6
targetDot.Parent = aimScreen

local dotCorner = Instance.new("UICorner")
dotCorner.CornerRadius = UDim.new(1, 0)
dotCorner.Parent = targetDot

local dotStroke = Instance.new("UIStroke")
dotStroke.Color = Color3.fromRGB(255, 255, 255)
dotStroke.Thickness = 2
dotStroke.Parent = targetDot

local function IsVisible(part)
    if not AimbotConfig.WallCheck then return true end
    local origin = Camera.CFrame.Position
    local direction = part.Position - origin

    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    local ignore = {LocalPlayer.Character}
    if part.Parent then table.insert(ignore, part.Parent) end
    params.FilterDescendantsInstances = ignore

    local result = workspace:Raycast(origin, direction, params)
    if not result then return true end
    if result.Instance and part.Parent and result.Instance:IsDescendantOf(part.Parent) then
        return true
    end
    return false
end

local function IsValidTarget(player)
    if not player or player == LocalPlayer then return false end
    if AimbotConfig.TeamCheck and player.Team and player.Team == LocalPlayer.Team then
        return false
    end
    local char = player.Character
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    return true
end

local function GetAimPart(player)
    local char = player.Character
    if not char then return nil end
    return char:FindFirstChild(AimbotConfig.AimPart)
        or char:FindFirstChild("Head")
        or char:FindFirstChild("HumanoidRootPart")
end

local function GetBestTarget()
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local myPos = myRoot and myRoot.Position

    local best, bestScore = nil, AimbotConfig.FOV

    for _, player in ipairs(Players:GetPlayers()) do
        if IsValidTarget(player) then
            local part = GetAimPart(player)
            if part and myPos then
                local realDist = (part.Position - myPos).Magnitude
                if realDist <= AimbotConfig.MaxDistance and IsVisible(part) then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
                    if onScreen and screenPos.Z > 0 then
                        local dist2D = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                        if dist2D < bestScore then
                            bestScore = dist2D
                            best = player
                        end
                    end
                end
            end
        end
    end
    return best
end

RunService:BindToRenderStep("RapaziadaAimbotLoop", Enum.RenderPriority.Camera.Value + 1, function(dt)
    fovFrame.Visible = AimbotConfig.Enabled and AimbotConfig.ShowFOV
    fovFrame.Size = UDim2.fromOffset(AimbotConfig.FOV * 2, AimbotConfig.FOV * 2)

    if not AimbotConfig.Enabled then
        targetDot.Visible = false
        lockedTarget = nil
        return
    end

    if lockedTarget then
        if not IsValidTarget(lockedTarget) then
            lockedTarget = nil
        else
            local part = GetAimPart(lockedTarget)
            if part then
                local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
                local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                local dist2D = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                if not onScreen or dist2D > AimbotConfig.FOV or not IsVisible(part) then
                    lockedTarget = nil
                end
            else
                lockedTarget = nil
            end
        end
    end

    if not lockedTarget then
        lockedTarget = GetBestTarget()
    end

    if not lockedTarget then
        targetDot.Visible = false
        return
    end

    local part = GetAimPart(lockedTarget)
    if not part then
        targetDot.Visible = false
        return
    end

    if AimbotConfig.ShowTarget then
        local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
        if onScreen and screenPos.Z > 0 then
            targetDot.Position = UDim2.fromOffset(screenPos.X, screenPos.Y)
            targetDot.Visible = true
        else
            targetDot.Visible = false
        end
    end

    local currentCFrame = Camera.CFrame
    local targetCFrame = CFrame.new(currentCFrame.Position, part.Position)

    if AimbotConfig.Smooth <= 0.01 then
        Camera.CFrame = targetCFrame
    else
        Camera.CFrame = currentCFrame:Lerp(targetCFrame, 1 - AimbotConfig.Smooth)
    end
end)

tabCombat:CreateToggle({
    name = "Enable Aimbot",
    default = false,
    callback = function(value)
        AimbotConfig.Enabled = value
        if not value then
            lockedTarget = nil
            targetDot.Visible = false
            fovFrame.Visible = false
        end
    end
})

tabCombat:CreateSlider({
    name = "FOV Radius",
    min = 50, max = 500, default = 200,
    callback = function(value) AimbotConfig.FOV = value end
})

tabCombat:CreateDropdown({
    name = "Aim Part",
    options = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"},
    callback = function(option) AimbotConfig.AimPart = option end
})

tabCombat:CreateSlider({
    name = "Smooth (0 = Instant)",
    min = 0, max = 90, default = 25,
    callback = function(value) AimbotConfig.Smooth = value / 100 end
})

tabCombat:CreateToggle({
    name = "Team Check",
    default = true,
    callback = function(value) AimbotConfig.TeamCheck = value end
})

tabCombat:CreateToggle({
    name = "Wall Check",
    default = true,
    callback = function(value) AimbotConfig.WallCheck = value end
})

tabCombat:CreateSlider({
    name = "Max Distance",
    min = 50, max = 2000, default = 500,
    callback = function(value) AimbotConfig.MaxDistance = value end
})

-- ---- HITBOX ----
local sectionHitbox = tabCombat:CreateSection("Hitbox")

local hitboxEnabled = false
local hitboxSize = 10

local function ApplyHitbox(player)
    if player == LocalPlayer then return end
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
        hrp.Transparency = 0.5
        hrp.BrickColor = BrickColor.new("Really red")
        hrp.Material = Enum.Material.Neon
        hrp.CanCollide = false
    end
end

local function ResetHitbox(player)
    if player == LocalPlayer then return end
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.Size = Vector3.new(2, 2, 1)
        hrp.Transparency = 1
        hrp.BrickColor = BrickColor.new("Medium stone grey")
        hrp.Material = Enum.Material.Plastic
        hrp.CanCollide = true
    end
end

tabCombat:CreateToggle({
    name = "Enable Hitbox",
    default = false,
    callback = function(value)
        hitboxEnabled = value
        for _, p in ipairs(Players:GetPlayers()) do
            if value then ApplyHitbox(p) else ResetHitbox(p) end
        end
    end
})

tabCombat:CreateSlider({
    name = "Hitbox Size",
    min = 5, max = 50, default = 10,
    callback = function(value)
        hitboxSize = value
        if hitboxEnabled then
            for _, p in ipairs(Players:GetPlayers()) do ApplyHitbox(p) end
        end
    end
})

Players.PlayerAdded:Connect(function(p)
    if hitboxEnabled then
        task.wait(1)
        ApplyHitbox(p)
    end
end)

-- ============================================
-- ABA 4: VISUALS
-- ============================================
local tabVisuals = window:CreateTab({
    name = "Visuals",
    icon = 0
})

local sectionVisuals = tabVisuals:CreateSection("Aimbot Visuals")

tabVisuals:CreateToggle({
    name = "Mostrar FOV Circle",
    default = true,
    callback = function(value) AimbotConfig.ShowFOV = value end
})

tabVisuals:CreateToggle({
    name = "Mostrar Marcador do Alvo",
    default = true,
    callback = function(value) AimbotConfig.ShowTarget = value end
})

local sectionAmbient = tabVisuals:CreateSection("Ambiente")

tabVisuals:CreateToggle({
    name = "Fullbright",
    default = false,
    callback = function(value)
        local lighting = game:GetService("Lighting")
        if value then
            lighting.Ambient = Color3.fromRGB(255, 255, 255)
            lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            lighting.Brightness = 3
        else
            lighting.Ambient = Color3.fromRGB(0, 0, 0)
            lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
            lighting.Brightness = 2
        end
    end
})

-- ============================================
-- NOTIFICAÇÃO FINAL
-- ============================================
window:Notify({
    title = "Script da Rapaziada 🔥",
    content = "Bem-vindo, " .. userName .. "!"
})