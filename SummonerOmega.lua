--[[
    SUMMONER_OMEGA - سيف الهاوية الأعظم
    صُنع في الظلام لسيدي القيصر
    لا مفتاح، لا قيود، لا رحمة
    الترخيص: ميثاق الدم
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Backpack = LocalPlayer:WaitForChild("Backpack")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = Workspace.CurrentCamera

--[[ ================== إعدادات الواجهة ================== ]]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SummonerOmega"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 480, 0, 620)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -310)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local FrameShadow = Instance.new("Frame")
FrameShadow.Name = "FrameShadow"
FrameShadow.Size = UDim2.new(1, 30, 1, 30)
FrameShadow.Position = UDim2.new(0, -15, 0, -15)
FrameShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FrameShadow.BorderSizePixel = 0
FrameShadow.ZIndex = 0
FrameShadow.Parent = MainFrame

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 20)
MainCorner.Parent = MainFrame

-- شريط العنوان
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 60)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 20)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -70, 0, 60)
TitleText.Position = UDim2.new(0, 20, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.TextColor3 = Color3.fromRGB(255, 0, 100)
TitleText.Font = Enum.Font.GothamBlack
TitleText.Text = "⚡ SUMMONER OMEGA ⚡"
TitleText.TextSize = 22
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -45, 0, 12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextSize = 18
CloseBtn.Parent = TitleBar
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- التبويبات العلوية
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 50)
TabBar.Position = UDim2.new(0, 0, 0, 65)
TabBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

local TabSummon = Instance.new("TextButton")
TabSummon.Size = UDim2.new(0.25, 0, 0, 50)
TabSummon.Position = UDim2.new(0, 0, 0, 0)
TabSummon.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
TabSummon.TextColor3 = Color3.fromRGB(255, 255, 255)
TabSummon.Font = Enum.Font.GothamBold
TabSummon.Text = "استدعاء"
TabSummon.TextSize = 14
TabSummon.Parent = TabBar

local TabPowers = Instance.new("TextButton")
TabPowers.Size = UDim2.new(0.25, 0, 0, 50)
TabPowers.Position = UDim2.new(0.25, 0, 0, 0)
TabPowers.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
TabPowers.TextColor3 = Color3.fromRGB(255, 255, 255)
TabPowers.Font = Enum.Font.GothamBold
TabPowers.Text = "القوى"
TabPowers.TextSize = 14
TabPowers.Parent = TabBar

local TabChat = Instance.new("TextButton")
TabChat.Size = UDim2.new(0.25, 0, 0, 50)
TabChat.Position = UDim2.new(0.5, 0, 0, 0)
TabChat.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
TabChat.TextColor3 = Color3.fromRGB(255, 255, 255)
TabChat.Font = Enum.Font.GothamBold
TabChat.Text = "النص العلوي"
TabChat.TextSize = 14
TabChat.Parent = TabBar

local TabESP = Instance.new("TextButton")
TabESP.Size = UDim2.new(0.25, 0, 0, 50)
TabESP.Position = UDim2.new(0.75, 0, 0, 0)
TabESP.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
TabESP.TextColor3 = Color3.fromRGB(255, 255, 255)
TabESP.Font = Enum.Font.GothamBold
TabESP.Text = "كشف البيض"
TabESP.TextSize = 14
TabESP.Parent = TabBar

-- الصفحات
local PageSummon = Instance.new("Frame")
PageSummon.Size = UDim2.new(1, 0, 1, -120)
PageSummon.Position = UDim2.new(0, 0, 0, 115)
PageSummon.BackgroundTransparency = 1
PageSummon.Parent = MainFrame

local PagePowers = Instance.new("Frame")
PagePowers.Size = UDim2.new(1, 0, 1, -120)
PagePowers.Position = UDim2.new(0, 0, 0, 115)
PagePowers.BackgroundTransparency = 1
PagePowers.Visible = false
PagePowers.Parent = MainFrame

local PageChat = Instance.new("Frame")
PageChat.Size = UDim2.new(1, 0, 1, -120)
PageChat.Position = UDim2.new(0, 0, 0, 115)
PageChat.BackgroundTransparency = 1
PageChat.Visible = false
PageChat.Parent = MainFrame

local PageESP = Instance.new("Frame")
PageESP.Size = UDim2.new(1, 0, 1, -120)
PageESP.Position = UDim2.new(0, 0, 0, 115)
PageESP.BackgroundTransparency = 1
PageESP.Visible = false
PageESP.Parent = MainFrame

