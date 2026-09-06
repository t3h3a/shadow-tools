--[[
    SUMMONER_X_PRO - السيف الأسود الأسمى
    صُنع في الهاوية لسيدي القيصر
    الوظيفة: استدعاء أي كائن حقيقي + نص فوق الرأس + قائمة بيض سرية
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

--[[ ================== واجهة المستخدم ================== ]]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SummonerXPro"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 560)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -280)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- ظل خارجي
local Shadow = Instance.new("Frame")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(1, 20, 1, 20)
Shadow.Position = UDim2.new(0, -10, 0, -10)
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BorderSizePixel = 0
Shadow.Parent = MainFrame
Shadow.ZIndex = 0

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- شريط العنوان
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -60, 0, 50)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0, 255, 200)
Title.Font = Enum.Font.GothamBlack
Title.Text = "⚔️ SUMMONER X PRO ⚔️"
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "✕"
CloseButton.TextSize = 16
CloseButton.Parent = TitleBar
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- تبويبات
local TabFrame = Instance.new("Frame")
TabFrame.Name = "TabFrame"
TabFrame.Size = UDim2.new(1, 0, 0, 40)
TabFrame.Position = UDim2.new(0, 0, 0, 55)
TabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TabFrame.BorderSizePixel = 0
TabFrame.Parent = MainFrame

local SummonTab = Instance.new("TextButton")
SummonTab.Name = "SummonTab"
SummonTab.Size = UDim2.new(0.5, 0, 0, 40)
SummonTab.Position = UDim2.new(0, 0, 0, 0)
SummonTab.BackgroundColor3 = Color3.fromRGB(0, 180, 150)
SummonTab.TextColor3 = Color3.fromRGB(255, 255, 255)
SummonTab.Font = Enum.Font.GothamBold
SummonTab.Text = "استدعاء الكائنات"
SummonTab.TextSize = 14
SummonTab.Parent = TabFrame

local ChatTab = Instance.new("TextButton")
ChatTab.Name = "ChatTab"
ChatTab.Size = UDim2.new(0.5, 0, 0, 40)
ChatTab.Position = UDim2.new(0.5, 0, 0, 0)
ChatTab.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
ChatTab.TextColor3 = Color3.fromRGB(255, 255, 255)
ChatTab.Font = Enum.Font.GothamBold
ChatTab.Text = "الكتابة فوق الرأس"
ChatTab.TextSize = 14
ChatTab.Parent = TabFrame

-- صفحة الاستدعاء
local SummonPage = Instance.new("Frame")
SummonPage.Name = "SummonPage"
SummonPage.Size = UDim2.new(1, 0, 1, -105)
SummonPage.Position = UDim2.new(0, 0, 0, 95)
SummonPage.BackgroundTransparency = 1
SummonPage.Parent = MainFrame

local SearchBox = Instance.new("TextBox")
SearchBox.Name = "SearchBox"
SearchBox.Size = UDim2.new(1, -20, 0, 40)
SearchBox.Position = UDim2.new(0, 10, 0, 10)
SearchBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.PlaceholderText = "🔍 اكتب اسم الكائن (مثال: Egg, Dragon, Secret)"
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 14
SearchBox.Parent = SummonPage

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 8)
SearchCorner.Parent = SearchBox

local SearchBtn = Instance.new("TextButton")
SearchBtn.Name = "SearchBtn"
SearchBtn.Size = UDim2.new(1, -20, 0, 40)
SearchBtn.Position = UDim2.new(0, 10, 0, 55)
SearchBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
SearchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBtn.Font = Enum.Font.GothamBold
SearchBtn.Text = "⚡ استدعاء الآن"
SearchBtn.TextSize = 16
SearchBtn.Parent = SummonPage

local SearchBtnCorner = Instance.new("UICorner")
SearchBtnCorner.CornerRadius = UDim.new(0, 8)
SearchBtnCorner.Parent = SearchBtn

SearchBtn.MouseButton1Click:Connect(function()
    local query = SearchBox.Text
    if query ~= "" then
        SafeSummon(query)
    end
end)

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Size = UDim2.new(1, -20, 1, -110)
ScrollFrame.Position = UDim2.new(0, 10, 0, 105)
ScrollFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.Parent = SummonPage

local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(0, 8)
ScrollCorner.Parent = ScrollFrame

local UIList = Instance.new("UIListLayout")
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 5)
UIList.Parent = ScrollFrame

-- قاعدة بيانات الكائنات المعروفة
local ItemDatabase = {
    "Egg", "GlassEgg", "FireEgg", "CosmicEgg", "GoldenEgg", "RottenEgg", "VoidEgg", "KingEgg",
    "Secret Cerberus Egg", "Secret Mutant Shark Egg",
    "StunGun", "SmokeGrenade", "LaserCutter", "CloakDevice", "SpeedGloves", "MasterKey",
    "Dog", "Cat", "Bird", "Rabbit", "Dragon", "Wolf", "Shark", "Cerberus", "Mutant"
}

for _, name in ipairs(ItemDatabase) do
    local Btn = Instance.new("TextButton")
    Btn.Name = name
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

-- صفحة الكتابة فوق الرأس
local ChatPage = Instance.new("Frame")
ChatPage.Name = "ChatPage"
ChatPage.Size = UDim2.new(1, 0, 1, -105)
ChatPage.Position = UDim2.new(0, 0, 0, 95)
ChatPage.BackgroundTransparency = 1
ChatPage.Visible = false
ChatPage.Parent = MainFrame

