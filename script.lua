-- Script autonome AutoClick avec GUI
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local playerGui = player:WaitForChild("PlayerGui")

-- Création du ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoClickerGUI"
screenGui.Parent = playerGui

-- Création du bouton +
local selectPosButton = Instance.new("TextButton")
selectPosButton.Size = UDim2.new(0,100,0,50)
selectPosButton.Position = UDim2.new(0,20,0,20)
selectPosButton.Text = "+"
selectPosButton.Parent = screenGui

-- Création du label de statut
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0,200,0,50)
statusLabel.Position = UDim2.new(0,140,0,20)
statusLabel.Text = "Cliquer sur une partie de l'écran"
statusLabel.TextScaled = true
statusLabel.Parent = screenGui

-- Création du bouton AutoClick
local autoClickButton = Instance.new("TextButton")
autoClickButton.Size = UDim2.new(0,150,0,50)
autoClickButton.Position = UDim2.new(0,20,0,80)
autoClickButton.Text = "AutoClick !"
autoClickButton.Parent = screenGui

-- Variables
local clickPosition
local autoClicking = false

-- Fonction pour sélectionner la position
selectPosButton.MouseButton1Click:Connect(function()
    statusLabel.Text = "Cliquer sur une partie de l'écran"
    
    local connection
    connection = mouse.Button1Down:Connect(function()
        clickPosition = Vector2.new(mouse.X, mouse.Y)
        statusLabel.Text = "Position sauvegardée !"
        connection:Disconnect()
    end)
end)

-- Fonction pour auto-click
autoClickButton.MouseButton1Click:Connect(function()
    if not clickPosition then
        statusLabel.Text = "Sélectionnez d'abord une position !"
        return
    end

    autoClicking = not autoClicking
    statusLabel.Text = autoClicking and "AutoClick activé !" or "AutoClick désactivé !"

    spawn(function()
        while autoClicking do
            local guiObjects = screenGui:GetGuiObjectsAtPosition(clickPosition.X, clickPosition.Y)
            for _, obj in pairs(guiObjects) do
                if obj:IsA("GuiButton") then
                    obj:Activate()
                end
            end
            wait(0.05) -- 20 clicks/sec
        end
    end)
end)
