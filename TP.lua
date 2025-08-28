local player = game.Players.LocalPlayer
local hrp = player.Character:WaitForChild("HumanoidRootPart")
local humanoid = player.Character:WaitForChild("Humanoid")
local runService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local PlayerGui = player:WaitForChild("PlayerGui")

humanoid.PlatformStand = true

-- BodyPosition pour bobine de gravité
local bp = Instance.new("BodyPosition")
bp.MaxForce = Vector3.new(1e5,1e5,1e5)
bp.D = 10
bp.P = 5000
bp.Position = hrp.Position
bp.Parent = hrp

local flyEnabled = false
local gravEnabled = false
local targetPos = hrp.Position

-- UI boutons
local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.ResetOnSpawn = false

local flyButton = Instance.new("TextButton", screenGui)
flyButton.Size = UDim2.new(0,100,0,50)
flyButton.Position = UDim2.new(0,20,0,20)
flyButton.Text = "Fly"
flyButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
flyButton.TextScaled = true

local gravButton = Instance.new("TextButton", screenGui)
gravButton.Size = UDim2.new(0,100,0,50)
gravButton.Position = UDim2.new(0,20,0,80)
gravButton.Text = "Gravité"
gravButton.BackgroundColor3 = Color3.fromRGB(0,255,85)
gravButton.TextScaled = true

flyButton.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    flyButton.Text = flyEnabled and "Fly ON" or "Fly OFF"
end)

gravButton.MouseButton1Click:Connect(function()
    gravEnabled = not gravEnabled
    gravButton.Text = gravEnabled and "Grav ON" or "Grav OFF"
end)

-- Suivi tactile pour la gravité
UserInputService.InputBegan:Connect(function(input)
    if gravEnabled and input.UserInputType == Enum.UserInputType.Touch then
        targetPos = workspace.CurrentCamera:ScreenPointToRay(input.Position.X, input.Position.Y).Origin
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if gravEnabled and input.UserInputType == Enum.UserInputType.Touch then
        targetPos = workspace.CurrentCamera:ScreenPointToRay(input.Position.X, input.Position.Y).Origin
    end
end)

runService.RenderStepped:Connect(function(delta)
    if flyEnabled then
        -- simple fly en restant à la position actuelle du HumanoidRootPart (déplacement libre avec gravité désactivée)
        bp.Position = hrp.Position
    end

    if gravEnabled then
        local dir = targetPos - hrp.Position
        if dir.Magnitude > 0 then
            bp.Position = hrp.Position + dir.Unit * 50 * delta
        end
    end
end)
