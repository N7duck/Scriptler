local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 1. GİRİŞ ANIMASYONU
local introGui = Instance.new("ScreenGui", playerGui)
local frameIntro = Instance.new("Frame", introGui)
frameIntro.Size = UDim2.new(0, 0, 0, 0)
frameIntro.Position = UDim2.new(0.5, 0, 0.5, 0)
frameIntro.BackgroundColor3 = Color3.new(0, 0, 0)
frameIntro.BorderSizePixel = 3
frameIntro.BorderColor3 = Color3.new(1, 1, 1)

local textLabel = Instance.new("TextLabel", frameIntro)
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.Text = "N7 Duck"
textLabel.TextScaled = true
textLabel.Font = Enum.Font.GothamBold

local growInfo = TweenInfo.new(1.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local growTween = TweenService:Create(frameIntro, growInfo, {Size = UDim2.new(0, 300, 0, 100), Position = UDim2.new(0.5, -150, 0.5, -50)})
growTween:Play()

growTween.Completed:Connect(function()
    task.wait(1)
    TweenService:Create(frameIntro, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -150, -0.5, 0), BackgroundTransparency = 1}):Play()
    TweenService:Create(textLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    
    task.wait(1)
    introGui:Destroy()

    -- 2. ANA HİLE MENÜSÜ
    local mainGui = Instance.new("ScreenGui", playerGui)
    local frame = Instance.new("Frame", mainGui)
    frame.Size = UDim2.new(0, 220, 0, 120)
    frame.Position = UDim2.new(0.5, -110, 0.5, -60)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BorderSizePixel = 3
    frame.Active = true
    frame.ZIndex = 1

    -- BAŞLIK
    local headerTitle = Instance.new("TextLabel", frame)
    headerTitle.Size = UDim2.new(1, 0, 0, 25)
    headerTitle.BackgroundTransparency = 1
    headerTitle.Text = "N7Duck"
    headerTitle.Font = Enum.Font.GothamBold
    headerTitle.TextScaled = true
    headerTitle.TextColor3 = Color3.new(1, 1, 1)
    headerTitle.ZIndex = 2

    -- SÜRÜKLEME ALANI
    local dragHandle = Instance.new("Frame", frame)
    dragHandle.Size = UDim2.new(1, 0, 0, 25)
    dragHandle.BackgroundTransparency = 1 
    dragHandle.ZIndex = 2

    -- TEXTBOX (Buraya odaklandık)
    local textBox = Instance.new("TextBox", frame)
    textBox.Size = UDim2.new(0, 180, 0, 40)
    textBox.Position = UDim2.new(0, 20, 0, 40)
    textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    textBox.BackgroundTransparency = 0.2
    textBox.TextColor3 = Color3.new(1, 1, 1)
    textBox.TextScaled = true
    textBox.Text = ""
    textBox.Visible = true
    textBox.ZIndex = 2
    
    local uiStroke = Instance.new("UIStroke", textBox)
    uiStroke.Color = Color3.new(1, 1, 1)
    uiStroke.Thickness = 1

    -- RESIZE BUTONU
    local resizeBtn = Instance.new("TextButton", frame)
    resizeBtn.Size = UDim2.new(0, 30, 0, 30)
    resizeBtn.Position = UDim2.new(1, -30, 1, -30)
    resizeBtn.Text = "⇲"
    resizeBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    resizeBtn.ZIndex = 2

    -- RAINBOW EFEKTİ
    RunService.RenderStepped:Connect(function()
        local color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        frame.BorderColor3 = color
        resizeBtn.TextColor3 = color
        headerTitle.TextColor3 = color
        uiStroke.Color = color
    end)

    -- KONTROLLER
    local dragging, resizing, dragStart, startPos, startSize
    dragHandle.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true; dragStart = input.Position; startPos = frame.Position end end)
    resizeBtn.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then resizing = true; dragStart = input.Position; startSize = frame.Size end end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging then local delta = input.Position - dragStart; frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        elseif resizing then local delta = input.Position - dragStart; frame.Size = UDim2.new(0, math.max(120, startSize.X.Offset + delta.X), 0, math.max(80, startSize.Y.Offset + delta.Y)) end
    end)
    UserInputService.InputEnded:Connect(function() dragging = false; resizing = false end)
end)
