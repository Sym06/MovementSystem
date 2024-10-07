local tweenservice = game:GetService('TweenService')
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum: Humanoid = char:WaitForChild("Humanoid")
local cam = workspace.CurrentCamera

local num = 1.1

game:GetService("RunService").Heartbeat:Connect(function()
	if cam.CameraType == Enum.CameraType.Scriptable or cam.CameraSubject ~= hum then return end
	local offset = char.HumanoidRootPart.CFrame:ToObjectSpace(char.Head.CFrame).Position
	tweenservice:Create(hum, TweenInfo.new(0.2), {CameraOffset = Vector3.new(offset.X, 0, offset.Z) * num}):Play()
end)
