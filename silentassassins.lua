--Bùm bùm chéo chéo con mẹ mày béo
--https://discord.gg/usv255Pw4t 
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("tzuanSmartUI") then
    CoreGui.tzuanSmartUI:Destroy()
end

local SG = Instance.new("ScreenGui")
SG.Name = "tzuanSmartUI"
SG.Parent = CoreGui

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 20, 0, 20)
ToggleBtn.Position = UDim2.new(0, 10, 0, 10)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleBtn.Text = ""
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = SG

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 240, 0, 140)
MainFrame.Position = UDim2.new(0.5, -120, 0.5, -70)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = SG

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Title.TextColor3 = Color3.fromRGB(255, 200, 0)
Title.Text = "⚡ tzuan "
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.Parent = MainFrame

local AutoBtn = Instance.new("TextButton")
AutoBtn.Size = UDim2.new(0.9, 0, 0, 40)
AutoBtn.Position = UDim2.new(0.05, 0, 0, 40)
AutoBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
AutoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoBtn.Text = "Auto Round(Chỉ bật ở sảnh): OFF"
AutoBtn.Font = Enum.Font.SourceSansBold
AutoBtn.TextSize = 15
AutoBtn.Parent = MainFrame

local ESPBtn = Instance.new("TextButton")
ESPBtn.Size = UDim2.new(0.9, 0, 0, 40)
ESPBtn.Position = UDim2.new(0.05, 0, 0, 90)
ESPBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 200)
ESPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPBtn.Text = "ESP Xuyên Tàng Hình: OFF"
ESPBtn.Font = Enum.Font.SourceSansBold
ESPBtn.TextSize = 15
ESPBtn.Parent = MainFrame

_G.AutoRound = false
_G.ESPEnabled = false
_G.LobbyPos = nil
local SAFE_RADIUS = 40 

AutoBtn.MouseButton1Click:Connect(function()
    _G.AutoRound = not _G.AutoRound
    if _G.AutoRound then 
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            _G.LobbyPos = LocalPlayer.Character.HumanoidRootPart.Position
            AutoBtn.Text = "Đang ở Sảnh (Chờ vô trận...)"
            AutoBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        else
            AutoBtn.Text = "Lỗi: Nhân vật chưa load!"
            _G.AutoRound = false
        end
    else
        AutoBtn.Text = "Auto Round(Chỉ bật ở sảnh): OFF"
        AutoBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        _G.LobbyPos = nil
    end
end)

ESPBtn.MouseButton1Click:Connect(function()
    _G.ESPEnabled = not _G.ESPEnabled
    ESPBtn.Text = "ESP Xuyên Tàng Hình: " .. (_G.ESPEnabled and "ON" or "OFF")
    ESPBtn.BackgroundColor3 = _G.ESPEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(50, 50, 200)
end)

task.spawn(function()
    while task.wait(0.05) do        
        if _G.ESPEnabled then
            for _, enemy in pairs(Players:GetPlayers()) do
                if enemy ~= LocalPlayer and enemy.Character then
                    local eHum = enemy.Character:FindFirstChild("Humanoid")
                    local eRoot = enemy.Character:FindFirstChild("HumanoidRootPart")
                    
                    if eHum and eHum.Health > 0 and eRoot then
                        local hl = enemy.Character:FindFirstChild("tzuanHL")
                        if not hl then
                            hl = Instance.new("Highlight")
                            hl.Name = "tzuanHL"
                            hl.FillColor = Color3.fromRGB(255, 0, 0)
                            hl.FillTransparency = 0.5
                            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            hl.Parent = enemy.Character
                        end

                        local tracker = eRoot:FindFirstChild("tzuanTracker")
                        if not tracker then
                            tracker = Instance.new("BillboardGui")
                            tracker.Name = "tzuanTracker"
                            tracker.AlwaysOnTop = true
                            tracker.Size = UDim2.new(4, 0, 5, 0)
                            local frame = Instance.new("Frame")
                            frame.Size = UDim2.new(1, 0, 1, 0)
                            frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                            frame.BackgroundTransparency = 0.6
                            frame.BorderSizePixel = 2
                            frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
                            frame.Parent = tracker
                            tracker.Parent = eRoot
                        end
                                                
                        for _, part in pairs(enemy.Character:GetChildren()) do
                            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" and part.Transparency == 1 then
                                part.Transparency = 0.5 
                            end
                        end
                    else
                        if enemy.Character:FindFirstChild("tzuanHL") then enemy.Character.tzuanHL:Destroy() end
                        if eRoot and eRoot:FindFirstChild("tzuanTracker") then eRoot.tzuanTracker:Destroy() end
                    end
                end
            end
        else
            for _, enemy in pairs(Players:GetPlayers()) do
                if enemy.Character then
                    if enemy.Character:FindFirstChild("tzuanHL") then enemy.Character.tzuanHL:Destroy() end
                    local eRoot = enemy.Character:FindFirstChild("HumanoidRootPart")
                    if eRoot and eRoot:FindFirstChild("tzuanTracker") then eRoot.tzuanTracker:Destroy() end
                end
            end
        end
        
        if _G.AutoRound and _G.LobbyPos and LocalPlayer.Character then
            local myChar = LocalPlayer.Character
            local myRoot = myChar:FindFirstChild("HumanoidRootPart")
            local myHum = myChar:FindFirstChild("Humanoid")
            
            if myRoot and myHum and myHum.Health > 0 then                
                
                local myDistFromLobby = (myRoot.Position - _G.LobbyPos).Magnitude
                
                if myDistFromLobby <= SAFE_RADIUS then                    
                    AutoBtn.Text = "Đang ở Sảnh (Chờ vô trận...)"
                    AutoBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
                else                    
                    local tool = myChar:FindFirstChildOfClass("Tool")
                    if not tool then
                        local bpTool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                        if bpTool then myHum:EquipTool(bpTool) end
                    end
                    
                    if tool then
                        local bringPos = myRoot.Position + (myRoot.CFrame.LookVector * 4)
                        local validEnemies = 0
                                                
                        for _, enemy in pairs(Players:GetPlayers()) do
                            if enemy ~= LocalPlayer and enemy.Character then
                                local eRoot = enemy.Character:FindFirstChild("HumanoidRootPart")
                                local eHum = enemy.Character:FindFirstChild("Humanoid")
                                                                
                                if eRoot and eHum and eHum.Health > 0 and not enemy.Character:FindFirstChildOfClass("ForceField") then
                                                                       
                                    local enemyDistFromLobby = (eRoot.Position - _G.LobbyPos).Magnitude
                                    if enemyDistFromLobby > SAFE_RADIUS then
                                        eRoot.CFrame = CFrame.new(bringPos)
                                        validEnemies = validEnemies + 1
                                    end
                                end
                            end
                        end
                                                
                        if validEnemies > 0 then
                            AutoBtn.Text = "🔥 ĐANG CHÉM (" .. validEnemies .. " ĐỊCH)"
                            AutoBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
                            
                            task.wait(0.2) 
                            tool:Activate()
                            task.wait(0.05)
                            tool:Deactivate()
                        else                            
                            AutoBtn.Text = "🏆 THẮNG! (Chờ về Sảnh...)"
                            AutoBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
                        end
                    end
                end
            end
        end
    end
end)
