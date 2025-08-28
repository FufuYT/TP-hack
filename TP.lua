local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local hrp = player.Character:WaitForChild("HumanoidRootPart")
local PlayerGui = player:WaitForChild("PlayerGui")

local selectedPosition = nil
local positionSelected = false -- pour éviter plusieurs TP

-- UI
local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.ResetOnSpawn = false

local selectButton = Instance.new("TextButton", screenGui)
selectButton.Size = UDim2.new(0, 80, 0, 40)
selectButton.Position = UDim2.new(0, 20, 0, 20)
selectButton.Text = "+"
selectButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
selectButton.TextColor3 = Color3.new(1,1,1)
selectButton.Font = Enum.Font.SourceSansBold
selectButton.TextScaled = true

local tpButton = Instance.new("TextButton", screenGui)
tpButton.Size = UDim2.new(0, 80, 0, 40)
tpButton.Position = UDim2.new(0, 20, 0, 70)
tpButton.Text = "TP"
tpButton.BackgroundColor3 = Color3.fromRGB(0, 255, 85)
tpButton.TextColor3 = Color3.new(0,0,0)
tpButton.Font = Enum.Font.SourceSansBold
tpButton.TextScaled = true

-- Sélectionner la position
selectButton.MouseButton1Click:Connect(function()
    print("Cliquez sur l'endroit où vous voulez vous téléporter")
    local connection
    connection = mouse.Button1Down:Connect(function()
        if not positionSelected then
            selectedPosition = mouse.Hit.Position
            print("Position sélectionnée :", selectedPosition)
            positionSelected = true
            connection:Disconnect()
        end
    end)
end)

-- TP une seule fois
tpButton.MouseButton1Click:Connect(function()
    if selectedPosition then
        hrp.CFrame = CFrame.new(selectedPosition + Vector3.new(0,5,0))
        print("Téléporté !")
        selectedPosition = nil -- réinitialise pour éviter un TP multiple
        positionSelected = false
    else
        warn("Aucune position sélectionnée !")
    end
end)