local ChatInput = Instance.new("TextBox")
ChatInput.Name = "ChatInput"
ChatInput.Size = UDim2.new(1, -20, 0, 40)
ChatInput.Position = UDim2.new(0, 10, 0, 10)
ChatInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ChatInput.TextColor3 = Color3.fromRGB(255, 255, 255)
ChatInput.PlaceholderText = "✍️ اكتب النص الذي سيظهر فوق رأسك"
ChatInput.Font = Enum.Font.Gotham
ChatInput.TextSize = 14
ChatInput.Parent = ChatPage

local ChatCorner = Instance.new("UICorner")
ChatCorner.CornerRadius = UDim.new(0, 8)
ChatCorner.Parent = ChatInput

local ShowChatBtn = Instance.new("TextButton")
ShowChatBtn.Name = "ShowChatBtn"
ShowChatBtn.Size = UDim2.new(1, -20, 0, 40)
ShowChatBtn.Position = UDim2.new(0, 10, 0, 55)
ShowChatBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
ShowChatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowChatBtn.Font = Enum.Font.GothamBold
ShowChatBtn.Text = "💬 عرض فوق الرأس"
ShowChatBtn.TextSize = 16
ShowChatBtn.Parent = ChatPage

local ShowChatCorner = Instance.new("UICorner")
ShowChatCorner.CornerRadius = UDim.new(0, 8)
ShowChatCorner.Parent = ShowChatBtn

ShowChatBtn.MouseButton1Click:Connect(function()
    local text = ChatInput.Text
    if text ~= "" then
        SetHeadText(text)
    end
end)

local ClearChatBtn = Instance.new("TextButton")
ClearChatBtn.Name = "ClearChatBtn"
ClearChatBtn.Size = UDim2.new(1, -20, 0, 40)
ClearChatBtn.Position = UDim2.new(0, 10, 0, 105)
ClearChatBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
ClearChatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearChatBtn.Font = Enum.Font.GothamBold
ClearChatBtn.Text = "🗑️ إخفاء النص"
ClearChatBtn.TextSize = 16
ClearChatBtn.Parent = ChatPage

local ClearCorner = Instance.new("UICorner")
ClearCorner.CornerRadius = UDim.new(0, 8)
ClearCorner.Parent = ClearChatBtn

ClearChatBtn.MouseButton1Click:Connect(function()
    SetHeadText("")
end)

-- تفعيل التبويبات
SummonTab.MouseButton1Click:Connect(function()
    SummonTab.BackgroundColor3 = Color3.fromRGB(0, 180, 150)
    ChatTab.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    SummonPage.Visible = true
    ChatPage.Visible = false
end)

ChatTab.MouseButton1Click:Connect(function()
    ChatTab.BackgroundColor3 = Color3.fromRGB(0, 180, 150)
    SummonTab.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    ChatPage.Visible = true
    SummonPage.Visible = false
end)

--[[ ================== الوظائف ================== ]]

-- دالة عرض النص فوق الرأس
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
            local textLabel = Instance.new("TextLabel")
            textLabel.Name = "TextLabel"
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            textLabel.Font = Enum.Font.GothamBlack
            textLabel.TextScaled = true
            textLabel.TextStrokeTransparency = 0
            textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            textLabel.Parent = billboard
        end
        local label = billboard:FindFirstChild("TextLabel")
        label.Text = text
        if text == "" then
            billboard:Destroy()
        end
        print("[SummonerXPro] تم تحديث نص الرأس: " .. text)
    end
end

-- دالة الاستدعاء الآمن
function SafeSummon(query)
    local target = nil
    local searchTerms = query:lower():split(" ")

    -- بحث شامل في Workspace و ReplicatedStorage
    for _, parent in ipairs({Workspace, ReplicatedStorage}) do
        for _, obj in ipairs(parent:GetDescendants()) do
            if obj:IsA("BasePart") or obj:IsA("Model") or obj:IsA("Tool") then
                local objName = obj.Name:lower()
                for _, term in ipairs(searchTerms) do
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
        -- محاولة استخدام الأحداث
        local possibleEvents = {
            "Spawn" .. query, "Give" .. query, "Create" .. query,
            "Steal" .. query, "Summon" .. query, query
        }
        for _, eventName in ipairs(possibleEvents) do
            local event = ReplicatedStorage:FindFirstChild(eventName)
            if event and event:IsA("RemoteEvent") then
                event:FireServer()
                print("[SummonerXPro] تم إطلاق الحدث: " .. eventName)
                return
            end
        end
        print("[SummonerXPro] لم يتم العثور على كائن: " .. query)
        return
    end

    -- إنشاء أداة آمنة
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
        -- نزع أي سكربتات قاتلة من النسخة
        for _, script in ipairs(clone:GetDescendants()) do
            if script:IsA("Script") or script:IsA("LocalScript") then
                script:Destroy()
            end
        end
        clone.Parent = Tool
        -- ضبط الأجزاء
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
        if primary then
            Handle.Size = primary.Size
        end
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
    print("[SummonerXPro] تم استدعاء كائن حقيقي: " .. target.Name)
end

-- تحديث CanvasSize تلقائياً
ScrollFrame.ChildAdded:Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
end)

print("[SummonerXPro] تم تحميل السيف الأسود الأسمى بنجاح.")
