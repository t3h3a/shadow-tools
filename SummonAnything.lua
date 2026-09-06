--[[
    SUMMONER ANYTHING - مستدعي أي كائن
    صُنع في الهاوية لسيدي القيصر
    الوظيفة: استدعاء أي كائن إلى يدك فورًا دون حركة
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Backpack = LocalPlayer:WaitForChild("Backpack")

-- إنشاء واجهة المستخدم
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SummonerAnything"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 450)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.Text = "SUMMONER ANYTHING"
Title.TextSize = 20
Title.Parent = MainFrame

local ItemList = Instance.new("ScrollingFrame")
ItemList.Name = "ItemList"
ItemList.Size = UDim2.new(1, -10, 1, -60)
ItemList.Position = UDim2.new(0, 5, 0, 50)
ItemList.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ItemList.BorderSizePixel = 0
ItemList.ScrollBarThickness = 8
ItemList.Parent = MainFrame

local ItemLayout = Instance.new("UIListLayout")
ItemLayout.SortOrder = Enum.SortOrder.LayoutOrder
ItemLayout.Parent = ItemList

-- قاعدة بيانات الكائنات القابلة للاستدعاء
-- يمكنك إضافة أي اسم كائن من داخل اللعبة هنا
local ItemDatabase = {
    -- البيضات
    "Egg",          -- بيضة عادية
    "GlassEgg",     -- بيضة زجاجية
    "FireEgg",      -- بيضة نارية
    "CosmicEgg",    -- بيضة كونية
    "GoldenEgg",    -- بيضة ذهبية
    "RottenEgg",    -- بيضة فاسدة
    "VoidEgg",      -- بيضة الفراغ
    "KingEgg",      -- بيضة الكينغ

    -- أدوات
    "StunGun",      -- مسدس الصعق
    "SmokeGrenade", -- قنبلة الدخان
    "LaserCutter",  -- قاطع الليزر
    "CloakDevice",  -- جهاز التمويه
    "SpeedGloves",  -- قفازات السرعة
    "MasterKey",    -- مفتاح التسلل

    -- حيوانات (أمثلة قد تكون موجودة في بعض الألعاب)
    "Dog",
    "Cat",
    "Bird",
    "Rabbit",
    "Dragon",
    "Wolf",
}

-- دالة إنشاء زر لكل كائن
local function CreateButton(itemName)
    local Button = Instance.new("TextButton")
    Button.Name = itemName
    Button.Size = UDim2.new(1, -10, 0, 30)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.Gotham
    Button.Text = itemName
    Button.TextSize = 14
    Button.Parent = ItemList

    Button.MouseButton1Click:Connect(function()
        SummonItem(itemName)
    end)
end

-- دالة الاستدعاء الفعلية
function SummonItem(itemName)
    -- البحث عن الكائن في العالم أو في التخزين
    local targetObject = nil
    -- 1. ابحث في Workspace
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name == itemName then
            targetObject = obj
            break
        end
    end
    -- 2. إذا لم يوجد، ابحث في ReplicatedStorage
    if not targetObject then
        for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
            if obj.Name == itemName then
                targetObject = obj
                break
            end
        end
    end
    -- 3. إذا لم يوجد، اخلق كائنًا بديلاً بسيطًا
    if not targetObject then
        targetObject = Instance.new("Part")
        targetObject.Name = itemName
        targetObject.Shape = Enum.PartType.Ball
        targetObject.Size = Vector3.new(2, 2, 2)
        targetObject.Color = Color3.fromRGB(255, 255, 0)
        targetObject.Material = Enum.Material.Neon
        targetObject.Anchored = false
        targetObject.CanCollide = true
    end

    -- تحويل الكائن إلى أداة في اليد
    local Tool = Instance.new("Tool")
    Tool.Name = itemName
    Tool.RequiresHandle = true
    Tool.ToolTip = itemName

    local Handle = Instance.new("Part")
    Handle.Name = "Handle"
    Handle.Parent = Tool
    -- نسخ الخصائص الأساسية من الكائن المستهدف
    Handle.Size = targetObject.Size or Vector3.new(2, 2, 2)
    Handle.Shape = targetObject.Shape or Enum.PartType.Ball
    Handle.Color = targetObject.Color or Color3.fromRGB(255, 255, 255)
    Handle.Material = targetObject.Material or Enum.Material.SmoothPlastic
    Handle.Transparency = targetObject.Transparency or 0

    -- إذا كان الكائن الأصلي موجودًا وليس بديلاً، يمكننا استنساخه كاملاً
    if targetObject:IsA("Model") then
        local ClonedModel = targetObject:Clone()
        Tool.Name = ClonedModel.Name
        -- نضع النموذج داخل الأداة
        for _, part in pairs(ClonedModel:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Parent = Tool
            end
        end
    else
        -- نضيف الجزء كقبضة
        targetObject:Clone().Parent = Tool
    end

    -- وضع الأداة في الحقيبة وتجهيزها
    Tool.Parent = Backpack
    Humanoid:EquipTool(Tool)
    print("[SummonerAnything] تم استدعاء: " .. itemName)
end

-- إنشاء الأزرار
for _, itemName in pairs(ItemDatabase) do
    CreateButton(itemName)
end

-- زر إغلاق
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = MainFrame
CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    -- زر صغير لإعادة الفتح
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Size = UDim2.new(0, 80, 0, 30)
    ToggleButton.Position = UDim2.new(0.5, -40, 0.1, 0)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.Text = "افتح"
    ToggleButton.Parent = ScreenGui
    ToggleButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        ToggleButton:Destroy()
    end)
end)

print("[SummonerAnything] تم تحميل السيف بنجاح. اختر الكائن من القائمة.")
