local player = game.Players.LocalPlayer
local character = script.Parent
local hrp = character.HumanoidRootPart
local rs = game.ReplicatedStorage
local uis = game:GetService("UserInputService")
local tweenservice = game:GetService("TweenService")
local runservice = game:GetService("RunService")
local soundservice = game:GetService("SoundService")
local tweeninfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local cas = game:GetService("ContextActionService")

local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = {workspace.MovementParts}
raycastParams.FilterType = Enum.RaycastFilterType.Include

local raycastParams2 = RaycastParams.new()
raycastParams2.FilterDescendantsInstances = {workspace.LookAt}
raycastParams2.FilterType = Enum.RaycastFilterType.Include

forward = false
backward = false
right = false
left = false

runservice.Heartbeat:Connect(function()
	rayright = workspace:Raycast(hrp.Position, Vector3.new(0, 0, 4), raycastParams)
	rayleft = workspace:Raycast(hrp.Position, Vector3.new(0, 0, -4), raycastParams)
	rayback = workspace:Raycast(hrp.Position, Vector3.new(-4, 0, 0), raycastParams)
	rayforward = workspace:Raycast(hrp.Position, Vector3.new(4, 0, 0), raycastParams)
	
	raylookatright = workspace:Raycast(hrp.Position, Vector3.new(0, 0, 7), raycastParams2)
	raylookatleft = workspace:Raycast(hrp.Position, Vector3.new(0, 0, -5), raycastParams2)
	raylookatback = workspace:Raycast(hrp.Position, Vector3.new(-5, 0, 0), raycastParams2)
	raylookatforward = workspace:Raycast(hrp.Position, Vector3.new(10, 0, 0), raycastParams2)
end)

local function move(ray)
	if ray == nil then
		if forward and raylookatforward then
			tweenservice:Create(hrp, tweeninfo, {CFrame = CFrame.lookAt(hrp.Position, raylookatforward.Instance.Position * Vector3.new(1, 0.9, 1))}):Play()
		elseif backward and raylookatback then
			tweenservice:Create(hrp, tweeninfo, {CFrame = CFrame.lookAt(hrp.Position, raylookatback.Instance.Position * Vector3.new(1, 0.9, 1))}):Play()
		elseif right and raylookatright then
			tweenservice:Create(hrp, tweeninfo, {CFrame = CFrame.lookAt(hrp.Position, raylookatright.Instance.Position * Vector3.new(1, 0.9, 1))}):Play()
		elseif left and raylookatleft then
			tweenservice:Create(hrp, tweeninfo, {CFrame = CFrame.lookAt(hrp.Position, raylookatleft.Instance.Position * Vector3.new(1, 0.9, 1))}):Play()
		end
		return
	end
	tweenservice:Create(hrp, tweeninfo, {CFrame = ray.Instance.CFrame}):Play()
	soundservice.Footstep.PlaybackSpeed = Random.new():NextNumber(1, 1.9)
	soundservice.Footstep:Play()
end

_G.forward = function(_, inputState)
	if inputState == Enum.UserInputState.Begin then
		forward = true
		for i,v in pairs(workspace.MovementParts:GetChildren()) do
			v.CFrame *= CFrame.Angles(0, math.rad(-90), 0)
		end
		move(rayforward)
		for i,v in pairs(workspace.MovementParts:GetChildren()) do
			v.CFrame *= CFrame.Angles(0, math.rad(90), 0)
		end
		forward = false
	end
end

_G.back = function(_, inputState)
	if inputState == Enum.UserInputState.Begin then
		backward = true
		for i,v in pairs(workspace.MovementParts:GetChildren()) do
			v.CFrame *= CFrame.Angles(0, math.rad(90), 0)
		end
		move(rayback)
		for i,v in pairs(workspace.MovementParts:GetChildren()) do
			v.CFrame *= CFrame.Angles(0, math.rad(-90), 0)
		end
		backward = false
	end
end

_G.left = function(_, inputState)
	if inputState == Enum.UserInputState.Begin then
		left = true
		move(rayleft)
		left = false
	end
end

_G.right = function(_, inputState)
	if inputState == Enum.UserInputState.Begin then
		right = true
		for i,v in pairs(workspace.MovementParts:GetChildren()) do
			v.CFrame *= CFrame.Angles(0, math.rad(-180), 0)
		end
		move(rayright)
		for i,v in pairs(workspace.MovementParts:GetChildren()) do
			v.CFrame *= CFrame.Angles(0, math.rad(180), 0)
		end
		right = false
	end
end

_G.rebind = function()
	cas:BindAction("W", _G.forward, true, Enum.KeyCode.W)
	cas:BindAction("S", _G.back, true, Enum.KeyCode.S)
	cas:BindAction("A", _G.left, true, Enum.KeyCode.A)
	cas:BindAction("D", _G.right, true, Enum.KeyCode.D)
end

_G.unbind = function()
	cas:UnbindAction("W") 
	cas:UnbindAction("S") 
	cas:UnbindAction("A") 
	cas:UnbindAction("D")
end

cas:BindAction("W", _G.forward, true, Enum.KeyCode.W)

cas:BindAction("S", _G.back, true, Enum.KeyCode.S)

cas:BindAction("A", _G.left, true, Enum.KeyCode.A)

cas:BindAction("D", _G.right, true, Enum.KeyCode.D)