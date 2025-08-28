local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local PlayerGui = player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local normalSpeed = 16
local boostSpeed = 100
local boostEnabled = false
local noclipEnabled = false

-- UI compacte
local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0,140,0,50)
frame.Position = UDim2.new(0,10,0,10)
frame.BackgroundColor3 = Color3.fromRGB(50,50,50)
frame.BackgroundTransparency = 0.4

local boostButton = Instance.new("TextButton", frame)
boostButton.Size = UDim2.new(0.5,0,1,0)
boostButton.Position = UDim2.new(0,0,0,0)
boostButton.Text = "Boost OFF"
boostButton.BackgroundColor3 = Color3.fromRGB(255,170,0)
boostButton.TextScaled = true

local noclipButton = Instance.new("TextButton", frame)
noclipButton.Size = UDim2.new(0.5,0,1,0)
noclipButton.Position = UDim2.new(0.5,0,0,0)
noclipButton.Text = "Noclip OFF"
noclipButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
noclipButton.TextScaled = true

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

-- Déplacement noclip
RunService.RenderStepped:Connect(function(delta)
    -- Boost
    if humanoid then
        humanoid.WalkSpeed = boostEnabled and boostSpeed or normalSpeed
    end

    -- Noclip via CFrame
    if noclipEnabled then
        local moveVector = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + Vector3.new(0,0,-1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector + Vector3.new(0,0,1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector + Vector3.new(-1,0,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + Vector3.new(1,0,0) end
        hrp.CFrame = hrp.CFrame + moveVector.Unit * (boostEnabled and boostSpeed or normalSpeed) * delta
    end
end)
