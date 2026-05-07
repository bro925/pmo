local repo = 'https://raw.githubusercontent.com/bro925/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'catware - Blox Fruits',
    Center = true,
    AutoShow = true,
    TabPadding = 0
})

local Tabs = {
    Combat = Window:AddTab('Combat'),
    Farming = Window:AddTab('Farming'),
    Visuals = Window:AddTab('Visuals'),
    Movement = Window:AddTab('Movement'),
    Player = Window:AddTab('Player'),
    Misc = Window:AddTab('Misc'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

-- // ============================================================== Variables ============================================================== \\ --

local charFolder = workspace:FindFirstChild("Characters")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net")
local NetModule = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net"))
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
local CommE = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommE")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local LightingService = game:GetService("Lighting")

local plr = game.Players.LocalPlayer
local character = plr.Character or plr.CharacterAdded:Wait()
local character2 = charFolder:FindFirstChild(plr.Name)

local First_Sea = false
local Second_Sea = false
local Third_Sea = false
local placeId = game.PlaceId
if placeId == 2753915549 then First_Sea = true
elseif placeId == 4442272183 then Second_Sea = true
elseif placeId == 7449423635 then Third_Sea = true
end

local swordList = {
    "Cutlass","Katana","Dual Katana","Triple Katana","Iron Mace","Shark Saw",
    "Twin Hooks","Dragon Trident","Dual-Headed Blade","Flail","Gravity Blade",
    "Longsword","Pipe","Soul Cane","Trident","Wardens Sword","Bisento",
    "Buddy Sword","Canvander","Dark Dagger","Dragonheart","Fox Lamp","Koko",
    "Midnight Blade","Oroshi","Pole (1st Form)","Pole (2nd Form)","Rengoku",
    "Saber","Saishi","Shark Anchor","Shizu","Spikey Trident","Tushita",
    "Yama","Cursed Dual Katana","Dark Blade","Hallow Scythe","True Triple Katana"
}

local quests = {
    ["[Lv.1] Bandit"] = {"BanditQuest1", 1, "First"},
    ["[Lv.10] Monkey"] = {"JungleQuest", 1, "First"},
    ["[Lv.15] Gorilla"] = {"JungleQuest", 2, "First"},
    ["[Lv.25] The Gorilla King [Boss]"] = {"JungleQuest", 3, "First"},
    ["[Lv.30] Pirate"] = {"BuggyQuest1", 1, "First"},
    ["[Lv.40] Brute"] = {"BuggyQuest1", 2, "First"},
    ["[Lv.55] Chef [Boss]"] = {"BuggyQuest1", 3, "First"},
    ["[Lv.60] Desert Bandit"] = {"DesertQuest", 1, "First"},
    ["[Lv.75] Desert Officer"] = {"DesertQuest", 2, "First"},
    ["[Lv.90] Snow Bandit"] = {"SnowQuest", 1, "First"},
    ["[Lv.100] Snowman"] = {"SnowQuest", 2, "First"},
    ["[Lv.110] Yeti [Boss]"] = {"SnowQuest", 3, "First"},
    ["[Lv.120] Chief Petty Officer"] = {"MarineQuest2", 1, "First"},
    ["[Lv.130] Vice Admiral [Boss]"] = {"MarineQuest2", 2, "First"},
    ["[Lv.150] Sky Bandit"] = {"SkyQuest", 1, "First"},
    ["[Lv.175] Dark Master"] = {"SkyQuest", 2, "First"},
    ["[Lv.190] Prisoner"] = {"PrisonerQuest", 1, "First"},
    ["[Lv.210] Dangerous Prisoner"] = {"PrisonerQuest", 2, "First"},
    ["[Lv.220] Warden [Boss]"] = {"ImpelQuest", 1, "First"},
    ["[Lv.230] Chief Warden [Boss]"] = {"ImpelQuest", 2, "First"},
    ["[Lv.240] Swan [Boss]"] = {"ImpelQuest", 3, "First"},
    ["[Lv.250] Toga Warrior"] = {"ColosseumQuest", 1, "First"},
    ["[Lv.275] Gladiator"] = {"ColosseumQuest", 2, "First"},
    ["[Lv.300] Military Soldier"] = {"MagmaQuest", 1, "First"},
    ["[Lv.325] Military Spy"] = {"MagmaQuest", 2, "First"},
    ["[Lv.350] Magma Admiral [Boss]"] = {"MagmaQuest", 3, "First"},
    ["[Lv.375] Fishman Warrior"] = {"FishmanQuest", 1, "First"},
    ["[Lv.400] Fishman Commando"] = {"FishmanQuest", 2, "First"},
    ["[Lv.425] Fishman Lord [Boss]"] = {"FishmanQuest", 3, "First"},
    ["[Lv.450] God's Guard"] = {"SkyExp1Quest", 1, "First"},
    ["[Lv.475] Shanda"] = {"SkyExp1Quest", 2, "First"},
    ["[Lv.500] Wysper [Boss]"] = {"SkyExp1Quest", 3, "First"},
    ["[Lv.525] Royal Squad"] = {"SkyExp2Quest", 1, "First"},
    ["[Lv.550] Royal Soldier"] = {"SkyExp2Quest", 2, "First"},
    ["[Lv.575] Thunder God [Boss]"] = {"SkyExp2Quest", 3, "First"},
    ["[Lv.625] Galley Pirate"] = {"FountainQuest", 1, "First"},
    ["[Lv.650] Galley Captain"] = {"FountainQuest", 2, "First"},
    ["[Lv.675] Cyborg [Boss]"] = {"FountainQuest", 3, "First"},
    ["[Lv.700] Raider"] = {"Area1Quest", 1, "Second"},
    ["[Lv.725] Mercenary"] = {"Area1Quest", 2, "Second"},
    ["[Lv.750] Diamond [Boss]"] = {"Area1Quest", 3, "Second"},
    ["[Lv.775] Swan Pirate"] = {"Area2Quest", 1, "Second"},
    ["[Lv.800] Factory Staff"] = {"Area2Quest", 2, "Second"},
    ["[Lv.850] Jeremy [Boss]"] = {"Area2Quest", 3, "Second"},
    ["[Lv.875] Marine Lieutenant"] = {"MarineQuest3", 1, "Second"},
    ["[Lv.900] Marine Captain"] = {"MarineQuest3", 2, "Second"},
    ["[Lv.925] Fajita [Boss]"] = {"MarineQuest3", 3, "Second"},
    ["[Lv.925] Zombie"] = {"ZombieQuest", 1, "Second"},
    ["[Lv.950] Vampire"] = {"ZombieQuest", 2, "Second"},
    ["[Lv.1000] Snow Trooper"] = {"SnowMountainQuest", 1, "Second"},
    ["[Lv.1025] Winter Warrior"] = {"SnowMountainQuest", 2, "Second"},
    ["[Lv.1100] Lab Subordinate"] = {"IceSideQuest", 1, "Second"},
    ["[Lv.1125] Horned Warrior"] = {"IceSideQuest", 2, "Second"},
    ["[Lv.1100] Smoke Admiral [Boss]"] = {"IceSideQuest", 3, "Second"},
    ["[Lv.1175] Magma Ninja"] = {"FireSideQuest", 1, "Second"},
    ["[Lv.1200] Lava Pirate"] = {"FireSideQuest", 2, "Second"},
    ["[Lv.1250] Ship Officer"] = {"ShipQuest1", 1, "Second"},
    ["[Lv.1275] Ship Steward"] = {"ShipQuest1", 2, "Second"},
    ["[Lv.1300] Ship Engineer"] = {"ShipQuest2", 1, "Second"},
    ["[Lv.1325] Ship Deckhand"] = {"ShipQuest2", 2, "Second"},
    ["[Lv.1350] Arctic Warrior"] = {"FrostQuest", 1, "Second"},
    ["[Lv.1375] Snow Bandit"] = {"FrostQuest", 2, "Second"},
    ["[Lv.1400] Awakened Ice Admiral [Boss]"] = {"FrostQuest", 3, "Second"},
    ["[Lv.1425] Sea Soldier"] = {"ForgottenQuest", 1, "Second"},
    ["[Lv.1450] Water Fighter"] = {"ForgottenQuest", 2, "Second"},
    ["[Lv.1475] Tide Keeper [Boss]"] = {"ForgottenQuest", 3, "Second"},
    ["[Lv.1500] Pirate Billionaire"] = {"PortQuest", 1, "Third"},
    ["[Lv.1525] Pirate Millionaire"] = {"PortQuest", 2, "Third"},
    ["[Lv.1550] Stone [Boss]"] = {"PortQuest", 3, "Third"},
    ["[Lv.1600] Dragon Crew Warrior"] = {"AmazonQuest", 1, "Third"},
    ["[Lv.1625] Dragon Crew Archer"] = {"AmazonQuest", 2, "Third"},
    ["[Lv.1675] Island Empress [Boss]"] = {"AmazonQuest2", 3, "Third"},
    ["[Lv.1700] Female Warrior"] = {"AmazonQuest2", 1, "Third"},
    ["[Lv.1725] Giant Islander"] = {"AmazonQuest2", 2, "Third"},
    ["[Lv.1750] Kilo Admiral [Boss]"] = {"MarineTreeQuest", 3, "Third"},
    ["[Lv.1775] Marine Captain"] = {"MarineTreeQuest", 1, "Third"},
    ["[Lv.1800] Marine Commodore"] = {"MarineTreeQuest", 2, "Third"},
    ["[Lv.1825] Fishman Warrior"] = {"TurtleQuest1", 1, "Third"},
    ["[Lv.1850] Fishman Captain"] = {"TurtleQuest1", 2, "Third"},
    ["[Lv.1875] Captain Elephant [Boss]"] = {"TurtleQuest1", 3, "Third"},
    ["[Lv.1900] Forest Pirate"] = {"TurtleQuest2", 1, "Third"},
    ["[Lv.1925] Mythical Pirate"] = {"TurtleQuest2", 2, "Third"},
    ["[Lv.1950] Beautiful Pirate [Boss]"] = {"TurtleQuest2", 3, "Third"},
    ["[Lv.1975] Jungle Pirate"] = {"MusketeerQuest", 1, "Third"},
    ["[Lv.2000] Musketeer Pirate"] = {"MusketeerQuest", 2, "Third"},
    ["[Lv.2025] Reborn Skeleton"] = {"HauntedQuest1", 1, "Third"},
    ["[Lv.2050] Living Zombie"] = {"HauntedQuest1", 2, "Third"},
    ["[Lv.2100] Demonic Soul"] = {"HauntedQuest2", 1, "Third"},
    ["[Lv.2125] Posessed Mummy"] = {"HauntedQuest2", 2, "Third"},
    ["[Lv.2150] Soul Reaper [Boss]"] = {"HauntedQuest2", 3, "Third"},
    ["[Lv.2150] Peanut Scout"] = {"PeanutQuest", 1, "Third"},
    ["[Lv.2175] Peanut President"] = {"PeanutQuest", 2, "Third"},
    ["[Lv.2200] Ice Cream Chef"] = {"IceCreamQuest", 1, "Third"},
    ["[Lv.2225] Ice Cream Commander"] = {"IceCreamQuest", 2, "Third"},
    ["[Lv.2100] Cake Queen [Boss]"] = {"IceCreamQuest", 3, "Third"},
    ["[Lv.2275] Cookie Crafter"] = {"CakeQuest1", 1, "Third"},
    ["[Lv.2300] Cake Guard"] = {"CakeQuest1", 2, "Third"},
    ["[Lv.2325] Baking Staff"] = {"CakeQuest2", 1, "Third"},
    ["[Lv.2350] Cake Warrior"] = {"CakeQuest2", 2, "Third"},
    ["[Lv.2375] Candy Rebel"] = {"ChocQuest2", 2, "Third"},
    ["[Lv.2400] Candy Pirate"] = {"CandyQuest1", 1, "Third"},
    ["[Lv.2425] Snow Demon"] = {"CandyQuest1", 2, "Third"},
    ["[Lv.2450] Isle Outlaw"] = {"TikiQuest1", 1, "Third"},
}

local request = http_request or request
local getServers

-- // ============================================================== Helpers ============================================================== \\ --
local partCache = setmetatable({}, {__mode = "v"})
local sethiddenproperty = sethiddenproperty or function(...) return ... end
sethiddenproperty(plr, "SimulationRadius", math.huge)

local function getTargetPart(model)
    if partCache[model] and partCache[model].Parent then 
        return partCache[model] 
    end
    
    local head = model:FindFirstChild("Head")
    if head then
        partCache[model] = head
        return head
    end
    
    return nil
end

local function attack(targetModel)
    local targetPart = getTargetPart(targetModel)
    if targetPart then
        NetModule:RemoteEvent("RegisterAttack"):FireServer(1)
        NetModule:RemoteEvent("RegisterHit"):FireServer(targetPart, {})
    end
end

local function attackTRex(targetHrp)
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not hrp or not targetHrp then return end
    local direction = (targetHrp.Position - hrp.Position).Unit
    local tRexFolder = character:FindFirstChild("T-Rex-T-Rex")
    if not tRexFolder then
        local tool = character:FindFirstChildOfClass("Tool")
        if tool and tool.Name:find("T%-Rex") then tRexFolder = tool end
    end
    if not tRexFolder then return end
    local remote = tRexFolder:FindFirstChild("LeftClickRemote")
    if not remote then return end

    remote:FireServer(vector.create(direction.X, direction.Y, direction.Z), 3)
end

local function attackTRexCustom(targetHrp, direction)
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not hrp or not targetHrp then return end
    
    local tRexFolder = character:FindFirstChild("T-Rex-T-Rex")
    if not tRexFolder then
        local tool = character:FindFirstChildOfClass("Tool")
        if tool and tool.Name == "T-Rex-T-Rex" then tRexFolder = tool end
    end
    if not tRexFolder then return end
    
    local remote = tRexFolder:FindFirstChild("LeftClickRemote")
    if not remote then return end
    
    remote:FireServer(vector.create(direction.X, direction.Y, direction.Z), 3)
end

local function attackKitsune(targetHrp)
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not hrp or not targetHrp then return end
    local direction = (targetHrp.Position - hrp.Position).Unit
    local kitsuneFolder = character:FindFirstChild("Kitsune-Kitsune")
    if not kitsuneFolder then
        local tool = character:FindFirstChildOfClass("Tool")
        if tool and tool.Name:find("Kitsune-Kitsune") then kitsuneFolder = tool end
    end
    if not kitsuneFolder then return end
    local remote = kitsuneFolder:FindFirstChild("LeftClickRemote")
    if not remote then return end

    remote:FireServer(vector.create(direction.X, direction.Y, direction.Z), 2, true)
end

local function attackKitsuneCustom(targetHrp, direction)
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not hrp or not targetHrp then return end
    
    local kitsuneFolder = character:FindFirstChild("Kitsune-Kitsune")
    if not kitsuneFolder then
        local tool = character:FindFirstChildOfClass("Tool")
        if tool and tool.Name:find("Kitsune-Kitsune") then kitsuneFolder = tool end
    end
    if not kitsuneFolder then return end
    
    local remote = kitsuneFolder:FindFirstChild("LeftClickRemote")
    if not remote then return end
    
    remote:FireServer(vector.create(direction.X, direction.Y, direction.Z), 4, true)
end

local function isUsingTRexFruit()
    local char = plr.Character
    if not char then return false end
    local tool = char:FindFirstChildOfClass("Tool")
    if tool and tool.Name:find("T%-Rex") then return true end
    local data = plr:FindFirstChild("Data")
    if not data then return false end
    for _, obj in ipairs(data:GetChildren()) do
        if obj:IsA("StringValue") and obj.Value == "T-Rex-T-Rex" then return true end
    end
    return false
end

local function isUsingKitsuneFruit()
    local char = plr.Character
    if not char then return false end
    local tool = char:FindFirstChildOfClass("Tool")
    if tool and tool.Name:find("Kitsune-Kitsune") then return true end
    local data = plr:FindFirstChild("Data")
    if not data then return false end
    for _, obj in ipairs(data:GetChildren()) do
        if obj:IsA("StringValue") and obj.Value == "Kitsune-Kitsune" then return true end
    end
    return false
end

local function isSword(name)
    for _, sword in ipairs(swordList) do
        if name == sword then return true end
    end
    return false
end

-- // ============================================================== Cheets Variables ============================================================== \\ --

local KillAura = { enabled = false, range = 60, speed = 20, switchDelay = 0, targetTypes = {}, circleEnabled = false, spoofWeaponEnabled = false, spoofWeaponType = "Melee", currentTargetIndex = 1, instaKillMode = false }
local Aimbot = { enabled = false, fov = 150, targetType = "Mobs", currentTarget = nil, highlightEnabled = false, highlight = nil }
local FastAttack = { enabled = false, connection = nil, attackDistance = 10, oldAttackSpeed = 1 }
local NoFruitM1 = { enabled = false, connection = nil, defaultSpeed = 0 }
local SwordReach = { enabled = false, rangeX = 50, rangeY = 50, rangeZ = 50, originalSizes = {}, connection = nil }
local Hitboxes = { enabled = false, targetType = "Mobs", rangeX = 10, rangeY = 10, rangeZ = 10, originalSizes = {}, connection = nil }
local ChestFarm = { enabled = false, horizontalSpeed = 200, boostEnabled = false, noclipEnabled = false, bodyVelocity = nil, cachedChests = {}, isBoosting = false, currentTarget = nil }
local Dealer = { enabled = false, spawned = false, position = nil, DEFAULT_POS = Vector3.new(0, -1000, 0) }
local NoSoru = { enabled = false, connection = nil, defaultCooldown = 0 }
local ChestRange = { enabled = false, originalSizes = {} }
local BringMobs = { enabled = false, bossesEnabled = false, range = 300, distance = 40, breakEnabled = true }
local Camera = { enabled = false, x = 0, y = 0, z = 0, fov = 70 }
local KitsuneColor = { enabled = false }
local Dash = { enabled = false, speed = 100 }
local SpeedBoost = { enabled = false, speed = 1 }
local SlyPort = { enabled = false }
local BoatFly = { enabled = false, speed = 1, connection = nil }
local BoatNoclip = { enabled = false }
local SaveEnergy = { enabled = false, connection = nil }
local Unbreakable = { enabled = false, defaultValue = nil }

-- // ============================================================== Combat Tab ============================================================== \\ --

-- ===== Kill Aura =====
local KillAuraBox = Tabs.Combat:AddLeftGroupbox('Kill Aura')

-- circle
KillAura.circleAdornment = Instance.new("CylinderHandleAdornment")
KillAura.circleAdornment.Name = "AuraVisual"
KillAura.circleAdornment.Transparency = 0.3
KillAura.circleAdornment.Color3 = Color3.fromRGB(157, 115, 255)
KillAura.circleAdornment.Height = 0.1
KillAura.circleAdornment.AlwaysOnTop = true
KillAura.circleAdornment.ZIndex = 10
KillAura.circleAdornment.Parent = game:GetService("CoreGui")

local function updateCircle()
    local shouldShow = KillAura.enabled and KillAura.circleEnabled and character and character:FindFirstChild("HumanoidRootPart")
    if shouldShow then
        KillAura.circleAdornment.Adornee = character.HumanoidRootPart
        KillAura.circleAdornment.Radius = KillAura.range
        KillAura.circleAdornment.InnerRadius = KillAura.range - 0.5
        KillAura.circleAdornment.CFrame = CFrame.Angles(math.rad(90), 0, 0) * CFrame.new(0, 0, 3.5)
    else
        KillAura.circleAdornment.Adornee = nil
    end
end

task.spawn(function() while task.wait() do updateCircle() end end)

local function targetsStunned(targets)
    for _, target in ipairs(targets) do
        local stunVal = target:FindFirstChild("Stun")
        if not stunVal or stunVal.Value <= 0 then
            return false
        end
    end
    return #targets > 0
end

KillAuraBox:AddToggle('KillAuraEnabled', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Automatically attack nearby entities',
}):AddKeyPicker('KillAuraKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Kill Aura',
    SyncToggleState = true,
})

