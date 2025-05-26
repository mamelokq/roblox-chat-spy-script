local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ChatSpyGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(0, 350, 0, 220)
scrollFrame.Position = UDim2.new(0, 10, 0, 60) -- Slight vertical shift
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 0 -- <- Hides scrollbar
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
scrollFrame.Parent = screenGui

local layout = Instance.new("UIListLayout")
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 2)
layout.Parent = scrollFrame

-- Add message to log
local function addChatMessage(playerName, message)
	local msg = Instance.new("TextLabel")
	msg.Size = UDim2.new(1, -10, 0, 0)
	msg.BackgroundTransparency = 1
	msg.TextColor3 = Color3.new(1, 1, 1)
	msg.Font = Enum.Font.Code
	msg.TextSize = 14
	msg.TextXAlignment = Enum.TextXAlignment.Left
	msg.TextWrapped = true
	msg.AutomaticSize = Enum.AutomaticSize.Y
	msg.Text = "[" .. playerName .. "]: " .. message
	msg.Parent = scrollFrame

	task.wait()
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
	scrollFrame.CanvasPosition = Vector2.new(0, layout.AbsoluteContentSize.Y)
end

-- Hook players
local function hookPlayer(player)
	player.Chatted:Connect(function(message)
		addChatMessage(player.Name, message)
	end)
end

for _, player in ipairs(Players:GetPlayers()) do
	hookPlayer(player)
end

Players.PlayerAdded:Connect(hookPlayer)
