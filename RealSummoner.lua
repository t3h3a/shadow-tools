--[[
    REAL_SUMMONER - سيف الصيد الحقيقي
    صُنع في الهاوية لسيدي القيصر
    الوظيفة: استدعاء الكائنات الحقيقية من عالم اللعبة دون بدائل وهمية
    الترخيص: ميثاق الدم
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
ScreenGui.Name = "RealSummoner"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 500)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.Text = "REAL SUMMONER"
Title.TextSize = 20
Title.Parent = MainFrame

-- صندوق إدخال اسم الكائن يدوياً
local InputBox = Instance.new("TextBox")
InputBox.Name = "InputBox"
InputBox.Size = UDim2.new(1, -10, 0, 40)
InputBox.Position = UDim2.new(0, 5, 0, 50)
InputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.Font = Enum.Font.Gotham
InputBox.PlaceholderText = "اكتب اسم الكائن هنا (مثل Egg, Dog, Cat)"
InputBox.TextSize = 14
InputBox.Parent = MainFrame

local SearchButton = Instance.new("TextButton")
SearchButton.Name = "SearchButton"
SearchButton.Size = UDim2.new(1, -10, 0, 30)
SearchButton.Position = UDim2.new(0, 5, 0, 95)
SearchButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
SearchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchButton.Font = Enum.Font.GothamBold
SearchButton.Text = "استدعاء"
SearchButton.TextSize = 14
SearchButton.Parent = MainFrame

SearchButton.MouseButton1Click:Connect(function()
    local query = InputBox.Text
    if query ~= "" then
        SummonReal(query)
    end
end)

-- قائمة الأسماء الشائعة كأزرار سريعة
local CommonList = Instance.new("ScrollingFrame")
CommonList.Name = "CommonList"
CommonList.Size = UDim2.new(1, -10, 1, -140)
CommonList.Position = UDim2.new(0, 5, 0, 130)
CommonList.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
CommonList.BorderSizePixel = 0
CommonList.ScrollBarThickness = 8
CommonList.Parent = MainFrame

local ItemLayout = Instance.new("UIListLayout")
ItemLayout.SortOrder = Enum.SortOrder.LayoutOrder
ItemLayout.Parent = CommonList

local CommonNames = {
    "Egg", "GlassEgg", "FireEgg", "CosmicEgg", "GoldenEgg", "RottenEgg", "VoidEgg", "KingEgg",
    "StunGun", "SmokeGrenade", "LaserCutter", "CloakDevice", "SpeedGloves", "MasterKey",
    "Dog", "Cat", "Bird", "Rabbit", "Dragon", "Wolf", "EggBag"
}

for _, name in ipairs(CommonNames) do
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Size = UDim2.new(1, -10, 0, 30)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.Gotham
    Button.Text = name
    Button.TextSize = 14
    Button.Parent = CommonList
    Button.MouseButton1Click:Connect(function()
        SummonReal(name)
    end)
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

-- دالة الاستدعاء الحقيقي
function SummonReal(query)
    local targetObject = nil
    local searchTerms = query:lower():split(" ")

    -- البحث في جميع الكائنات داخل Workspace و ReplicatedStorage
    for _, parent in ipairs({Workspace, ReplicatedStorage}) do
        for _, obj in ipairs(parent:GetDescendants()) do
            if obj:IsA("BasePart") or obj:IsA("Model") or obj:IsA("Tool") then
                local objName = obj.Name:lower()
                -- فحص تطابق جزئي: إذا كان اسم الكائن يحتوي على أي كلمة من كلمات البحث
                for _, term in ipairs(searchTerms) do
                    if objName:find(term, 1, true) then
                        targetObject = obj
                        break
                    end
                end
            end
            if targetObject then break end
        end
        if targetObject then break end
    end

    -- إذا لم نعثر على الكائن، نستخدم الأحداث الخادمية كحل أخير
    if not targetObject then
        local possibleEvents = {
            "Spawn" .. query,
            "Give" .. query,
            "Create" .. query,
            "Steal" .. query,
            "Summon" .. query
        }
        for _, eventName in ipairs(possibleEvents) do
            local event = ReplicatedStorage:FindFirstChild(eventName) or ReplicatedStorage:FindFirstChild(query)
            if event and event:IsA("RemoteEvent") then
                event:FireServer()
                print("[RealSummoner] تم استدعاء الحدث: " .. eventName)
                return
            end
        end
        print("[RealSummoner] لم يتم العثور على كائن حقيقي بالاسم: " .. query)
        return
    end

    -- إنشاء أداة تحتوي على نسخة حقيقية من الكائن
    local Tool = Instance.new("Tool")
    Tool.Name = targetObject.Name
    Tool.RequiresHandle = true
    Tool.ToolTip = targetObject.Name

    local Handle = Instance.new("Part")
    Handle.Name = "Handle"
    Handle.Parent = Tool
    Handle.Size = Vector3.new(1, 1, 1)
    Handle.Transparency = 1
    Handle.CanCollide = false

    if targetObject:IsA("Model") then
        -- استنساخ النموذج بالكامل
        local ClonedModel = targetObject:Clone()
        ClonedModel.Parent = Tool
        -- جعل الأجزاء لا تتعارض
        for _, part in ipairs(ClonedModel:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
                part.Anchored = false
            end
        end
        -- ضبط المقبض على أول جزء رئيسي
        local primaryPart = ClonedModel.PrimaryPart or ClonedModel:FindFirstChildWhichIsA("BasePart")
        if primaryPart then
            Handle.Size = primaryPart.Size
            Handle.Transparency = 1
        end
    else
        -- استنساخ الجزء مباشرة
        local ClonedPart = targetObject:Clone()
        ClonedPart.Parent = Tool
        ClonedPart.CanCollide = false
        ClonedPart.Anchored = false
        Handle.Size = ClonedPart.Size
    end

    Tool.Parent = Backpack
    Humanoid:EquipTool(Tool)
    print("[RealSummoner] تم استدعاء الكائن الحقيقي: " .. targetObject.Name)
end

print("[RealSummoner] تم تحميل السيف بنجاح. ابحث عن الكائن أو اكتب اسمه.")