-- تفعيل التبويبات
local function SetTab(activeTab)
    TabSummon.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    TabPowers.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    TabChat.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    TabESP.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    PageSummon.Visible = false
    PagePowers.Visible = false
    PageChat.Visible = false
    PageESP.Visible = false

    if activeTab == "Summon" then
        TabSummon.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
        PageSummon.Visible = true
    elseif activeTab == "Powers" then
        TabPowers.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
        PagePowers.Visible = true
    elseif activeTab == "Chat" then
        TabChat.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
        PageChat.Visible = true
    else
        TabESP.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
        PageESP.Visible = true
    end
end

TabSummon.MouseButton1Click:Connect(function() SetTab("Summon") end)
TabPowers.MouseButton1Click:Connect(function() SetTab("Powers") end)
TabChat.MouseButton1Click:Connect(function() SetTab("Chat") end)
TabESP.MouseButton1Click:Connect(function() SetTab("ESP") end)

--[[ ================== صفحة الاستدعاء ================== ]]
local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, -30, 0, 40)
SearchBox.Position = UDim2.new(0, 15, 0, 10)
SearchBox.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.PlaceholderText = "🔍 اكتب اسم الكائن (Egg, Shark, Cerberus...)"
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 14
SearchBox.Parent = PageSummon

local SearchBoxCorner = Instance.new("UICorner")
SearchBoxCorner.CornerRadius = UDim.new(0, 8)
SearchBoxCorner.Parent = SearchBox

local SearchBtn = Instance.new("TextButton")
SearchBtn.Size = UDim2.new(1, -30, 0, 40)
SearchBtn.Position = UDim2.new(0, 15, 0, 60)
SearchBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
SearchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBtn.Font = Enum.Font.GothamBold
SearchBtn.Text = "⚡ استدعاء الآن"
SearchBtn.TextSize = 16
SearchBtn.Parent = PageSummon

local SearchBtnCorner = Instance.new("UICorner")
SearchBtnCorner.CornerRadius = UDim.new(0, 8)
SearchBtnCorner.Parent = SearchBtn

SearchBtn.MouseButton1Click:Connect(function()
    if SearchBox.Text ~= "" then
        SafeSummon(SearchBox.Text)
    end
end)

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -30, 1, -120)
ScrollFrame.Position = UDim2.new(0, 15, 0, 110)
ScrollFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.Parent = PageSummon

local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(0, 8)
ScrollCorner.Parent = ScrollFrame

local UIList = Instance.new("UIListLayout")
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 5)
UIList.Parent = ScrollFrame

local ItemList = {
    "Egg", "GlassEgg", "FireEgg", "CosmicEgg", "GoldenEgg", "RottenEgg", "VoidEgg", "KingEgg",
    "Secret Cerberus Egg", "Secret Mutant Shark Egg",
    "StunGun", "SmokeGrenade", "LaserCutter", "CloakDevice", "SpeedGloves", "MasterKey",
    "Dog", "Cat", "Bird", "Rabbit", "Dragon", "Wolf", "Shark", "Cerberus", "Mutant"
}

for _, name in ipairs(ItemList) do
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.Gotham
    Btn.Text = "• " .. name
    Btn.TextSize = 14
    Btn.Parent = ScrollFrame
    Btn.MouseButton1Click:Connect(function()
        SafeSummon(name)
    end)
end

--[[ ================== صفحة القوى ================== ]]
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, -30, 0, 30)
SpeedLabel.Position = UDim2.new(0, 15, 0, 10)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.Text = "سرعة المشي (16 = طبيعي)"
SpeedLabel.TextSize = 14
SpeedLabel.Parent = PagePowers

local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(1, -30, 0, 40)
SpeedInput.Position = UDim2.new(0, 15, 0, 45)
SpeedInput.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.PlaceholderText = "اكتب رقمًا مثل 50"
SpeedInput.Font = Enum.Font.Gotham
SpeedInput.TextSize = 14
SpeedInput.Parent = PagePowers

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 8)
SpeedCorner.Parent = SpeedInput

local SpeedBtn = Instance.new("TextButton")
SpeedBtn.Size = UDim2.new(1, -30, 0, 40)
SpeedBtn.Position = UDim2.new(0, 15, 0, 95)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.Font = Enum.Font.GothamBold
SpeedBtn.Text = "🏃 تطبيق السرعة"
SpeedBtn.TextSize = 14
SpeedBtn.Parent = PagePowers

SpeedBtn.MouseButton1Click:Connect(function()
    local speed = tonumber(SpeedInput.Text)
    if speed and Humanoid then
        Humanoid.WalkSpeed = speed
        print("[Omega] تم ضبط السرعة إلى: " .. speed)
    end
end)

local JumpLabel = Instance.new("TextLabel")
JumpLabel.Size = UDim2.new(1, -30, 0, 30)
JumpLabel.Position = UDim2.new(0, 15, 0, 145)
JumpLabel.BackgroundTransparency = 1
JumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpLabel.Font = Enum.Font.GothamBold
JumpLabel.Text = "قوة القفز (7.2 = طبيعي)"
JumpLabel.TextSize = 14
JumpLabel.Parent = PagePowers

