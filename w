local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local Player = Players.LocalPlayer
local cam = workspace.CurrentCamera
local uis = UserInputService
local rs = RunService

--// ===== ذخیره زبان =====
local LANG_FILE = "qasim_lang.json"
local currentLang = nil

local function loadLang()
    local success, result = pcall(function()
        if readfile and isfile and isfile(LANG_FILE) then
            local data = HttpService:JSONDecode(readfile(LANG_FILE))
            return data.lang
        end
    end)
    if success and result then return result end
    return nil
end

local function saveLang(lang)
    pcall(function()
        if writefile then
            writefile(LANG_FILE, HttpService:JSONEncode({lang = lang}))
        end
    end)
end

--// ===== ترجمه =====
local T = {
    fa = {
        title = "🗿 قاسم تریاک ورژن 5",
        fly = "پرواز", fly_on = "پرواز (روشن)",
        noclip = "نوکلیپ", noclip_on = "نوکلیپ (روشن)",
        night = "دید در شب", night_on = "دید در شب (روشن)",
        reset = "ریست",
        checkpoint = "چک پوینت", goto_checkpoint = "رفتن به چک",
        hitbox = "هیت‌باکس بزرگ", hitbox_on = "هیت‌باکس (روشن)",
        invisible = "👻 اختفا", invisible_on = "👻 اختفا (روشن)",
        esp = "🔴 ESP قرمز", esp_on = "🔴 ESP (روشن)",
        waterwalk = "🌊 راه رفتن روی آب", waterwalk_on = "🌊 راه رفتن روی آب (روشن)",
        multijump = "🦘 جامپ بی‌نهایت", multijump_on = "🦘 جامپ بی‌نهایت (روشن)",
        zoom = "🔍 زوم بی‌نهایت", zoom_on = "🔍 زوم بی‌نهایت (روشن)",
        antiafk = "🛡 ضد AFK", antiafk_on = "🛡 ضد AFK (روشن)",
        rejoin = "🔄 ری‌جوئین",
        serverhop = "🌐 سرور هاب",
        fpsboost = "🚀 FPS بوست", fpsboost_on = "🚀 FPS بوست (روشن)",
        fps_show = "📈 نمایش FPS", fps_show_on = "📈 نمایش FPS (روشن)",
        ping_show = "📶 نمایش پینگ", ping_show_on = "📶 نمایش پینگ (روشن)",
        antivoid = "🕳 ضد سقوط", antivoid_on = "🕳 ضد سقوط (روشن)",
        freecam = "🎥 دوربین آزاد", freecam_on = "🎥 دوربین آزاد (روشن)",
        ragdoll = "🤸 افتادن", ragdoll_on = "🤸 افتادن (روشن)",
        shiftlock = "🔒 شیفت لاک", shiftlock_on = "🔒 شیفت لاک (روشن)",
        fling = "💥 فلینگ", fling_on = "💥 فلینگ (روشن)",
        spiderman = "🕷 مرد عنکبوتی", spiderman_on = "🕷 مرد عنکبوتی (روشن)",
        gravityfly = "🚀 پرواز جاذبه‌ای", gravityfly_on = "🚀 پرواز جاذبه‌ای (روشن)",
        antifling = "🛡 انتی فلینگ", antifling_on = "🛡 انتی فلینگ (روشن)",
        antislap = "🛡 انتی اسلپ", antislap_on = "🛡 انتی اسلپ (روشن)",
        antisit = "🛡 انتی سیت", antisit_on = "🛡 انتی سیت (روشن)",
        antilaunch = "🛡 انتی لانچ", antilaunch_on = "🛡 انتی لانچ (روشن)",
        antigrab = "🛡 انتی گرپ", antigrab_on = "🛡 انتی گرپ (روشن)",
        spider_speed = "سرعت مرد عنکبوتی",
        gravityfly_speed = "سرعت پرواز جاذبه‌ای",
        destroy = "⚡نابودی",
        sky = "آسمون:",
        sky_default = "پیش‌فرض", sky_space = "فضا", sky_starry = "پرستاره",
        sky_sunset = "غروب", sky_night = "شب", sky_cloudy = "ابری",
        player_list = "👥 لیست بازیکنان",
        target_list = "🎯 لیست هدف", target_list_up = "🎯 لیست هدف ▲", target_list_down = "🎯 لیست هدف ▼",
        follow = "👣 دنبال کردن هدف", follow_on = "👣 دنبال کردن (روشن)",
        player_info = "📊 اطلاعات بازیکن",
        attach = "🎒 چسبیدن به هدف", attach_on = "🎒 جدا شدن از هدف",
        go = "برو",
        fly_speed = "سرعت پرواز", walk_speed = "سرعت راه",
        jump_power = "پرش", gravity = "جاذبه",
        change_lang = "🌐 تغییر زبان",
        status_none = "هیچ بازیکنی انتخاب نشده", status_target = "🎯 هدف: ",
        choose_lang = "زبان خود را انتخاب کنید",
    },
    en = {
        title = "🗿 Ghasem Teryak v5",
        fly = "Fly", fly_on = "Fly (ON)",
        noclip = "Noclip", noclip_on = "Noclip (ON)",
        night = "Night Vision", night_on = "Night Vision (ON)",
        reset = "Reset",
        checkpoint = "Checkpoint", goto_checkpoint = "Go to Checkpoint",
        hitbox = "Big Hitbox", hitbox_on = "Hitbox (ON)",
        invisible = "👻 Invisible", invisible_on = "👻 Invisible (ON)",
        esp = "🔴 ESP Red", esp_on = "🔴 ESP (ON)",
        waterwalk = "🌊 Water Walk", waterwalk_on = "🌊 Water Walk (ON)",
        multijump = "🦘 Infinite Jump", multijump_on = "🦘 Infinite Jump (ON)",
        zoom = "🔍 Infinite Zoom", zoom_on = "🔍 Infinite Zoom (ON)",
        antiafk = "🛡 Anti AFK", antiafk_on = "🛡 Anti AFK (ON)",
        rejoin = "🔄 Rejoin",
        serverhop = "🌐 Server Hop",
        fpsboost = "🚀 FPS Boost", fpsboost_on = "🚀 FPS Boost (ON)",
        fps_show = "📈 Show FPS", fps_show_on = "📈 Show FPS (ON)",
        ping_show = "📶 Show Ping", ping_show_on = "📶 Show Ping (ON)",
        antivoid = "🕳 Anti Void", antivoid_on = "🕳 Anti Void (ON)",
        freecam = "🎥 Freecam", freecam_on = "🎥 Freecam (ON)",
        ragdoll = "🤸 Ragdoll", ragdoll_on = "🤸 Ragdoll (ON)",
        shiftlock = "🔒 Shift Lock", shiftlock_on = "🔒 Shift Lock (ON)",
        fling = "💥 Fling", fling_on = "💥 Fling (ON)",
        spiderman = "🕷 Spider Man", spiderman_on = "🕷 Spider Man (ON)",
        gravityfly = "🚀 Gravity Fly", gravityfly_on = "🚀 Gravity Fly (ON)",
        antifling = "🛡 Anti Fling", antifling_on = "🛡 Anti Fling (ON)",
        antislap = "🛡 Anti Slap", antislap_on = "🛡 Anti Slap (ON)",
        antisit = "🛡 Anti Sit", antisit_on = "🛡 Anti Sit (ON)",
        antilaunch = "🛡 Anti Launch", antilaunch_on = "🛡 Anti Launch (ON)",
        antigrab = "🛡 Anti Grab", antigrab_on = "🛡 Anti Grab (ON)",
        spider_speed = "Spider Man Speed",
        gravityfly_speed = "Gravity Fly Speed",
        destroy = "⚡Destroy",
        sky = "Sky:",
        sky_default = "Default", sky_space = "Space", sky_starry = "Starry",
        sky_sunset = "Sunset", sky_night = "Night", sky_cloudy = "Cloudy",
        player_list = "👥 Player List",
        target_list = "🎯 Target List", target_list_up = "🎯 Target List ▲", target_list_down = "🎯 Target List ▼",
        follow = "👣 Follow Target", follow_on = "👣 Follow (ON)",
        player_info = "📊 Player Info",
        attach = "🎒 Attach to Target", attach_on = "🎒 Detach from Target",
        go = "Go",
        fly_speed = "Fly Speed", walk_speed = "Walk Speed",
        jump_power = "Jump Power", gravity = "Gravity",
        change_lang = "🌐 Change Language",
        status_none = "No player selected", status_target = "🎯 Target: ",
        choose_lang = "Choose your language",
    },
    es = {
        title = "🗿 Ghasem Teryak v5",
        fly = "Volar", fly_on = "Volar (ACTIVADO)",
        noclip = "Noclip", noclip_on = "Noclip (ACTIVADO)",
        night = "Visión nocturna", night_on = "Visión nocturna (ACTIVADA)",
        reset = "Reiniciar",
        checkpoint = "Punto de control", goto_checkpoint = "Ir al punto",
        hitbox = "Hitbox grande", hitbox_on = "Hitbox (ACTIVADO)",
        invisible = "👻 Invisible", invisible_on = "👻 Invisible (ACTIVADO)",
        esp = "🔴 ESP rojo", esp_on = "🔴 ESP (ACTIVADO)",
        waterwalk = "🌊 Caminar sobre agua", waterwalk_on = "🌊 Caminar sobre agua (ACTIVADO)",
        multijump = "🦘 Salto infinito", multijump_on = "🦘 Salto infinito (ACTIVADO)",
        zoom = "🔍 Zoom infinito", zoom_on = "🔍 Zoom infinito (ACTIVADO)",
        antiafk = "🛡 Anti AFK", antiafk_on = "🛡 Anti AFK (ACTIVADO)",
        rejoin = "🔄 Volver a entrar",
        serverhop = "🌐 Cambiar de servidor",
        fpsboost = "🚀 Aumentar FPS", fpsboost_on = "🚀 Aumentar FPS (ACTIVADO)",
        fps_show = "📈 Mostrar FPS", fps_show_on = "📈 Mostrar FPS (ACTIVADO)",
        ping_show = "📶 Mostrar Ping", ping_show_on = "📶 Mostrar Ping (ACTIVADO)",
        antivoid = "🕳 Anti caída", antivoid_on = "🕳 Anti caída (ACTIVADO)",
        freecam = "🎥 Cámara libre", freecam_on = "🎥 Cámara libre (ACTIVADA)",
        ragdoll = "🤸 Caer", ragdoll_on = "🤸 Caer (ACTIVADO)",
        shiftlock = "🔒 Shift Lock", shiftlock_on = "🔒 Shift Lock (ACTIVADO)",
        fling = "💥 Fling", fling_on = "💥 Fling (ACTIVADO)",
        spiderman = "🕷 Hombre araña", spiderman_on = "🕷 Hombre araña (ACTIVADO)",
        gravityfly = "🚀 Vuelo con gravedad", gravityfly_on = "🚀 Vuelo con gravedad (ACTIVADO)",
        antifling = "🛡 Anti Fling", antifling_on = "🛡 Anti Fling (ACTIVADO)",
        antislap = "🛡 Anti Slap", antislap_on = "🛡 Anti Slap (ACTIVADO)",
        antisit = "🛡 Anti Sit", antisit_on = "🛡 Anti Sit (ACTIVADO)",
        antilaunch = "🛡 Anti Launch", antilaunch_on = "🛡 Anti Launch (ACTIVADO)",
        antigrab = "🛡 Anti Grab", antigrab_on = "🛡 Anti Grab (ACTIVADO)",
        spider_speed = "Velocidad del hombre araña",
        gravityfly_speed = "Velocidad del vuelo con gravedad",
        destroy = "⚡Destruir",
        sky = "Cielo:",
        sky_default = "Predeterminado", sky_space = "Espacio", sky_starry = "Estrellado",
        sky_sunset = "Atardecer", sky_night = "Noche", sky_cloudy = "Nublado",
        player_list = "👥 Lista de jugadores",
        target_list = "🎯 Lista de objetivos", target_list_up = "🎯 Lista de objetivos ▲", target_list_down = "🎯 Lista de objetivos ▼",
        follow = "👣 Seguir objetivo", follow_on = "👣 Siguiendo (ACTIVADO)",
        player_info = "📊 Información del jugador",
        attach = "🎒 Unirse al objetivo", attach_on = "🎒 Separarse del objetivo",
        go = "Ir",
        fly_speed = "Velocidad de vuelo", walk_speed = "Velocidad al caminar",
        jump_power = "Potencia de salto", gravity = "Gravedad",
        change_lang = "🌐 Cambiar idioma",
        status_none = "Ningún jugador seleccionado", status_target = "🎯 Objetivo: ",
        choose_lang = "Elige tu idioma",
    }
}

