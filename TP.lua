local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local hrp = player.Character:WaitForChild("HumanoidRootPart")
local PlayerGui = player:WaitForChild("PlayerGui")

local selectedPosition = nil
local positionSelected = false

-- UI
local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.ResetOnSpawn = false

-- Bouton "+"
local selectButton = Instance.new("TextButton", screenGui)
selectButton.Size = UDim2.new(0, 80, 0, 40)
selectButton.Position = UDim2.new(0, 20, 0, 20)
selectButton.Text = "+"
selectButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
selectButton.TextColor3 = Color3.new(1,1,1)
selectButton.Font = Enum.Font.SourceSansBold
selectButton.TextScaled = true

-- Bouton TP
local tpButton = Instance.new("TextButton", screenGui)
tpButton.Size = UDim2.new(0, 80, 0, 40)
tpButton.Position = UDim2.new(0, 20, 0, 70)
tpButton.Text = "TP"
tpButton.BackgroundColor3 = Color3.fromRGB(0, 255, 85)
tpButton.TextColor3 = Color3.new(0,0,0)
tpButton.Font = Enum.Font.SourceSansBold
tpButton.TextScaled = true

-- Label d'information
local infoLabel = Instance.new("TextLabel", screenGui)
infoLabel.Size = UDim2.new(0, 300, 0, 30)
infoLabel.Position = UDim2.new(0, 120, 0, 20)
infoLabel.Text = ""
infoLabel.TextColor3 = Color3.fromRGB(255,255,255)
infoLabel.BackgroundTransparency = 1
infoLabel.Font = Enum.Font.SourceSansBold
infoLabel.TextScaled = true

-- Sélectionner la position
selectButton.MouseButton1Click:Connect(function()
    infoLabel.Text = "Cliquez sur un endroit"
    print("Cliquez sur l'endroit où vous voulez vous téléporter")
    local connection
    connection = mouse.Button1Down:Connect(function()
        if not positionSelected then
            selectedPosition = mouse.Hit.Position
            positionSelected = true
            infoLabel.Text = "Position sauvegardée !"
            print("Position sélectionnée :", selectedPosition)
            connection:Disconnect()
        end
    end)
end)

-- TP une seule fois
tpButton.MouseButton1Click:Connect(function()
    if selectedPosition then
        hrp.CFrame = CFrame.new(selectedPosition + Vector3.new(0,5,0))
        print("Téléporté !")
        infoLabel.Text = "Téléporté !"
        -- réinitialiser pour permettre une nouvelle sélection
        selectedPosition = nil
        positionSelected = false
    else
        warn("Aucune position sélectionnée !")
        infoLabel.Text = "Aucune position sélectionnée !"
    end
end)
