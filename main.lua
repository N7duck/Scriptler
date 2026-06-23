--[ N7DUCK HUB | FINAL V82 | UNIVERSAL AIM & LOCK ]--
local Players, RunService = game:GetService("Players"), game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = game:GetService("Workspace").CurrentCamera
local CoreGui = game:GetService("CoreGui")
local valid_key = "N7Duck"

local function runHub()
    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    local state = {ESP=false, Aimbot=false, Lock=false}
    
    -- GİRİŞ ANİMASYONU
    local RainbowLabel = Instance.new("TextLabel", ScreenGui)
    RainbowLabel.Size = UDim2.new(0, 400, 0, 100) RainbowLabel.Position = UDim2.new(0.5, -200, 0.5, -50)
    RainbowLabel.Text = "N7Duck" RainbowLabel.Font = Enum.Font.GothamBold RainbowLabel.TextScaled = true
    RainbowLabel.BackgroundTransparency = 1
    task.spawn(function()
        for i = 1, 150 do RainbowLabel.TextColor3 = Color3.fromHSV(i/50, 1, 1) task.wait(0.02) end
        RainbowLabel:Destroy()
    end)
    task.wait(3)

    -- LOCK KUTUSU
    local LockFrame = Instance.new("TextButton", ScreenGui)
    LockFrame.Size = UDim2.new(0, 80, 0, 80) LockFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    LockFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) LockFrame.BackgroundTransparency = 0.5
    LockFrame.Text = "LOCK" LockFrame.TextColor3 = Color3.new(1,1,1)
    LockFrame.Active = true LockFrame.Draggable = true Instance.new("UICorner", LockFrame)
    LockFrame.MouseButton1Click:Connect(function()
        state.Lock = not state.Lock
        LockFrame.BackgroundColor3 = state.Lock and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 0, 0)
    end)

    -- MENÜ YAPISI
    local MainFrame = Instance.new("Frame", ScreenGui) MainFrame.Size = UDim2.new(0, 350, 0, 280) MainFrame.Position = UDim2.new(0.2, 0, 0.3, 0)
    MainFrame.BackgroundColor3 = Color3.new(1, 1, 1) MainFrame.Active = true MainFrame.Draggable = true Instance.new("UICorner", MainFrame)
    local SmallBox = Instance.new("TextButton", ScreenGui) SmallBox.Size = UDim2.new(0, 80, 0, 30) SmallBox.Position = UDim2.new(0.01, 0, 0.5, 0) SmallBox.Text = "N7Duck" SmallBox.Visible = false
    SmallBox.MouseButton1Click:Connect(function() MainFrame.Visible = true SmallBox.Visible = false end)
    local CloseBtn = Instance.new("TextButton", MainFrame) CloseBtn.Size = UDim2.new(0, 30, 0, 30) CloseBtn.Position = UDim2.new(0.9, 0, 0, 5) CloseBtn.Text = "X" CloseBtn.BackgroundColor3 = Color3.new(1, 0, 0)
    CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false SmallBox.Visible = true end)
    
    local holders = {}
    local tabs = {"Main", "ESP", "Aim", "Lang"}
    for i, name in pairs(tabs) do
        local btn = Instance.new("TextButton", MainFrame) btn.Size = UDim2.new(0.25, 0, 0.15, 0) btn.Position = UDim2.new(0.02, 0, 0.15 + (i-1)*0.18, 0) btn.Text = name
        local holder = Instance.new("Frame", MainFrame) holder.Size = UDim2.new(0.7,0,1,0) holder.Position = UDim2.new(0.3,0,0,0) holder.BackgroundTransparency = 1 holder.Visible = false
        table.insert(holders, holder) btn.MouseButton1Click:Connect(function() for _,h in pairs(holders) do h.Visible = false end holder.Visible = true end)
    end
    
    local Note = Instance.new("TextLabel", holders[1]) Note.Size = UDim2.new(0.9, 0, 0, 80) Note.Position = UDim2.new(0.05, 0, 0.3, 0) Note.TextScaled = true Note.BackgroundTransparency = 1 Note.Text = "Not: Espde Katiller rainbow, Serifler kipkirmizi, normal adamlar ise gridir"
    
    local function CreateBtn(parent, text, val)
        local b = Instance.new("TextButton", parent) b.Size = UDim2.new(0.8,0,0,40) b.Position = UDim2.new(0.1,0,0, 70 + (#parent:GetChildren()-1) * 55) b.Text = text
        b.MouseButton1Click:Connect(function() state[val] = not state[val] b.BackgroundColor3 = state[val] and Color3.new(0,1,0) or Color3.new(0.9,0.9,0.9) end) return b
    end
    CreateBtn(holders[2], "ESP", "ESP") CreateBtn(holders[3], "Aimbot", "Aimbot")
    
    local trB = Instance.new("TextButton", holders[4]) trB.Text = "Türkçe 🇹🇷" trB.Size = UDim2.new(0.8,0,0,40) trB.Position = UDim2.new(0.1,0,0,70)
    trB.MouseButton1Click:Connect(function() Note.Text = "Not: Espde Katiller rainbow, Serifler kipkirmizi, normal adamlar ise gridir" end)
    local enB = Instance.new("TextButton", holders[4]) enB.Text = "English 🇬🇧" enB.Size = UDim2.new(0.8,0,0,40) enB.Position = UDim2.new(0.1,0,0,120)
    enB.MouseButton1Click:Connect(function() Note.Text = "Note: Murderer is rainbow, sheriff is red, normal players are gray" end)
    
    -- ESP GÜNCELLEME
    local function updateESP(p)
        if not p.Character then return end
        local isM = p:FindFirstChild("Murderer") or (p:FindFirstChild("Backpack") and p.Backpack:FindFirstChild("Knife")) or p.Character:FindFirstChild("Knife")
        local isS = p:FindFirstChild("Sheriff") or (p:FindFirstChild("Backpack") and p.Backpack:FindFirstChild("Gun")) or p.Character:FindFirstChild("Gun")
        local h = p.Character:FindFirstChild("Highlight") or Instance.new("Highlight", p.Character)
        h.Enabled = state.ESP
        if isM then h.FillColor = Color3.fromHSV(tick() % 2 / 2, 1, 1) elseif isS then h.FillColor = Color3.fromRGB(255, 0, 0) else h.FillColor = Color3.fromRGB(128, 128, 128) end
    end
    Players.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function() task.wait(1) updateESP(p) end) end)
    
    -- ANA SİSTEM (HERKESE KİLİTLENME)
    RunService.Heartbeat:Connect(function()
        pcall(function()
            local myChar = LocalPlayer.Character
            if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end
            local closestTarget = nil
            local shortestDist = math.huge
            
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    if state.ESP then updateESP(p) end
                    
                    -- HERKESE KİTLENME
                    local dist = (p.Character.HumanoidRootPart.Position - myChar.HumanoidRootPart.Position).Magnitude
                    if dist < shortestDist then shortestDist = dist closestTarget = p.Character.HumanoidRootPart end
                end
            end
            
            if closestTarget then
                if state.Aimbot then Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestTarget.Position) end
                if state.Lock then myChar.HumanoidRootPart.CFrame = closestTarget.CFrame * CFrame.new(0, 0, 0.90) end
            end
        end)
    end)
end

local SG = Instance.new("ScreenGui", CoreGui)
local BG = Instance.new("Frame", SG) BG.Size = UDim2.new(0, 250, 0, 100) BG.Position = UDim2.new(0.5, -125, 0.5, -50)
local Box = Instance.new("TextBox", BG) Box.Size = UDim2.new(0, 200, 0, 40) Box.Position = UDim2.new(0.5, -100, 0.5, -20) Box.PlaceholderText = "Enter Key"
Box.FocusLost:Connect(function(enter) 
    if enter and Box.Text == valid_key then SG:Destroy() runHub() elseif enter then LocalPlayer:Kick("Wrong Key!") end
end)