local function L(key)
    if not currentLang then return key end
    return T[currentLang][key] or key
end

--// ===== منوی انتخاب زبان =====
local function showLangMenu(onSelected)
    local langGui = Instance.new("ScreenGui")
    langGui.Name = "LangSelectGui"
    langGui.ResetOnSpawn = false
    langGui.Parent = Player.PlayerGui

    local frame = Instance.new("Frame")
    frame.Parent = langGui
    frame.Size = UDim2.new(0, 280, 0, 260)
    frame.Position = UDim2.new(0.5, -140, 0.5, -130)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
    frame.Active = true
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

    local function clampGui(gui)
        local cam = workspace.CurrentCamera
        if not cam then return end
        local vp = cam.ViewportSize
        local p = gui.Position
        local x = math.clamp(p.X.Offset, 0, math.max(0, vp.X - gui.AbsoluteSize.X))
        local y = math.clamp(p.Y.Offset, 0, math.max(0, vp.Y - gui.AbsoluteSize.Y))
        gui.Position = UDim2.new(0, x, 0, y)
    end

    local function makeDraggable(gui, handle)
        handle.Active = true
        local dragging = false
        local dragStart, startPos, startAbs
        handle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = gui.Position
                startAbs = gui.AbsolutePosition
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        uis.InputChanged:Connect(function(input)
            if not dragging then return end
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                local delta = input.Position - dragStart
                gui.Position = UDim2.new(0, startAbs.X + delta.X, 0, startAbs.Y + delta.Y)
                clampGui(gui)
            end
        end)
    end

    local title = Instance.new("TextLabel")
    title.Parent = frame
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundTransparency = 1
    title.Text = "Choose Language / زبان خود را انتخاب کنید / Elige tu idioma"
    title.TextColor3 = Color3.fromRGB(255, 50, 150)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 13
    title.TextWrapped = true

    local function makeLangButton(textValue, y, color, lang)
        local btn = Instance.new("TextButton")
        btn.Parent = frame
        btn.Size = UDim2.new(0.8, 0, 0, 35)
        btn.Position = UDim2.new(0.1, 0, 0, y)
        btn.BackgroundColor3 = color
        btn.Text = textValue
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14
        btn.AutoButtonColor = true
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        btn.Activated:Connect(function()
            currentLang = lang
            saveLang(lang)
            langGui:Destroy()
            onSelected()
        end)
        return btn
    end

    makeLangButton("🇮🇷 فارسی", 50, Color3.fromRGB(0, 150, 100), "fa")
    makeLangButton("🇬🇧 English", 95, Color3.fromRGB(0, 100, 200), "en")
    makeLangButton("🇪🇸 Español", 140, Color3.fromRGB(200, 100, 0), "es")

    local hint = Instance.new("TextLabel")
    hint.Parent = frame
    hint.Size = UDim2.new(0.9, 0, 0, 60)
    hint.Position = UDim2.new(0.05, 0, 0, 185)
    hint.BackgroundColor3 = Color3.fromRGB(25, 25, 55)
    hint.TextColor3 = Color3.fromRGB(255, 255, 255)
    hint.Font = Enum.Font.GothamBold
    hint.TextSize = 10
    hint.TextWrapped = true
    hint.Text = "📱 Toca los botones para elegir el idioma"
    Instance.new("UICorner", hint).CornerRadius = UDim.new(0, 6)

    makeDraggable(frame, title)
end

--// ===== State ها =====
local flying = false
local flyBV, flyBG, flyLoop = nil, nil, nil
local noclip = false
local ncConn = nil
local nightVision = false
local nightConn, nightAtmo = nil, nil
local checkpointPos = nil
local showHitbox = false
local invis_on = false
local attached = false
local attachWeld, attachBodyVelocity = nil, nil
local showEsp = false
local espHighlights = {}
local waterWalkEnabled = false
local waterWalkPart, waterWalkLoop = nil, nil
local multiJumpEnabled = false
local gravityFlyEnabled = false
local jumpCount = 0
local maxJumps = 999
local lastJumpTime = 0
local zoomEnabled = false
local currentMaxZoom = 128
local antiAfkEnabled = false
local antiAfkLoop = nil
local showFps = false
local showPing = false
local antiVoidEnabled = false
local antiVoidLoop = nil
local followEnabled = false
local followLoop = nil
local freecamEnabled = false
local freecamLoop = nil
local originalCameraSubject = nil
local ragdollEnabled = false
local skyObjects = {}
local originalLightingSettings = {}
local skyListOpen = false
local selectedTarget = nil
local playerInfoGui = nil
local ghost = nil
local ghostConn = nil

--// ===== توابع کمکی =====
local function trans(char, t)
    if not char then return end
    for _, v in char:GetDescendants() do
        if v:IsA("BasePart") or v:IsA("Decal") or v:IsA("MeshPart") then
            v.Transparency = t
        end
    end
end

--// ===== Sky Functions =====
local function createSaturn()
    local saturn = Instance.new("Part")
    saturn.Name = "Saturn"
    saturn.Shape = Enum.PartType.Ball
    saturn.Size = Vector3.new(6000, 6000, 6000)
    saturn.Position = Vector3.new(8000, 3000, 8000)
    saturn.Anchored = true
    saturn.CanCollide = false
    saturn.Material = Enum.Material.Neon
    saturn.Color = Color3.fromRGB(220, 190, 150)
    saturn.Parent = workspace
    table.insert(skyObjects, saturn)
    local light = Instance.new("PointLight")
    light.Parent = saturn
    light.Brightness = 3
    light.Range = 5000
    light.Color = Color3.fromRGB(255, 230, 180)
    local ring = Instance.new("Part")
    ring.Name = "SaturnRing"
    ring.Shape = Enum.PartType.Cylinder
    ring.Size = Vector3.new(80, 9000, 9000)
    ring.Position = Vector3.new(8000, 3000, 8000)
    ring.Orientation = Vector3.new(20, 0, 0)
    ring.Anchored = true
    ring.CanCollide = false
    ring.Material = Enum.Material.Neon
    ring.Color = Color3.fromRGB(200, 170, 140)
    ring.Transparency = 0.3
    ring.Parent = workspace
    table.insert(skyObjects, ring)
    spawn(function()
        while saturn and saturn.Parent do
            wait(0.1)
            saturn.CFrame = saturn.CFrame * CFrame.Angles(0, math.rad(0.05), 0)
            ring.CFrame = ring.CFrame * CFrame.Angles(0, math.rad(0.05), 0)
        end
    end)
end

local function createNeptune()
    local neptune = Instance.new("Part")
    neptune.Name = "Neptune"
    neptune.Shape = Enum.PartType.Ball
    neptune.Size = Vector3.new(4500, 4500, 4500)
    neptune.Position = Vector3.new(-6000, 1500, -6000)
    neptune.Anchored = true
    neptune.CanCollide = false
    neptune.Material = Enum.Material.Neon
    neptune.Color = Color3.fromRGB(50, 100, 220)
    neptune.Parent = workspace
    table.insert(skyObjects, neptune)
    local light = Instance.new("PointLight")
    light.Parent = neptune
    light.Brightness = 2
    light.Range = 4000
    light.Color = Color3.fromRGB(100, 150, 255)
    spawn(function()
        while neptune and neptune.Parent do
            wait(0.1)
            neptune.CFrame = neptune.CFrame * CFrame.Angles(0, math.rad(0.05), 0)
        end
    end)
end

local function clearSky()
    for _, obj in pairs(skyObjects) do
        if obj and obj.Parent then obj:Destroy() end
    end
    skyObjects = {}
    local sky = Lighting:FindFirstChild("CustomSky")
    if sky then sky:Destroy() end
    if originalLightingSettings.Ambient then
        Lighting.Ambient = originalLightingSettings.Ambient
        Lighting.Brightness = originalLightingSettings.Brightness
        Lighting.ClockTime = originalLightingSettings.ClockTime
        Lighting.FogColor = originalLightingSettings.FogColor
        Lighting.FogEnd = originalLightingSettings.FogEnd
    end
end

local function setSky(skyName, SkyBtn)
    clearSky()
    if skyName == "پیش‌فرض" or skyName == "Default" then
        SkyBtn.Text = L("sky_default")
        return
    end
    if not originalLightingSettings.Ambient then
        originalLightingSettings.Ambient = Lighting.Ambient
        originalLightingSettings.Brightness = Lighting.Brightness
        originalLightingSettings.ClockTime = Lighting.ClockTime
        originalLightingSettings.FogColor = Lighting.FogColor
        originalLightingSettings.FogEnd = Lighting.FogEnd
    end
    if skyName == "فضا" or skyName == "Space" then
        Lighting.Ambient = Color3.fromRGB(10, 10, 20)
        Lighting.Brightness = 0.2
        Lighting.ClockTime = 0
        Lighting.FogColor = Color3.fromRGB(0, 0, 0)
        Lighting.FogEnd = 100000
        createSaturn()
        createNeptune()
        SkyBtn.Text = L("sky_space")
    elseif skyName == "پرستاره" or skyName == "Starry" then
        Lighting.Ambient = Color3.fromRGB(30, 30, 50)
        Lighting.Brightness = 0.5
        Lighting.ClockTime = 0
        Lighting.FogColor = Color3.fromRGB(0, 0, 20)
        Lighting.FogEnd = 100000
        local sky = Instance.new("Sky")
        sky.Name = "CustomSky"
        sky.SkyboxBk = "rbxassetid://159508113"
        sky.SkyboxDn = "rbxassetid://159508113"
        sky.SkyboxFt = "rbxassetid://159508113"
        sky.SkyboxLf = "rbxassetid://159508113"
        sky.SkyboxRt = "rbxassetid://159508113"
        sky.SkyboxUp = "rbxassetid://159508113"
        sky.StarCount = 10000
        sky.Parent = Lighting
        SkyBtn.Text = L("sky_starry")
    elseif skyName == "غروب" or skyName == "Sunset" then
        Lighting.Ambient = Color3.fromRGB(255, 150, 100)
        Lighting.Brightness = 2
        Lighting.ClockTime = 18
        Lighting.FogColor = Color3.fromRGB(255, 150, 100)
        Lighting.FogEnd = 5000
        SkyBtn.Text = L("sky_sunset")
    elseif skyName == "شب" or skyName == "Night" then
        Lighting.Ambient = Color3.fromRGB(20, 20, 50)
        Lighting.Brightness = 1
        Lighting.ClockTime = 0
        Lighting.FogColor = Color3.fromRGB(10, 10, 30)
        Lighting.FogEnd = 10000
        SkyBtn.Text = L("sky_night")
    elseif skyName == "ابری" or skyName == "Cloudy" then
        Lighting.Ambient = Color3.fromRGB(200, 200, 200)
        Lighting.Brightness = 1.5
        Lighting.ClockTime = 12
        Lighting.FogColor = Color3.fromRGB(200, 200, 200)
        Lighting.FogEnd = 500
        SkyBtn.Text = L("sky_cloudy")
    end
