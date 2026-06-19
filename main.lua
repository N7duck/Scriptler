--[ N7DUCK HUB | FINAL V37 - KESİN RENK VE HİTBOX ]--
local Players, RunService, TweenService = game:GetService("Players"), game:GetService("RunService"), game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- GİRİŞ ANİMASYONU
local AnimGui = Instance.new("ScreenGui", game.CoreGui)
local IntroText = Instance.new("TextLabel", AnimGui)
IntroText.Size = UDim2.new(0,0,0,0) IntroText.Position = UDim2.new(0.5,0,0.5,0) IntroText.Text = "N7 DUCK" 
IntroText.Font = Enum.Font.GothamBold IntroText.TextSize = 80 IntroText.BackgroundTransparency = 1 IntroText.AnchorPoint = Vector2.new(0.5,0.5)
spawn(function() for i=0,1,0.02 do IntroText.TextColor3 = Color3.fromHSV(i,1,1) task.wait(0.01) end end)
TweenService:Create(IntroText, TweenInfo.new(1.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 600, 0, 150)}):Play()
task.wait(2) AnimGui:Destroy()

-- ANA MENÜ
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 350, 0, 280) MainFrame.Position = UDim2.new(0.2, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.new(1, 1, 1) MainFrame.Active = true MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

local CloseBtn = Instance.new("TextButton", MainFrame) 
CloseBtn.Size = UDim2.new(0, 30, 0, 30) CloseBtn.Position = UDim2.new(0.9, 0, 0, 5) CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.new(1, 0, 0)

local SmallBox = Instance.new("TextButton", ScreenGui) 
SmallBox.Size = UDim2.new(0, 80, 0, 30) SmallBox.Position = UDim2.new(0.01, 0, 0.5, 0) 
SmallBox.Text = "N7Duck" SmallBox.Visible = false

CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false SmallBox.Visible = true end)
SmallBox.MouseButton1Click:Connect(function() MainFrame.Visible = true SmallBox.Visible = false end)

-- SEKMELER
local tabs = {"Main", "ESP", "Aim", "Lang"}
local holders = {}
local state = {ESP=false, Item=false, Hitbox=false}
local lang = "TR"

for i, name in pairs(tabs) do
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0.25, 0, 0.15, 0) btn.Position = UDim2.new(0.02, 0, 0.15 + (i-1)*0.18, 0)
    btn.Text = name btn.BackgroundColor3 = Color3.new(0.9, 0.9, 0.9)
    local holder = Instance.new("Frame", MainFrame) holder.Size = UDim2.new(0.7,0,1,0) holder.Position = UDim2.new(0.3,0,0,0) holder.BackgroundTransparency = 1 holder.Visible = false
    table.insert(holders, holder)
    btn.MouseButton1Click:Connect(function() for _,h in pairs(holders) do h.Visible = false end holder.Visible = true end)
end

-- NOT
local note = Instance.new("TextLabel", holders[1])
note.Size = UDim2.new(0.9, 0, 0.4, 0) note.Position = UDim2.new(0.05, 0, 0.15, 0)
note.Text = "NOT: Katil: Yeşil, Şerif: Kırmızı, Normal Oyuncular: Gri olarak ayarlanmıştır."
note.TextWrapped = true note.BackgroundTransparency = 1 note.TextColor3 = Color3.new(0,0,0)

-- BUTONLAR
local function CreateBtn(parent, text, val)
    local b = Instance.new("TextButton", parent) b.Size = UDim2.new(0.8,0,0,40) 
    b.Position = UDim2.new(0.1,0,0, 70 + (#parent:GetChildren()-1) * 55) 
    b.Text = text b.BackgroundColor3 = Color3.new(0.9,0.9,0.9)
    b.MouseButton1Click:Connect(function() 
        state[val] = not state[val]
        b.BackgroundColor3 = state[val] and Color3.new(0,1,0) or Color3.new(0.9,0.9,0.9)
    end)
    return b
end

CreateBtn(holders[2], "ESP", "ESP")
CreateBtn(holders[2], "Item ESP", "Item")
CreateBtn(holders[3], "Hitbox (Katil)", "Hitbox")

-- DİL BUTONLARI
local trB = Instance.new("TextButton", holders[4]) trB.Text = "Türkçe 🇹🇷" trB.Size = UDim2.new(0.8,0,0,40) trB.Position = UDim2.new(0.1,0,0,70)
local enB = Instance.new("TextButton", holders[4]) enB.Text = "English 🇬🇧" enB.Size = UDim2.new(0.8,0,0,40) enB.Position = UDim2.new(0.1,0,0,120)
trB.MouseButton1Click:Connect(function() lang = "TR" trB.BackgroundColor3 = Color3.new(0,1,0) enB.BackgroundColor3 = Color3.new(0.9,0.9,0.9) end)
enB.MouseButton1Click:Connect(function() lang = "EN" enB.BackgroundColor3 = Color3.new(0,1,0) trB.BackgroundColor3 = Color3.new(0.9,0.9,0.9) end)

-- DÖNGÜ
RunService.Heartbeat:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local isM = p:FindFirstChild("Murderer") or p.Backpack:FindFirstChild("Knife")
            local isS = p:FindFirstChild("Sheriff") or p.Backpack:FindFirstChild("Gun")
            local root = p.Character:FindFirstChild("HumanoidRootPart")
            
            -- ESP GÜNCELLEME
            if state.ESP then
                local h = p.Character:FindFirstChild("Highlight") or Instance.new("Highlight", p.Character)
                h.Adornee = p.Character h.Enabled = true h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                
                if isM then h.FillColor = Color3.fromRGB(0, 255, 0)
                elseif isS then h.FillColor = Color3.fromRGB(255, 0, 0)
                else h.FillColor = Color3.fromRGB(128, 128, 128) end
            else
                local h = p.Character:FindFirstChild("Highlight") if h then h:Destroy() end
            end
            
            -- HİTBOX
            if state.Hitbox and isM then
                if root then root.Size = Vector3.new(10,10,10) root.Transparency = 0.5 root.CanCollide = false root.Massless = true end
            elseif root and root.Size == Vector3.new(10,10,10) then
                root.Size = Vector3.new(2,2,1) root.Transparency = 1
            end
        end
    end
end)