KillAuraBox:AddDropdown('KillAuraTargets', {
    Text = 'Targets',
    Values = {'Mobs', 'Players', 'Sea Beasts'},
    Default = {},
    Multi = true,
    Tooltip = 'Select which targets to attack',
})

KillAuraBox:AddSlider('KillAuraRange', {
    Text = 'Aura Range',
    Default = 50,
    Min = 1,
    Max = 500,
    Rounding = 0,
    Suffix = ' studs',
})

KillAuraBox:AddSlider('KillAuraSpeed', {
    Text = 'Attack Speed',
    Default = 20,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Suffix = ' APS',
})

KillAuraBox:AddSlider('KillAuraSwitchDelay', {
    Text = 'Switch Delay',
    Default = 0,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Suffix = 's',
})

KillAuraBox:AddToggle('KillAuraSpoofWeapon', {
    Text = 'Spoof Weapon',
    Default = false,
    Tooltip = 'Attack without holding a weapon',
})

local SpoofDepbox = KillAuraBox:AddDependencyBox()
SpoofDepbox:AddDropdown('KillAuraSpoofType', {
    Text = 'Weapon Type',
    Values = {'Melee', 'Sword', 'Demon Fruit'},
    Default = 1,
    Tooltip = 'Type to spoof as',
})
SpoofDepbox:SetupDependencies({ {Toggles.KillAuraSpoofWeapon, true} })

KillAuraBox:AddToggle('KillAuraVisualCircle', {
    Text = 'Visual Circle',
    Default = false,
    Tooltip = 'Shows the range circle',
})

KillAuraBox:AddToggle('KillAuraInstaKill', {
    Text = 'Insta-Kill',
    Default = false,
    Tooltip = "Conqueror's Haki",
})

Options.KillAuraTargets:OnChanged(function()
    KillAura.targetTypes = Options.KillAuraTargets.Value
end)

