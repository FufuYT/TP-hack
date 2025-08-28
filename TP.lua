local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Crée un RemoteEvent automatiquement
local kickEvent = Instance.new("RemoteEvent")
kickEvent.Name = "KickPlayerEvent"
kickEvent.Parent = ReplicatedStorage

-- Fonction pour créer l'UI côté joueur
local function createUI(player)
    local screenGui = Instance.new("ScreenGui")
    screenGui.ResetOnSpawn = false
    screenGui.Name = "KickUI"

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 250, 0, 350)
    frame.Position = UDim2.new(0, 50, 0.2, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    title.Text = "Kick Players"
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 20
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Parent = frame

    local playerList = Instance.new("ScrollingFrame")
    playerList.Size = UDim2.new(1, -10, 1, -50)
    playerList.Position = UDim2.new(0, 5, 0, 45)
    playerList.CanvasSize = UDim2.new(0, 0, 0, 0)
    playerList.ScrollBarThickness = 6
    playerList.BackgroundTransparency = 1
    playerList.Parent = frame

    local layout = Instance.new("UIListLayout")
    layout.Parent = playerList
    layout.Padding = UDim.new(0, 5)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    -- LocalScript pour gérer les boutons
    local localScript = Instance.new("LocalScript")
    localScript.Parent = screenGui
    localScript.Source = [[
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local kickEvent = ReplicatedStorage:WaitForChild("KickPlayerEvent")
        local player = Players.LocalPlayer
        local playerList = script.Parent.Frame.ScrollingFrame
        local layout = playerList.UIListLayout

        -- Fonction pour ajouter un bouton joueur
        local function addPlayerButton(p)
            if p == player then return end
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, -10, 0, 30)
            button.Text = "Kick " .. p.Name
            button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.Font = Enum.Font.SourceSansBold
            button.TextSize = 16
            button.Parent = playerList

            button.MouseButton1Click:Connect(function()
                kickEvent:FireServer(p.Name)
            end)

            p.AncestryChanged:Connect(function(_, parent)
                if not parent then
                    button:Destroy()
                end
            end)
        end

        -- Ajouter les joueurs existants
        for _, plr in ipairs(Players:GetPlayers()) do
            addPlayerButton(plr)
        end

        -- Quand un joueur rejoint
        Players.PlayerAdded:Connect(addPlayerButton)

        -- Ajuster la taille du scroll
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            playerList.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
        end)
    ]]

    screenGui.Parent = player:WaitForChild("PlayerGui")
end

-- Quand un joueur rejoint → créer son UI
Players.PlayerAdded:Connect(createUI)

-- Quand on clique sur un bouton → le serveur kick
kickEvent.OnServerEvent:Connect(function(player, targetName)
    if player.UserId == 123456789 then -- << mets ton UserId
        local target = Players:FindFirstChild(targetName)
        if target then
            target:Kick("Vous avez été kick par un admin.")
        end
    else
        player:Kick("Tentative de kick sans permission.")
    end
end)
