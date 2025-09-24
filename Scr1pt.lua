-- LocalScript à mettre dans StarterPlayerScripts
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Vie infinie
local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.HealthChanged:Connect(function(health)
        if health < humanoid.MaxHealth then
            humanoid.Health = humanoid.MaxHealth
        end
    end)
end

if player.Character then
    onCharacterAdded(player.Character)
end
player.CharacterAdded:Connect(onCharacterAdded)

-- One-shot sur les autres joueurs
mouse.Button1Down:Connect(function()
    local target = mouse.Target
    if target then
        local targetHumanoid = target.Parent:FindFirstChild("Humanoid")
        if targetHumanoid and targetHumanoid.Parent ~= player.Character then
            -- Tue automatiquement le joueur touché
            targetHumanoid.Health = 0
        end
    end
end)