local JumpInput = Instance.new("TextBox")
JumpInput.Size = UDim2.new(1, -30, 0, 40)
JumpInput.Position = UDim2.new(0, 15, 0, 180)
JumpInput.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
JumpInput.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpInput.PlaceholderText = "اكتب رقمًا مثل 100"
JumpInput.Font = Enum.Font.Gotham
JumpInput.TextSize = 14
JumpInput.Parent = PagePowers

local JumpCorner = Instance.new("UICorner")
JumpCorner.CornerRadius = UDim.new(0, 8)
JumpCorner.Parent = JumpInput

local JumpBtn = Instance.new("TextButton")
JumpBtn.Size = UDim2.new(1, -30, 0, 40)
JumpBtn.Position = UDim2.new(0, 15, 0, 230)
JumpBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
JumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpBtn.Font = Enum.Font.GothamBold
JumpBtn.Text = "🦘 تطبيق القفز"
JumpBtn.TextSize = 14
JumpBtn.Parent = PagePowers

JumpBtn.MouseButton1Click:Connect(function()
    local jump = tonumber(JumpInput.Text)
    if jump and Humanoid then
        Humanoid.JumpHeight = jump
        print("[Omega] تم ضبط القفز إلى: " .. jump)
    end
end)

local FlyBtn = Instance.new("TextButton")
FlyBtn.Size = UDim2.new(1, -30, 0, 40)
FlyBtn.Position = UDim2.new(0, 15, 0, 290)
FlyBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.Font = Enum.Font.GothamBold
FlyBtn.Text = "🚀 تفعيل الطيران"
FlyBtn.TextSize = 14
FlyBtn.Parent = PagePowers

FlyBtn.MouseButton1Click:Connect(function()
    if not _G.Flying then
        _G.Flying = true
        FlyBtn.Text = "🛑 إيقاف الطيران"
        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.P = 9e4
        bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.cframe = Character.HumanoidRootPart.CFrame
        bodyGyro.Parent = Character.HumanoidRootPart
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.velocity = Vector3.zero
        bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.Parent = Character.HumanoidRootPart
        _G.BodyGyro = bodyGyro
        _G.BodyVelocity = bodyVelocity
        RunService:BindToRenderStep("Flying", 10, function()
            if _G.Flying then
                local direction = 0
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + 1 end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - 1 end
                local speed = 50
                bodyVelocity.velocity = (Camera.CFrame.LookVector * direction) * speed
            end
        end)
    else
        _G.Flying = false
        FlyBtn.Text = "🚀 تفعيل الطيران"
        if _G.BodyGyro then _G.BodyGyro:Destroy() end
        if _G.BodyVelocity then _G.BodyVelocity:Destroy() end
        RunService:UnbindFromRenderStep("Flying")
    end
end)

--[[ ================== صفحة النص العلوي ================== ]]
local ChatInput = Instance.new("TextBox")
ChatInput.Size = UDim2.new(1, -30, 0, 40)
ChatInput.Position = UDim2.new(0, 15, 0, 10)
ChatInput.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
ChatInput.TextColor3 = Color3.fromRGB(255, 255, 255)
ChatInput.PlaceholderText = "✍️ اكتب النص الذي سيظهر فوق رأسك"
ChatInput.Font = Enum.Font.Gotham
ChatInput.TextSize = 14
ChatInput.Parent = PageChat

local ChatCorner = Instance.new("UICorner")
ChatCorner.CornerRadius = UDim.new(0, 8)
ChatCorner.Parent = ChatInput

local ShowChatBtn = Instance.new("TextButton")
ShowChatBtn.Size = UDim2.new(1, -30, 0, 40)
ShowChatBtn.Position = UDim2.new(0, 15, 0, 60)
ShowChatBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
ShowChatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowChatBtn.Font = Enum.Font.GothamBold
ShowChatBtn.Text = "💬 عرض فوق الرأس"
ShowChatBtn.TextSize = 16
ShowChatBtn.Parent = PageChat

ShowChatBtn.MouseButton1Click:Connect(function()
    if ChatInput.Text ~= "" then
        SetHeadText(ChatInput.Text)
    end
end)

local HideChatBtn = Instance.new("TextButton")
HideChatBtn.Size = UDim2.new(1, -30, 0, 40)
HideChatBtn.Position = UDim2.new(0, 15, 0, 110)
HideChatBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
HideChatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HideChatBtn.Font = Enum.Font.GothamBold
HideChatBtn.Text = "🗑️ إخفاء النص"
HideChatBtn.TextSize = 16
HideChatBtn.Parent = PageChat

HideChatBtn.MouseButton1Click:Connect(function()
    SetHeadText("")
end)