Toggles.KillAuraEnabled:OnChanged(function()
    KillAura.enabled = Toggles.KillAuraEnabled.Value
    if KillAura.enabled then
        task.spawn(function()
            local enemiesFolder = workspace:FindFirstChild("Enemies")
            local charactersFolder = workspace:FindFirstChild("Characters")
            local seaBeastsFolder = workspace:FindFirstChild("SeaBeasts")
            local lastTargetScan = 0
            local cachedTargets = {}

            while KillAura.enabled do
                local startTime = os.clock()
                local delayTime = math.max(KillAura.switchDelay, 1 / math.max(KillAura.speed, 1))
                local char = plr.Character

                if char then
                    local hum = char:FindFirstChild("Humanoid")
                    local hrp = char:FindFirstChild("HumanoidRootPart")

                    if hum and hum.Health > 0 and hrp then
                        if KillAura.instaKillMode then
                            if startTime - lastTargetScan > 0.1 then
                                if KillAura.targetTypes and KillAura.targetTypes.Mobs and enemiesFolder then
                                    for _, target in ipairs(enemiesFolder:GetChildren()) do
                                        if target.Name == "Terrorshark" then
                                            continue
                                        end
                                        
                                        local targetHum = target:FindFirstChildOfClass("Humanoid")
                                        local targetTorso = target:FindFirstChild("UpperTorso")
                                        if targetHum and targetHum.Health > 0 then
                                            local targetHrp = target:FindFirstChild("HumanoidRootPart")
                                            if targetHrp and (hrp.Position - targetHrp.Position).Magnitude < 1000 then
                                                targetTorso:Destroy()
                                                targetHum.Health = -25000
                                                targetHum.MaxHealth = -25000
                                                targetHum.HipHeight = 4
                                                targetHum:ChangeState(5)
                                            end
                                        end
                                    end
                                end
                                
                                lastTargetScan = startTime
                            end
                        else
                            local currentTool = char:FindFirstChildOfClass("Tool")

                            local hasTRexTool = currentTool and currentTool.Name == "T-Rex-T-Rex"
                            local usingTRex = hasTRexTool and isUsingTRexFruit()

                            local hasKitsuneTool = currentTool and currentTool.Name == "Kitsune-Kitsune"
                            local usingKitsune = hasKitsuneTool and isUsingKitsuneFruit()

                            local canAttackNormally = (not (usingTRex or usingKitsune)) and (KillAura.spoofWeaponEnabled or (currentTool and currentTool.ToolTip ~= "Gun"))

                            if usingTRex or usingKitsune or canAttackNormally then
                                if startTime - lastTargetScan > 0.3 then
                                    cachedTargets = {}
                                    
                                    local function scanFolder(folder, skipSelf)
                                        if not folder then return end
                                        for _, target in ipairs(folder:GetChildren()) do
                                            if skipSelf and target == char then continue end
                                            local targetHrp = target:FindFirstChild("HumanoidRootPart")
                                            local targetHum = target:FindFirstChild("Humanoid")
                                            if targetHrp and targetHum and targetHum.Health > 0 then
                                                if (hrp.Position - targetHrp.Position).Magnitude < KillAura.range then
                                                    table.insert(cachedTargets, target)
                                                end
                                            end
                                        end
                                    end
                                    
                                    if KillAura.targetTypes then
                                        if KillAura.targetTypes.Mobs then
                                            scanFolder(enemiesFolder, false)
                                        end
                                        
                                        if KillAura.targetTypes.Players then
                                            scanFolder(charactersFolder, true)
                                        end
                                    end
                                    
                                    if KillAura.targetTypes and KillAura.targetTypes['Sea Beasts'] and seaBeastsFolder and (usingTRex or usingKitsune) then
                                        for _, beast in ipairs(seaBeastsFolder:GetChildren()) do
                                            if beast:IsA("Model") and beast.Name:sub(1, 8) == "SeaBeast" then
                                                local beastHrp = beast:FindFirstChild("HumanoidRootPart")
                                                if beastHrp then
                                                    table.insert(cachedTargets, beast)
                                                end
                                            end
                                        end
                                    end
                                    
                                    lastTargetScan = startTime
                                end

                                if #cachedTargets > 0 then
                                    if KillAura.currentTargetIndex > #cachedTargets then KillAura.currentTargetIndex = 1 end
                                    local target = cachedTargets[KillAura.currentTargetIndex]
                                    local targetHrp = target:FindFirstChild("HumanoidRootPart")
                                    
                                    local isSeaBeast = target.Name:sub(1, 8) == "SeaBeast"

                                    if targetHrp then
                                        if isSeaBeast then
                                            if usingKitsune then
                                                attackKitsune(targetHrp)
                                            elseif usingTRex then
                                                attackTRex(targetHrp)
                                            end
                                        elseif targetsStunned(cachedTargets) then
                                            if usingTRex then
                                                attackTRexCustom(targetHrp, Vector3.new(0, -1, 0))
                                            elseif usingKitsune then
                                                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                                                if hrp and targetHrp then
                                                    local directionToPlayer = (hrp.Position - targetHrp.Position).Unit
                                                    attackKitsuneCustom(targetHrp, directionToPlayer)
                                                end
                                            elseif canAttackNormally then
                                                attack(target)
                                            end
                                        else
                                            if usingKitsune then
                                                attackKitsune(targetHrp)
                                            elseif usingTRex then
                                                attackTRex(targetHrp)
                                            elseif canAttackNormally then
                                                attack(target)
                                            end
                                        end
                                    elseif canAttackNormally then
                                        attack(target)
                                    end

                                    KillAura.currentTargetIndex = KillAura.currentTargetIndex + 1
                                end
                            end
                        end
                    end
                end

                task.wait(delayTime)
            end
        end)
    end
end)

Options.KillAuraRange:OnChanged(function() KillAura.range = Options.KillAuraRange.Value end)
Options.KillAuraSpeed:OnChanged(function() KillAura.speed = Options.KillAuraSpeed.Value end)
Options.KillAuraSwitchDelay:OnChanged(function() KillAura.switchDelay = Options.KillAuraSwitchDelay.Value end)
Toggles.KillAuraSpoofWeapon:OnChanged(function() KillAura.spoofWeaponEnabled = Toggles.KillAuraSpoofWeapon.Value end)
Options.KillAuraSpoofType:OnChanged(function() KillAura.spoofWeaponType = Options.KillAuraSpoofType.Value end)
Toggles.KillAuraVisualCircle:OnChanged(function() KillAura.circleEnabled = Toggles.KillAuraVisualCircle.Value end)
Toggles.KillAuraInstaKill:OnChanged(function() KillAura.instaKillMode = Toggles.KillAuraInstaKill.Value end)

-- ===== Aimbot =====
local AimbotBox = Tabs.Combat:AddRightGroupbox('Aimbot')

Aimbot.circle = Drawing.new("Circle")
Aimbot.circle.Visible = false
Aimbot.circle.Thickness = 1.5
Aimbot.circle.Color = Color3.fromRGB(255, 255, 255)
Aimbot.circle.Transparency = 1
Aimbot.circle.Filled = false
Aimbot.circle.NumSides = 200
Aimbot.circle.Radius = Aimbot.fov
Aimbot.camera = workspace.CurrentCamera

local function getMouseScreenPos() return UserInputService:GetMouseLocation() end

local function worldToScreen(pos)
    local sp, onScreen = Aimbot.camera:WorldToViewportPoint(pos)
    return Vector2.new(sp.X, sp.Y), onScreen, sp.Z
end

local function getBestTarget()
    local mousePos = getMouseScreenPos()
    local bestTarget, bestDist = nil, math.huge
    local folders = {}
    
    if Aimbot.targetType == "Players" then
        folders = {workspace:FindFirstChild("Characters")}
    elseif Aimbot.targetType == "Mobs" then
        folders = {workspace:FindFirstChild("Enemies")}
    elseif Aimbot.targetType == "Both" then
        folders = {workspace:FindFirstChild("Enemies"), workspace:FindFirstChild("Characters")}
    end
    
    for _, folder in ipairs(folders) do
        if not folder then continue end
        for _, target in ipairs(folder:GetChildren()) do
            local hrp = target:FindFirstChild("HumanoidRootPart")
            local hum = target:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health > 0 and target ~= plr.Character then
                local screenPos, onScreen, depth = worldToScreen(hrp.Position)
                if onScreen and depth > 0 then
                    local distToCursor = (screenPos - mousePos).Magnitude
                    if distToCursor <= Aimbot.fov then
                        local distToPlayer = plr:DistanceFromCharacter(hrp.Position)
                        if distToPlayer < bestDist then
                            bestDist = distToPlayer
                            bestTarget = hrp
                        end
                    end
                end
            end
        end
    end
    return bestTarget
end

local function clearHighlight()
    if Aimbot.highlight and Aimbot.highlight.Parent then 
        Aimbot.highlight:Destroy() 
    end
    Aimbot.highlight = nil
end

local function applyHighlight(target)
    local model = target and target.Parent
    if not model then return end
    clearHighlight()
    local existing = model:FindFirstChildOfClass("Highlight")
    if existing then existing:Destroy() end
    local hl = Instance.new("Highlight")
    hl.FillColor = Color3.fromRGB(255, 0, 0)
    hl.OutlineColor = Color3.fromRGB(255, 0, 0)
    hl.FillTransparency = 0.5
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = model
    Aimbot.highlight = hl
end

task.spawn(function()
    local gg = getrawmetatable(game)
    local old = gg.__namecall
    setreadonly(gg, false)
    gg.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if Aimbot.enabled and Aimbot.currentTarget and (method == "FireServer" or method == "InvokeServer") then
            local args = table.pack(...)
            local modified = false
            for i = 1, args.n do
                if typeof(args[i]) == "Vector3" then
                    args[i] = Aimbot.currentTarget.Position
                    modified = true
                elseif typeof(args[i]) == "CFrame" then
                    local orig = args[i]
                    args[i] = CFrame.new(Aimbot.currentTarget.Position) * (orig - orig.Position)
                    modified = true
                end
            end
            if modified then return old(self, table.unpack(args, 1, args.n)) end
        end
        return old(self, ...)
    end)
    setreadonly(gg, true)
end)

task.spawn(function()
    local lastTarget = nil
    local lastUpdate = 0
    
    while task.wait() do
        local mousePos = getMouseScreenPos()
        
        if Aimbot.enabled then
            Aimbot.circle.Visible = true
            Aimbot.circle.Position = mousePos
            Aimbot.circle.Radius = Aimbot.fov
            
            local currentTime = tick()
            if currentTime - lastUpdate > 0.1 then
                local target = getBestTarget()
                if target then
                    local screenPos, onScreen = worldToScreen(target.Position)
                    if onScreen then
                        Aimbot.currentTarget = target
                        if Aimbot.highlightEnabled and target ~= lastTarget then
                            applyHighlight(target)
                            lastTarget = target
                        end
                    else
                        Aimbot.currentTarget = nil
                    end
                else
                    Aimbot.currentTarget = nil
                    if lastTarget ~= nil then 
                        clearHighlight() 
                        lastTarget = nil 
                    end
                end
                lastUpdate = currentTime
            end
        else
            Aimbot.circle.Visible = false
            Aimbot.currentTarget = nil
            clearHighlight()
            lastTarget = nil
        end
        
        if not Aimbot.highlightEnabled then 
            clearHighlight() 
            lastTarget = nil 
        end
    end
end)

AimbotBox:AddToggle('AimbotEnabled', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Silently aims at entities (only for skills tho)',
}):AddKeyPicker('AimbotKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Aimbot',
    SyncToggleState = true,
})

AimbotBox:AddLabel('FOV Color'):AddColorPicker('AimbotFOVColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'FOV Circle Color',
    Transparency = 0,
})

Options.AimbotFOVColor:OnChanged(function()
    Aimbot.circle.Color = Options.AimbotFOVColor.Value
end)

AimbotBox:AddDropdown('AimbotTargets', {
    Text = 'Targets',
    Values = {'Mobs', 'Players', 'Both'},
    Default = 1,
    Tooltip = 'Who to target',
})

AimbotBox:AddSlider('AimbotFOV', {
    Text = 'FOV Size',
    Default = 150,
    Min = 10,
    Max = 800,
    Rounding = 0,
    Suffix = ' px',
})

AimbotBox:AddToggle('AimbotHighlight', {
    Text = 'Highlight Target',
    Default = false,
    Tooltip = 'Highlight the current aimbot target',
})

-- callbacks
Toggles.AimbotEnabled:OnChanged(function() 
    Aimbot.enabled = Toggles.AimbotEnabled.Value
    if not Aimbot.enabled then
        Aimbot.currentTarget = nil
        clearHighlight()
    end
end)

Options.AimbotTargets:OnChanged(function() 
    Aimbot.targetType = Options.AimbotTargets.Value 
end)

Options.AimbotFOV:OnChanged(function() 
    Aimbot.fov = Options.AimbotFOV.Value 
    Aimbot.circle.Radius = Aimbot.fov
end)

Toggles.AimbotHighlight:OnChanged(function()
    Aimbot.highlightEnabled = Toggles.AimbotHighlight.Value
    if not Aimbot.highlightEnabled then 
        clearHighlight() 
    end
end)

-- ===== Fast Attack =====
local FastAttackBox = Tabs.Combat:AddLeftGroupbox('Fast Attack')

FastAttackBox:AddToggle('FastAttack', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Attack faster',
}):AddKeyPicker('FastAttackKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Fast Attack',
    SyncToggleState = true,
})

