local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local PlayerGui = player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")

-- Paramètres
local normalSpeed = 16
local boostSpeed = 100
local boostEnabled = false
local noclipEnabled = false
local invincibleEnabled = false

-- UI compacte
local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0,160,0,50)
frame.Position = UDim2.new(0,10,0,10)
frame.BackgroundColor3 = Color3.fromRGB(50,50,50)
frame.BackgroundTransparency = 0.4
frame.BorderSizePixel = 0

-- Bouton Boost
local boostButton = Instance.new("TextButton", frame)
boostButton.Size = UDim2.new(0.33,0,1,0)
boostButton.Position = UDim2.new(0,0,0,0)
boostButton.Text = "Boost OFF"
boostButton.BackgroundColor3 = Color3.fromRGB(255,170,0)
boostButton.TextScaled = true

-- Bouton Noclip
local noclipButton = Instance.new("TextButton", frame)
noclipButton.Size = UDim2.new(0.33,0,1,0)
noclipButton.Position = UDim2.new(0.33,0,0,0)
noclipButton.Text = "Noclip OFF"
noclipButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
noclipButton.TextScaled = true

-- Bouton Invincible
local invButton = Instance.new("TextButton", frame)
invButton.Size = UDim2.new(0.34,0,1,0)
invButton.Position = UDim2.new(0.66,0,0,0)
invButton.Text = "Inv OFF"
invButton.BackgroundColor3 = Color3.fromRGB(170,0,255)
invButton.TextScaled = true

-- Toggle Boost
boostButton.MouseButton1Click:Connect(function()
    boostEnabled = not boostEnabled
    boostButton.Text = boostEnabled and "Boost ON" or "Boost OFF"
end)

-- Toggle Noclip
noclipButton.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    noclipButton.Text = noclipEnabled and "Noclip ON" or "Noclip OFF"
end)

-- Toggle Invincible
invButton.MouseButton1Click:Connect(function()
    invincibleEnabled = not invincibleEnabled
    invButton.Text = invincibleEnabled and "Inv ON" or "Inv OFF"
end)

-- Noclip, boost, invincibilité
RunService.RenderStepped:Connect(function()
    -- Boost de vitesse
    if humanoid then
        humanoid.WalkSpeed = boostEnabled and boostSpeed or normalSpeed
    end

    -- Noclip
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.CanCollide = not noclipEnabled
        end
    end

    -- Invincible
    if invincibleEnabled then
        humanoid.Health = humanoid.MaxHealth
    end
end)
