-- AutoClick GUI Script (100 CPS) - à mettre dans StarterPlayerScripts

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local playerGui = player:WaitForChild("PlayerGui")

-- Création de l'interface
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoClickerGUI"
screenGui.Parent = playerGui

-- Bouton "+"
local selectPosButton = Instance.new("TextButton")
selectPosButton.Size = UDim2.new(0,100,0,50)
selectPosButton.Position = UDim2.new(0,20,0,20)
selectPosButton.Text = "+"
selectPosButton.TextScaled = true
selectPosButton.Parent = screenGui

-- Label d'état
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0,250,0,50)
statusLabel.Position = UDim2.new(0,140,0,20)
statusLabel.Text = "Cliquez sur + pour choisir une position"
statusLabel.TextScaled = true
statusLabel.BackgroundTransparency = 0.3
statusLabel.Parent = screenGui

-- Bouton AutoClick
local autoClickButton = Instance.new("TextButton")
autoClickButton.Size = UDim2.new(0,150,0,50)
autoClickButton.Position = UDim2.new(0,20,0,90)
autoClickButton.Text = "AutoClick !"
autoClickButton.TextScaled = true
autoClickButton.Parent = screenGui

-- Variables
local clickPosition = nil
local autoClicking = false

-- Sélection de la position
selectPosButton.MouseButton1Click:Connect(function()
    statusLabel.Text = "Cliquez sur une partie de l'écran..."
    local connection
    connection = mouse.Button1Down:Connect(function()
        clickPosition = Vector2.new(mouse.X, mouse.Y)
        statusLabel.Text = "Position sauvegardée !"
        connection:Disconnect()
    end)
end)

-- AutoClick (100 CPS)
autoClickButton.MouseButton1Click:Connect(function()
    if not clickPosition then
        statusLabel.Text = "⚠️ Sélectionnez d'abord une position !"
        return
    end

    autoClicking = not autoClicking
    statusLabel.Text = autoClicking and "AutoClick activé (100 CPS) !" or "AutoClick désactivé !"

    task.spawn(function()
        while autoClicking do
            local guiObjects = playerGui:GetGuiObjectsAtPosition(clickPosition.X, clickPosition.Y)
            for _, obj in pairs(guiObjects) do
                if obj:IsA("GuiButton") then
                    obj:Activate()
                end
            end
            task.wait(0.01) -- 0.01 sec = 100 clics/seconde
        end
    end)
end)
