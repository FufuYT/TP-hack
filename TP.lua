local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local kickEvent = ReplicatedStorage:WaitForChild("KickPlayerEvent")
local localPlayer = Players.LocalPlayer

-- Création d'un ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

-- Cadre principal
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 300)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Parent = screenGui

-- Titre
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Liste des joueurs"
title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = frame

-- Liste des joueurs
local listLayout = Instance.new("UIListLayout")
listLayout.Parent = frame
listLayout.Padding = UDim.new(0, 5)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Fonction pour créer un bouton joueur
local function createPlayerButton(player)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 30)
    button.Text = player.Name
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = frame

    button.MouseButton1Click:Connect(function()
        kickEvent:FireServer(player.Name) -- demande au serveur de kicker
    end)
end

-- Remplir la liste au début
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= localPlayer then
        createPlayerButton(player)
    end
end

-- Quand un joueur rejoint
Players.PlayerAdded:Connect(function(player)
    if player ~= localPlayer then
        createPlayerButton(player)
    end
end)