Toggles.FastAttack:OnChanged(function()
    FastAttack.enabled = Toggles.FastAttack.Value
    if FastAttack.enabled then
        if character then FastAttack.oldAttackSpeed = character:GetAttribute("AttackSpeedMultiplier") or 1 end
        FastAttack.connection = RunService.Stepped:Connect(function()
            if not FastAttack.enabled then
                if FastAttack.connection then FastAttack.connection:Disconnect() end
                return
            end
            character:SetAttribute("AttackSpeedMultiplier", 3)
            if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                if not (character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0) then return end
                local tool = character:FindFirstChildOfClass("Tool")
                if tool and tool.ToolTip ~= "Gun" then
                    local nearest, nearestDist = nil, math.huge
                    for _, folder in pairs({workspace.Enemies, workspace.Characters}) do
                        for _, enemy in pairs(folder:GetChildren()) do
                            local hrp = enemy:FindFirstChild("HumanoidRootPart")
                            local hum = enemy:FindFirstChild("Humanoid")
                            if hrp and hum and hum.Health > 0 and enemy ~= character then
                                local dist = plr:DistanceFromCharacter(hrp.Position)
                                if dist < FastAttack.attackDistance and dist < nearestDist then
                                    nearestDist = dist
                                    nearest = enemy
                                end
                            end
                        end
                    end
                    if nearest then
                        pcall(function()
                            NetModule:RemoteEvent("RegisterAttack"):FireServer(0)
                            NetModule:RemoteEvent("RegisterHit"):FireServer(getTargetPart(nearest), {})
                        end)
                    end
                end
            end
        end)
    else
        if FastAttack.connection then FastAttack.connection:Disconnect() FastAttack.connection = nil end
        if character then character:SetAttribute("AttackSpeedMultiplier", FastAttack.oldAttackSpeed) end
    end
end)

-- ===== No Fruit M1 Cooldown =====
local NoFruitM1Box = Tabs.Combat:AddRightGroupbox('No Fruit M1 Cooldown')

NoFruitM1Box:AddToggle('NoFruitM1', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Removes fruit M1 attack cooldown',
}):AddKeyPicker('NoFruitM1Keybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'No Fruit M1 Cooldown',
    SyncToggleState = true,
})

Toggles.NoFruitM1:OnChanged(function()
    NoFruitM1.enabled = Toggles.NoFruitM1.Value
    if NoFruitM1.enabled then
        if character2 then
            local val = character2:GetAttribute("FruitTAPCooldown")
            if val then NoFruitM1.defaultSpeed = val end
        end
        NoFruitM1.connection = RunService.Heartbeat:Connect(function()
            if not NoFruitM1.enabled then if NoFruitM1.connection then NoFruitM1.connection:Disconnect() end return end
            local c2 = charFolder:FindFirstChild(plr.Name)
            if c2 then c2:SetAttribute("FruitTAPCooldown", 1) end
        end)
    else
        if NoFruitM1.connection then NoFruitM1.connection:Disconnect() NoFruitM1.connection = nil end
        if character2 then character2:SetAttribute("FruitTAPCooldown", NoFruitM1.defaultSpeed) end
    end
end)

-- ===== Sword Reach =====
local SwordReachBox = Tabs.Combat:AddLeftGroupbox('Sword Reach')

SwordReachBox:AddToggle('SwordReach', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Extend sword hitboxes',
}):AddKeyPicker('SwordReachKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Sword Reach',
    SyncToggleState = true,
})

SwordReachBox:AddSlider('SwordReachX', { Text = 'X Reach', Default = 50, Min = 1, Max = 100, Rounding = 0 })
SwordReachBox:AddSlider('SwordReachY', { Text = 'Y Reach', Default = 50, Min = 1, Max = 100, Rounding = 0 })
SwordReachBox:AddSlider('SwordReachZ', { Text = 'Z Reach', Default = 50, Min = 1, Max = 100, Rounding = 0 })

Toggles.SwordReach:OnChanged(function()
    SwordReach.enabled = Toggles.SwordReach.Value
    if not SwordReach.enabled then
        for part, size in pairs(SwordReach.originalSizes) do
            if part and part.Parent then part.Size = size end
        end
        SwordReach.originalSizes = {}
        if SwordReach.connection then SwordReach.connection:Disconnect() end
    else
        SwordReach.connection = RunService.Heartbeat:Connect(function()
            if not SwordReach.enabled then return end
            local tool = character:FindFirstChildOfClass("Tool")
            if tool and isSword(tool.Name) then
                local weaponModel = character:FindFirstChild("EquippedWeapon")
                if weaponModel then
                    for _, part in ipairs(weaponModel:GetDescendants()) do
                        if part.Name == "Handle" and part:IsA("BasePart") then
                            if not SwordReach.originalSizes[part] then SwordReach.originalSizes[part] = part.Size end
                            part.Size = Vector3.new(SwordReach.rangeX, SwordReach.rangeY, SwordReach.rangeZ)
                            part.CanCollide = false
                            part.Massless = true
                        end
                    end
                end
            end
        end)
    end
end)
Options.SwordReachX:OnChanged(function() SwordReach.rangeX = Options.SwordReachX.Value end)
Options.SwordReachY:OnChanged(function() SwordReach.rangeY = Options.SwordReachY.Value end)
Options.SwordReachZ:OnChanged(function() SwordReach.rangeZ = Options.SwordReachZ.Value end)

-- ===== Hitboxes =====
local IncreaseHitboxBox = Tabs.Combat:AddRightGroupbox('Hitboxes')

IncreaseHitboxBox:AddToggle('IncreaseHitbox', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Increase hitboxes',
}):AddKeyPicker('IncreaseHitboxKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Increase Hitbox',
    SyncToggleState = true,
})

IncreaseHitboxBox:AddDropdown('HitboxTargets', {
    Text = 'Targets',
    Values = {'Mobs', 'Players', 'Both'},
    Default = 1,
})
IncreaseHitboxBox:AddSlider('HitboxX', { Text = 'X Size', Default = 10, Min = 1, Max = 100, Rounding = 0 })
IncreaseHitboxBox:AddSlider('HitboxY', { Text = 'Y Size', Default = 10, Min = 1, Max = 100, Rounding = 0 })
IncreaseHitboxBox:AddSlider('HitboxZ', { Text = 'Z Size', Default = 10, Min = 1, Max = 100, Rounding = 0 })

Toggles.IncreaseHitbox:OnChanged(function()
    Hitboxes.enabled = Toggles.IncreaseHitbox.Value
    if Hitboxes.enabled then
        Hitboxes.connection = RunService.Heartbeat:Connect(function()
            if not Hitboxes.enabled then return end
            local folders = Hitboxes.targetType == "Players" and {workspace.Characters}
                or Hitboxes.targetType == "Mobs" and {workspace.Enemies}
                or {workspace.Enemies, workspace.Characters}
            for _, folder in ipairs(folders) do
                for _, target in ipairs(folder:GetChildren()) do
                    local head = target:FindFirstChild("Head")
                    if head and target ~= plr.Character then
                        if not Hitboxes.originalSizes[head] then 
                            Hitboxes.originalSizes[head] = head.Size 
                        end
                        head.Size = Vector3.new(Hitboxes.rangeX, Hitboxes.rangeY, Hitboxes.rangeZ)
                        head.CanCollide = false
                        head.Massless = true
                        head.Transparency = 0.5
                    end
                end
            end
        end)
    else
        if Hitboxes.connection then Hitboxes.connection:Disconnect() Hitboxes.connection = nil end
        for head, size in pairs(Hitboxes.originalSizes) do
            if head and head.Parent then 
                head.Size = size
                head.CanCollide = true
                head.Massless = false
            end
        end
        Hitboxes.originalSizes = {}
    end
end)
Options.HitboxTargets:OnChanged(function() Hitboxes.targetType = Options.HitboxTargets.Value end)
Options.HitboxX:OnChanged(function() Hitboxes.rangeX = Options.HitboxX.Value end)
Options.HitboxY:OnChanged(function() Hitboxes.rangeY = Options.HitboxY.Value end)
Options.HitboxZ:OnChanged(function() Hitboxes.rangeZ = Options.HitboxZ.Value end)

-- // ============================================================== Farming Tab ============================================================== \\ --
local ChestFarmBox = Tabs.Farming:AddLeftGroupbox('Chest Farm')

local function getHRP()
    return (game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"))
end

local function loadChests()
    local rs = game:GetService("ReplicatedStorage")
    local unloaded = rs:FindFirstChild("Unloaded")
    local map = workspace:FindFirstChild("Map")
    
    if not unloaded or not map then return end
    
    for _, item in ipairs(unloaded:GetDescendants()) do
        if item:IsA("BasePart") and item.Name:find("Chest") then
            item.Parent = map
            item.CanTouch = true
            item.CanCollide = true
        end
    end
end

local function getChests()
    local found = {}
    local map = workspace:FindFirstChild("Map")
    if not map then return found end

    for _, desc in ipairs(map:GetDescendants()) do
        if desc:IsA("BasePart") and desc.Name:find("Chest") then
            if desc:FindFirstChildWhichIsA("TouchTransmitter") then
                table.insert(found, desc)
            end
        end
    end
    return found
end

ChestFarmBox:AddToggle('ChestFarmEnabled', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Farms Beli by collecting chests',
})

Toggles.ChestFarmEnabled:OnChanged(function()
    ChestFarm.enabled = Toggles.ChestFarmEnabled.Value
    
    if ChestFarm.enabled then
        ChestFarm.lastTeamSwitch = tick()
        
        task.spawn(function()
            while ChestFarm.enabled do
                local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart", 5)
                
                if not hrp then task.wait() continue end
                
                loadChests()

                if tick() - ChestFarm.lastTeamSwitch >= 6 then
                    local oldChar = char
                    local newTeam = (game.Players.LocalPlayer.Team and game.Players.LocalPlayer.Team.Name == "Marines") and "Pirates" or "Marines"
                    
                    pcall(function() CommF:InvokeServer("SetTeam", newTeam) end)
                    ChestFarm.lastTeamSwitch = tick()

                    task.delay(0.5, function()
                        if game.Players.LocalPlayer.Character == oldChar then
                            local hum = oldChar:FindFirstChildOfClass("Humanoid")
                            if hum and hum.Health > 0 then hum.Health = 0 end
                        end
                    end)
                    
                    game.Players.LocalPlayer.CharacterAdded:Wait()
                    continue 
                end

                local chests = getChests()
                local target = nil
                local minDist = math.huge

                for _, chest in ipairs(chests) do
                    local d = (hrp.Position - chest.Position).Magnitude
                    if d < minDist then
                        minDist = d
                        target = chest
                    end
                end

                if target and target.Parent then
                    local collecting = true
                    task.spawn(function()
                        while collecting and target.Parent and ChestFarm.enabled and game.Players.LocalPlayer.Character == char do
                            firetouchinterest(hrp, target, 0)
                            firetouchinterest(hrp, target, 1)

                            task.wait(0.05)
                        end
                    end)

                    while target.Parent and target:FindFirstChildWhichIsA("TouchTransmitter") and ChestFarm.enabled and game.Players.LocalPlayer.Character == char do
                        hrp.CFrame = target.CFrame
                        task.wait(0.1)
                    end
                    
                    collecting = false
                else
                    task.wait(0.1)
                end
            end
        end)
    end
end)

-- ===== Legendary Sword Dealer Detector =====
local DealerBox = Tabs.Farming:AddLeftGroupbox('Legendary Sword Dealer Detector')

local function checkDealer()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace = game:GetService("Workspace")
    
    local npcsFolder = Workspace:FindFirstChild("NPCs")
    local dealerInWorkspace = npcsFolder and npcsFolder:FindFirstChild("Legendary Sword Dealer")
    
    if dealerInWorkspace then
        local hrp = dealerInWorkspace:FindFirstChild("HumanoidRootPart")
        if hrp then
            Dealer.position = hrp.Position
            return true, "workspace"
        end
        return true, "workspace"
    end
    
    local drugDealer = ReplicatedStorage:FindFirstChild("NPCs") and 
                               ReplicatedStorage.NPCs:FindFirstChild("Legendary Sword Dealer")
    
    if drugDealer then
        local hrp = drugDealer:FindFirstChild("HumanoidRootPart")
        if hrp then
            local isDefault = (hrp.Position - Dealer.DEFAULT_POS).Magnitude < 0.1
            if not isDefault then
                Dealer.position = hrp.Position
                return true, "replicated"
            end
        end
    end
    
    Dealer.position = nil
    return false, "unknown"
end

local statusLabel = DealerBox:AddLabel("Status: Disabled")

DealerBox:AddToggle('DealerDetector', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Get notified when the Legendary Sword Dealer spawns',
})