end

--// ===== ساخت منو =====
local function buildMenu()
    local old = Player.PlayerGui:FindFirstChild("QasimTriak")
    if old then old:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = Player.PlayerGui
    ScreenGui.Name = "QasimTriak"
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0, 300, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
    MainFrame.Active = true
    MainFrame.Draggable = false
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
    MainFrame.Visible = true

    local Title = Instance.new("TextLabel")
    Title.Parent = MainFrame
    Title.Size = UDim2.new(1, 0, 0, 35)
    Title.BackgroundColor3 = Color3.fromRGB(25, 25, 55)
    Title.Text = L("title")
    Title.Font = Enum.Font.FredokaOne
    Title.TextSize = 18
    Title.TextColor3 = Color3.fromRGB(255, 50, 150)
    Title.Active = true

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Parent = MainFrame
    CloseBtn.Size = UDim2.new(0, 28, 0, 28)
    CloseBtn.Position = UDim2.new(1, -33, 0, 4)
    CloseBtn.Text = "✕"
    CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 14
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

    local OpenBtn = Instance.new("TextButton")
    OpenBtn.Parent = ScreenGui
    OpenBtn.Size = UDim2.new(0, 45, 0, 45)
    OpenBtn.Position = UDim2.new(0.02, 0, 0.5, -22)
    OpenBtn.Text = "🗿"
    OpenBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
    OpenBtn.TextColor3 = Color3.fromRGB(255, 50, 150)
    OpenBtn.Font = Enum.Font.FredokaOne
    OpenBtn.TextSize = 22
    OpenBtn.Visible = false
    OpenBtn.Active = true
    OpenBtn.Draggable = false
    Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 10)

    -- Drag is deliberately unrestricted: the menu can be moved freely in both axes,
    -- including partially outside the phone screen. The opener is kept on-screen.
    local function clampGui(gui)
        local camera = workspace.CurrentCamera
        if not camera then return end
        local vp = camera.ViewportSize
        local abs = gui.AbsoluteSize
        local x = math.clamp(gui.AbsolutePosition.X, 0, math.max(0, vp.X - abs.X))
        local y = math.clamp(gui.AbsolutePosition.Y, 0, math.max(0, vp.Y - abs.Y))
        gui.Position = UDim2.new(0, x, 0, y)
    end

    local function makeTouchDraggable(gui, handle, keepOnScreen)
        handle.Active = true
        local dragging = false
        local dragStart, startAbs
        handle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startAbs = gui.AbsolutePosition
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        uis.InputChanged:Connect(function(input)
            if not dragging then return end
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                local delta = input.Position - dragStart
                gui.Position = UDim2.new(0, startAbs.X + delta.X, 0, startAbs.Y + delta.Y)
                if keepOnScreen then clampGui(gui) end
            end
        end)
    end

    CloseBtn.Activated:Connect(function()
        MainFrame.Visible = false
        OpenBtn.Visible = true
        clampGui(OpenBtn)
    end)

    OpenBtn.Activated:Connect(function()
        MainFrame.Visible = true
        OpenBtn.Visible = false
    end)

    makeTouchDraggable(OpenBtn, OpenBtn, true)
    makeTouchDraggable(MainFrame, Title, false)

    local KillBtn = Instance.new("TextButton")
    KillBtn.Parent = MainFrame
    KillBtn.Size = UDim2.new(0, 75, 0, 28)
    KillBtn.Position = UDim2.new(0, 5, 0, 4)
    KillBtn.Text = L("destroy")
    KillBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    KillBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    KillBtn.Font = Enum.Font.GothamBold
    KillBtn.TextSize = 11
    Instance.new("UICorner", KillBtn).CornerRadius = UDim.new(0, 6)

    local Scroll = Instance.new("ScrollingFrame")
    Scroll.Parent = MainFrame
    Scroll.Size = UDim2.new(1, 0, 1, -40)
    Scroll.Position = UDim2.new(0, 0, 0, 40)
    Scroll.BackgroundTransparency = 1
    Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Scroll.ScrollBarThickness = 4

    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Parent = Scroll
    ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ListLayout.Padding = UDim.new(0, 8)

    local Padding = Instance.new("UIPadding")
    Padding.Parent = Scroll
    Padding.PaddingTop = UDim.new(0, 8)
    Padding.PaddingBottom = UDim.new(0, 8)

    --// ✅ اینجا تغییر اعمال شد
    local GridFrame = Instance.new("Frame")
    GridFrame.Parent = Scroll
    GridFrame.Size = UDim2.new(0, 280, 0, 0)
    GridFrame.AutomaticSize = Enum.AutomaticSize.Y
    GridFrame.BackgroundTransparency = 1

    local GridLayout = Instance.new("UIGridLayout")
    GridLayout.Parent = GridFrame
    GridLayout.CellSize = UDim2.new(0, 130, 0, 32)
    GridLayout.CellPadding = UDim2.new(0, 6, 0, 8)
    GridLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local function createBtn(name, color)
        local btn = Instance.new("TextButton")
        btn.Parent = GridFrame
        btn.Text = name
        btn.BackgroundColor3 = color
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.TextColor3 = Color3.fromRGB(0, 0, 0)
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        return btn
    end

    local FlyBtn = createBtn(L("fly"), Color3.fromRGB(0, 150, 255))
    local NoclipBtn = createBtn(L("noclip"), Color3.fromRGB(150, 50, 255))
    local NightBtn = createBtn(L("night"), Color3.fromRGB(0, 255, 100))
    local ResetBtn = createBtn(L("reset"), Color3.fromRGB(255, 50, 50))
    local CheckpointBtn = createBtn(L("checkpoint"), Color3.fromRGB(255, 200, 0))
    local GotoCheckpointBtn = createBtn(L("goto_checkpoint"), Color3.fromRGB(0, 255, 200))
    local HitboxBtn = createBtn(L("hitbox"), Color3.fromRGB(255, 0, 200))
    local InvisibleBtn = createBtn(L("invisible"), Color3.fromRGB(150, 0, 255))
    local EspBtn = createBtn(L("esp"), Color3.fromRGB(255, 0, 0))
    local WaterWalkBtn = createBtn(L("waterwalk"), Color3.fromRGB(0, 200, 255))
    local MultiJumpBtn = createBtn(L("multijump"), Color3.fromRGB(255, 200, 0))
    local ZoomBtn = createBtn(L("zoom"), Color3.fromRGB(100, 100, 255))
    local AntiAFKBtn = createBtn(L("antiafk"), Color3.fromRGB(0, 200, 100))
    local RejoinBtn = createBtn(L("rejoin"), Color3.fromRGB(255, 150, 0))
    local ServerHopBtn = createBtn(L("serverhop"), Color3.fromRGB(200, 100, 255))
    local FpsBoostBtn = createBtn(L("fpsboost"), Color3.fromRGB(0, 255, 150))
    local FpsShowBtn = createBtn(L("fps_show"), Color3.fromRGB(0, 255, 0))
    local PingShowBtn = createBtn(L("ping_show"), Color3.fromRGB(255, 255, 0))
    local AntiVoidBtn = createBtn(L("antivoid"), Color3.fromRGB(100, 50, 150))
    local FreecamBtn = createBtn(L("freecam"), Color3.fromRGB(50, 150, 200))
    local RagdollBtn = createBtn(L("ragdoll"), Color3.fromRGB(255, 100, 100))

    local ShiftLockBtn = createBtn(L("shiftlock"), Color3.fromRGB(180, 180, 220))
    local FlingBtn = createBtn(L("fling"), Color3.fromRGB(255, 50, 150))
    local SpiderManBtn = createBtn(L("spiderman"), Color3.fromRGB(200, 50, 50))
    local GravityFlyBtn = createBtn(L("gravityfly"), Color3.fromRGB(0, 180, 255))
    local AntiFlingBtn = createBtn(L("antifling"), Color3.fromRGB(100, 200, 100))
    local AntiSlapBtn = createBtn(L("antislap"), Color3.fromRGB(100, 200, 150))
    local AntiSitBtn = createBtn(L("antisit"), Color3.fromRGB(100, 200, 200))
    local AntiLaunchBtn = createBtn(L("antilaunch"), Color3.fromRGB(100, 180, 200))
    local AntiGrabBtn = createBtn(L("antigrab"), Color3.fromRGB(100, 160, 200))

    --// ===== Mobile Controls =====
    local mobileGui = nil
    local mobileButtons = {}
    local mobileHeld = {}
    local mobileTouchEnabled = uis.TouchEnabled

    local function mobileSet(key, state)
        mobileHeld[key] = state
    end

    local function mobileMakeButton(parent, textValue, key, pos, size, color)
        local b = Instance.new("TextButton")
        b.Parent = parent
        b.Size = size
        b.Position = pos
        b.Text = textValue
        b.BackgroundColor3 = color
        b.TextColor3 = Color3.fromRGB(255,255,255)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 16
        b.AutoButtonColor = true
        b.Active = true
        b.ZIndex = 200
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        b.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                mobileSet(key, true)
            end
        end)
        b.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                mobileSet(key, false)
            end
        end)
        mobileButtons[key] = b
        return b
    end

    local function createMobileControls()
        if not mobileTouchEnabled or mobileGui then return end
        mobileGui = Instance.new("ScreenGui")
        mobileGui.Name = "QasimMobileControls"
        mobileGui.ResetOnSpawn = false
        mobileGui.DisplayOrder = 999
        mobileGui.Enabled = false

        local pad = Instance.new("Frame")
        pad.Parent = mobileGui
        pad.Size = UDim2.new(0, 190, 0, 155)
        pad.Position = UDim2.new(0, 12, 1, -167)
        pad.BackgroundTransparency = 1

        local baseColor = Color3.fromRGB(25,25,55)
        mobileMakeButton(pad, "W", "W", UDim2.new(0, 65, 0, 0), UDim2.new(0, 55, 0, 45), baseColor)
        mobileMakeButton(pad, "A", "A", UDim2.new(0, 0, 0, 50), UDim2.new(0, 55, 0, 45), baseColor)
        mobileMakeButton(pad, "S", "S", UDim2.new(0, 65, 0, 50), UDim2.new(0, 55, 0, 45), baseColor)
        mobileMakeButton(pad, "D", "D", UDim2.new(0, 130, 0, 50), UDim2.new(0, 55, 0, 45), baseColor)
        mobileMakeButton(pad, "▲", "UP", UDim2.new(0, 65, 0, 100), UDim2.new(0, 55, 0, 45), Color3.fromRGB(0,150,255))
        mobileMakeButton(pad, "▼", "DOWN", UDim2.new(0, 130, 0, 100), UDim2.new(0, 55, 0, 45), Color3.fromRGB(200,80,80))
        mobileMakeButton(pad, "Q", "Q", UDim2.new(0, 0, 0, 100), UDim2.new(0, 55, 0, 45), baseColor)

        mobileGui.Parent = Player.PlayerGui
    end

    local function setMobileControlsVisible(visible)
        if not mobileTouchEnabled then return end
        if visible then
            createMobileControls()
            if mobileGui then mobileGui.Enabled = true end
        elseif mobileGui then
            mobileGui.Enabled = false
            for key in pairs(mobileHeld) do mobileHeld[key] = false end
        end
    end

    local function mobileDirection(camera)
        local direction = Vector3.zero
        if mobileHeld.W then direction += camera.CFrame.LookVector end
        if mobileHeld.S then direction -= camera.CFrame.LookVector end
        if mobileHeld.A then direction -= camera.CFrame.RightVector end
        if mobileHeld.D then direction += camera.CFrame.RightVector end
        if mobileHeld.UP then direction += Vector3.new(0,1,0) end
        if mobileHeld.DOWN then direction -= Vector3.new(0,1,0) end
        return direction
    end


    --// ===== Sky Frame =====
    local SkyFrame = Instance.new("Frame")
    SkyFrame.Parent = Scroll
    SkyFrame.Size = UDim2.new(0, 280, 0, 60)
    SkyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 45)
    SkyFrame.BorderSizePixel = 0
    Instance.new("UICorner", SkyFrame).CornerRadius = UDim.new(0, 8)

    local SkyLabel = Instance.new("TextLabel")
    SkyLabel.Parent = SkyFrame
    SkyLabel.Size = UDim2.new(0, 80, 0, 30)
    SkyLabel.Position = UDim2.new(0, 10, 0, 15)
    SkyLabel.BackgroundTransparency = 1
    SkyLabel.Text = L("sky")
    SkyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SkyLabel.Font = Enum.Font.GothamBold
    SkyLabel.TextSize = 13
    SkyLabel.TextXAlignment = Enum.TextXAlignment.Left

    local SkyBtn = Instance.new("TextButton")
    SkyBtn.Parent = SkyFrame
    SkyBtn.Size = UDim2.new(0, 140, 0, 30)
    SkyBtn.Position = UDim2.new(0, 80, 0, 15)
    SkyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 100)
    SkyBtn.Text = L("sky_default")
    SkyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SkyBtn.Font = Enum.Font.GothamBold
    SkyBtn.TextSize = 12
    Instance.new("UICorner", SkyBtn).CornerRadius = UDim.new(0, 6)

    local SkyArrow = Instance.new("TextButton")
    SkyArrow.Parent = SkyFrame
    SkyArrow.Size = UDim2.new(0, 30, 0, 30)
    SkyArrow.Position = UDim2.new(0, 235, 0, 15)
    SkyArrow.BackgroundColor3 = Color3.fromRGB(50, 50, 100)
    SkyArrow.Text = "▼"
    SkyArrow.TextColor3 = Color3.fromRGB(255, 255, 255)
    SkyArrow.Font = Enum.Font.GothamBold
    SkyArrow.TextSize = 12
    Instance.new("UICorner", SkyArrow).CornerRadius = UDim.new(0, 6)

    local SkyListFrame = Instance.new("Frame")
    SkyListFrame.Parent = SkyFrame
    SkyListFrame.Size = UDim2.new(0, 140, 0, 0)
    SkyListFrame.Position = UDim2.new(0, 80, 0, 50)
    SkyListFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    SkyListFrame.BorderSizePixel = 0
    SkyListFrame.Visible = false
    SkyListFrame.ZIndex = 10
    Instance.new("UICorner", SkyListFrame).CornerRadius = UDim.new(0, 6)

    local SkyListLayout = Instance.new("UIListLayout")
    SkyListLayout.Parent = SkyListFrame
    SkyListLayout.Padding = UDim.new(0, 2)
    SkyListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local skyNames = {L("sky_default"), L("sky_space"), L("sky_starry"), L("sky_sunset"), L("sky_night"), L("sky_cloudy")}
    for i, name in pairs(skyNames) do
        local btn = Instance.new("TextButton")
        btn.Parent = SkyListFrame
        btn.Size = UDim2.new(1, 0, 0, 28)
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.BorderSizePixel = 0
        btn.ZIndex = 11
        btn.Activated:Connect(function()
            setSky(name, SkyBtn)
            SkyListFrame.Visible = false
            SkyListFrame.Size = UDim2.new(0, 140, 0, 0)
            skyListOpen = false
            SkyArrow.Text = "▼"
        end)
    end

    SkyArrow.Activated:Connect(function()
        skyListOpen = not skyListOpen
        if skyListOpen then
            SkyListFrame.Visible = true
            SkyListFrame.Size = UDim2.new(0, 140, 0, #skyNames * 30)
            SkyArrow.Text = "▲"
        else
            SkyListFrame.Visible = false
            SkyListFrame.Size = UDim2.new(0, 140, 0, 0)
            SkyArrow.Text = "▼"
        end
    end)

    SkyBtn.Activated:Connect(function()
        skyListOpen = not skyListOpen
        if skyListOpen then
            SkyListFrame.Visible = true
            SkyListFrame.Size = UDim2.new(0, 140, 0, #skyNames * 30)
            SkyArrow.Text = "▲"
        else
            SkyListFrame.Visible = false
            SkyListFrame.Size = UDim2.new(0, 140, 0, 0)
            SkyArrow.Text = "▼"
        end
    end)

    --// ===== Anti AFK =====
    AntiAFKBtn.Activated:Connect(function()
        antiAfkEnabled = not antiAfkEnabled
        if antiAfkEnabled then
            if antiAfkLoop then antiAfkLoop:Disconnect() end
            antiAfkLoop = rs.Heartbeat:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
            AntiAFKBtn.Text = L("antiafk_on")
            AntiAFKBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        else
            if antiAfkLoop then antiAfkLoop:Disconnect() end
            antiAfkLoop = nil
            AntiAFKBtn.Text = L("antiafk")
            AntiAFKBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        end
    end)

    --// ===== Rejoin =====
    RejoinBtn.Activated:Connect(function()
        TeleportService:Teleport(game.PlaceId, Player)
    end)

    --// ===== Server Hop =====
    ServerHopBtn.Activated:Connect(function()
        local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        for _, server in pairs(servers.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, Player)
                break
            end
        end
    end)

    --// ===== FPS Boost =====
    local originalSettings = {}
    FpsBoostBtn.Activated:Connect(function()
        if FpsBoostBtn.Text == L("fpsboost") then
            originalSettings.FogEnd = Lighting.FogEnd
            originalSettings.GlobalShadows = Lighting.GlobalShadows
            originalSettings.Brightness = Lighting.Brightness
            Lighting.FogEnd = 0
            Lighting.GlobalShadows = false
            Lighting.Brightness = 0
            FpsBoostBtn.Text = L("fpsboost_on")
            FpsBoostBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        else
            Lighting.FogEnd = originalSettings.FogEnd or 10000
            Lighting.GlobalShadows = originalSettings.GlobalShadows or true
            Lighting.Brightness = originalSettings.Brightness or 2
            FpsBoostBtn.Text = L("fpsboost")
            FpsBoostBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
        end
    end)

    --// ===== Hitbox =====
    HitboxBtn.Activated:Connect(function()
        showHitbox = not showHitbox
        HitboxBtn.Text = showHitbox and L("hitbox_on") or L("hitbox")
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= Player and plr.Character then
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.Size = showHitbox and Vector3.new(15, 15, 15) or Vector3.new(2, 2, 1)
                end
            end
        end
    end)

    --// ===== FPS/Ping GUI =====
    local fpsGui = Instance.new("ScreenGui")
    fpsGui.Parent = Player.PlayerGui
    fpsGui.Name = "FpsPingGui"

    local fpsLabel = Instance.new("TextLabel")
    fpsLabel.Parent = fpsGui
    fpsLabel.Size = UDim2.new(0, 120, 0, 25)
    fpsLabel.Position = UDim2.new(0, 10, 0, 10)
    fpsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    fpsLabel.BackgroundTransparency = 0.5
    fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    fpsLabel.Font = Enum.Font.GothamBold
    fpsLabel.TextSize = 14
    fpsLabel.Text = "FPS: 0"
    fpsLabel.Visible = false
    Instance.new("UICorner", fpsLabel).CornerRadius = UDim.new(0, 6)

    local pingLabel = Instance.new("TextLabel")
    pingLabel.Parent = fpsGui
    pingLabel.Size = UDim2.new(0, 120, 0, 25)
    pingLabel.Position = UDim2.new(0, 10, 0, 40)
    pingLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    pingLabel.BackgroundTransparency = 0.5
    pingLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    pingLabel.Font = Enum.Font.GothamBold
    pingLabel.TextSize = 14
    pingLabel.Text = "Ping: 0"
    pingLabel.Visible = false
    Instance.new("UICorner", pingLabel).CornerRadius = UDim.new(0, 6)

    local frameCount = 0
    local lastTime = tick()
    rs.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        local currentTime = tick()
        if currentTime - lastTime >= 1 then
            local fps = frameCount
            frameCount = 0
            lastTime = currentTime
            if showFps then fpsLabel.Text = "FPS: " .. fps end
        end
    end)

    spawn(function()
        while wait(2) do
            local start = tick()
            pcall(function() HttpService:GetAsync("https://www.roblox.com") end)
            local ping = math.floor((tick() - start) * 1000)
            if showPing then pingLabel.Text = "Ping: " .. ping .. "ms" end
        end
    end)

    FpsShowBtn.Activated:Connect(function()
        showFps = not showFps
        fpsLabel.Visible = showFps
        FpsShowBtn.Text = showFps and L("fps_show_on") or L("fps_show")
        FpsShowBtn.BackgroundColor3 = showFps and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(0, 255, 0)
    end)

    PingShowBtn.Activated:Connect(function()
        showPing = not showPing
        pingLabel.Visible = showPing
        PingShowBtn.Text = showPing and L("ping_show_on") or L("ping_show")
        PingShowBtn.BackgroundColor3 = showPing and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 255, 0)
    end)

    --// ===== Multi Jump =====
    MultiJumpBtn.Activated:Connect(function()
        multiJumpEnabled = not multiJumpEnabled
        if multiJumpEnabled then
            local char = Player.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.PlatformStand = false
                char.Humanoid.WalkSpeed = 16
                char.Humanoid.JumpPower = 50
                char.Humanoid.UseJumpPower = true
            end
            jumpCount = 0
            MultiJumpBtn.Text = L("multijump_on")
            MultiJumpBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
            setMobileControlsVisible(true)
        else
            local char = Player.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.PlatformStand = false
                char.Humanoid.WalkSpeed = 16
                char.Humanoid.JumpPower = 50
                char.Humanoid.UseJumpPower = true
            end
            jumpCount = 0
            MultiJumpBtn.Text = L("multijump")
            MultiJumpBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
            setMobileControlsVisible(flying or gravityFlyEnabled)
        end
    end)

    --// ===== Zoom =====
    ZoomBtn.Activated:Connect(function()
        zoomEnabled = not zoomEnabled
        if zoomEnabled then
            currentMaxZoom = Player.CameraMaxZoomDistance
            Player.CameraMaxZoomDistance = math.huge
            ZoomBtn.Text = L("zoom_on")
            ZoomBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        else
            Player.CameraMaxZoomDistance = currentMaxZoom or 128
            ZoomBtn.Text = L("zoom")
            ZoomBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
        end
    end)

    --// ===== Anti Void =====
    AntiVoidBtn.Activated:Connect(function()
        antiVoidEnabled = not antiVoidEnabled
        if antiVoidEnabled then
            if antiVoidLoop then antiVoidLoop:Disconnect() end
            antiVoidLoop = rs.Heartbeat:Connect(function()
                if Player.Character then
                    local hrp = Player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and hrp.Position.Y < -100 then
                        hrp.CFrame = CFrame.new(hrp.Position.X, 50, hrp.Position.Z)
                    end
                end
            end)
            AntiVoidBtn.Text = L("antivoid_on")
            AntiVoidBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        else
            if antiVoidLoop then antiVoidLoop:Disconnect() end
            antiVoidLoop = nil
            AntiVoidBtn.Text = L("antivoid")
            AntiVoidBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 150)
        end
    end)

    --// ===== Freecam =====
    FreecamBtn.Activated:Connect(function()
        freecamEnabled = not freecamEnabled
        if freecamEnabled then
            originalCameraSubject = cam.CameraSubject
            cam.CameraType = Enum.CameraType.Scriptable
            if freecamLoop then freecamLoop:Disconnect() end
            freecamLoop = rs.RenderStepped:Connect(function()
                local move = Vector3.new(0, 0, 0)
                local speed = 2
                if uis:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
                if uis:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
                if uis:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
                if uis:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
                if uis:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
                if uis:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0, 1, 0) end
                cam.CFrame = cam.CFrame + move * speed
            end)
            FreecamBtn.Text = L("freecam_on")
            FreecamBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        else
            if freecamLoop then freecamLoop:Disconnect() end
            freecamLoop = nil
            cam.CameraType = Enum.CameraType.Custom
            if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                cam.CameraSubject = Player.Character.Humanoid
            end
            FreecamBtn.Text = L("freecam")
            FreecamBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
        end
    end)

    --// ===== Ragdoll =====
    RagdollBtn.Activated:Connect(function()
        ragdollEnabled = not ragdollEnabled
        local char = Player.Character
        if not char then return end
        local hum = char:FindFirstChild("Humanoid")
        if not hum then return end
        if ragdollEnabled then
            hum:ChangeState(Enum.HumanoidStateType.Physics)
            RagdollBtn.Text = L("ragdoll_on")
            RagdollBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        else
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            RagdollBtn.Text = L("ragdoll")
            RagdollBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)

    --// ============================================================
    --// ===== SHIFT LOCK =====
    --// ============================================================
    local shiftLockActive = false
    local shiftLockGui = nil
    local shiftLockBtn = nil

    local function shiftLock_enable()
        local char = Player.Character
        if not char then return end
        local hum = char:FindFirstChild("Humanoid")
        if not hum then return end
        hum.AutoRotate = false
        hum.CameraOffset = Vector3.new(1.75, 0.5, 0)
        shiftLockActive = true
        if shiftLockBtn then
            shiftLockBtn.Text = "🔓"
            shiftLockBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        end
    end

    local function shiftLock_disable()
        local char = Player.Character
        if not char then return end
        local hum = char:FindFirstChild("Humanoid")
        if not hum then return end
        hum.AutoRotate = true
        hum.CameraOffset = Vector3.new(0, 0, 0)
        shiftLockActive = false
        if shiftLockBtn then
            shiftLockBtn.Text = "🔒"
            shiftLockBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
        end
    end

    local function shiftLock_createButton()
        if shiftLockGui then shiftLockGui:Destroy() end
        shiftLockGui = Instance.new("ScreenGui")
        shiftLockGui.Parent = Player.PlayerGui
        shiftLockGui.Name = "ShiftLockGui"
        shiftLockGui.ResetOnSpawn = false

        shiftLockBtn = Instance.new("TextButton")
        shiftLockBtn.Parent = shiftLockGui
        shiftLockBtn.Size = UDim2.new(0, 55, 0, 55)
        shiftLockBtn.Position = UDim2.new(0.85, 0, 0.5, -25)
        shiftLockBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
        shiftLockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        shiftLockBtn.Text = "🔒"
        shiftLockBtn.Font = Enum.Font.GothamBold
        shiftLockBtn.TextScaled = true
        shiftLockBtn.Active = true
        shiftLockBtn.Draggable = true
        Instance.new("UICorner", shiftLockBtn).CornerRadius = UDim.new(0, 12)

        shiftLockBtn.Activated:Connect(function()
            if shiftLockActive then
                shiftLock_disable()
            else
                shiftLock_enable()
            end
        end)
    end

    local function shiftLock_destroyButton()
        if shiftLockGui then
            shiftLockGui:Destroy()
            shiftLockGui = nil
            shiftLockBtn = nil
        end
        shiftLock_disable()
    end

    ShiftLockBtn.Activated:Connect(function()
        if ShiftLockBtn.Text == L("shiftlock") then
            ShiftLockBtn.Text = L("shiftlock_on")
            ShiftLockBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
            shiftLock_createButton()
        else
            ShiftLockBtn.Text = L("shiftlock")
            ShiftLockBtn.BackgroundColor3 = Color3.fromRGB(180, 180, 220)
            shiftLock_destroyButton()
        end
    end)

    rs.Heartbeat:Connect(function()
        if shiftLockActive then
            local char = Player.Character
            if char then
                local hum = char:FindFirstChild("Humanoid")
                local root = char:FindFirstChild("HumanoidRootPart")
                local camera = workspace.CurrentCamera
                if hum and root then
                    hum.AutoRotate = false
                    hum.CameraOffset = Vector3.new(1.75, 0.5, 0)
                    local camDirection = camera.CFrame.LookVector
                    local flatDirection = Vector3.new(camDirection.X, 0, camDirection.Z)
                    if flatDirection.Magnitude > 0 then
                        root.CFrame = CFrame.new(root.Position, root.Position + flatDirection.Unit)
                    end
                end
            end
        end
    end)

    --// ============================================================
    --// ===== FLING =====
    --// ============================================================
    local flingEnabled = false
    local flingConn = nil

    local function fling_start()
        if flingConn then flingConn:Disconnect() end
        flingConn = rs.PostSimulation:Connect(function()
            if not flingEnabled then return end
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Player and player.Character then
                    for _, part in pairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = Player.Character.HumanoidRootPart
                local strength = 100000
                local oldV = hrp.Velocity
                hrp.Velocity = Vector3.new(strength, strength, strength)
                for _, v in pairs(Player.Character:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
                RunService.RenderStepped:Wait()
                hrp.Velocity = oldV
            end
        end)
    end

    local function fling_stop()
        if flingConn then
            flingConn:Disconnect()
            flingConn = nil
        end
    end

    FlingBtn.Activated:Connect(function()
        flingEnabled = not flingEnabled
        if flingEnabled then
            FlingBtn.Text = L("fling_on")
            FlingBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
            fling_start()
        else
            FlingBtn.Text = L("fling")
            FlingBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 150)
            fling_stop()
        end
    end)

    --// ============================================================
    --// ===== SPIDER MAN (Wall Climb) =====
    --// ============================================================
    local spiderEnabled = false
    local spiderClimbing = false
    local spiderWallNormal = nil
    local spiderSpeed = 12
    local spiderTracks = {}
    local spiderAnimator = nil
    local spiderKeys = {}

    local SPIDER_ANIM_CLIMB = "rbxassetid://616086039"

    local function spider_getAnimator(char)
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return nil end
        local anim = hum:FindFirstChildOfClass("Animator")
        if not anim then
            anim = Instance.new("Animator")
            anim.Parent = hum
        end
        return anim
    end

    local function spider_setupAnimations(char)
        spiderAnimator = spider_getAnimator(char)
        if not spiderAnimator then return end
        for _, t in pairs(spiderTracks) do
            if t then t:Stop(0) end
        end
        spiderTracks = {}
        local anim = Instance.new("Animation")
        anim.AnimationId = SPIDER_ANIM_CLIMB
        local track = spiderAnimator:LoadAnimation(anim)
        track.Priority = Enum.AnimationPriority.Action4
        spiderTracks.Climb = track
    end

    local function spider_stopAnims()
        if spiderTracks.Climb and spiderTracks.Climb.IsPlaying then
            spiderTracks.Climb:Stop(0.15)
        end
    end

    local function spider_resetNormal()
        local char = Player.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        if not hum then return end
        hum.AutoRotate = true
        hum.PlatformStand = false
        if root then
            root.Velocity = Vector3.zero
            root.RotVelocity = Vector3.zero
        end
        spider_stopAnims()
    end

    local function spider_findWall(char, root)
        local params = RaycastParams.new()
        params.FilterDescendantsInstances = {char}
        params.FilterType = Enum.RaycastFilterType.Exclude
        local directions = {
            root.CFrame.LookVector,
            -root.CFrame.LookVector,
            root.CFrame.RightVector,
            -root.CFrame.RightVector,
        }
        local bestHit, bestDist = nil, 2.3
        for _, dir in ipairs(directions) do
            local flat = Vector3.new(dir.X, 0, dir.Z)
            if flat.Magnitude > 0.01 then
                flat = flat.Unit
                local result = workspace:Raycast(root.Position, flat * 2.3, params)
                if result and result.Distance < bestDist then
                    if math.abs(result.Normal.Y) < 0.3 then
                        bestDist = result.Distance
                        bestHit = result
                    end
                end
            end
        end
        return bestHit
    end

    uis.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            spiderKeys[input.KeyCode] = true
        end
    end)
    uis.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            spiderKeys[input.KeyCode] = false
        end
    end)

    rs.Heartbeat:Connect(function(dt)
        if not spiderEnabled then return end
        local char = Player.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        if not hum or not root then return end
        if not spiderAnimator or spiderAnimator.Parent ~= hum then
            spider_setupAnimations(char)
        end
        local wallHit = spider_findWall(char, root)
        if wallHit then
            spiderClimbing = true
            spiderWallNormal = wallHit.Normal
            local wallNormal = Vector3.new(wallHit.Normal.X, 0, wallHit.Normal.Z).Unit
            local moveUp = spiderKeys[Enum.KeyCode.W]
            local moveDown = spiderKeys[Enum.KeyCode.S]
            local verticalVel = 0
            if moveUp and not moveDown then
                verticalVel = spiderSpeed
            elseif moveDown and not moveUp then
                verticalVel = -spiderSpeed
            end
            local stickVel = -wallNormal * 4
            root.Velocity = Vector3.new(stickVel.X, verticalVel, stickVel.Z)
            local lookDir = -wallNormal
            root.CFrame = CFrame.new(root.Position, root.Position + lookDir)
            hum.AutoRotate = false
            if (moveUp or moveDown) and spiderTracks.Climb then
                if not spiderTracks.Climb.IsPlaying then
                    spiderTracks.Climb:Play(0.1)
                end
            end
        else
            if spiderClimbing then
                spiderClimbing = false
                spiderWallNormal = nil
                hum.AutoRotate = true
                spider_stopAnims()
            end
        end
    end)

    SpiderManBtn.Activated:Connect(function()
        spiderEnabled = not spiderEnabled
        if spiderEnabled then
            SpiderManBtn.Text = L("spiderman_on")
            SpiderManBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
            if Player.Character then
                spider_setupAnimations(Player.Character)
            end
        else
            SpiderManBtn.Text = L("spiderman")
            SpiderManBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            spider_resetNormal()
        end
    end)

    --// ============================================================
    --// ===== GRAVITY FLY =====
    --// ============================================================
    local gravityFlySpeed = 80
    local gravityFlyGyro = nil
    local gravityFlyOriginalGravity = workspace.Gravity
    local gravityFlyKeys = {}

    uis.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            gravityFlyKeys[input.KeyCode] = true
        end
    end)
    uis.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            gravityFlyKeys[input.KeyCode] = false
        end
    end)

    local function gravityFly_enable()
        local char = Player.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        if not hum or not root then return end
        gravityFlyOriginalGravity = workspace.Gravity
        workspace.Gravity = 0
        hum.PlatformStand = true
        hum.WalkSpeed = 0
        hum.JumpPower = 0
        if gravityFlyGyro then gravityFlyGyro:Destroy() end
        gravityFlyGyro = Instance.new("BodyGyro")
        gravityFlyGyro.MaxTorque = Vector3.new(0, 400000, 0)
        gravityFlyGyro.P = 10000
        gravityFlyGyro.D = 500
        gravityFlyGyro.CFrame = root.CFrame
        gravityFlyGyro.Parent = root
    end

    local function gravityFly_disable()
        local char = Player.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        workspace.Gravity = gravityFlyOriginalGravity
        if hum then
            hum.PlatformStand = false
            hum.WalkSpeed = 16
            hum.JumpPower = 50
            hum.UseJumpPower = true
        end
        if root then
            root.Velocity = Vector3.zero
            root.RotVelocity = Vector3.zero
        end
        if gravityFlyGyro then gravityFlyGyro:Destroy() gravityFlyGyro = nil end
    end

    rs.RenderStepped:Connect(function(dt)
        if not gravityFlyEnabled then return end
        local char = Player.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        if not hum or not root then return end
        local camLook = cam.CFrame.LookVector
        local camRight = cam.CFrame.RightVector
        local moveDir = Vector3.zero
        moveDir = moveDir + mobileDirection(cam)
        if gravityFlyKeys[Enum.KeyCode.W] then moveDir = moveDir + camLook end
        if gravityFlyKeys[Enum.KeyCode.S] then moveDir = moveDir - camLook end
        if gravityFlyKeys[Enum.KeyCode.D] then moveDir = moveDir + camRight end
        if gravityFlyKeys[Enum.KeyCode.A] then moveDir = moveDir - camRight end
        if gravityFlyKeys[Enum.KeyCode.Space] then moveDir = moveDir + Vector3.new(0, 1, 0) end
        if gravityFlyKeys[Enum.KeyCode.LeftControl] or gravityFlyKeys[Enum.KeyCode.RightControl] then
            moveDir = moveDir - Vector3.new(0, 1, 0)
        end
        if moveDir.Magnitude > 0 then
            local offset = moveDir.Unit * gravityFlySpeed * dt
            root.CFrame = root.CFrame + offset
            root.Velocity = Vector3.zero
            root.RotVelocity = Vector3.zero
        else
            root.Velocity = Vector3.zero
            root.RotVelocity = Vector3.zero
        end
        local flatLook = Vector3.new(camLook.X, 0, camLook.Z)
        if flatLook.Magnitude > 0.01 and gravityFlyGyro then
            gravityFlyGyro.CFrame = CFrame.new(root.Position, root.Position + flatLook.Unit)
        end
    end)

    GravityFlyBtn.Activated:Connect(function()
        gravityFlyEnabled = not gravityFlyEnabled
        setMobileControlsVisible(flying or gravityFlyEnabled or multiJumpEnabled)
        if gravityFlyEnabled then
            GravityFlyBtn.Text = L("gravityfly_on")
            GravityFlyBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
            gravityFly_enable()
        else
            GravityFlyBtn.Text = L("gravityfly")
            GravityFlyBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
            gravityFly_disable()
        end
    end)

    --// ============================================================
    --// ===== ANTI SYSTEM =====
    --// ============================================================
    local antiFlingOn = false
    local antiSlapOn = false
    local antiSitOn = false
    local antiLaunchOn = false
    local antiGrabOn = false
    local antiSystemLastPos = nil
    local antiSystemConn = nil

    local function antiSystem_updateLastPos()
        local char = Player.Character
        if char then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then antiSystemLastPos = root.Position end
        end
    end

    local function antiSystem_start()
        if antiSystemConn then antiSystemConn:Disconnect() end
        antiSystem_updateLastPos()
        antiSystemConn = rs.Heartbeat:Connect(function()
            local char = Player.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChild("Humanoid")
            if not root or not hum then return end
            if not antiSystemLastPos then antiSystemLastPos = root.Position end

            if antiFlingOn then
                for _, v in pairs(root:GetChildren()) do
                    if v:IsA("BodyVelocity") or v:IsA("BodyAngularVelocity") or v:IsA("BodyThrust") or v:IsA("BodyForce") then
                        if v.Name ~= "FlyBV" and v.Name ~= "AntiFlingBV" and v.Name ~= "QasimFlyVelocity" then
                            v:Destroy()
                        end
                    end
                end
                if root.RotVelocity.Magnitude > 5 then
                    root.RotVelocity = Vector3.new(0, 0, 0)
                end
            end

            if antiSlapOn then
                if root.Velocity.Magnitude > 120 then
                    root.Velocity = Vector3.new(0, 0, 0)
                end
            end

            if antiSitOn then
                if hum.Sit then hum.Sit = false end
                if hum.PlatformStand then hum.PlatformStand = false end
            end

            if antiLaunchOn then
                if root.Velocity.Y > 100 then
                    root.Velocity = Vector3.new(root.Velocity.X, 0, root.Velocity.Z)
                end
                for _, v in pairs(root:GetChildren()) do
                    if v:IsA("BodyPosition") or v:IsA("BodyGyro") then
                        if v.Name ~= "FlyBG" and v.Name ~= "QasimFlyGyro" then
                            v:Destroy()
                        end
                    end
                end
            end

            if antiGrabOn then
                for _, v in pairs(root:GetChildren()) do
                    if v:IsA("Weld") or v:IsA("WeldConstraint") or v:IsA("Motor6D") then
                        local part0 = v.Part0
                        local part1 = v.Part1
                        if part0 and part0 ~= root and not char:IsAncestorOf(part0) then
                            v:Destroy()
                        end
                        if part1 and part1 ~= root and not char:IsAncestorOf(part1) then
                            v:Destroy()
                        end
                    end
                end
            end

            antiSystemLastPos = root.Position
        end)
    end

    AntiFlingBtn.Activated:Connect(function()
        antiFlingOn = not antiFlingOn
        AntiFlingBtn.Text = antiFlingOn and L("antifling_on") or L("antifling")
        AntiFlingBtn.BackgroundColor3 = antiFlingOn and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(100, 200, 100)
    end)

    AntiSlapBtn.Activated:Connect(function()
        antiSlapOn = not antiSlapOn
        AntiSlapBtn.Text = antiSlapOn and L("antislap_on") or L("antislap")
        AntiSlapBtn.BackgroundColor3 = antiSlapOn and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(100, 200, 150)
    end)

    AntiSitBtn.Activated:Connect(function()
        antiSitOn = not antiSitOn
        AntiSitBtn.Text = antiSitOn and L("antisit_on") or L("antisit")
        AntiSitBtn.BackgroundColor3 = antiSitOn and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(100, 200, 200)
    end)

    AntiLaunchBtn.Activated:Connect(function()
        antiLaunchOn = not antiLaunchOn
        AntiLaunchBtn.Text = antiLaunchOn and L("antilaunch_on") or L("antilaunch")
        AntiLaunchBtn.BackgroundColor3 = antiLaunchOn and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(100, 180, 200)
    end)

    AntiGrabBtn.Activated:Connect(function()
        antiGrabOn = not antiGrabOn
        AntiGrabBtn.Text = antiGrabOn and L("antigrab_on") or L("antigrab")
        AntiGrabBtn.BackgroundColor3 = antiGrabOn and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(100, 160, 200)
    end)

    antiSystem_start()

    --// ============================================================
    --// ===== ESP =====
    --// ============================================================
    local function updateEspForPlayer(plr)
        if not showEsp then return end
        if plr == Player then return end
        local char = plr.Character
        if not char then return end
        if espHighlights[plr] then espHighlights[plr]:Destroy() espHighlights[plr] = nil end
        local highlight = Instance.new("Highlight")
        highlight.Parent = char
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.FillTransparency = 0.4
        highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineTransparency = 0.2
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        espHighlights[plr] = highlight
    end

    EspBtn.Activated:Connect(function()
        showEsp = not showEsp
        EspBtn.Text = showEsp and L("esp_on") or L("esp")
        if showEsp then
            for _, plr in pairs(Players:GetPlayers()) do updateEspForPlayer(plr) end
        else
            for plr, hl in pairs(espHighlights) do if hl then hl:Destroy() end end
            espHighlights = {}
        end
    end)

    --// ===== Water Walk =====
    WaterWalkBtn.Activated:Connect(function()
        waterWalkEnabled = not waterWalkEnabled
        local char = Player.Character
        if not char then return end
        if waterWalkEnabled then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            waterWalkPart = Instance.new("Part")
            waterWalkPart.Name = "WaterWalkPart"
            waterWalkPart.Size = Vector3.new(8, 0.5, 8)
            waterWalkPart.Anchored = true
            waterWalkPart.CanCollide = true
            waterWalkPart.Transparency = 1
            waterWalkPart.Parent = workspace
            waterWalkPart.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y - 3, hrp.Position.Z)
            if waterWalkLoop then waterWalkLoop:Disconnect() end
            waterWalkLoop = rs.Heartbeat:Connect(function()
                if waterWalkEnabled and Player.Character and waterWalkPart then
                    local root = Player.Character:FindFirstChild("HumanoidRootPart")
                    if root then
                        waterWalkPart.CFrame = CFrame.new(root.Position.X, waterWalkPart.Position.Y, root.Position.Z)
                    end
                end
            end)
            WaterWalkBtn.Text = L("waterwalk_on")
            WaterWalkBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        else
            if waterWalkPart then waterWalkPart:Destroy() end
            if waterWalkLoop then waterWalkLoop:Disconnect() end
            waterWalkPart = nil
            waterWalkLoop = nil
            WaterWalkBtn.Text = L("waterwalk")
            WaterWalkBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
        end
    end)

    --// ===== Invisible =====
    InvisibleBtn.Activated:Connect(function()
        invis_on = not invis_on
        if invis_on then
            local char = Player.Character
            if not char then return end
            trans(char, 0.5)
            InvisibleBtn.Text = L("invisible_on")
            InvisibleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        else
            if Player.Character then trans(Player.Character, 0) end
            InvisibleBtn.Text = L("invisible")
            InvisibleBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
        end
    end)

    --// ===== Night Vision =====
    NightBtn.Activated:Connect(function()
        nightVision = not nightVision
        NightBtn.Text = nightVision and L("night_on") or L("night")
        if nightVision then
            Lighting.Ambient = Color3.fromRGB(0, 255, 0)
            Lighting.Brightness = 5
            Lighting.ClockTime = 0
            Lighting.FogColor = Color3.fromRGB(0, 50, 0)
            Lighting.FogEnd = 100
            if nightAtmo then nightAtmo:Destroy() end
            nightAtmo = Instance.new("Atmosphere")
            nightAtmo.Parent = Lighting
            nightAtmo.Density = 0.1
            nightAtmo.Color = Color3.fromRGB(0, 255, 0)
            nightAtmo.Decay = Color3.fromRGB(0, 200, 0)
            if nightConn then nightConn:Disconnect() end
            nightConn = rs.Heartbeat:Connect(function()
                if nightVision then
                    Lighting.Ambient = Color3.fromRGB(0, 255, 0)
                    Lighting.Brightness = 5
                end
            end)
        else
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogColor = Color3.fromRGB(255, 255, 255)
            Lighting.FogEnd = 10000
            if nightAtmo then nightAtmo:Destroy() end
            if nightConn then nightConn:Disconnect() end
        end
    end)

    --// ===== Reset =====
    ResetBtn.Activated:Connect(function()
        if Player.Character then Player.Character:BreakJoints() end
    end)

    --// ===== Checkpoint =====
    CheckpointBtn.Activated:Connect(function()
        local char = Player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            checkpointPos = char.HumanoidRootPart.CFrame
            CheckpointBtn.Text = "✅ " .. L("checkpoint")
            task.wait(1)
            CheckpointBtn.Text = L("checkpoint")
        end
    end)

    GotoCheckpointBtn.Activated:Connect(function()
        if checkpointPos then
            local char = Player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = checkpointPos
            end
        end
    end)

    --// ===== Noclip =====
    NoclipBtn.Activated:Connect(function()
        noclip = not noclip
        NoclipBtn.Text = noclip and L("noclip_on") or L("noclip")
        if noclip then
            if ncConn then ncConn:Disconnect() end
            ncConn = rs.Stepped:Connect(function()
                if Player.Character then
                    for _, v in pairs(Player.Character:GetDescendants()) do
                        if v:IsA("BasePart") then v.CanCollide = false end
                    end
                end
            end)
        else
            if ncConn then ncConn:Disconnect() end
            if Player.Character then
                for _, v in pairs(Player.Character:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = true end
                end
            end
        end
    end)

    --// ===== Fly =====
    local getFlySpeed

    FlyBtn.Activated:Connect(function()
        flying = not flying
        FlyBtn.Text = flying and L("fly_on") or L("fly")
        setMobileControlsVisible(flying or gravityFlyEnabled or multiJumpEnabled)

        local char = Player.Character
        if not char then
            flying = false
            FlyBtn.Text = L("fly")
            return
        end

        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")

        if flying and hum and hrp then
            if flyLoop then flyLoop:Disconnect() flyLoop = nil end
            if flyBV then flyBV:Destroy() flyBV = nil end
            if flyBG then flyBG:Destroy() flyBG = nil end

            flyBV = Instance.new("BodyVelocity")
            flyBV.Name = "QasimFlyVelocity"
            flyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            flyBV.Velocity = Vector3.zero
            flyBV.Parent = hrp

            flyBG = Instance.new("BodyGyro")
            flyBG.Name = "QasimFlyGyro"
            flyBG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            flyBG.P = 90000
            flyBG.D = 1000
            flyBG.CFrame = hrp.CFrame
            flyBG.Parent = hrp

            hum.PlatformStand = true

            flyLoop = rs.RenderStepped:Connect(function()
                if not flying then return end
                local currentChar = Player.Character
                if not currentChar then return end
                local root = currentChar:FindFirstChild("HumanoidRootPart")
                if not root then return end
                local camera = workspace.CurrentCamera
                if not camera then return end
                local direction = Vector3.zero
                direction = direction + mobileDirection(camera)
                if uis:IsKeyDown(Enum.KeyCode.W) then direction += camera.CFrame.LookVector end
                if uis:IsKeyDown(Enum.KeyCode.S) then direction -= camera.CFrame.LookVector end
                if uis:IsKeyDown(Enum.KeyCode.A) then direction -= camera.CFrame.RightVector end
                if uis:IsKeyDown(Enum.KeyCode.D) then direction += camera.CFrame.RightVector end
                if uis:IsKeyDown(Enum.KeyCode.Space) then direction += Vector3.new(0, 1, 0) end
                if uis:IsKeyDown(Enum.KeyCode.LeftControl) or uis:IsKeyDown(Enum.KeyCode.LeftShift) then
                    direction -= Vector3.new(0, 1, 0)
                end
                local speed = 60
                if type(getFlySpeed) == "function" then
                    local ok, value = pcall(getFlySpeed)
                    if ok and type(value) == "number" then speed = value end
                end
                if direction.Magnitude > 0 then
                    flyBV.Velocity = direction.Unit * speed
                else
                    flyBV.Velocity = Vector3.zero
                end
                flyBG.CFrame = camera.CFrame
            end)
        else
            if flyLoop then flyLoop:Disconnect() flyLoop = nil end
            if flyBV then flyBV:Destroy() flyBV = nil end
            if flyBG then flyBG:Destroy() flyBG = nil end
            if hum then hum.PlatformStand = false end
        end
    end)

    --// ===== Sliders =====
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Parent = Scroll
    SliderFrame.Size = UDim2.new(0, 280, 0, 300)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 45)
    SliderFrame.BorderSizePixel = 0
    Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 8)

    local SliderLayout = Instance.new("UIListLayout")
    SliderLayout.Parent = SliderFrame
    SliderLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SliderLayout.Padding = UDim.new(0, 5)
    SliderLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local SliderPadding = Instance.new("UIPadding")
    SliderPadding.Parent = SliderFrame
    SliderPadding.PaddingTop = UDim.new(0, 8)
    SliderPadding.PaddingBottom = UDim.new(0, 8)

    local function createSlider(name, min, max, default, onChange)
        local Holder = Instance.new("Frame")
        Holder.Parent = SliderFrame
        Holder.Size = UDim2.new(0, 260, 0, 40)
        Holder.BackgroundTransparency = 1
        local Label = Instance.new("TextLabel")
        Label.Parent = Holder
        Label.Size = UDim2.new(1, 0, 0, 18)
        Label.BackgroundTransparency = 1
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextSize = 11
        Label.Text = name .. ": " .. default
        Label.Font = Enum.Font.GothamBold
        Label.TextXAlignment = Enum.TextXAlignment.Left
        local SFrame = Instance.new("Frame")
        SFrame.Parent = Holder
        SFrame.Size = UDim2.new(1, 0, 0, 18)
        SFrame.Position = UDim2.new(0, 0, 0, 20)
        SFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
        Instance.new("UICorner", SFrame).CornerRadius = UDim.new(0, 4)
        local Bar = Instance.new("Frame")
        Bar.Parent = SFrame
        Bar.Size = UDim2.new(0.9, 0, 0, 4)
        Bar.Position = UDim2.new(0.05, 0, 0.5, -2)
        Bar.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
        local Dot = Instance.new("TextButton")
        Dot.Parent = Bar
        Dot.Size = UDim2.new(0, 14, 0, 14)
        Dot.Position = UDim2.new((default-min)/(max-min), -7, 0.5, -7)
        Dot.Text = ""
        Dot.BackgroundColor3 = Color3.fromRGB(255, 50, 150)
        Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)
        local val = default
        local sliding = false
        local function beginSlide(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                sliding = true
            end
        end
        Dot.InputBegan:Connect(beginSlide)
        SFrame.InputBegan:Connect(beginSlide)
        uis.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                sliding = false
            end
        end)
        uis.InputChanged:Connect(function(i)
            if sliding and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                local per = math.clamp((i.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
                Dot.Position = UDim2.new(per, -7, 0.5, -7)
                val = math.floor(min + (per * (max - min)))
                Label.Text = name .. ": " .. val
                if onChange then onChange(val) end
            end
        end)
        return function() return val end
    end

    getFlySpeed = createSlider(L("fly_speed"), 20, 1000, 60)
    local getSpeed = createSlider(L("walk_speed"), 16, 200, 16)
    local getJumpPower = createSlider(L("jump_power"), 50, 200, 50)
    local getGravity = createSlider(L("gravity"), 20, 196, 196)
    local _ = createSlider(L("spider_speed"), 2, 30, 12, function(v) spiderSpeed = v end)
    local _ = createSlider(L("gravityfly_speed"), 10, 300, 80, function(v) gravityFlySpeed = v end)

    --// ===== Player List =====
    local ListTitle = Instance.new("TextLabel")
    ListTitle.Parent = Scroll
    ListTitle.Size = UDim2.new(1, 0, 0, 25)
    ListTitle.BackgroundTransparency = 1
    ListTitle.Text = L("player_list")
    ListTitle.Font = Enum.Font.GothamBold
    ListTitle.TextColor3 = Color3.fromRGB(255, 50, 150)
    ListTitle.TextSize = 12

    local PlayerListFrame = Instance.new("Frame")
    PlayerListFrame.Parent = Scroll
    PlayerListFrame.Size = UDim2.new(0, 280, 0, 0)
    PlayerListFrame.BackgroundTransparency = 1
    local PlayerListLayout = Instance.new("UIListLayout")
    PlayerListLayout.Parent = PlayerListFrame
    PlayerListLayout.Padding = UDim.new(0, 5)

    local function updatePlayerList()
        for _, v in pairs(PlayerListFrame:GetChildren()) do
            if v:IsA("Frame") then v:Destroy() end
        end
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= Player then
                local card = Instance.new("Frame")
                card.Parent = PlayerListFrame
                card.Size = UDim2.new(1, 0, 0, 60)
                card.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
                Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6)
                local avatar = Instance.new("ImageLabel")
                avatar.Parent = card
                avatar.Size = UDim2.new(0, 45, 0, 45)
                avatar.Position = UDim2.new(0, 6, 0.5, -22)
                avatar.BackgroundTransparency = 1
                avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. plr.UserId .. "&width=420&height=420&format=png"
                local nameLabel = Instance.new("TextLabel")
                nameLabel.Parent = card
                nameLabel.Size = UDim2.new(0.45, 0, 1, 0)
                nameLabel.Position = UDim2.new(0.22, 0, 0, 0)
                nameLabel.BackgroundTransparency = 1
                nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                nameLabel.Text = plr.Name
                nameLabel.TextScaled = true
                nameLabel.TextXAlignment = Enum.TextXAlignment.Left
                nameLabel.Font = Enum.Font.GothamBold
                local goBtn = Instance.new("TextButton")
                goBtn.Parent = card
                goBtn.Size = UDim2.new(0.2, 0, 0.6, 0)
                goBtn.Position = UDim2.new(0.75, 0, 0.2, 0)
                goBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
                goBtn.Text = L("go")
                goBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                goBtn.Font = Enum.Font.GothamBold
                goBtn.TextSize = 10
                Instance.new("UICorner", goBtn).CornerRadius = UDim.new(0, 4)
                goBtn.Activated:Connect(function()
                    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            hrp.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 3)
                        end
                    end
                end)
            end
        end
        PlayerListFrame.Size = UDim2.new(0, 280, 0, #Players:GetPlayers() * 65)
    end
    updatePlayerList()
    Players.PlayerAdded:Connect(updatePlayerList)
    Players.PlayerRemoving:Connect(updatePlayerList)

    --// ===== Target List =====
    local targetBtn = Instance.new("TextButton")
    targetBtn.Parent = Scroll
    targetBtn.Size = UDim2.new(0, 280, 0, 32)
    targetBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 150)
    targetBtn.Text = L("target_list_down")
    targetBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    targetBtn.Font = Enum.Font.GothamBold
    targetBtn.TextSize = 12
    Instance.new("UICorner", targetBtn).CornerRadius = UDim.new(0, 6)

    local targetListVisible = false
    local targetListFrame = nil

    targetBtn.Activated:Connect(function()
        targetListVisible = not targetListVisible
        targetBtn.Text = targetListVisible and L("target_list_up") or L("target_list_down")
        if targetListVisible then
            if targetListFrame then targetListFrame:Destroy() end
            targetListFrame = Instance.new("ScrollingFrame")
            targetListFrame.Parent = Scroll
            targetListFrame.Size = UDim2.new(0, 280, 0, 200)
            targetListFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
            targetListFrame.BorderSizePixel = 1
            targetListFrame.BorderColor3 = Color3.fromRGB(255, 50, 150)
            targetListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
            targetListFrame.ScrollBarThickness = 5
            local y = 0
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= Player then
                    local card = Instance.new("Frame")
                    card.Parent = targetListFrame
                    card.Size = UDim2.new(0.95, 0, 0, 60)
                    card.Position = UDim2.new(0.025, 0, 0, y)
                    card.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
                    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6)
                    local avatar = Instance.new("ImageLabel")
                    avatar.Parent = card
                    avatar.Size = UDim2.new(0, 45, 0, 45)
                    avatar.Position = UDim2.new(0, 6, 0.5, -22)
                    avatar.BackgroundTransparency = 1
                    avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. plr.UserId .. "&width=420&height=420&format=png"
                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Parent = card
                    nameLabel.Size = UDim2.new(0.6, 0, 1, 0)
                    nameLabel.Position = UDim2.new(0.22, 0, 0, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    nameLabel.Text = plr.Name
                    nameLabel.TextScaled = true
                    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
                    nameLabel.Font = Enum.Font.GothamBold
                    local selectBtn = Instance.new("TextButton")
                    selectBtn.Parent = card
                    selectBtn.Size = UDim2.new(1, 0, 1, 0)
                    selectBtn.BackgroundTransparency = 1
                    selectBtn.Text = ""
                    selectBtn.ZIndex = 1
                    selectBtn.Activated:Connect(function()
                        selectedTarget = plr
                        for _, child in pairs(targetListFrame:GetChildren()) do
                            if child:IsA("Frame") then child.BackgroundColor3 = Color3.fromRGB(30, 30, 60) end
                        end
                        card.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                    end)
                    y = y + 65
                end
            end
            targetListFrame.CanvasSize = UDim2.new(0, 0, 0, y)
        else
            if targetListFrame then targetListFrame:Destroy() end
        end
    end)

    --// ===== Follow / PlayerInfo / Attach =====
    local FollowBtn = Instance.new("TextButton")
    FollowBtn.Parent = Scroll
    FollowBtn.Size = UDim2.new(0, 280, 0, 32)
    FollowBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 50)
    FollowBtn.Text = L("follow")
    FollowBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    FollowBtn.Font = Enum.Font.GothamBold
    FollowBtn.TextSize = 12
    Instance.new("UICorner", FollowBtn).CornerRadius = UDim.new(0, 6)

    local PlayerInfoBtn = Instance.new("TextButton")
    PlayerInfoBtn.Parent = Scroll
    PlayerInfoBtn.Size = UDim2.new(0, 280, 0, 32)
    PlayerInfoBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    PlayerInfoBtn.Text = L("player_info")
    PlayerInfoBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    PlayerInfoBtn.Font = Enum.Font.GothamBold
    PlayerInfoBtn.TextSize = 12
    Instance.new("UICorner", PlayerInfoBtn).CornerRadius = UDim.new(0, 6)

    local AttachBtn = Instance.new("TextButton")
    AttachBtn.Parent = Scroll
    AttachBtn.Size = UDim2.new(0, 280, 0, 32)
    AttachBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
    AttachBtn.Text = L("attach")
    AttachBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    AttachBtn.Font = Enum.Font.GothamBold
    AttachBtn.TextSize = 12
    Instance.new("UICorner", AttachBtn).CornerRadius = UDim.new(0, 6)

    --// ===== Change Language Button =====
    local ChangeLangBtn = Instance.new("TextButton")
    ChangeLangBtn.Parent = Scroll
    ChangeLangBtn.Size = UDim2.new(0, 280, 0, 35)
    ChangeLangBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
    ChangeLangBtn.Text = L("change_lang")
    ChangeLangBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ChangeLangBtn.Font = Enum.Font.GothamBold
    ChangeLangBtn.TextSize = 12
    Instance.new("UICorner", ChangeLangBtn).CornerRadius = UDim.new(0, 6)

    ChangeLangBtn.Activated:Connect(function()
        ScreenGui:Destroy()
        local fpsGui2 = Player.PlayerGui:FindFirstChild("FpsPingGui")
        if fpsGui2 then fpsGui2:Destroy() end
        showLangMenu(function()
            buildMenu()
        end)
    end)

    --// ===== Follow Function =====
    FollowBtn.Activated:Connect(function()
        followEnabled = not followEnabled
        if followEnabled and selectedTarget then
            if followLoop then followLoop:Disconnect() end
            followLoop = rs.Heartbeat:Connect(function()
                if followEnabled and selectedTarget and selectedTarget.Character and Player.Character then
                    local targetRoot = selectedTarget.Character:FindFirstChild("HumanoidRootPart")
                    local myRoot = Player.Character:FindFirstChild("HumanoidRootPart")
                    if targetRoot and myRoot then
                        local dist = (myRoot.Position - targetRoot.Position).Magnitude
                        if dist > 5 then
                            myRoot.CFrame = CFrame.new(targetRoot.Position - targetRoot.CFrame.LookVector * 5)
                        end
                    end
                end
            end)
            FollowBtn.Text = L("follow_on")
            FollowBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        else
            if followLoop then followLoop:Disconnect() end
            followLoop = nil
            FollowBtn.Text = L("follow")
            FollowBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 50)
        end
    end)

    --// ===== Player Info =====
    PlayerInfoBtn.Activated:Connect(function()
        if playerInfoGui then
            playerInfoGui:Destroy()
            playerInfoGui = nil
            return
        end
        playerInfoGui = Instance.new("ScreenGui")
        playerInfoGui.Parent = Player.PlayerGui
        playerInfoGui.Name = "PlayerInfoGui"
        local infoFrame = Instance.new("Frame")
        infoFrame.Parent = playerInfoGui
        infoFrame.Size = UDim2.new(0, 260, 0, 30)
        infoFrame.Position = UDim2.new(0.5, -130, 0, 10)
        infoFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        infoFrame.BackgroundTransparency = 0.5
        Instance.new("UICorner", infoFrame).CornerRadius = UDim.new(0, 6)
        local infoLabel = Instance.new("TextLabel")
        infoLabel.Parent = infoFrame
        infoLabel.Size = UDim2.new(1, 0, 1, 0)
        infoLabel.BackgroundTransparency = 1
        infoLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        infoLabel.Font = Enum.Font.GothamBold
        infoLabel.TextSize = 12
        infoLabel.Text = L("status_none")
        spawn(function()
            while playerInfoGui and playerInfoGui.Parent do
                wait(1)
                if selectedTarget and selectedTarget.Character and Player.Character then
                    local tChar = selectedTarget.Character
                    local tHum = tChar:FindFirstChild("Humanoid")
                    local myRoot = Player.Character:FindFirstChild("HumanoidRootPart")
                    local tRoot = tChar:FindFirstChild("HumanoidRootPart")
                    if tHum and myRoot and tRoot then
                        local dist = (myRoot.Position - tRoot.Position).Magnitude
                        infoLabel.Text = selectedTarget.Name .. " | HP: " .. math.floor(tHum.Health) .. " | Dist: " .. math.floor(dist)
                    end
                else
                    infoLabel.Text = L("status_none")
                end
            end
        end)
    end)

    --// ===== Attach =====
    AttachBtn.Activated:Connect(function()
        if not selectedTarget then return end
        attached = not attached
        if attached then
            local char = Player.Character
            local targetChar = selectedTarget.Character
            if char and targetChar then
                local root = char:FindFirstChild("HumanoidRootPart")
                local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
                if root and targetRoot then
                    root.CFrame = targetRoot.CFrame + Vector3.new(0, 0, 2.5)
                    task.wait(0.1)
                    attachWeld = Instance.new("Weld")
                    attachWeld.Part0 = root
                    attachWeld.Part1 = targetRoot
                    attachWeld.C0 = CFrame.new(0, 0, -2.5)
                    attachWeld.Parent = root
                    attachBodyVelocity = Instance.new("BodyVelocity")
                    attachBodyVelocity.Parent = root
                    attachBodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                    attachBodyVelocity.Velocity = Vector3.new(0, 0, 0)
                    if char:FindFirstChild("Humanoid") then char.Humanoid.PlatformStand = true end
                    AttachBtn.Text = L("attach_on")
                    AttachBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                end
            end
        else
            if attachWeld then attachWeld:Destroy() end
            if attachBodyVelocity then attachBodyVelocity:Destroy() end
            attachWeld = nil
            attachBodyVelocity = nil
            local char = Player.Character
            if char and char:FindFirstChild("Humanoid") then char.Humanoid.PlatformStand = false end
            AttachBtn.Text = L("attach")
            AttachBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
        end
    end)

    uis.JumpRequest:Connect(function()
        if not multiJumpEnabled then return end
        local char = Player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")
        if not hrp or not hum then return end
        local now = tick()
        if now - lastJumpTime > 0.1 and jumpCount < maxJumps then
            hrp.Velocity = Vector3.new(hrp.Velocity.X, 50, hrp.Velocity.Z)
            jumpCount += 1
            lastJumpTime = now
        end
    end)

    --// ===== Heartbeat Loop =====
    rs.Heartbeat:Connect(function()
        if multiJumpEnabled and Player.Character then
            local char = Player.Character
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChild("Humanoid")
            if hrp and hum and hum:GetState() == Enum.HumanoidStateType.Landed then
                jumpCount = 0
            end
        end
        if waterWalkEnabled and Player.Character and waterWalkPart then
            if uis:IsKeyDown(Enum.KeyCode.Q) then
                waterWalkPart.CFrame = waterWalkPart.CFrame - Vector3.new(0, 0.5, 0)
            end
        end
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            local hum = Player.Character.Humanoid
            hum.UseJumpPower = true
            hum.WalkSpeed = getSpeed()
            hum.JumpPower = getJumpPower()
        end
        workspace.Gravity = getGravity()
    end)

    --// ===== ESP Player Added =====
    Players.PlayerAdded:Connect(function(plr)
        if showEsp then plr.CharacterAdded:Connect(function() wait(0.5) updateEspForPlayer(plr) end) end
    end)

    Players.PlayerRemoving:Connect(function(plr)
        if espHighlights[plr] then espHighlights[plr]:Destroy() espHighlights[plr] = nil end
    end)

    --// ===== KILL BUTTON =====
    KillBtn.Activated:Connect(function()
        if flyLoop then pcall(function() flyLoop:Disconnect() end) end
        if flyBV then pcall(function() flyBV:Destroy() end) end
        if flyBG then pcall(function() flyBG:Destroy() end) end
        if ncConn then pcall(function() ncConn:Disconnect() end) end
        if nightConn then pcall(function() nightConn:Disconnect() end) end
        if nightAtmo then pcall(function() nightAtmo:Destroy() end) end
        if antiAfkLoop then pcall(function() antiAfkLoop:Disconnect() end) end
        if antiVoidLoop then pcall(function() antiVoidLoop:Disconnect() end) end
        if waterWalkLoop then pcall(function() waterWalkLoop:Disconnect() end) end
        if waterWalkPart then pcall(function() waterWalkPart:Destroy() end) end
        if freecamLoop then pcall(function() freecamLoop:Disconnect() end) end
        if followLoop then pcall(function() followLoop:Disconnect() end) end
        if ghostConn then pcall(function() ghostConn:Disconnect() end) end
        if ghost then pcall(function() ghost:Destroy() end) end
        if attachWeld then pcall(function() attachWeld:Destroy() end) end
        if attachBodyVelocity then pcall(function() attachBodyVelocity:Destroy() end) end
        for plr, hl in pairs(espHighlights) do if hl then pcall(function() hl:Destroy() end) end end
        for _, obj in pairs(skyObjects) do if obj and obj.Parent then pcall(function() obj:Destroy() end) end end
        local invisChair = workspace:FindFirstChild("invischair")
        if invisChair then invisChair:Destroy() end
        local sky = Lighting:FindFirstChild("CustomSky")
        if sky then sky:Destroy() end
        local fpsGui3 = Player.PlayerGui:FindFirstChild("FpsPingGui")
        if fpsGui3 then fpsGui3:Destroy() end
        local mobileGui3 = Player.PlayerGui:FindFirstChild("QasimMobileControls")
        if mobileGui3 then mobileGui3:Destroy() end
        for key in pairs(mobileHeld) do mobileHeld[key] = false end
        if playerInfoGui then playerInfoGui:Destroy() end

        if shiftLockGui then pcall(function() shiftLockGui:Destroy() end) end
        if flingConn then pcall(function() flingConn:Disconnect() end) end
        if gravityFlyGyro then pcall(function() gravityFlyGyro:Destroy() end) end
        if antiSystemConn then pcall(function() antiSystemConn:Disconnect() end) end
        workspace.Gravity = gravityFlyOriginalGravity
        flingEnabled = false
        shiftLockActive = false
        spiderEnabled = false
        gravityFlyEnabled = false
        spider_resetNormal()
        gravityFly_disable()

        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogColor = Color3.fromRGB(255, 255, 255)
        Lighting.FogEnd = 10000
        Lighting.GlobalShadows = true

        if Player.Character then
            local hum = Player.Character:FindFirstChild("Humanoid")
            if hum then
                hum.PlatformStand = false
                hum.WalkSpeed = 16
                hum.JumpPower = 50
                hum.UseJumpPower = true
                hum.AutoRotate = true
                hum.CameraOffset = Vector3.new(0, 0, 0)
            end
            for _, v in pairs(Player.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = true
                    v.Transparency = 0
                end
            end
        end

        ScreenGui:Destroy()
    end)

    --// ===== Keybind =====
    uis.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.K then
            MainFrame.Visible = not MainFrame.Visible
            OpenBtn.Visible = not MainFrame.Visible
            if not MainFrame.Visible then clampGui(OpenBtn) end
        end
    end)

    print("🗿 Qasim Triak v5 Loaded!")
end

--// ===== START =====
currentLang = loadLang()
if currentLang == "fa" or currentLang == "en" or currentLang == "es" then
    buildMenu()
else
    showLangMenu(function()
        buildMenu()
    end)
end
