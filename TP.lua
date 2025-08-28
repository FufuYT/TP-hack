local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local PlayerGui = player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local mouse = player:GetMouse()

local targetPos = nil
local choosing = false

-- UI
local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0,160,0,50)
frame.Position = UDim2.new(0,10,0,10)
frame.BackgroundColor3 = Color3.fromRGB(50,50,50)
frame.BackgroundTransparency = 0.4

local chooseButton = Instance.new("TextButton", frame)
chooseButton.Size = UDim2.new(0.5,0,1,0)
chooseButton.Position = UDim2.new(0,0,0,0)
chooseButton.Text = "+ (Choisir)"
chooseButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
chooseButton.TextScaled = true

local tpButton = Instance.new("TextButton", frame)
tpButton.Size = UDim2.new(0.5,0,1,0)
tpButton.Position = UDim2.new(0.5,0,0,0)
tpButton.Text = "TP"
tpButton.BackgroundColor3 = Color3.fromRGB(255,170,0)
tpButton.TextScaled = true

-- Choisir la position
chooseButton.MouseButton1Click:Connect(function()
    choosing = true
    chooseButton.Text = "Cliquez sur un endroit"
end)

mouse.Button1Down:Connect(function()
    if choosing then
        targetPos = mouse.Hit.Position
        choosing = false
        chooseButton.Text = "+ (Choisir)"
    end
end)

-- TP à la position choisie
tpButton.MouseButton1Click:Connect(function()
    if targetPos then
        hrp.CFrame = CFrame.new(targetPos)
    end
end)