Toggles.DealerDetector:OnChanged(function()
    Dealer.enabled = Toggles.DealerDetector.Value
    
    if Dealer.enabled then
        statusLabel:SetText("Status: Checking...")
        local spawned = checkDealer()
        if spawned then
            Dealer.spawned = true
            if Dealer.position then
                local distance = plr:DistanceFromCharacter(Dealer.position)
                statusLabel:SetText(string.format('Status: SPAWNED! (%.1fm)', distance))
            else
                statusLabel:SetText("Status: SPAWNED!")
            end
        end
    else
        statusLabel:SetText("Status: Disabled")
        Dealer.spawned = false
        Dealer.position = nil
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        
        if Dealer.enabled then
            local spawned = checkDealer()
            
            if spawned and not Dealer.spawned then
                Dealer.spawned = true
                
                if Dealer.position then
                    local distance = plr:DistanceFromCharacter(Dealer.position)
                    statusLabel:SetText(string.format('Status: SPAWNED! (%.1fm)', distance))
                else
                    statusLabel:SetText("Status: SPAWNED!")
                end
                
                for i = 1, 20 do
                    Library:Notify("[LSDDetector] >> The Dealer has spawned!", 15)
                end
                
            elseif not spawned and Dealer.spawned then
                Dealer.spawned = false
                Dealer.position = nil
                statusLabel:SetText("Status: Checking...")
                Library:Notify("[LSDDetector] >> The Dealer has despawned :(", 15)
                
            elseif spawned and Dealer.spawned and Dealer.position then
                local distance = plr:DistanceFromCharacter(Dealer.position)
                statusLabel:SetText(string.format('Status: SPAWNED! (%.1fm)', distance))
            end
        end
    end
end)

DealerBox:AddButton({
    Text = 'Check',
    Func = function()
        local spawned = checkDealer()
        if spawned and Dealer.position then
            local distance = plr:DistanceFromCharacter(Dealer.position)
            Library:Notify(string.format("[LSDDetector] >> The Dealer has spawned! (%.1fm)", distance), 5)
        elseif spawned then
            Library:Notify("[LSDDetector] >> The Dealer has spawned!", 15)
        else
            Library:Notify("[LSDDetector] >> The Dealer hasn't spawned", 10)
        end
    end,
})

-- ===== Bring Mobs =====
local BringMobsBox = Tabs.Farming:AddRightGroupbox('Bring Mobs')

BringMobsBox:AddToggle('BringMobs', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Pull nearby mobs to you',
}):AddKeyPicker('BringMobsKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Bring Mobs',
    SyncToggleState = true,
})

local BringBossesDepbox = BringMobsBox:AddDependencyBox()
BringBossesDepbox:AddToggle('BringBosses', {
    Text = 'Bring Bosses',
    Default = false,
    Tooltip = 'Also bring Bosses',
})

BringMobsBox:AddSlider('BringRange', {
    Text = 'Bring Range',
    Default = 6,
    Min = 1,
    Max = 800,
    Rounding = 1,
    Suffix = ' studs',
})

BringMobsBox:AddSlider('BringDistance', {
    Text = 'Bring Distance',
    Default = 6,
    Min = -20,
    Max = 60,
    Rounding = 1,
    Suffix = ' studs',
})

BringMobsBox:AddToggle('BreakMobs', {
    Text = 'Break Mobs',
    Default = false,
    Tooltip = "Breaks the mobs by removing their humanoid.",
})

Toggles.BringMobs:OnChanged(function() BringMobs.enabled = Toggles.BringMobs.Value end)
Toggles.BringBosses:OnChanged(function() BringMobs.bossesEnabled = Toggles.BringBosses.Value end)
Options.BringDistance:OnChanged(function() BringMobs.distance = Options.BringDistance.Value end)
Options.BringRange:OnChanged(function() BringMobs.range = Options.BringRange.Value end)
Toggles.BreakMobs:OnChanged(function() BringMobs.breakEnabled = Toggles.BreakMobs.Value end)

local activeMobs = {}

task.spawn(function()
    while task.wait() do
        if BringMobs.enabled and character and character:FindFirstChild("HumanoidRootPart") then
            local root = character.HumanoidRootPart
            local enemies = workspace.Enemies or game:GetService("Workspace"):FindFirstChild("Enemies")
            
            if enemies then
                for _, mob in pairs(enemies:GetChildren()) do
                    pcall(function()
                        local mRoot = mob:FindFirstChild("HumanoidRootPart")
                        local mHum = mob:FindFirstChild("Humanoid")
                        
                        if mRoot and (BringMobs.breakEnabled or (mHum and mHum.Health > 0)) then
                            local distToPlayer = (mRoot.Position - root.Position).Magnitude
                            
                            if distToPlayer <= BringMobs.range then
                                local isBoss = mob:GetAttribute("IsBoss") == true
                                
                                if not isBoss or BringMobs.bossesEnabled then
                                    local targetPos = root.Position + (root.CFrame.LookVector * BringMobs.distance)
                                    
                                    if BringMobs.breakEnabled and mHum then
                                        mHum:Destroy()
                                    end
                                    
                                    mRoot.CFrame = CFrame.new(targetPos)
                                    mRoot.AssemblyLinearVelocity = Vector3.zero
                                    mRoot.AssemblyAngularVelocity = Vector3.zero
                                end
                            end
                        end
                    end)
                end
            end
        end
        task.wait()
    end
end)

-- ===== Quests =====
local QuestBox = Tabs.Farming:AddRightGroupbox('Quests')

local currentSeaQuests = {}
for name, data in pairs(quests) do
    if (First_Sea and data[3] == "First") or (Second_Sea and data[3] == "Second") or (Third_Sea and data[3] == "Third") then
        currentSeaQuests[name] = data
    end
end

local questList = {}
for name in pairs(currentSeaQuests) do table.insert(questList, name) end
table.sort(questList, function(a, b)
    return (tonumber(a:match("%d+")) or 0) < (tonumber(b:match("%d+")) or 0)
end)

local selectedQuestData = nil
QuestBox:AddDropdown('QuestSelect', {
    Text = 'Select Quest',
    Values = questList,
    Default = 1,
    Tooltip = 'Choose a quest to start',
})
Options.QuestSelect:OnChanged(function() selectedQuestData = currentSeaQuests[Options.QuestSelect.Value] end)
selectedQuestData = currentSeaQuests[questList[1]]

QuestBox:AddButton({
    Text = 'Start Quest',
    Tooltip = 'Accept selected quest',
    Func = function()
        if selectedQuestData then
            CommF:InvokeServer("StartQuest", selectedQuestData[1], selectedQuestData[2])
            Library:Notify("Started Quest!", 5)
        else
            Library:Notify("Select a quest first!", 5)
        end
    end,
})

-- // ============================================================== Visuals Tab ============================================================== \\ --
local CameraBox = Tabs.Visuals:AddLeftGroupbox('Camera')
local camEnabled = false
local colorCorrectionObjects = {"GlobalColorCorrection", "RainCorrection", "SubmergedColorCorrection", "SeaTerrorCC"}

CameraBox:AddToggle('Camera', {
    Text = 'Enabled',
    Default = false,
    Tooltip = "Modifies your camera's behavior",
}):AddKeyPicker('CameraKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Camera',
    SyncToggleState = true,
})

CameraBox:AddToggle('DisableColorCorrection', {
    Text = 'Disable Color Correction',
    Default = false,
    Tooltip = 'Disables color correction?'
})

CameraBox:AddToggle('RevertSky', {
    Text = 'Old Skybox',
    Default = false,
    Tooltip = "Revert to Roblox's old skybox (also removes fog for some reason)"
})

task.spawn(function()
    while true do
        task.wait()
        
        -- color correction
        local colorCorrectionEnabled = Toggles.Camera.Value and Toggles.DisableColorCorrection.Value
        
        for _, ccName in ipairs(colorCorrectionObjects) do
            local cc = LightingService:FindFirstChild(ccName)
            if cc then
                if colorCorrectionEnabled then
                    if cc.Parent ~= workspace then
                        cc.Parent = workspace
                    end
                else
                    if cc.Parent ~= LightingService then
                        cc.Parent = LightingService
                    end
                end
            end
        end
        
        -- old skybox
        local skyEnabled = Toggles.Camera.Value and Toggles.RevertSky.Value
        local sky = LightingService:FindFirstChild("Sky") or workspace:FindFirstChild("Sky")
        local fantasySky = LightingService:FindFirstChild("FantasySky") or workspace:FindFirstChild("FantasySky")
        
        for _, skyObj in ipairs({sky, fantasySky}) do
            if skyObj then
                if skyEnabled then
                    if skyObj.Parent ~= workspace then
                        skyObj.Parent = workspace
                    end
                else
                    if skyObj.Parent ~= LightingService then
                        skyObj.Parent = LightingService
                    end
                end
            end
        end
    end
end)

local FullbrightBox = Tabs.Visuals:AddRightGroupbox('Fullbright')
local originalBrightness = LightingService.Brightness

FullbrightBox:AddToggle('Fullbright', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Brights up the game to see better',
}):AddKeyPicker('FBKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Fullbright',
    SyncToggleState = true,
})

FullbrightBox:AddSlider('BrightnessSlider', {
    Text = 'Brightness',
    Default = 4,
    Min = 0,
    Max = 5,
    Rounding = 0,
})

task.spawn(function()
    while true do
        local fullbrightEnabled = Toggles.Fullbright.Value
        local targetBrightness = Options.BrightnessSlider.Value
        
        if fullbrightEnabled then
            if LightingService.Brightness ~= targetBrightness then
                LightingService.Brightness = targetBrightness
            end
        else
            if LightingService.Brightness ~= originalBrightness then
                LightingService.Brightness = originalBrightness
            end
        end
        
        task.wait()
    end
end)

task.spawn(function()
    while true do
        if not Toggles.Fullbright.Value then
            originalBrightness = LightingService.Brightness
        end
        task.wait(1)
    end
end)

-- ===== Fruit Skins =====
local FruitSkinsBox = Tabs.Visuals:AddLeftGroupbox('Fruit Skins')
local kitsuneColorEnabled = false
local portalColorEnabled = false
local diamondColorEnabled = false
local rumbleColorEnabled = false
local originalKitsuneColor = nil
local originalPortalColors = {}
local originalDiamondColors = {}
local originalRumbleColors = {}

FruitSkinsBox:AddToggle('KitsuneColor', {
    Text = 'Kitsune Color',
    Default = false,
    Tooltip = "Changes the Kitsune Fruit's Color",
})

local KitsuneDepbox = FruitSkinsBox:AddDependencyBox()
KitsuneDepbox:AddLabel('Color'):AddColorPicker('KitsuneColorPicker', {
    Default = Color3.fromRGB(150, 0, 0),
    Title = 'Kitsune Color',
    Transparency = 0,
})
KitsuneDepbox:SetupDependencies({ {Toggles.KitsuneColor, true} })

FruitSkinsBox:AddToggle('PortalColor', {
    Text = 'Portal Color',
    Default = false,
    Tooltip = "Changes the Portal Fruit's Color",
})

local PortalDepbox = FruitSkinsBox:AddDependencyBox()
PortalDepbox:AddLabel('Color'):AddColorPicker('PortalColorPicker', {
    Default = Color3.fromRGB(0, 150, 255),
    Title = 'Portal Color',
    Transparency = 0,
})
PortalDepbox:SetupDependencies({ {Toggles.PortalColor, true} })

FruitSkinsBox:AddToggle('DiamondColor', {
    Text = 'Diamond Color',
    Default = false,
    Tooltip = "Changes the Diamond Fruit's Color",
})

local DiamondDepbox = FruitSkinsBox:AddDependencyBox()
DiamondDepbox:AddLabel('Color'):AddColorPicker('DiamondColorPicker', {
    Default = Color3.fromRGB(255, 200, 0),
    Title = 'Diamond Color',
    Transparency = 0,
})
DiamondDepbox:SetupDependencies({ {Toggles.DiamondColor, true} })

FruitSkinsBox:AddToggle('RumbleColor', {
    Text = 'Rumble Color',
    Default = false,
    Tooltip = "Changes the Rumble Fruit's Color",
})

