local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local PlayerGui = player:WaitForChild("PlayerGui")

local speedBoost = 100 -- vitesse du boost
local boostEnabled = false

-- UI compacte
local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0,120,0,50)
frame.Position = UDim2.new(0,10,0,10) -- coin en haut à gauche
frame.BackgroundColor3 = Color3.fromRGB(50,50,50)
frame.BackgroundTransparency = 0.4
frame.BorderSizePixel = 0

local boostButton = Instance.new("TextButton", frame)
boostButton.Size = UDim2.new(1,0,1,0)
boostButton.Position = UDim2.new(0,0,0,0)
boostButton.Text = "Boost OFF"
boostButton.BackgroundColor3 = Color3.fromRGB(255,170,0)
boostButton.TextScaled = true

-- Activer / désactiver le boost
boostButton.MouseButton1Click:Connect(function()
    boostEnabled = not boostEnabled
    boostButton.Text = boostEnabled and "Boost ON" or "Boost OFF"
end)

-- Appliquer le boost
humanoid.WalkSpeed = 16 -- vitesse normale

game:GetService("RunService").RenderStepped:Connect(function()
    if boostEnabled then
        humanoid.WalkSpeed = speedBoost
    else
        humanoid.WalkSpeed = 16 -- remettre à la normale si boost off
    end
end)
