ReplicatedStorage = game:GetService("ReplicatedStorage")
VirtualUser = game:GetService("VirtualUser")
RunService = game:GetService("RunService")
Lighting = game:GetService("Lighting")
Players = game:GetService("Players")
LocalPlayer = Players.LocalPlayer
HRP = "HumanoidRootPart"

Library, Locale = loadstring(game:HttpGet("https://raw.githubusercontent.com/rbxluau/Roblox/main/Library.lua"))()

Window = Library:Window("SH", Locale.RF)

Player = Window:Tab(Locale.Player)

Player:Slider(Locale.WS, 0, 200, LocalPlayer.Character.Humanoid.WalkSpeed, function(Value)
    LocalPlayer.Character.Humanoid.WalkSpeed = Value
end)

Player:Toggle(Locale.Noclip, false, function(Value)
    Noclip = Value
    if not Noclip then
        LocalPlayer.Character.Humanoid:ChangeState("Flying")
    end
end)

Player:Toggle(Locale.Invisible, false, function(Value)
    Invisible = Value
    if not Invisible then
        ReplicatedStorage.communication.boxes.cl.BoxUpdated:FireServer("Unequip")
    end
end)

Fly = Window:Tab(Locale.Fly)

Fly:Slider(Locale.Speed, 0, 200, 1, function(Value)
    Speed = Value
end)

Fly:Toggle(Locale.Toggle, false, function(Value)
    Toggle = Value
    for i, v in pairs(Enum.HumanoidStateType:GetEnumItems()) do
        LocalPlayer.Character.Humanoid:SetStateEnabled(v, not Toggle)
    end
end)

Auto = Window:Tab(Locale.Auto)

Auto:Toggle(Locale.Get, false, function(Value)
    Get = Value
end)

Auto:Toggle(Locale.Put, false, function(Value)
    Put = Value
end)

Loop = Window:Tab(Locale.Loop)

Loop:Dropdown(Locale.Type, "DisplayName", {"DisplayName", "Name"}, function(Value)
    Type = Value
end)

Loop:Textbox(Locale.Name, "", true, function(Value)
    Name = Value
end)

Loop:Toggle(Locale.TP, false, function(Value)
    LT = Value
end)

ESP = Window:Tab(Locale.ESP)

ESP:Toggle(Locale.Player, false, function(Value)
    EP = Value
end)

ESP:Toggle(Locale.Other, false, function(Value)
    EO = Value
end)

Other = Window:Tab(Locale.Other)

Other:Button(Locale.BT, function()
    for i = 3, 4 do
        HB = Instance.new("HopperBin", LocalPlayer.Backpack)
        HB.BinType = i
    end
end)

Other:Button(Locale.CT, function()
    Tool = Instance.new("Tool", LocalPlayer.Backpack)
    Tool.RequiresHandle = false
    Tool.Activated:Connect(function()
        LocalPlayer.Character[HRP].CFrame = LocalPlayer:GetMouse().Hit+Vector3.new(0, 2.5, 0)
    end)
end)

Other:Dropdown(Locale.Camera, LocalPlayer.CameraMode.Name, {"Classic", "LockFirstPerson"}, function(Value)
    LocalPlayer.CameraMode = Value
end)

Other:Toggle(Locale.FB, false, function(Value)
    Light = Value
    if Light then
        Lighting.Ambient = Color3.new(1, 1, 1)
    else
        Lighting.Ambient = Color3.new(0, 0, 0)
    end
end)

Other:Toggle(Locale.AFK, false, function(Value)
    AFK = Value
end)

About = Window:Tab(Locale.About)

About:Label(Locale.By)

About:Button(Locale.Copy, function()
    setclipboard(Locale.Link)
end)

RunService.Stepped:Connect(function()
    if Noclip then
        for i, v in pairs(LocalPlayer.Character:GetChildren()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
    if Invisible then
        ReplicatedStorage.communication.boxes.cl.BoxUpdated:FireServer("Equip")
    end
end)

RunService.Heartbeat:Connect(function()
    if Toggle then
        LocalPlayer.Character.Humanoid:ChangeState("Swimming")
        LocalPlayer.Character:TranslateBy(LocalPlayer.Character.Humanoid.MoveDirection*Speed)
        LocalPlayer.Character[HRP].Velocity = Vector3.zero
    end
    if Get then
        for i, v in pairs(workspace:GetChildren()) do
            if table.find({
                "Fuse1",
                "Fuse2",
                "Fuse3",
                "Fuse4",
                "Fuse5",
                "Fuse6",
                "Fuse7",
                "Fuse8",
                "Fuse9",
                "Fuse10",
                "Fuse11",
                "Fuse12",
                "Fuse13",
                "Fuse14",
                "Block1",
                "Block2",
                "Block3",
                "Block4",
                "Block5",
                "Block6",
                "Block7",
                "Block8",
                "Block9",
                "Block10",
                "Block11",
                "Block12",
                "Block13",
                "Block14",
                "Block15",
                "Block16",
                "Block17",
                "Block18",
                "Block19",
                "Block20",
                "Block21",
                "Block22",
                "Block23",
                "Block24",
                "Battery",
                "FoodPink",
                "FoodGreen",
                "FoodOrange",
                "CakeMix",
                "LightBulb",
                "GasCanister"
            }, v.Name) then
                v.TouchTrigger.CFrame = LocalPlayer.Character[HRP].CFrame
            end
        end
    end
    if Put then
        for i, v in pairs(workspace.GroupBuildStructures:GetChildren()) do
            v.Trigger.CFrame = LocalPlayer.Character[HRP].CFrame
        end
    end
    for i, v in pairs(Players:GetPlayers()) do
        if LT and string.find(v[Type], Name) then
            LocalPlayer.Character.Humanoid.Sit = false
            LocalPlayer.Character[HRP].CFrame = v.Character[HRP].CFrame
        end
        if not v.Character:FindFirstChild("Highlight") then
            Instance.new("Highlight", v.Character)
            BG = Instance.new("BillboardGui", v.Character)
            TL = Instance.new("TextLabel", BG)
            BG.AlwaysOnTop = true
            BG.Size = UDim2.new(0, 100, 0, 50)
            BG.StudsOffset = Vector3.new(0, 4, 0)
            TL.BackgroundTransparency = 1
            TL.Size = UDim2.new(0, 100, 0, 50)
        end
        v.Character.BillboardGui.TextLabel.Text = v.Name.."\nHealth: "..math.round(v.Character.Humanoid.Health).."\nDistance: "..math.round(LocalPlayer:DistanceFromCharacter(v.Character.Head.Position))
        v.Character.BillboardGui.TextLabel.TextColor = v.TeamColor
        v.Character.BillboardGui.Enabled = EP
        v.Character.Highlight.Enabled = EP
    end
    for i, v in pairs(workspace.ignore:GetChildren()) do
        if v.Name == "Looky" then
            v.Highlight.Enabled = EO
        end
    end
end)

Lighting.LightingChanged:Connect(function()
    if Light then
        Lighting.Ambient = Color3.new(1, 1, 1)
    end
end)

LocalPlayer.Idled:Connect(function()
    if AFK then
        VirtualUser:MoveMouse(Vector2.new())
    end
end)