local RumbleDepbox = FruitSkinsBox:AddDependencyBox()
RumbleDepbox:AddLabel('Color'):AddColorPicker('RumbleColorPicker', {
	Default = Color3.fromRGB(111, 0, 255),
	Title = 'Rumble Color',
	Transparency = 0,
})
RumbleDepbox:SetupDependencies({ {Toggles.RumbleColor, true} })

task.spawn(function()
    while true do
        task.wait()
        
        local kitsuneEnabled = Toggles.KitsuneColor.Value
        local kitsuneFolder = plr:FindFirstChild("KitsuneFruitVFXColor")
        
        if kitsuneFolder then
            local shifted = kitsuneFolder:FindFirstChild("Shifted")
            
            if shifted then
                if originalKitsuneColor == nil and shifted:GetAttribute("Shifted_Color1") then
                    originalKitsuneColor = shifted:GetAttribute("Shifted_Color1")
                end
                
                if kitsuneEnabled then
                    local selectedColor = Options.KitsuneColorPicker.Value
                    shifted:SetAttribute("Shifted_Color1", selectedColor)
                else
                    if originalKitsuneColor then
                        shifted:SetAttribute("Shifted_Color1", originalKitsuneColor)
                    end
                end
            end
        end
        
        local portalEnabled = Toggles.PortalColor.Value
        local portalFolder = plr:FindFirstChild("PortalFruitVFXColor")
        
        if portalFolder then
            local shifted = portalFolder:FindFirstChild("Shifted")
            
            if shifted then
                if portalEnabled then
                    local selectedColor = Options.PortalColorPicker.Value
                    for i = 1, 7 do
                        if originalPortalColors[i] == nil then
                            originalPortalColors[i] = shifted:GetAttribute("Shifted_Color" .. i)
                        end
                        shifted:SetAttribute("Shifted_Color" .. i, selectedColor)
                    end
                else
                    for i = 1, 7 do
                        if originalPortalColors[i] then
                            shifted:SetAttribute("Shifted_Color" .. i, originalPortalColors[i])
                        end
                    end
                end
            end
        end
        
        local diamondEnabled = Toggles.DiamondColor.Value
        local diamondFolder = plr:FindFirstChild("DiamondFruitVFXColor")
        
        if diamondFolder then
            local shifted = diamondFolder:FindFirstChild("Shifted")
            
            if shifted then
                if diamondEnabled then
                    for i = 1, 3 do
                        if originalDiamondColors[i] == nil then
                            originalDiamondColors[i] = shifted:GetAttribute("Shifted_Color" .. i)
                        end
                    end
                    
                    local selectedColor = Options.DiamondColorPicker.Value
                    shifted:SetAttribute("Shifted_Color1", selectedColor)
                    
                    local h, s, v = Color3.toHSV(selectedColor)
                    local bright = Color3.fromHSV(h, s, math.min(1, v * 1.5))
                    local bright2 = Color3.fromHSV(h, s, math.min(1, v * 1.2))
                    
                    shifted:SetAttribute("Shifted_Color2", bright)
                    shifted:SetAttribute("Shifted_Color3", bright2)
                else
                    for i = 1, 3 do
                        if originalDiamondColors[i] then
                            shifted:SetAttribute("Shifted_Color" .. i, originalDiamondColors[i])
                        end
                    end
                end
            end
        end
		
		local rumbleEnabled = Toggles.RumbleColor.Value
        local rumbleFolder = plr:FindFirstChild("LightningFruitVFXColor")
        
        if rumbleFolder then
            local shifted = rumbleFolder:FindFirstChild("Shifted")
            
            if shifted then
                if rumbleEnabled then
                    for i = 1, 3 do
                        if originalRumbleColors[i] == nil then
                            originalRumbleColors[i] = shifted:GetAttribute("Shifted_Color" .. i)
                        end
                    end
                    
                    local selectedColor = Options.RumbleColorPicker.Value
                    shifted:SetAttribute("Shifted_Color1", selectedColor)
                    
                    local h, s, v = Color3.toHSV(selectedColor)
                    local dark = Color3.fromHSV(h, s, math.min(1, v * 0.95))
                    local dark2 = Color3.fromHSV(h, s, math.min(1, v * 0.8))
                    
                    shifted:SetAttribute("Shifted_Color2", dark)
                    shifted:SetAttribute("Shifted_Color3", dark2)
                else
                    for i = 1, 3 do
                        if originalRumbleColors[i] then
                            shifted:SetAttribute("Shifted_Color" .. i, originalRumbleColors[i])
                        end
                    end
                end
            end
        end
    end
end)

-- // ============================================================== Movement Tab ============================================================== \\ --

-- ===== Dash Distance =====
local DashBox = Tabs.Movement:AddLeftGroupbox('Dash Distance')

local dashEnabled = false
local dashDistance = 100
local defaultDashLength = 0

DashBox:AddToggle('DashDistance', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Increases dash distance',
}):AddKeyPicker('DashDistanceKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Dash Distance',
    SyncToggleState = true,
})

DashBox:AddSlider('DashDistanceSlider', {
    Text = 'Distance',
    Default = 100,
    Min = 0,
    Max = 500,
    Rounding = 0,
})

Toggles.DashDistance:OnChanged(function()
    dashEnabled = Toggles.DashDistance.Value
    local c2 = charFolder:FindFirstChild(plr.Name)
    if dashEnabled then
        if c2 then defaultDashLength = c2:GetAttribute("DashLength") or 0 end
    else
        if c2 then c2:SetAttribute("DashLength", defaultDashLength) end
    end
end)
Options.DashDistanceSlider:OnChanged(function()
    dashDistance = Options.DashDistanceSlider.Value
    if dashEnabled then
        local c2 = charFolder:FindFirstChild(plr.Name)
        if c2 then c2:SetAttribute("DashLength", dashDistance) end
    end
end)

task.spawn(function()
    while task.wait() do
        if dashEnabled then
            local c2 = charFolder:FindFirstChild(plr.Name)
            if c2 then c2:SetAttribute("DashLength", dashDistance) end
        end
    end
end)

-- ===== Speed Boost =====
local SpeedBox = Tabs.Movement:AddLeftGroupbox('Speed Boost')

local speedBoostEnabled = false
local speedBoostValue = 2
local defaultSpeedMult = 1

SpeedBox:AddToggle('SpeedBoost', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Increases movement speed',
}):AddKeyPicker('SpeedBoostKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Speed Boost',
    SyncToggleState = true,
})

SpeedBox:AddSlider('SpeedBoostSlider', {
    Text = 'Speed Multiplier',
    Default = 2,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Suffix = 'x',
})

Toggles.SpeedBoost:OnChanged(function()
    speedBoostEnabled = Toggles.SpeedBoost.Value
    local c2 = charFolder:FindFirstChild(plr.Name)
    if speedBoostEnabled then
        if c2 then defaultSpeedMult = c2:GetAttribute("SpeedMultiplier") or 1 end
    else
        if c2 then c2:SetAttribute("SpeedMultiplier", defaultSpeedMult) end
    end
end)
Options.SpeedBoostSlider:OnChanged(function()
    speedBoostValue = Options.SpeedBoostSlider.Value
    if speedBoostEnabled then
        local c2 = charFolder:FindFirstChild(plr.Name)
        if c2 then c2:SetAttribute("SpeedMultiplier", speedBoostValue) end
    end
end)

task.spawn(function()
    while task.wait() do
        if speedBoostEnabled then
            local c2 = charFolder:FindFirstChild(plr.Name)
            if c2 then c2:SetAttribute("SpeedMultiplier", speedBoostValue) end
        end
    end
end)

-- ===== SlyPort =====
local SlyPortBox = Tabs.Movement:AddLeftGroupbox('SlyPort')

local slyPortEnabled = false

local function getNearestPlayer()
    local nearest = nil
    local nearestDist = math.huge
    local charactersFolder = workspace:FindFirstChild("Characters")
    if not charactersFolder then return nil end
    
    for _, target in ipairs(charactersFolder:GetChildren()) do
        if target ~= plr.Character then
            local hrp = target:FindFirstChild("HumanoidRootPart")
            local hum = target:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local dist = plr:DistanceFromCharacter(hrp.Position)
                if dist < nearestDist then
                    nearestDist = dist
                    nearest = target
                end
            end
        end
    end
    return nearest
end

SlyPortBox:AddToggle('SlyPortEnabled', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'look behind you...',
}):AddKeyPicker('SlyPortKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'SlyPort',
    SyncToggleState = true,
})

Toggles.SlyPortEnabled:OnChanged(function()
    if Toggles.SlyPortEnabled.Value then
        local char = plr.Character
        if not char then return end
        
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        local target = getNearestPlayer()
        if not target then 
            Library:Notify("No nearby players found!", 3)
            Toggles.SlyPortEnabled:SetValue(false)
            return 
        end
        
        local targetHrp = target:FindFirstChild("HumanoidRootPart")
        if not targetHrp then 
            Toggles.SlyPortEnabled:SetValue(false)
            return 
        end
        
        local offset = targetHrp.CFrame.LookVector * -2
        local newPos = targetHrp.Position + offset + Vector3.new(0, 0, 0)
        
        hrp.CFrame = CFrame.new(newPos)
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
        
        Library:Notify("Teleported behind "..target.Name, 3)
        Toggles.SlyPortEnabled:SetValue(false)
    end
end)

-- ===== Boat Fly =====
local BoatFlyBox = Tabs.Movement:AddRightGroupbox('Boat Fly')

local boatFlyEnabled = false
local boatFlyHSpeed = 100
local boatFlyVSpeed = 100
local boatNoclipEnabled = false
local boatCONTROL = {F=0,B=0,L=0,R=0,U=0,D=0}
local boatBV, boatBG = nil, nil
local boatFlyConnection, flyKeyDown, flyKeyUp, seatWeldConnection, noclipConnection = nil, nil, nil, nil, nil
local currentSeat, currentBoat, boatRoot = nil, nil, nil
local waitingForBoat = false

local function getPlayerSeatAndBoat()
    local boatsFolder = workspace:FindFirstChild("Boats")
    if not boatsFolder then return nil, nil end
    local char = plr.Character
    if not char then return nil, nil end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return nil, nil end
    for _, boat in ipairs(boatsFolder:GetChildren()) do
        for _, v in ipairs(boat:GetDescendants()) do
            if v:IsA("VehicleSeat") and v.Occupant == hum then return v, boat end
            if v:IsA("Seat") then
                local sw = v:FindFirstChild("SeatWeld")
                if sw and sw.Part1 and sw.Part1:IsDescendantOf(char) then return v, boat end
            end
        end
    end
    return nil, nil
end

local function getBoatRoot(boat)
    for _, part in ipairs(boat:GetDescendants()) do
        if part:IsA("BasePart") and not part:IsA("Seat") and not part:IsA("VehicleSeat") then return part end
    end
    return currentSeat
end

local function keepSeated()
    if not currentSeat or not plr.Character then return end
    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
    if hum and hum.Sit == false then hum.Sit = true end
    local sw = currentSeat:FindFirstChild("SeatWeld")
    if not sw then
        sw = Instance.new("Weld")
        sw.Name = "SeatWeld"
        sw.Part0 = currentSeat
        sw.Part1 = plr.Character:FindFirstChild("HumanoidRootPart")
        sw.C0 = CFrame.new(0,0,0)
        sw.C1 = CFrame.new(0,0,0)
        sw.Parent = currentSeat
    else
        sw.Part1 = plr.Character:FindFirstChild("HumanoidRootPart")
    end
end

