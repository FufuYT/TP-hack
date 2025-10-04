-- Script à mettre dans StarterGui (LocalScript)

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- GUI
local ScreenGui = Instance.new("ScreenGui")
local PlusButton = Instance.new("TextButton")
local TPButton = Instance.new("TextButton")

ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Bouton "+"
PlusButton.Parent = ScreenGui
PlusButton.Size = UDim2.new(0, 50, 0, 50)
PlusButton.Position = UDim2.new(0.05, 0, 0.8, 0)
PlusButton.Text = "+"

-- Bouton "TP!"
TPButton.Parent = ScreenGui
TPButton.Size = UDim2.new(0, 100, 0, 50)
TPButton.Position = UDim2.new(0.15, 0, 0.8, 0)
TPButton.Text = "TP!"

-- Variable de sauvegarde
local savedPosition = nil
local selecting = false

-- Quand on clique sur "+"
PlusButton.MouseButton1Click:Connect(function()
	selecting = true
	print("Cliquez sur un endroit dans le monde pour sauvegarder la position.")
end)

-- Quand on clique dans le monde
mouse.Button1Down:Connect(function()
	if selecting then
		if mouse.Hit then
			savedPosition = mouse.Hit.Position
			print("Position sauvegardée :", savedPosition)
			selecting = false
		end
	end
end)

-- Quand on clique sur "TP!"
TPButton.MouseButton1Click:Connect(function()
	local character = player.Character
	if character and character:FindFirstChild("HumanoidRootPart") and savedPosition then
		character:MoveTo(savedPosition)
	end
end)