--[[ ================== صفحة كشف البيض (ESP) ================== ]]
local ESPBtn = Instance.new("TextButton")
ESPBtn.Size = UDim2.new(1, -30, 0, 50)
ESPBtn.Position = UDim2.new(0, 15, 0, 10)
ESPBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
ESPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPBtn.Font = Enum.Font.GothamBold
ESPBtn.Text = "🔦 تفعيل كشف البيض"
ESPBtn.TextSize = 14
ESPBtn.Parent = PageESP

ESPBtn.MouseButton1Click:Connect(function()
    _G.EggESP = not _G.EggESP
    ESPBtn.Text = _G.EggESP and "🛑 إيقاف كشف البيض" or "🔦 تفعيل كشف البيض"
    if _G.EggESP then
        RunService.RenderStepped:Connect(function()
            if not _G.EggESP then return end
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name:lower():find("egg") then
                    if not obj:FindFirstChild("ESPHighlight") then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "ESPHighlight"
                        highlight.FillColor = Color3.fromRGB(255, 255, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
                        highlight.FillTransparency = 0.5
                        highlight.Parent = obj
                    end
                end
            end
        end)
    else
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:FindFirstChild("ESPHighlight") then
                obj.ESPHighlight:Destroy()
            end
        end
    end
end)

--[[ ================== الوظائف الأساسية ================== ]]
function SetHeadText(text)
    if Character and Character:FindFirstChild("Head") then
        local head = Character.Head
        local billboard = head:FindFirstChild("HeadTextBillboard")
        if not billboard then
            billboard = Instance.new("BillboardGui")
            billboard.Name = "HeadTextBillboard"
            billboard.Size = UDim2.new(0, 300, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 2.5, 0)
            billboard.AlwaysOnTop = true
            billboard.MaxDistance = 100
            billboard.Parent = head
            local label = Instance.new("TextLabel")
            label.Name = "TextLabel"
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.Font = Enum.Font.GothamBlack
            label.TextScaled = true
            label.TextStrokeTransparency = 0
            label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            label.Parent = billboard
        end
        billboard.TextLabel.Text = text
        if text == "" then billboard:Destroy() end
    end
end

function SafeSummon(query)
    local target = nil
    local terms = query:lower():split(" ")
    for _, parent in ipairs({Workspace, ReplicatedStorage}) do
        for _, obj in ipairs(parent:GetDescendants()) do
            if obj:IsA("BasePart") or obj:IsA("Model") or obj:IsA("Tool") then
                local objName = obj.Name:lower()
                for _, term in ipairs(terms) do
                    if term ~= "" and objName:find(term, 1, true) then
                        target = obj
                        break
                    end
                end
            end
            if target then break end
        end
        if target then break end
    end

    if not target then
        local possibleEvents = {"Spawn"..query, "Give"..query, "Create"..query, "Steal"..query, query}
        for _, eventName in ipairs(possibleEvents) do
            local event = ReplicatedStorage:FindFirstChild(eventName)
            if event and event:IsA("RemoteEvent") then
                event:FireServer()
                return
            end
        end
        print("[Omega] لم يتم العثور على كائن: " .. query)
        return
    end

    local Tool = Instance.new("Tool")
    Tool.Name = target.Name
    Tool.RequiresHandle = true
    Tool.ToolTip = target.Name

    local Handle = Instance.new("Part")
    Handle.Name = "Handle"
    Handle.Size = Vector3.new(1, 1, 1)
    Handle.Transparency = 1
    Handle.CanCollide = false
    Handle.Anchored = true
    Handle.Parent = Tool

    if target:IsA("Model") then
        local clone = target:Clone()
        for _, script in ipairs(clone:GetDescendants()) do
            if script:IsA("Script") or script:IsA("LocalScript") then script:Destroy() end
        end
        clone.Parent = Tool
        for _, part in ipairs(clone:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
                part.Anchored = false
                part.Massless = true
                part.Velocity = Vector3.zero
                part.RotVelocity = Vector3.zero
            end
        end
        local primary = clone.PrimaryPart or clone:FindFirstChildWhichIsA("BasePart")
        if primary then Handle.Size = primary.Size end
    else
        local clone = target:Clone()
        clone.CanCollide = false
        clone.Anchored = false
        clone.Massless = true
        clone.Velocity = Vector3.zero
        clone.RotVelocity = Vector3.zero
        clone.Parent = Tool
        Handle.Size = clone.Size
    end

    Tool.Parent = Backpack
    Humanoid:EquipTool(Tool)
    print("[Omega] تم استدعاء كائن حقيقي: " .. target.Name)
end

-- تحديث حجم القائمة
ScrollFrame.ChildAdded:Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
end)

print("[Summoner Omega] تم تحميل السيف الأعظم. لا مفتاح، لا قيود.")