local function applyNoclip()
    if not boatNoclipEnabled or not currentBoat then return end
    
    for _, part in ipairs(currentBoat:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
    
    if plr.Character then
        for _, part in ipairs(plr.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
    
    for _, child in ipairs(currentBoat:GetDescendants()) do
        if child:IsA("VehicleSeat") or child:IsA("Seat") then
            if child.Occupant and child.Occupant.Parent then
                local otherChar = child.Occupant.Parent
                for _, part in ipairs(otherChar:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end
end

local function stopBoatFly(keepEnabled)
    if boatBV and boatBV.Parent then boatBV:Destroy() end
    if boatBG and boatBG.Parent then boatBG:Destroy() end
    boatBV, boatBG = nil, nil
    if boatFlyConnection then boatFlyConnection:Disconnect() boatFlyConnection = nil end
    if flyKeyDown then flyKeyDown:Disconnect() flyKeyDown = nil end
    if flyKeyUp then flyKeyUp:Disconnect() flyKeyUp = nil end
    if seatWeldConnection then seatWeldConnection:Disconnect() seatWeldConnection = nil end
    if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
    boatCONTROL = {F=0,B=0,L=0,R=0,U=0,D=0}
    currentSeat, currentBoat, boatRoot = nil, nil, nil
    
    if not keepEnabled and boatFlyEnabled then
        boatFlyEnabled = false
        Toggles.BoatFly:SetValue(false)
    end
end

local function startBoatFly()
    currentSeat, currentBoat = getPlayerSeatAndBoat()
    
    if currentSeat and currentBoat then
        boatRoot = getBoatRoot(currentBoat)
        if not boatRoot then return false end
        
        if currentSeat:IsA("VehicleSeat") then
            currentSeat.HeadsUpDisplay = false
            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        end
        
        boatBV = Instance.new("BodyVelocity")
        boatBV.MaxForce = Vector3.new(9e9,9e9,9e9)
        boatBV.Velocity = Vector3.zero
        boatBV.Parent = boatRoot
        
        boatBG = Instance.new("BodyGyro")
        boatBG.MaxTorque = Vector3.new(9e9,9e9,9e9)
        boatBG.P = 5000
        boatBG.D = 400
        boatBG.CFrame = boatRoot.CFrame
        boatBG.Parent = boatRoot
        
        keepSeated()
        seatWeldConnection = RunService.Heartbeat:Connect(keepSeated)
        
        flyKeyDown = UserInputService.InputBegan:Connect(function(input, processed)
            if processed or not boatFlyEnabled then return end
            if input.KeyCode == Enum.KeyCode.W then boatCONTROL.F = 1
            elseif input.KeyCode == Enum.KeyCode.S then boatCONTROL.B = 1
            elseif input.KeyCode == Enum.KeyCode.A then boatCONTROL.L = 1
            elseif input.KeyCode == Enum.KeyCode.D then boatCONTROL.R = 1
            elseif input.KeyCode == Enum.KeyCode.C then boatCONTROL.U = 1
            elseif input.KeyCode == Enum.KeyCode.V then boatCONTROL.D = 1 end
        end)
        
        flyKeyUp = UserInputService.InputEnded:Connect(function(input, processed)
            if processed or not boatFlyEnabled then return end
            if input.KeyCode == Enum.KeyCode.W then boatCONTROL.F = 0
            elseif input.KeyCode == Enum.KeyCode.S then boatCONTROL.B = 0
            elseif input.KeyCode == Enum.KeyCode.A then boatCONTROL.L = 0
            elseif input.KeyCode == Enum.KeyCode.D then boatCONTROL.R = 0
            elseif input.KeyCode == Enum.KeyCode.C then boatCONTROL.U = 0
            elseif input.KeyCode == Enum.KeyCode.V then boatCONTROL.D = 0 end
        end)
        
        noclipConnection = RunService.Heartbeat:Connect(applyNoclip)
        
        boatFlyConnection = RunService.Heartbeat:Connect(function()
            if not boatFlyEnabled then return end
            
            local seat, boat = getPlayerSeatAndBoat()
            
            if not seat or not boat then
                stopBoatFly(true)
                waitingForBoat = true
                return
            end
            
            if waitingForBoat then
                waitingForBoat = false
                startBoatFly()
                return
            end
            
            if boat ~= currentBoat then
                currentBoat = boat
                currentSeat = seat
                boatRoot = getBoatRoot(boat)
                if boatBV then boatBV.Parent = boatRoot end
                if boatBG then boatBG.Parent = boatRoot end
            end
            
            local cam = workspace.CurrentCamera
            local moveDir = Vector3.zero
            
            if boatCONTROL.F == 1 then moveDir = moveDir + cam.CFrame.LookVector end
            if boatCONTROL.B == 1 then moveDir = moveDir - cam.CFrame.LookVector end
            if boatCONTROL.R == 1 then moveDir = moveDir + cam.CFrame.RightVector end
            if boatCONTROL.L == 1 then moveDir = moveDir - cam.CFrame.RightVector end
            
            local hMove = Vector3.new(moveDir.X, 0, moveDir.Z)
            if hMove.Magnitude > 0 then hMove = hMove.Unit * boatFlyHSpeed end
            
            local vVel = 0
            if boatCONTROL.U == 1 then vVel = boatFlyVSpeed end
            if boatCONTROL.D == 1 then vVel = -boatFlyVSpeed end
            
            boatBV.Velocity = hMove + Vector3.new(0, vVel, 0)
            
            local look = cam.CFrame.LookVector
            local flatLook = Vector3.new(look.X, 0, look.Z).Unit
            
            if hMove.Magnitude > 0 then
                boatBG.CFrame = CFrame.lookAt(Vector3.zero, hMove)
            else
                boatBG.CFrame = CFrame.lookAt(Vector3.zero, flatLook)
            end
        end)
        
        return true
    end
    
    return false
end

BoatFlyBox:AddToggle('BoatFly', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Fly. but on a boat',
}):AddKeyPicker('BoatFlyKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Boat Fly',
    SyncToggleState = true,
})

BoatFlyBox:AddSlider('BoatFlyHSpeed', { Text = 'Horizontal Speed', Default = 100, Min = 10, Max = 800, Rounding = 0 })
BoatFlyBox:AddSlider('BoatFlyVSpeed', { Text = 'Vertical Speed', Default = 100, Min = 5, Max = 800, Rounding = 0 })
BoatFlyBox:AddToggle('BoatNoclip', { Text = 'Boat NoClip', Default = false })
BoatFlyBox:AddLabel('Hold [C] to go up')
BoatFlyBox:AddLabel('Hold [V] to go down')

Toggles.BoatFly:OnChanged(function()
    boatFlyEnabled = Toggles.BoatFly.Value
    waitingForBoat = false
    
    if boatFlyEnabled then
        if not startBoatFly() then
            waitingForBoat = true
            Library:Notify("[BoatFly] >> get on a boat bro", 6)
            
            task.spawn(function()
                while boatFlyEnabled and waitingForBoat do
                    if startBoatFly() then
                        waitingForBoat = false
                        break
                    end
                    task.wait(0.5)
                end
            end)
        end
    else
        stopBoatFly(false)
        waitingForBoat = false
    end
end)

Options.BoatFlyHSpeed:OnChanged(function() boatFlyHSpeed = Options.BoatFlyHSpeed.Value end)
Options.BoatFlyVSpeed:OnChanged(function() boatFlyVSpeed = Options.BoatFlyVSpeed.Value end)
Toggles.BoatNoclip:OnChanged(function() 
    boatNoclipEnabled = Toggles.BoatNoclip.Value
end)

-- // ============================================================== Player Tab ============================================================== \\ --

-- ===== Save Energy =====
local SaveEnergyBox = Tabs.Player:AddLeftGroupbox('Save Energy')

local saveEnergyEnabled = false
local blockDashEnergy = false
local blockGeppoEnergy = false
local blockDJEnergy = false
local blockIceWalkEnergy = false

task.spawn(function()
    local gg = getrawmetatable(game)
    local old = gg.__namecall
    setreadonly(gg, false)
    local prev = old
    gg.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "FireServer" and rawequal(self, CommE) then
            local args = table.pack(...)
            if args[1] == "Dodge" then
                if blockDashEnergy and args[2] == nil and type(args[3]) == "number" then return end
                if blockGeppoEnergy and args[2] == "Geppo" then return end
            end
            
            if args[1] == "DoubleJump" then
                if blockDJEnergy and args[2] == false then return end
            end

            if args[1] == "IceWalk" then
                if blockIceWalkEnergy then return end
            end
        end
        return prev(self, ...)
    end)
    setreadonly(gg, true)
end)

SaveEnergyBox:AddToggle('SaveEnergy', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Blocks certain actions from consuming your energy',
}):AddKeyPicker('SaveEnergyKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Save Energy',
    SyncToggleState = true,
})

local SaveEnergyDepbox = SaveEnergyBox:AddDependencyBox()
SaveEnergyDepbox:AddToggle('BlockDashEnergy', { Text = 'Dashing', Default = false })
SaveEnergyDepbox:AddToggle('BlockDJEnergy', { Text = 'Double Jump', Default = false })
SaveEnergyDepbox:AddToggle('BlockGeppoEnergy', { Text = 'Geppos', Default = false })
SaveEnergyDepbox:AddDivider()
SaveEnergyDepbox:AddToggle('BlockIceWalkEnergy', { Text = 'Ice Walk', Default = false })

Toggles.SaveEnergy:OnChanged(function()
    saveEnergyEnabled = Toggles.SaveEnergy.Value
    if not saveEnergyEnabled then blockDashEnergy = false blockGeppoEnergy = false blockDJEnergy = false blockIceWalkEnergy = false end
end)
Toggles.BlockDashEnergy:OnChanged(function() blockDashEnergy = Toggles.BlockDashEnergy.Value end)
Toggles.BlockGeppoEnergy:OnChanged(function() blockGeppoEnergy = Toggles.BlockGeppoEnergy.Value end)
Toggles.BlockDJEnergy:OnChanged(function() blockDJEnergy = Toggles.BlockDJEnergy.Value end)
Toggles.BlockIceWalkEnergy:OnChanged(function() blockIceWalkEnergy = Toggles.BlockIceWalkEnergy.Value end)

-- ===== No Soru Cooldown =====
local NoSoruBox = Tabs.Player:AddLeftGroupbox('No Soru Cooldown')

NoSoruBox:AddToggle('NoSoru', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Removes Soru cooldown',
}):AddKeyPicker('NoSoruKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'No Soru Cooldown',
    SyncToggleState = true,
})

Toggles.NoSoru:OnChanged(function()
    NoSoru.enabled = Toggles.NoSoru.Value
    if NoSoru.enabled then
        if character2 then
            local s = character2:GetAttribute("FlashstepCooldown")
            if s then NoSoru.defaultCooldown = s end
        end
        NoSoru.connection = RunService.Heartbeat:Connect(function()
            if not NoSoru.enabled then if NoSoru.connection then NoSoru.connection:Disconnect() end return end
            local c2 = charFolder:FindFirstChild(plr.Name)
            if c2 then c2:SetAttribute("FlashstepCooldown", 1) end
        end)
    else
        if NoSoru.connection then NoSoru.connection:Disconnect() NoSoru.connection = nil end
        if character2 then character2:SetAttribute("FlashstepCooldown", NoSoru.defaultCooldown) end
    end
end)

-- ===== Chest Reach =====
local ChestRangeBox = Tabs.Player:AddRightGroupbox('Chest Reach')
ChestRangeBox:AddToggle('ChestRange', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Open chests from far away',
}):AddKeyPicker('ChestRangeKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Chest Range',
    SyncToggleState = true,
})

Toggles.ChestRange:OnChanged(function()
    local v = Toggles.ChestRange.Value
    task.wait()
    if v then
        local mapFolder = workspace:FindFirstChild("Map")
        if mapFolder then
            for _, obj in ipairs(mapFolder:GetDescendants()) do
                if obj:IsA("BasePart") and (obj.Name == "Chest1" or obj.Name == "Chest2" or obj.Name == "Chest3") then
                    if not ChestRange.originalSizes[obj] then ChestRange.originalSizes[obj] = obj.Size end
                    if obj.Size.X ~= 100 then obj.Size = Vector3.new(100,100,100) end
                end
            end
        end
    else
        for chest, size in pairs(ChestRange.originalSizes) do
            if chest and chest.Parent then chest.Size = size end
        end
        table.clear(ChestRange.originalSizes)
    end
end)

-- ===== Unbreakable =====
local UnbreakableBox = Tabs.Player:AddRightGroupbox('Unbreakable')

local unbreakableEnabled = false
local defaultUnbreakable = nil

UnbreakableBox:AddToggle('Unbreakable', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Prevent your skills from getting interupted',
}):AddKeyPicker('UnbreakableKeybind', {
    Default = 'None',
    NoUI = false,
    Mode = 'Toggle',
    Text = 'Unbreakable',
    SyncToggleState = true,
})

Toggles.Unbreakable:OnChanged(function()
    unbreakableEnabled = Toggles.Unbreakable.Value
    local c2 = charFolder:FindFirstChild(plr.Name)
    if unbreakableEnabled then
        if c2 then defaultUnbreakable = c2:GetAttribute("UnbreakableAll") c2:SetAttribute("UnbreakableAll", true) end
    else
        if c2 then c2:SetAttribute("UnbreakableAll", defaultUnbreakable) end
    end
end)

task.spawn(function()
    while task.wait() do
        if unbreakableEnabled then
            local c2 = charFolder:FindFirstChild(plr.Name)
            if c2 then c2:SetAttribute("UnbreakableAll", true) end
        end
    end
end)

-- // ============================================================== Misc Tab ============================================================== \\ --

-- ===== Shop =====
local ShopBox = Tabs.Misc:AddLeftGroupbox('Shop')
ShopBox:AddButton({
    Text = 'Roll Fruit',
    Tooltip = 'gambling $$$',
    Func = function()
        CommF:InvokeServer("Cousin", "Buy", "DLCBoxData")
    end,
})

-- ===== Fruit Shop =====
local FruitShopBox = Tabs.Misc:AddLeftGroupbox('Fruit Shop')

local container = FruitShopBox.Container
local layout = container:FindFirstChildOfClass("UIListLayout")

local function clearDynamicContent()
    if not container then return end
    
    for _, child in ipairs(container:GetChildren()) do
        if child ~= layout then
            child:Destroy()
        end
    end
end

local function fetchFruitData(isAdvanced)
    isAdvanced = isAdvanced or false
    local success, data = pcall(function()
        return game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("GetFruits", isAdvanced)
    end)
    
    if success and data then
        return data
    end
    return nil
end

local function buyFruit(fruitName, isAdvanced)
    isAdvanced = isAdvanced or false
    
    local success, result = pcall(function()
        return game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("PurchaseRawFruit", fruitName, isAdvanced)
    end)
    
    if success then
        Library:Notify("Purchased " .. fruitName .. "!", 5)
    else
        Library:Notify("Failed to purchase " .. fruitName .. "!", 5)
    end
end

local function create()
    clearDynamicContent()
    
    local refreshBtn = FruitShopBox:AddButton({
        Text = 'Refresh Stock',
        Func = function()
            create()
            Library:Notify("Refreshed Fruit Stock!", 5)
        end
    })

    FruitShopBox:AddDivider()
    
    -- normal stock
    local normalStock = fetchFruitData(false)
    if normalStock then
        local hasNormalStock = false
        for _, fruit in ipairs(normalStock) do
            if fruit.OnSale and not fruit.Offsale then
                hasNormalStock = true
                break
            end
        end
        
        if hasNormalStock then
            FruitShopBox:AddLabel("Stock (Normal)")
            
            for _, fruit in ipairs(normalStock) do
                if fruit.OnSale and not fruit.Offsale then
                    local btn = FruitShopBox:AddButton({
                        Text = fruit.Name,
                        Func = function()
                            Library:Notify(string.format("%s\nPrice: %d Beli\nRarity: %s", 
                                fruit.Name, fruit.Price,
                                fruit.Rarity == 0 and "Common" or
                                fruit.Rarity == 1 and "Uncommon" or
                                fruit.Rarity == 2 and "Rare" or
                                fruit.Rarity == 3 and "Legendary" or
                                fruit.Rarity == 4 and "Mythical" or "Unknown"), 5)
                        end,
                    })
                    
                    btn:AddButton({
                        Text = "Buy Fruit",
                        Func = function()
                            buyFruit(fruit.Name, false)
                        end,
                        DoubleClick = true,
                    })
                end
            end
        end
    end
    
    -- advanced stock
    local advancedStock = fetchFruitData(true)
    if advancedStock then
        local hasAdvancedStock = false
        for _, fruit in ipairs(advancedStock) do
            if fruit.OnSale and not fruit.Offsale then
                hasAdvancedStock = true
                break
            end
        end
        
        if hasAdvancedStock then
            FruitShopBox:AddDivider()
            FruitShopBox:AddLabel("Stock (Advanced)")
            
            for _, fruit in ipairs(advancedStock) do
                if fruit.OnSale and not fruit.Offsale then
                    local btn = FruitShopBox:AddButton({
                        Text = fruit.Name,
                        Func = function()
                            Library:Notify(string.format("%s\nPrice: %d Beli\nRarity: %s", 
                                fruit.Name, fruit.Price,
                                fruit.Rarity == 0 and "Common" or
                                fruit.Rarity == 1 and "Uncommon" or
                                fruit.Rarity == 2 and "Rare" or
                                fruit.Rarity == 3 and "Legendary" or
                                fruit.Rarity == 4 and "Mythical" or "Unknown"), 5)
                        end,
                    })
                    
                    btn:AddButton({
                        Text = "Buy Fruit",
                        Func = function()
                            buyFruit(fruit.Name, true)
                        end,
                        DoubleClick = true,
                    })
                end
            end
        end
    end
    
    FruitShopBox:Resize()
end

create()

-- ===== Trolling =====
local TrollingBox = Tabs.Misc:AddRightGroupbox('Trolling')

local selectedTpBoat = nil
local boatMap = {}

local function getBoatList()
    local list = {}
    boatMap = {}
    local boatsFolder = workspace:FindFirstChild("Boats")
    if not boatsFolder then return list end
    for _, boat in ipairs(boatsFolder:GetChildren()) do
        local ownerVal = boat:FindFirstChild("Owner")
        local owner = ownerVal and tostring(ownerVal.Value) or "Unknown"
        local label = boat.Name.." ("..owner..")"
        table.insert(list, label)
        boatMap[label] = boat
    end
    return list
end

local function getAvailableSeat(boat)
    for _, v in ipairs(boat:GetDescendants()) do
        if (v:IsA("Seat") or v:IsA("VehicleSeat")) and not v:FindFirstChild("SeatWeld") then return v end
    end
    return nil
end

local initialBoatList = getBoatList()
if #initialBoatList == 0 then initialBoatList = {"None"} end

TrollingBox:AddDivider()
TrollingBox:AddLabel("Boat Teleport")

TrollingBox:AddDropdown('BoatTpSelect', {
    Text = 'Select Boat',
    Values = initialBoatList,
    Default = 1,
    Tooltip = 'Pick a boat to teleport',
})
Options.BoatTpSelect:OnChanged(function() selectedTpBoat = Options.BoatTpSelect.Value end)
selectedTpBoat = initialBoatList[1]

TrollingBox:AddButton({
    Text = 'Refresh Boat List',
    Func = function()
        local newList = getBoatList()
        if #newList == 0 then newList = {"None"} end
        Options.BoatTpSelect:SetValues(newList)
        Options.BoatTpSelect:SetValue(newList[1])
        selectedTpBoat = newList[1]
        Library:Notify("Refreshed boat list!", 3)
    end,
})

TrollingBox:AddButton({
    Text = 'Teleport Boat',
    Func = function()
        if not selectedTpBoat or selectedTpBoat == "None" then
            Library:Notify("Select a boat first!", 5) return
        end
        local boat = boatMap[selectedTpBoat]
        if not boat or not boat.Parent then Library:Notify("Boat not found!", 5) return end
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")
        if not hrp or not hum then Library:Notify("Character not ready!", 5) return end
        local seat = getAvailableSeat(boat)
        if not seat then Library:Notify("No available seats!", 5) return end
        if (seat.Position - hrp.Position).Magnitude < 1000 then
            Library:Notify("Boat is too close! Must be at least 1000 studs away.", 5) return
        end
        hrp.CFrame = seat.CFrame
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
        task.spawn(function()
            local attempts = 0
            repeat task.wait(0.1) attempts = attempts + 1 until hum.SeatPart ~= nil or attempts >= 15
            if hum.SeatPart then Library:Notify("Teleported boat!", 5)
            else Library:Notify("Failed to sit, try again!", 5) end
        end)
    end,
})

-- ===== Teams =====
local TeamsBox = Tabs.Misc:AddRightGroupbox('Teams')
TeamsBox:AddButton({
    Text = 'Join Marines',
    Tooltip = 'Switches to the Marines team',
    Func = function()
        CommF:InvokeServer("SetTeam", "Marines")
    end,
})
TeamsBox:AddButton({
    Text = 'Join Pirates',
    Tooltip = 'Switches to the Pirates team',
    Func = function()
        CommF:InvokeServer("SetTeam", "Pirates")
    end,
})

-- ===== Server =====
local ServerBox = Tabs.Misc:AddRightGroupbox('Server')

getServers = function(placeId)
    local servers = {}
    local cursor = ""
    repeat
        local url = "https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100"..cursor
        local success, res = pcall(function() return request({Url = url, Method = "GET"}) end)
        if success and res and res.Body then
            local ok, data = pcall(function() return HttpService:JSONDecode(res.Body) end)
            if ok and data and data.data then
                for _, server in ipairs(data.data) do
                    if server.playing < server.maxPlayers and server.id ~= game.JobId then
                        table.insert(servers, server)
                    end
                end
                cursor = data.nextPageCursor and ("&cursor="..data.nextPageCursor) or nil
            else break end
        else break end
        task.wait()
    until not cursor
    return servers
end

ServerBox:AddButton({
    Text = 'Server Hop (Normal)',
    Func = function()
        local servers = getServers(game.PlaceId)
        if #servers == 0 then Library:Notify("No servers found!", 5) return end
        TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)].id)
    end,
})

ServerBox:AddButton({
    Text = 'Server Hop (Lowest)',
    Func = function()
        local servers = getServers(game.PlaceId)
        if #servers == 0 then Library:Notify("No servers found!", 5) return end
        table.sort(servers, function(a,b) return a.playing < b.playing end)
        TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[1].id)
    end,
})

ServerBox:AddButton({
    Text = 'Rejoin Server',
    Func = function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end,
})

-- // ============================================================== Utils ============================================================== \\ --

getSpawnedChests = function()
    local spawnedChests = {}
    local mapFolder = workspace:FindFirstChild("Map")
    if not mapFolder then return spawnedChests end
    local function search(parent)
        for _, child in ipairs(parent:GetChildren()) do
            if child:IsA("BasePart") and (child.Name == "Chest3" or child.Name == "Chest2" or child.Name == "Chest1") then
                local hasTouchInterest = false
                for _, obj in ipairs(child:GetChildren()) do
                    if obj:IsA("TouchTransmitter") then hasTouchInterest = true break end
                end
                if hasTouchInterest then
                    local count = 0
                    local kept = false
                    for _, obj in ipairs(child:GetChildren()) do
                        if obj.ClassName == "TouchInterest" or obj:IsA("TouchTransmitter") then
                            count = count + 1
                            if kept then obj:Destroy() else kept = true end
                        end
                    end
                    table.insert(spawnedChests, child)
                end
            end
            if #child:GetChildren() > 0 then search(child) end
        end
    end
    search(mapFolder)
    return spawnedChests
end

watchChest = function(chest)
    if chestConnection then chestConnection:Disconnect() chestConnection = nil end
    currentChest = chest
    chestConnection = chest.ChildRemoved:Connect(function(child)
        if child:IsA("TouchTransmitter") or child.ClassName == "TouchInterest" then
            currentChest = nil
        end
    end)
end

-- // ============================================================== UI Settings ============================================================== \\ --

Library:SetWatermarkVisibility(true)

local FrameTimer = tick()
local FrameCounter = 0;
local FPS = 0;

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
    FrameCounter += 1;

    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter;
        FrameTimer = tick();
        FrameCounter = 0;
    end;

    Library:SetWatermark(('catware - %s fps - %s ms'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ));
end);

Library.KeybindFrame.Visible = true;

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
MenuGroup:AddButton({ Text = 'Unload', Func = function() Library:Unload() end })
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'LeftAlt', NoUI = true, Text = 'Menu keybind' })
Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'})
ThemeManager:SetFolder('catware')
SaveManager:SetFolder('catware/bloxfruits')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
SaveManager:LoadAutoloadConfig()
