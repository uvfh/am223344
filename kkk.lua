local DINOHUB = Instance.new("ScreenGui")
local OPENCLOSE = Instance.new("TextButton")

DINOHUB.Name = "HUB"
DINOHUB.Parent = game.CoreGui
DINOHUB.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

OPENCLOSE.Name = "OPENCLOSE"
OPENCLOSE.Parent = DINOHUB
OPENCLOSE.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
OPENCLOSE.BorderSizePixel = 0
OPENCLOSE.Position = UDim2.new(0.120833337, 0, 0.0952890813, 0)
OPENCLOSE.Size = UDim2.new(0.0447916649, 0, 0.0845824406, 0)
OPENCLOSE.Font = Enum.Font.DenkOne
OPENCLOSE.Text = ""
OPENCLOSE.TextColor3 = Color3.fromRGB(96, 255, 16)
OPENCLOSE.TextScaled = true
OPENCLOSE.TextSize = 14.000
OPENCLOSE.TextWrapped = true
OPENCLOSE.MouseButton1Click:Connect(function()
    game.CoreGui:FindFirstChild("1xliiUI").Enabled = not game.CoreGui:FindFirstChild("1xliiUI").Enabled
end)
if not game:IsLoaded() then 
    repeat game.Loaded:Wait()
    until game:IsLoaded() 
end
repeat wait(1)
    pcall(function()
        if game:GetService("Players").LocalPlayer.PlayerGui.Main:FindFirstChild("ChooseTeam") then
            if game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Visible == true then
                if _G.Team == "Marines" then
                    for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.MouseButton1Click)) do
                        v.Function()
                    end
                else
                    for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.MouseButton1Click)) do
                        v.Function()
                    end
                end
            end
        end
    end)
until game.Players.localPlayer.Neutral == false
if _G.Fast_Delay == nil then
	_G.Fast_Delay = 0.3
end
spawn(function()
    while true do wait()
        getgenv().rejoin = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(Kick)
            if not _G.TP_Ser and _G.Rejoin then
                if Kick.Name == 'ErrorPrompt' and Kick:FindFirstChild('MessageArea') and Kick.MessageArea:FindFirstChild("ErrorFrame") then
                    game:GetService("TeleportService"):Teleport(game.PlaceId)
                    wait(50)
                end
            end
        end)
    end
end)

local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)

spawn(function()
	while wait(3) do
		game:GetService'VirtualUser':CaptureController()
	end
end)

Old_World = false
New_World = false
Three_World = false
local placeId = game.PlaceId
if placeId == 2753915549 then
    Old_World = true
elseif placeId == 4442272183 then
    New_World = true
elseif placeId == 7449423635 then
    Three_World = true
end
_G.Color = Color3.fromRGB(68, 202, 186)

_G.Setting_table = {
    Auto_Farm = false,
    FastAttack = true,
	Auto_Buso = true,
	Auto_Ken = true,
	Show_Damage = true,
	NoClip = true,
	Save_Member = true,
	Melee_A = true,
	Defense_A = true,
	SkillZ = true,
	Rejoin = true,
	Anti_AFK = true,
	K_MAX = 50,
	Chest_Lock = 50,
	Delay_C = 15
}

_G.Check_Save_Setting = "CheckSaveSetting"

getgenv()['JsonEncode'] = function(msg)
    return game:GetService("HttpService"):JSONEncode(msg)
end
getgenv()['JsonDecode'] = function(msg)
    return game:GetService("HttpService"):JSONDecode(msg)
end
getgenv()['Check_Setting'] = function(Name)
    if not _G.Dis and not isfolder('Switch Hub BF Premium') then
        makefolder('Switch Hub BF Premium')
    end
    if not _G.Dis and not isfile('Switch Hub BF Premium/'..Name..'.json') then
        writefile('Switch Hub BF Premium/'..Name..'.json',JsonEncode(_G.Setting_table))
    end
end
getgenv()['Get_Setting'] = function(Name)
    if not _G.Dis and isfolder('Switch Hub BF Premium') and isfile('Switch Hub BF Premium/'..Name..'.json') then
        _G.Setting_table = JsonDecode(readfile('Switch Hub BF Premium/'..Name..'.json'))
        return _G.Setting_table
	elseif not _G.Dis then
        Check_Setting(Name)
    end
end
getgenv()['Update_Setting'] = function(Name)
    if not _G.Dis and isfolder('Switch Hub BF Premium') and isfile('Switch Hub BF Premium/'..Name..'.json') then
        writefile('Switch Hub BF Premium/'..Name..'.json',JsonEncode(_G.Setting_table))
	elseif not _G.Dis then
        Check_Setting(Name)
    end
end

Check_Setting(_G.Check_Save_Setting)
Get_Setting(_G.Check_Save_Setting)

if _G.Setting_table.Save_Member then
	getgenv()['MyName'] = game.Players.LocalPlayer.Name
	print("Save Member")
elseif _G.Setting_table.Save_All_Member then
	getgenv()['MyName'] = "AllMember"
	print("Save All Member")
else
	getgenv()['MyName'] = "None"
	_G.Dis = true
end

Check_Setting(getgenv()['MyName'])
Get_Setting(getgenv()['MyName'])

_G.Setting_table.Key = _G.wl_key
Update_Setting(getgenv()['MyName'])

if type(_G.Setting_table.Weapon) ~= 'string' then
	for i2,v2 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do  
		if tostring(v2.ToolTip) == "Melee" then
			_G.Setting_table.Weapon = v2.Name
		end
	end
end


function Text(value)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Switch Notification", 
        Text = tostring(value),
        Icon = "http://www.roblox.com/asset/?id=9606070311",
        Duration = 10
    })
end
function Com()
    game.StarterGui:SetCore("SendNotification", {
        Title = "Switch Notification", 
        Text = "✅  Complete",
        Icon = "http://www.roblox.com/asset/?id=9606070311",
        Duration = 5
    })
end

function TelePBoss(p)
	if (p.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 2000 and not Auto_Raid and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
		if NameQuest == "FishmanQuest" then
			_G.Stop_Tween = true
			TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
			wait(.5)
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
			_G.Stop_Tween = nil
		elseif Ms == "God's Guard [Lv. 450]"  then
			_G.Stop_Tween = true
			TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
			wait(.5)
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
			_G.Stop_Tween = nil
		elseif NameQuest == "SkyExp1Quest" then
			_G.Stop_Tween = true
			TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
			wait(.5)
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
			_G.Stop_Tween = nil
		elseif NameQuest == "ShipQuest1" then
			_G.Stop_Tween = true
			TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
			wait(.5)
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
			_G.Stop_Tween = nil
		elseif NameQuest == "ShipQuest2" then
			_G.Stop_Tween = true
			TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
			wait(.5)
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
			_G.Stop_Tween = nil
		elseif NameQuest == "FrostQuest" then
			_G.Stop_Tween = true
			TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
			wait(.5)
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
			_G.Stop_Tween = nil
		else
			Mix_Farm = true
			_G.Stop_Tween = true
			game.Players.LocalPlayer.Character.Humanoid:ChangeState(15)
			repeat wait(.5)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p
				wait()
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
			until (p.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 1500 and game.Players.LocalPlayer.Character.Humanoid.Health > 0
			wait(.5)
			_G.Stop_Tween = nil
			Mix_Farm = nil
		end
	end
end

function CheckQuestBoss()
	-- Old World
		if _G.SelectBoss == "Saber Expert [Lv. 200] [Boss]" then
			MsBoss = "Saber Expert [Lv. 200] [Boss]"
			NameBoss = "Saber Expert"
			CFrameBoss = CFrame.new(-1458.89502, 29.8870335, -50.633564, 0.858821094, 1.13848939e-08, 0.512275636, -4.85649254e-09, 1, -1.40823326e-08, -0.512275636, 9.6063415e-09, 0.858821094)
		elseif _G.SelectBoss == "The Saw [Lv. 100] [Boss]" then
			MsBoss = "The Saw [Lv. 100] [Boss]"
			NameBoss = "The Saw"
			CFrameBoss = CFrame.new(-683.519897, 13.8534927, 1610.87854, -0.290192783, 6.88365773e-08, 0.956968188, 6.98413629e-08, 1, -5.07531119e-08, -0.956968188, 5.21077759e-08, -0.290192783)
		elseif _G.SelectBoss == "Greybeard [Lv. 750] [Raid Boss]" then
			MsBoss = "Greybeard [Lv. 750] [Raid Boss]"
			NameBoss = "Greybeard"
			CFrameBoss = CFrame.new(-4955.72949, 80.8163834, 4305.82666, -0.433646321, -1.03394289e-08, 0.901083171, -3.0443168e-08, 1, -3.17633075e-09, -0.901083171, -2.88092288e-08, -0.433646321)
		elseif _G.SelectBoss == "The Gorilla King [Lv. 25] [Boss]" then
			MsBoss = "The Gorilla King [Lv. 25] [Boss]" 
			NameBoss = "The Gorilla King"
			NameQuestBoss = "JungleQuest"
			QuestLvBoss = 3
			CFrameQBoss = CFrame.new(-1604.12012, 36.8521118, 154.23732, 0.0648873374, -4.70858913e-06, -0.997892559, 1.41431883e-07, 1, -4.70933674e-06, 0.997892559, 1.64442184e-07, 0.0648873374)
			CFrameBoss = CFrame.new(-1223.52808, 6.27936459, -502.292664, 0.310949147, -5.66602516e-08, 0.950426519, -3.37275488e-08, 1, 7.06501808e-08, -0.950426519, -5.40241736e-08, 0.310949147)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Bobby [Lv. 55] [Boss]" then
			MsBoss = "Bobby [Lv. 55] [Boss]"
			NameBoss = "Bobby"
			NameQuestBoss = "BuggyQuest1"
			QuestLvBoss = 3
			CFrameQBoss = CFrame.new(-1139.59717, 4.75205183, 3825.16211, -0.959730506, -7.5857054e-09, 0.280922383, -4.06310328e-08, 1, -1.11807175e-07, -0.280922383, -1.18718916e-07, -0.959730506)
			CFrameBoss = CFrame.new(-1147.65173, 32.5966301, 4156.02588, 0.956680477, -1.77109952e-10, -0.29113996, 5.16530874e-10, 1, 1.08897802e-09, 0.29113996, -1.19218679e-09, 0.956680477)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Yeti [Lv. 110] [Boss]" then
			MsBoss = "Yeti [Lv. 110] [Boss]"
			NameBoss = "Yeti"
			NameQuestBoss = "SnowQuest"
			QuestLvBoss = 3
			CFrameQBoss = CFrame.new(1384.90247, 87.3078308, -1296.6825, 0.280209213, 2.72035177e-08, -0.959938943, -6.75690828e-08, 1, 8.6151708e-09, 0.959938943, 6.24481444e-08, 0.280209213)
			CFrameBoss = CFrame.new(1221.7356, 138.046906, -1488.84082, 0.349343032, -9.49245944e-08, 0.936994851, 6.29478194e-08, 1, 7.7838429e-08, -0.936994851, 3.17894653e-08, 0.349343032)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Mob Leader [Lv. 120] [Boss]" then
			MsBoss = "Mob Leader [Lv. 120] [Boss]"
			NameBoss = "Mob Leader"
			CFrameBoss = CFrame.new(-2848.59399, 7.4272871, 5342.44043, -0.928248107, -8.7248246e-08, 0.371961564, -7.61816636e-08, 1, 4.44474857e-08, -0.371961564, 1.29216433e-08, -0.92824)
		elseif _G.SelectBoss == "Vice Admiral [Lv. 130] [Boss]" then
			MsBoss = "Vice Admiral [Lv. 130] [Boss]"
			NameBoss = "Vice Admiral"
			NameQuestBoss = "MarineQuest2"
			QuestLvBoss = 2
			CFrameQBoss = CFrame.new(-5035.42285, 28.6520386, 4324.50293, -0.0611100644, -8.08395768e-08, 0.998130739, -1.57416586e-08, 1, 8.00271849e-08, -0.998130739, -1.08217701e-08, -0.0611100644)
			CFrameBoss = CFrame.new(-5078.45898, 99.6520691, 4402.1665, -0.555574954, -9.88630566e-11, 0.831466436, -6.35508286e-08, 1, -4.23449258e-08, -0.831466436, -7.63661632e-08, -0.555574954)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Warden [Lv. 220] [Boss]" then
			MsBoss = "Warden [Lv. 220] [Boss]"
			NameBoss = "Warden"
			NameQuestBoss = "ImpelQuest"
			QuestLvBoss = 1
			CFrameQBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-08, -0.842635691, 1.38001752e-08, 1, -8.81300792e-08, 0.842635691, -5.90851599e-08, -0.538484037)
			CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-08, 0.330433697, 3.47818627e-08, 1, 3.81658154e-08, -0.330433697, -2.45289105e-08, 0.943829298)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Chief Warden [Lv. 230] [Boss]" then
			MsBoss = "Chief Warden [Lv. 230] [Boss]"
			NameBoss = "Chief Warden"
			NameQuestBoss = "ImpelQuest"
			QuestLvBoss = 2
			CFrameQBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-08, -0.842635691, 1.38001752e-08, 1, -8.81300792e-08, 0.842635691, -5.90851599e-08, -0.538484037)
			CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-08, 0.330433697, 3.47818627e-08, 1, 3.81658154e-08, -0.330433697, -2.45289105e-08, 0.943829298)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Swan [Lv. 240] [Boss]" then
			MsBoss = "Swan [Lv. 240] [Boss]"
			NameBoss = "Swan"
			NameQuestBoss = "ImpelQuest"
			QuestLvBoss = 3
			CFrameQBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-08, -0.842635691, 1.38001752e-08, 1, -8.81300792e-08, 0.842635691, -5.90851599e-08, -0.538484037)
			CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-08, 0.330433697, 3.47818627e-08, 1, 3.81658154e-08, -0.330433697, -2.45289105e-08, 0.943829298)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Magma Admiral [Lv. 350] [Boss]" then
			MsBoss = "Magma Admiral [Lv. 350] [Boss]"
			NameBoss = "Magma Admiral"
			NameQuestBoss = "MagmaQuest"
			QuestLvBoss = 3
			CFrameQBoss = CFrame.new(-5317.07666, 12.2721891, 8517.41699, 0.51175487, -2.65508806e-08, -0.859131515, -3.91131572e-08, 1, -5.42026761e-08, 0.859131515, 6.13418294e-08, 0.51175487)
			CFrameBoss = CFrame.new(-5530.12646, 22.8769703, 8859.91309, 0.857838571, 2.23414389e-08, 0.513919294, 1.53689133e-08, 1, -6.91265853e-08, -0.513919294, 6.71978384e-08, 0.857838571)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Fishman Lord [Lv. 425] [Boss]" then
			MsBoss = "Fishman Lord [Lv. 425] [Boss]"
			NameBoss = "Fishman Lord"
			NameQuestBoss = "FishmanQuest"
			QuestLvBoss = 3
			CFrameQBoss = CFrame.new(61123.0859, 18.5066795, 1570.18018, 0.927145958, 1.0624845e-07, 0.374700129, -6.98219367e-08, 1, -1.10790765e-07, -0.374700129, 7.65569368e-08, 0.927145958)
			CFrameBoss = CFrame.new(61351.7773, 31.0306778, 1113.31409, 0.999974668, 0, -0.00714713801, 0, 1.00000012, 0, 0.00714714266, 0, 0.999974549)
			if (CFrameQBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
			end
		elseif _G.SelectBoss == "Wysper [Lv. 500] [Boss]" then
			MsBoss = "Wysper [Lv. 500] [Boss]"
			NameBoss = "Wysper"
			NameQuestBoss = "SkyExp1Quest"
			QuestLvBoss = 3
			CFrameQBoss = CFrame.new(-7862.94629, 5545.52832, -379.833954, 0.462944925, 1.45838088e-08, -0.886386991, 1.0534996e-08, 1, 2.19553424e-08, 0.886386991, -1.95022007e-08, 0.462944925)
			CFrameBoss = CFrame.new(-7925.48389, 5550.76074, -636.178345, 0.716468513, -1.22915289e-09, 0.697619379, 3.37381434e-09, 1, -1.70304748e-09, -0.697619379, 3.57381835e-09, 0.716468513)
			if (CFrameQBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
			end
		elseif _G.SelectBoss == "Thunder God [Lv. 575] [Boss]" then
			MsBoss = "Thunder God [Lv. 575] [Boss]"
			NameBoss = "Thunder God"
			NameQuestBoss = "SkyExp2Quest"
			QuestLvBoss = 3
			CFrameQBoss = CFrame.new(-7902.78613, 5635.99902, -1411.98706, -0.0361216255, -1.16895912e-07, 0.999347389, 1.44533963e-09, 1, 1.17024491e-07, -0.999347389, 5.6715117e-09, -0.0361216255)
			CFrameBoss = CFrame.new(-7917.53613, 5616.61377, -2277.78564, 0.965189934, 4.80563429e-08, -0.261550069, -6.73089886e-08, 1, -6.46515304e-08, 0.261550069, 8.00056768e-08, 0.965189934)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Cyborg [Lv. 675] [Boss]" then
			MsBoss = "Cyborg [Lv. 675] [Boss]"
			NameBoss = "Cyborg"
			NameQuestBoss = "FountainQuest"
			QuestLvBoss = 3
			CFrameQBoss = CFrame.new(5253.54834, 38.5361786, 4050.45166, -0.0112687312, -9.93677887e-08, -0.999936521, 2.55291371e-10, 1, -9.93769547e-08, 0.999936521, -1.37512213e-09, -0.0112687312)
			CFrameBoss = CFrame.new(6041.82813, 52.7112198, 3907.45142, -0.563162148, 1.73805248e-09, -0.826346457, -5.94632716e-08, 1, 4.26280238e-08, 0.826346457, 7.31437524e-08, -0.563162148)
			TelePBoss(CFrameBoss)
		-- New World
		elseif _G.SelectBoss == "Diamond [Lv. 750] [Boss]" then
			MsBoss = "Diamond [Lv. 750] [Boss]"
			NameBoss = "Diamond"
			NameQuestBoss = "Area1Quest"
			QuestLvBoss = 3
			CFrameQBoss = CFrame.new(-424.080078, 73.0055847, 1836.91589, 0.253544956, -1.42165932e-08, 0.967323601, -6.00147771e-08, 1, 3.04272909e-08, -0.967323601, -6.5768397e-08, 0.253544956)
			CFrameBoss = CFrame.new(-1736.26587, 198.627731, -236.412857, -0.997808516, 0, -0.0661673471, 0, 1, 0, 0.0661673471, 0, -0.997808516)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Jeremy [Lv. 850] [Boss]" then
			MsBoss = "Jeremy [Lv. 850] [Boss]"
			NameBoss = "Jeremy"
			NameQuestBoss = "Area2Quest"
			QuestLvBoss = 3
			CFrameQBoss = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-10, -0.999488771, 1.36326533e-10, 1, 8.92172336e-10, 0.999488771, -1.07732087e-10, -0.0319722369)
			CFrameBoss = CFrame.new(2203.76953, 448.966034, 752.731079, -0.0217453763, 0, -0.999763548, 0, 1, 0, 0.999763548, 0, -0.0217453763)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Fajita [Lv. 925] [Boss]" then
			MsBoss = "Fajita [Lv. 925] [Boss]"
			NameBoss = "Fajita"
			NameQuestBoss = "MarineQuest3"
			QuestLvBoss = 3
			CFrameQBoss = CFrame.new(-2442.65015, 73.0511475, -3219.11523, -0.873540044, 4.2329841e-08, -0.486752301, 5.64383384e-08, 1, -1.43220786e-08, 0.486752301, -3.99823996e-08, -0.873540044)
			CFrameBoss = CFrame.new(-2297.40332, 115.449463, -3946.53833, 0.961227536, -1.46645796e-09, -0.275756449, -2.3212845e-09, 1, -1.34094433e-08, 0.275756449, 1.35296352e-08, 0.961227536)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Don Swan [Lv. 1000] [Boss]" then
			MsBoss = "Don Swan [Lv. 1000] [Boss]"
			NameBoss = "Don Swan"
			CFrameBoss = CFrame.new(2288.802, 15.1870775, 863.034607, 0.99974072, -8.41247214e-08, -0.0227668174, 8.4774733e-08, 1, 2.75850098e-08, 0.0227668174, -2.95079072e-08, 0.99974072)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Smoke Admiral [Lv. 1150] [Boss]" then
			MsBoss = "Smoke Admiral [Lv. 1150] [Boss]"
			NameBoss = "Smoke Admiral"
			NameQuestBoss = "IceSideQuest"
			QuestLvBoss = 3
			CFrameQBoss = CFrame.new(-6059.96191, 15.9868021, -4904.7373, -0.444992423, -3.0874483e-09, 0.895534337, -3.64098796e-08, 1, -1.4644522e-08, -0.895534337, -3.91229982e-08, -0.444992423)
			CFrameBoss = CFrame.new(-5115.72754, 23.7664986, -5338.2207, 0.251453817, 1.48345061e-08, -0.967869282, 4.02796978e-08, 1, 2.57916977e-08, 0.967869282, -4.54708946e-08, 0.251453817)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Cursed Captain [Lv. 1325] [Raid Boss]" then
			MsBoss = "Cursed Captain [Lv. 1325] [Raid Boss]"
			NameBoss = "Cursed Captain"
			CFrameBoss = CFrame.new(916.928589, 181.092773, 33422, -0.999505103, 9.26310495e-09, 0.0314563364, 8.42916226e-09, 1, -2.6643713e-08, -0.0314563364, -2.63653774e-08, -0.999505103)
		elseif _G.SelectBoss == "Darkbeard [Lv. 1000] [Raid Boss]" then
			MsBoss = "Darkbeard [Lv. 1000] [Raid Boss]"
			NameBoss = "Darkbeard"
			CFrameBoss = CFrame.new(3876.00366, 24.6882591, -3820.21777, -0.976951957, 4.97356325e-08, 0.213458836, 4.57335361e-08, 1, -2.36868622e-08, -0.213458836, -1.33787044e-08, -0.976951957)
		elseif _G.SelectBoss == "Order [Lv. 1250] [Raid Boss]" then
			MsBoss = "Order [Lv. 1250] [Raid Boss]"
			NameBoss = "Order"
			CFrameBoss = CFrame.new(-6221.15039, 16.2351036, -5045.23584, -0.380726993, 7.41463495e-08, 0.924687505, 5.85604774e-08, 1, -5.60738549e-08, -0.924687505, 3.28013137e-08, -0.380726993)
		elseif _G.SelectBoss == "Awakened Ice Admiral [Lv. 1400] [Boss]" then
			MsBoss = "Awakened Ice Admiral [Lv. 1400] [Boss]"
			NameBoss = "Awakened Ice Admiral"
			NameQuestBoss = "FrostQuest"
			QuestLvBoss = 3
			CFrameQBoss = CFrame.new(5669.33203, 28.2118053, -6481.55908, 0.921275556, -1.25320829e-08, 0.388910472, 4.72230788e-08, 1, -7.96414241e-08, -0.388910472, 9.17372489e-08, 0.921275556)
			CFrameBoss = CFrame.new(6407.33936, 340.223785, -6892.521, 0.49051559, -5.25310213e-08, -0.871432424, -2.76146022e-08, 1, -7.58250565e-08, 0.871432424, 6.12576301e-08, 0.49051559)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Tide Keeper [Lv. 1475] [Boss]" then
			MsBoss = "Tide Keeper [Lv. 1475] [Boss]"
			NameBoss = "Tide Keeper"
			NameQuestBoss = "ForgottenQuest"             
			QuestLvBoss = 3
			CFrameQBoss = CFrame.new(-3053.89648, 236.881363, -10148.2324, -0.985987961, -3.58504737e-09, 0.16681771, -3.07832915e-09, 1, 3.29612559e-09, -0.16681771, 2.73641976e-09, -0.985987961)
			CFrameBoss = CFrame.new(-3570.18652, 123.328949, -11555.9072, 0.465199202, -1.3857326e-08, 0.885206044, 4.0332897e-09, 1, 1.35347511e-08, -0.885206044, -2.72606271e-09, 0.465199202)
			TelePBoss(CFrameBoss)
		-- Thire World
		elseif _G.SelectBoss == "Stone [Lv. 1550] [Boss]" then
			MsBoss = "Stone [Lv. 1550] [Boss]"
			NameBoss = "Stone"
			NameQuestBoss = "PiratePortQuest"             
			QuestLvBoss = 3
			CFrameQBoss = CFrame.new(-290, 44, 5577)
			CFrameBoss = CFrame.new(-1085, 40, 6779)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Island Empress [Lv. 1675] [Boss]" then
			MsBoss = "Island Empress [Lv. 1675] [Boss]"
			NameBoss = "Island Empress"
			NameQuestBoss = "AmazonQuest2"             
			QuestLvBoss = 3
			CFrameQBoss = CFrame.new(5443, 602, 752)
			CFrameBoss = CFrame.new(5659, 602, 244)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Kilo Admiral [Lv. 1750] [Boss]" then
			MsBoss = "Kilo Admiral [Lv. 1750] [Boss]"
			NameBoss = "Kilo Admiral"
			NameQuestBoss = "MarineTreeIsland"             
			QuestLvBoss = 3
			CFrameQBoss = CFrame.new(2178, 29, -6737)
			CFrameBoss =CFrame.new(2846, 433, -7100)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Captain Elephant [Lv. 1875] [Boss]" then
			MsBoss = "Captain Elephant [Lv. 1875] [Boss]"
			NameBoss = "Captain Elephant"
			NameQuestBoss = "DeepForestIsland"             
			QuestLvBoss = 3
			CFrameQBoss = CFrame.new(-13232, 333, -7631)
			CFrameBoss = CFrame.new(-13221, 325, -8405)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Beautiful Pirate [Lv. 1950] [Boss]" then
			MsBoss = "Beautiful Pirate [Lv. 1950] [Boss]"
			NameBoss = "Beautiful Pirate"
			NameQuestBoss = "DeepForestIsland2"             
			QuestLvBoss = 3
			CFrameQBoss = CFrame.new(-12686, 391, -9902)
			CFrameBoss = CFrame.new(5182, 23, -20)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "rip_indra True Form [Lv. 5000] [Raid Boss]" then
			MsBoss = "rip_indra True Form [Lv. 5000] [Raid Boss]"
			NameBoss = "rip_indra True Form"
			CFrameBoss = CFrame.new(-5359, 424, -2735)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Longma [Lv. 2000] [Boss]" then
			MsBoss = "Longma [Lv. 2000] [Boss]"
			NameBoss = "Longma"
			CFrameBoss = CFrame.new(-10248.3936, 353.79129, -9306.34473)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Soul Reaper [Lv. 2100] [Raid Boss]" then
			MsBoss = "Soul Reaper [Lv. 2100] [Raid Boss]"
			NameBoss = "Soul Reaper"
			CFrameBoss = CFrame.new(-9515.62109, 315.925537, 6691.12012)
			TelePBoss(CFrameBoss)
		elseif _G.SelectBoss == "Cake Queen [Lv. 2175] [Boss]" then
			MsBoss = "Cake Queen [Lv. 2175] [Boss]"
			NameBoss = "Cake Queen"
			NameQuestBoss = "IceCreamIslandQuest"             
			QuestLvBoss = 3
			CFrameQBoss = CFrame.new(-821.267456, 65.9448776, -10964.3994, 0.814093888, -3.67296735e-08, -0.58073324, 3.30765637e-08, 1, -1.6879099e-08, 0.58073324, -5.46748513e-09, 0.814093888)
			CFrameBoss = CFrame.new(-715.467102, 381.69104, -11019.8896, 0.955998719, -1.07319993e-08, -0.293370903, 5.00311881e-09, 1, -2.02781667e-08, 0.293370903, 1.7918131e-08, 0.955998719)
			TelePBoss(CFrameBoss)
		end
	end

		function CheckLevel()
			local Lv = game:GetService("Players").LocalPlayer.Data.Level.Value
			if Old_World then
				if Lv == 1 or Lv <= 9 or SelectMonster == "Bandit [Lv. 5]" then -- Bandit
					Ms = "Bandit [Lv. 5]"
					NameQuest = "BanditQuest1"
					QuestLv = 1
					NameMon = "Bandit"
					CFrameQ = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
					CFrameMon = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)
				elseif Lv == 10 or Lv <= 14 or SelectMonster == "Monkey [Lv. 14]" then -- Monkey
					Ms = "Monkey [Lv. 14]"
					NameQuest = "JungleQuest"
					QuestLv = 1
					NameMon = "Monkey"
					CFrameQ = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
					CFrameMon = CFrame.new(-1448.1446533203, 50.851993560791, 63.60718536377)
				elseif Lv == 15 or Lv <= 29 or SelectMonster == "Gorilla [Lv. 20]" then -- Gorilla
					Ms = "Gorilla [Lv. 20]"
					NameQuest = "JungleQuest"
					QuestLv = 2
					NameMon = "Gorilla"
					CFrameQ = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
					CFrameMon = CFrame.new(-1142.6488037109, 40.462348937988, -515.39227294922)
				elseif Lv == 30 or Lv <= 39 or SelectMonster == "Pirate [Lv. 35]" then -- Pirate
					Ms = "Pirate [Lv. 35]"
					NameQuest = "BuggyQuest1"
					QuestLv = 1
					NameMon = "Pirate"
					CFrameQ = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
					CFrameMon = CFrame.new(-1201.0881347656, 40.628940582275, 3857.5966796875)
				elseif Lv == 40 or Lv <= 59 or SelectMonster == "Brute [Lv. 45]" then -- Brute
					Ms = "Brute [Lv. 45]"
					NameQuest = "BuggyQuest1"
					QuestLv = 2
					NameMon = "Brute"
					CFrameQ = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
					CFrameMon = CFrame.new(-1387.5324707031, 24.592035293579, 4100.9575195313)
				elseif Lv == 60 or Lv <= 74 or SelectMonster == "Desert Bandit [Lv. 60]" then -- Desert Bandit
					Ms = "Desert Bandit [Lv. 60]"
					NameQuest = "DesertQuest"
					QuestLv = 1
					NameMon = "Desert Bandit"
					CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
					CFrameMon = CFrame.new(984.99896240234, 16.109552383423, 4417.91015625)
				elseif Lv == 75 or Lv <= 89 or SelectMonster == "Desert Officer [Lv. 70]" then -- Desert Officer
					Ms = "Desert Officer [Lv. 70]"
					NameQuest = "DesertQuest"
					QuestLv = 2
					NameMon = "Desert Officer"
					CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
					CFrameMon = CFrame.new(1547.1510009766, 14.452038764954, 4381.8002929688)
				elseif Lv == 90 or Lv <= 99 or SelectMonster == "Snow Bandit [Lv. 90]" then -- Snow Bandit
					Ms = "Snow Bandit [Lv. 90]"
					NameQuest = "SnowQuest"
					QuestLv = 1
					NameMon = "Snow Bandit"
					CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
					CFrameMon = CFrame.new(1356.3028564453, 105.76865386963, -1328.2418212891)
				elseif Lv == 100 or Lv <= 119 or SelectMonster == "Snowman [Lv. 100]" then -- Snowman
					Ms = "Snowman [Lv. 100]"
					NameQuest = "SnowQuest"
					QuestLv = 2
					NameMon = "Snowman"
					CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
					CFrameMon = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
				elseif Lv == 120 or Lv <= 149 or SelectMonster == "Chief Petty Officer [Lv. 120]" then -- Chief Petty Officer
					Ms = "Chief Petty Officer [Lv. 120]"
					NameQuest = "MarineQuest2"
					QuestLv = 1
					NameMon = "Chief Petty Officer"
					CFrameQ = CFrame.new(-5035.49609375, 28.677835464478, 4324.1840820313)
					CFrameMon = CFrame.new(-4931.1552734375, 65.793113708496, 4121.8393554688)
				elseif Lv == 150 or Lv <= 174 or SelectMonster == "Sky Bandit [Lv. 150]" then -- Sky Bandit
					Ms = "Sky Bandit [Lv. 150]"
					NameQuest = "SkyQuest"
					QuestLv = 1
					NameMon = "Sky Bandit"
					CFrameQ = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438)
					CFrameMon = CFrame.new(-4955.6411132813, 365.46365356445, -2908.1865234375)
				elseif Lv == 175 or Lv <= 249 or SelectMonster == "Dark Master [Lv. 175]" then -- Dark Master
					Ms = "Dark Master [Lv. 175]"
					NameQuest = "SkyQuest"
					QuestLv = 2
					NameMon = "Dark Master"
					CFrameQ = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438)
					CFrameMon = CFrame.new(-5148.1650390625, 439.04571533203, -2332.9611816406)
				elseif Lv == 250 or Lv <= 274 or SelectMonster == "Toga Warrior [Lv. 250]" then -- Toga Warrior
					Ms = "Toga Warrior [Lv. 250]"
					NameQuest = "ColosseumQuest"
					QuestLv = 1
					NameMon = "Toga Warrior"
					CFrameQ = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188)
					CFrameMon = CFrame.new(-1872.5166015625, 49.080215454102, -2913.810546875)
				elseif Lv == 275 or Lv <= 299 or SelectMonster == "Gladiator [Lv. 275]" then -- Gladiator
					Ms = "Gladiator [Lv. 275]"
					NameQuest = "ColosseumQuest"
					QuestLv = 2
					NameMon = "Gladiator"
					CFrameQ = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188)
					CFrameMon = CFrame.new(-1521.3740234375, 81.203170776367, -3066.3139648438)
				elseif Lv == 300 or Lv <= 329 or SelectMonster == "Military Soldier [Lv. 300]" then -- Military Soldier
					Ms = "Military Soldier [Lv. 300]"
					NameQuest = "MagmaQuest"
					QuestLv = 1
					NameMon = "Military Soldier"
					CFrameQ = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625)
					CFrameMon = CFrame.new(-5369.0004882813, 61.24352645874, 8556.4921875)
				elseif Lv == 330 or Lv <= 374 or SelectMonster == "Military Spy [Lv. 325]" then -- Military Spy
					Ms = "Military Spy [Lv. 325]"
					NameQuest = "MagmaQuest"
					QuestLv = 2
					NameMon = "Military Spy"
					CFrameQ = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625)
					CFrameMon = CFrame.new(-5984.0532226563, 82.14656829834, 8753.326171875)
				elseif Lv == 375 or Lv <= 399 or SelectMonster == "Fishman Warrior [Lv. 375]" then -- Fishman Warrior 
					_G.FM = true
					Ms = "Fishman Warrior [Lv. 375]"
					NameQuest = "FishmanQuest"
					QuestLv = 1
					NameMon = "Fishman Warrior"
					CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
					CFrameMon = CFrame.new(60844.10546875, 98.462875366211, 1298.3985595703)
					if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
					end
				elseif Lv == 400 or Lv <= 449 or SelectMonster == "Fishman Commando [Lv. 400]" then -- Fishman Commando
					_G.FM = true
					Ms = "Fishman Commando [Lv. 400]"
					NameQuest = "FishmanQuest"
					QuestLv = 2
					NameMon = "Fishman Commando"
					CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
					CFrameMon = CFrame.new(61738.3984375, 64.207321166992, 1433.8375244141)
					if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
					end
				elseif Lv == 450 or Lv <= 474 or SelectMonster == "God's Guard [Lv. 450]" then -- God's Guard
					_G.FM = false
					Ms = "God's Guard [Lv. 450]"
					NameQuest = "SkyExp1Quest"
					QuestLv = 1
					NameMon = "God's Guard"
					CFrameQ = CFrame.new(-4721.8603515625, 845.30297851563, -1953.8489990234)
					CFrameMon = CFrame.new(-4628.0498046875, 866.92877197266, -1931.2352294922)
					if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
					end
				elseif Lv == 475 or Lv <= 524 or SelectMonster == "Shanda [Lv. 475]" then -- Shanda
					_G.FM = false
					Ms = "Shanda [Lv. 475]"
					NameQuest = "SkyExp1Quest"
					QuestLv = 2
					NameMon = "Shanda"
					CFrameQ = CFrame.new(-7863.1596679688, 5545.5190429688, -378.42266845703)
					CFrameMon = CFrame.new(-7685.1474609375, 5601.0751953125, -441.38876342773)
					if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
					end
				elseif Lv == 525 or Lv <= 549 or SelectMonster == "Royal Squad [Lv. 525]" then -- Royal Squad
					Ms = "Royal Squad [Lv. 525]"
					NameQuest = "SkyExp2Quest"
					QuestLv = 1
					NameMon = "Royal Squad"
					CFrameQ = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
					CFrameMon = CFrame.new(-7654.2514648438, 5637.1079101563, -1407.7550048828)
				elseif Lv == 550 or Lv <= 624 or SelectMonster == "Royal Soldier [Lv. 550]" then -- Royal Soldier
					Ms = "Royal Soldier [Lv. 550]"
					NameQuest = "SkyExp2Quest"
					QuestLv = 2
					NameMon = "Royal Soldier"
					CFrameQ = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
					CFrameMon = CFrame.new(-7760.4106445313, 5679.9077148438, -1884.8112792969)
				elseif Lv == 625 or Lv <= 649 or SelectMonster == "Galley Pirate [Lv. 625]" then -- Galley Pirate
					Ms = "Galley Pirate [Lv. 625]"
					NameQuest = "FountainQuest"
					QuestLv = 1
					NameMon = "Galley Pirate"
					CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
					CFrameMon = CFrame.new(5557.1684570313, 152.32717895508, 3998.7758789063)
				elseif Lv >= 650 or SelectMonster == "Galley Captain [Lv. 650]" then -- Galley Captain
					Ms = "Galley Captain [Lv. 650]"
					NameQuest = "FountainQuest"
					QuestLv = 2
					NameMon = "Galley Captain"
					CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
					CFrameMon = CFrame.new(5677.6772460938, 92.786109924316, 4966.6323242188)
				end
			end
			if New_World then
				if Lv == 700 or Lv <= 724 or SelectMonster == "Raider [Lv. 700]" then -- Raider
					Ms = "Raider [Lv. 700]"
					NameQuest = "Area1Quest"
					QuestLv = 1
					NameMon = "Raider"
					CFrameQ = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531)
					CFrameMon = CFrame.new(68.874565124512, 93.635643005371, 2429.6752929688)
				elseif Lv == 725 or Lv <= 774 or SelectMonster == "Mercenary [Lv. 725]" then -- Mercenary
					Ms = "Mercenary [Lv. 725]"
					NameQuest = "Area1Quest"
					QuestLv = 2
					NameMon = "Mercenary"
					CFrameQ = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531)
					CFrameMon = CFrame.new(-864.85009765625, 122.47104644775, 1453.1505126953)
				elseif Lv == 775 or Lv <= 799 or SelectMonster == "Swan Pirate [Lv. 775]" then -- Swan Pirate
					Ms = "Swan Pirate [Lv. 775]"
					NameQuest = "Area2Quest"
					QuestLv = 1
					NameMon = "Swan Pirate"
					CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
					CFrameMon = CFrame.new(1065.3669433594, 137.64012145996, 1324.3798828125)
				elseif Lv == 800 or Lv <= 874 or SelectMonster == "Factory Staff [Lv. 800]" then -- Factory Staff
					Ms = "Factory Staff [Lv. 800]"
					NameQuest = "Area2Quest"
					QuestLv = 2
					NameMon = "Factory Staff"
					CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
					CFrameMon = CFrame.new(533.22045898438, 128.46876525879, 355.62615966797)
				elseif Lv == 875 or Lv <= 899 or SelectMonster == "Marine Lieutenant [Lv. 875]" then -- Marine Lieutenant
					Ms = "Marine Lieutenant [Lv. 875]"
					NameQuest = "MarineQuest3"
					QuestLv = 1
					NameMon = "Marine Lieutenant"
					CFrameQ = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531)
					CFrameMon = CFrame.new(-2489.2622070313, 84.613594055176, -3151.8830566406)
				elseif Lv == 900 or Lv <= 949 or SelectMonster == "Marine Captain [Lv. 900]" then -- Marine Captain
					Ms = "Marine Captain [Lv. 900]"
					NameQuest = "MarineQuest3"
					QuestLv = 2
					NameMon = "Marine Captain"
					CFrameQ = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531)
					CFrameMon = CFrame.new(-2335.2026367188, 79.786659240723, -3245.8674316406)
					if Lv >= 925 then
						_G.SelectBoss = "Fajita [Lv. 925] [Boss]"
					end
				elseif Lv == 950 or Lv <= 974 or SelectMonster == "Zombie [Lv. 950]" then -- Zombie
					Ms = "Zombie [Lv. 950]"
					NameQuest = "ZombieQuest"
					QuestLv = 1
					NameMon = "Zombie"
					CFrameQ = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281)
					CFrameMon = CFrame.new(-5536.4970703125, 101.08577728271, -835.59075927734)
				elseif Lv == 975 or Lv <= 999 or SelectMonster == "Vampire [Lv. 975]" then -- Vampire
					Ms = "Vampire [Lv. 975]"
					NameQuest = "ZombieQuest"
					QuestLv = 2
					NameMon = "Vampire"
					CFrameQ = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281)
					CFrameMon = CFrame.new(-5806.1098632813, 16.722528457642, -1164.4384765625)
				elseif Lv == 1000 or Lv <= 1049 or SelectMonster == "Snow Trooper [Lv. 1000]" then -- Snow Trooper
					Ms = "Snow Trooper [Lv. 1000]"
					NameQuest = "SnowMountainQuest"
					QuestLv = 1
					NameMon = "Snow Trooper"
					CFrameQ = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875)
					CFrameMon = CFrame.new(535.21051025391, 432.74209594727, -5484.9165039063)
				elseif Lv == 1050 or Lv <= 1099 or SelectMonster == "Winter Warrior [Lv. 1050]" then -- Winter Warrior
					Ms = "Winter Warrior [Lv. 1050]"
					NameQuest = "SnowMountainQuest"
					QuestLv = 2
					NameMon = "Winter Warrior"
					CFrameQ = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875)
					CFrameMon = CFrame.new(1234.4449462891, 456.95419311523, -5174.130859375)
				elseif Lv == 1100 or Lv <= 1124 or SelectMonster == "Lab Subordinate [Lv. 1100]" then -- Lab Subordinate
					Ms = "Lab Subordinate [Lv. 1100]"
					NameQuest = "IceSideQuest"
					QuestLv = 1
					NameMon = "Lab Subordinate"
					CFrameQ = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188)
					CFrameMon = CFrame.new(-5720.5576171875, 63.309471130371, -4784.6103515625)
				elseif Lv == 1125 or Lv <= 1174 or SelectMonster == "Horned Warrior [Lv. 1125]" then -- Horned Warrior
					Ms = "Horned Warrior [Lv. 1125]"
					NameQuest = "IceSideQuest"
					QuestLv = 2
					NameMon = "Horned Warrior"
					CFrameQ = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188)
					CFrameMon = CFrame.new(-6292.751953125, 91.181983947754, -5502.6499023438)
				elseif Lv == 1175 or Lv <= 1199 or SelectMonster == "Magma Ninja [Lv. 1175]" then -- Magma Ninja
					Ms = "Magma Ninja [Lv. 1175]"
					NameQuest = "FireSideQuest"
					QuestLv = 1
					NameMon = "Magma Ninja"
					CFrameQ = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
					CFrameMon = CFrame.new(-5461.8388671875, 130.36347961426, -5836.4702148438)
				elseif Lv == 1200 or Lv <= 1249 or SelectMonster == "Lava Pirate [Lv. 1200]" then -- Lava Pirate
					Ms = "Lava Pirate [Lv. 1200]"
					NameQuest = "FireSideQuest"
					QuestLv = 2
					NameMon = "Lava Pirate"
					CFrameQ = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
					CFrameMon = CFrame.new(-5251.1889648438, 55.164535522461, -4774.4096679688)
				elseif Lv == 1250 or Lv <= 1274 or SelectMonster == "Ship Deckhand [Lv. 1250]" then -- Ship Deckhand
					Ms = "Ship Deckhand [Lv. 1250]"
					NameQuest = "ShipQuest1"
					QuestLv = 1
					NameMon = "Ship Deckhand"
					CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
					CFrameMon = CFrame.new(921.12365722656, 125.9839553833, 33088.328125)
					if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
					end
				elseif Lv == 1275 or Lv <= 1299 or SelectMonster == "Ship Engineer [Lv. 1275]" then -- Ship Engineer
					Ms = "Ship Engineer [Lv. 1275]"
					NameQuest = "ShipQuest1"
					QuestLv = 2
					NameMon = "Ship Engineer"
					CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
					CFrameMon = CFrame.new(886.28179931641, 40.47790145874, 32800.83203125)
					if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
					end
				elseif Lv == 1300 or Lv <= 1324 or SelectMonster == "Ship Steward [Lv. 1300]" then -- Ship Steward
					Ms = "Ship Steward [Lv. 1300]"
					NameQuest = "ShipQuest2"
					QuestLv = 1
					NameMon = "Ship Steward"
					CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
					CFrameMon = CFrame.new(943.85504150391, 129.58183288574, 33444.3671875)
					if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
					end
				elseif Lv == 1325 or Lv <= 1349 or SelectMonster == "Ship Officer [Lv. 1325]" then -- Ship Officer
					Ms = "Ship Officer [Lv. 1325]"
					NameQuest = "ShipQuest2"
					QuestLv = 2
					NameMon = "Ship Officer"
					CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
					CFrameMon = CFrame.new(955.38458251953, 181.08335876465, 33331.890625)
					if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
					end
				elseif Lv == 1350 or Lv <= 1374 or SelectMonster == "Arctic Warrior [Lv. 1350]" then -- Arctic Warrior
					Ms = "Arctic Warrior [Lv. 1350]"
					NameQuest = "FrostQuest"
					QuestLv = 1
					NameMon = "Arctic Warrior"
					CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375)
					CFrameMon = CFrame.new(5935.4541015625, 77.26016998291, -6472.7568359375)
					if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
					end
				elseif Lv == 1375 or Lv <= 1424 or SelectMonster == "Snow Lurker [Lv. 1375]" then -- Snow Lurker
					Ms = "Snow Lurker [Lv. 1375]"
					NameQuest = "FrostQuest"
					QuestLv = 2
					NameMon = "Snow Lurker"
					CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375)
					CFrameMon = CFrame.new(5628.482421875, 57.574996948242, -6618.3481445313)
				elseif Lv == 1425 or Lv <= 1449 or SelectMonster == "Sea Soldier [Lv. 1425]" then -- Sea Soldier
					Ms = "Sea Soldier [Lv. 1425]"
					NameQuest = "ForgottenQuest"
					QuestLv = 1
					NameMon = "Sea Soldier"
					CFrameQ = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063)
					CFrameMon = CFrame.new(-3185.0153808594, 58.789089202881, -9663.6064453125)
				elseif Lv >= 1450 or SelectMonster == "Water Fighter [Lv. 1450]" then -- Water Fighter
					Ms = "Water Fighter [Lv. 1450]"
					NameQuest = "ForgottenQuest"
					QuestLv = 2
					NameMon = "Water Fighter"
					CFrameQ = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063)
					CFrameMon = CFrame.new(-3262.9301757813, 298.69036865234, -10552.529296875)
				end
			end
			if Three_World then
				if Lv == 1500 or Lv <= 1524 or SelectMonster == "Pirate Millionaire [Lv. 1500]" then -- Pirate Millionaire
					Ms = "Pirate Millionaire [Lv. 1500]"
					NameQuest = "PiratePortQuest"
					QuestLv = 1
					NameMon = "Pirate Millionaire"
					CFrameQ = CFrame.new(-289.61752319336, 43.819011688232, 5580.0903320313)
					CFrameMon = CFrame.new(-435.68109130859, 189.69866943359, 5551.0756835938)
				elseif Lv == 1525 or Lv <= 1574 or SelectMonster == "Pistol Billionaire [Lv. 1525]" then -- Pistol Billoonaire
					Ms = "Pistol Billionaire [Lv. 1525]"
					NameQuest = "PiratePortQuest"
					QuestLv = 2
					NameMon = "Pistol Billionaire"
					CFrameQ = CFrame.new(-289.61752319336, 43.819011688232, 5580.0903320313)
					CFrameMon = CFrame.new(-236.53652954102, 217.46676635742, 6006.0883789063)
				elseif Lv == 1575 or Lv <= 1599 or SelectMonster == "Dragon Crew Warrior [Lv. 1575]" then -- Dragon Crew Warrior
					Ms = "Dragon Crew Warrior [Lv. 1575]"
					NameQuest = "AmazonQuest"
					QuestLv = 1
					NameMon = "Dragon Crew Warrior"
					CFrameQ = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375)
					CFrameMon = CFrame.new(6301.9975585938, 104.77153015137, -1082.6075439453)
				elseif Lv == 1600 or Lv <= 1624 or SelectMonster == "Dragon Crew Archer [Lv. 1600]" then -- Dragon Crew Archer
					Ms = "Dragon Crew Archer [Lv. 1600]"
					NameQuest = "AmazonQuest"
					QuestLv = 2
					NameMon = "Dragon Crew Archer"
					CFrameQ = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375)
					CFrameMon = CFrame.new(6831.1171875, 441.76708984375, 446.58615112305)
				elseif Lv == 1625 or Lv <= 1649 or SelectMonster == "Female Islander [Lv. 1625]" then -- Female Islander
					Ms = "Female Islander [Lv. 1625]"
					NameQuest = "AmazonQuest2"
					QuestLv = 1
					NameMon = "Female Islander"
					CFrameQ = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
					CFrameMon = CFrame.new(5792.5166015625, 848.14392089844, 1084.1818847656)
				elseif Lv == 1650 or Lv <= 1699 or SelectMonster == "Giant Islander [Lv. 1650]" then -- Giant Islander
					Ms = "Giant Islander [Lv. 1650]"
					NameQuest = "AmazonQuest2"
					QuestLv = 2
					NameMon = "Giant Islander"
					CFrameQ = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
					CFrameMon = CFrame.new(5009.5068359375, 664.11071777344, -40.960144042969)
				elseif Lv == 1700 or Lv <= 1724 or SelectMonster == "Marine Commodore [Lv. 1700]" then -- Marine Commodore
					Ms = "Marine Commodore [Lv. 1700]"
					NameQuest = "MarineTreeIsland"
					QuestLv = 1
					NameMon = "Marine Commodore"
					CFrameQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
					CFrameMon = CFrame.new(2198.0063476563, 128.71075439453, -7109.5043945313)
				elseif Lv == 1725 or Lv <= 1774 or SelectMonster == "Marine Rear Admiral [Lv. 1725]" then -- Marine Rear Admiral
					Ms = "Marine Rear Admiral [Lv. 1725]"
					NameQuest = "MarineTreeIsland"
					QuestLv = 2
					NameMon = "Marine Rear Admiral"
					CFrameQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
					CFrameMon = CFrame.new(3294.3142089844, 385.41125488281, -7048.6342773438)
				elseif Lv == 1775 or Lv <= 1799 or SelectMonster == "Fishman Raider [Lv. 1775]" then -- Fishman Raide
					Ms = "Fishman Raider [Lv. 1775]"
					NameQuest = "DeepForestIsland3"
					QuestLv = 1
					NameMon = "Fishman Raider"
					CFrameQ = CFrame.new(-10582.759765625, 331.78845214844, -8757.666015625)
					CFrameMon = CFrame.new(-10553.268554688, 521.38439941406, -8176.9458007813)
				elseif Lv == 1800 or Lv <= 1824 or SelectMonster == "Fishman Captain [Lv. 1800]" then -- Fishman Captain
					Ms = "Fishman Captain [Lv. 1800]"
					NameQuest = "DeepForestIsland3"
					QuestLv = 2
					NameMon = "Fishman Captain"
					CFrameQ = CFrame.new(-10583.099609375, 331.78845214844, -8759.4638671875)
					CFrameMon = CFrame.new(-10789.401367188, 427.18637084961, -9131.4423828125)
				elseif Lv == 1825 or Lv <= 1849 or SelectMonster == "Forest Pirate [Lv. 1825]" then -- Forest Pirate
					Ms = "Forest Pirate [Lv. 1825]"
					NameQuest = "DeepForestIsland"
					QuestLv = 1
					NameMon = "Forest Pirate"
					CFrameQ = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
					CFrameMon = CFrame.new(-13489.397460938, 400.30349731445, -7770.251953125)
				elseif Lv == 1850 or Lv <= 1899 or SelectMonster == "Mythological Pirate [Lv. 1850]" then -- Mythological Pirate
					Ms = "Mythological Pirate [Lv. 1850]"
					NameQuest = "DeepForestIsland"
					QuestLv = 2
					NameMon = "Mythological Pirate"
					CFrameQ = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
					CFrameMon = CFrame.new(-13508.616210938, 582.46228027344, -6985.3037109375)
				elseif Lv >= 1900 and Lv <= 1924 or SelectMonster == "Jungle Pirate [Lv. 1900]" then -- Jungle Pirate
					Ms = "Jungle Pirate [Lv. 1900]"
					NameQuest = "DeepForestIsland2"
					QuestLv = 1
					NameMon = "Jungle Pirate"
					CFrameQ = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
					CFrameMon = CFrame.new(-12267.103515625, 459.75262451172, -10277.200195313)
				elseif Lv >= 1925 and Lv <= 1974 or SelectMonster == "Musketeer Pirate [Lv. 1925]" then -- Musketeer Pirate
					Ms = "Musketeer Pirate [Lv. 1925]"
					NameQuest = "DeepForestIsland2"
					QuestLv = 2
					NameMon = "Musketeer Pirate"
					CFrameQ = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
					CFrameMon = CFrame.new(-13291.5078125, 520.47338867188, -9904.638671875)
				elseif Lv >= 1975 and Lv <= 1999 or SelectMonster == "Reborn Skeleton [Lv. 1975]" then -- Reborn Skeleton
					Ms = "Musketeer Pirate [Lv. 1925]"
					NameQuest = "DeepForestIsland2"
					QuestLv = 2
					NameMon = "Musketeer Pirate"
					CFrameQ = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
					CFrameMon = CFrame.new(-13291.5078125, 520.47338867188, -9904.638671875)
				elseif Lv >= 2000 and Lv <= 2024 or SelectMonster == "Living Zombie [Lv. 2000]" then -- Living Zombie
					Ms = "Living Zombie [Lv. 2000]"
					NameQuest = "HauntedQuest1"
					QuestLv = 2
					NameMon = "Living Zombie"
					CFrameQ = CFrame.new(-9480.80762, 142.130661, 5566.37305)
					CFrameMon = CFrame.new(-10103.7529, 238.565979, 6179.75977)
				elseif Lv >= 2025 and Lv <= 2049 or SelectMonster == "Demonic Soul [Lv. 2025]" then -- Demonic Soul
					Ms = "Demonic Soul [Lv. 2025]"
					NameQuest = "HauntedQuest1"
					QuestLv = 1
					NameMon = "Demonic Souls"
					CFrameQ = CFrame.new(-9515.39551, 172.266037, 6078.89746)
					CFrameMon = CFrame.new(-9709.30762, 204.695892, 6044.04688)
				elseif Lv >= 2050 and Lv <= 2074 or SelectMonster == "Posessed Mummy [Lv. 2050]" then -- Posessed Mummy
					Ms = "Posessed Mummy [Lv. 2050]"
					NameQuest = "HauntedQuest2"
					QuestLv = 2
					NameMon = "Posessed Mummys"
					CFrameQ = CFrame.new(-9515.39551, 172.266037, 6078.89746)
					CFrameMon = CFrame.new(-9554.11035, 65.6141663, 6041.73584)
				elseif Lv >= 2075 and Lv <= 2099 or SelectMonster == "Peanut Scout [Lv. 2075]" then -- Peanut Scout
					Ms = "Peanut Scout [Lv. 2075]"
					NameQuest = "PeanutQuest1"
					QuestLv = 1
					NameMon = "Peanut Scout"
					CFrameQ = CFrame.new(-2104.453125, 38.129974365234, -10194.0078125)
					CFrameMon = CFrame.new(-2068.0949707031, 76.512603759766, -10117.150390625)
				elseif Lv >= 2100 and Lv <= 2124 or SelectMonster == "Peanut President [Lv. 2100]" then -- Peanut President
					Ms = "Peanut President [Lv. 2100]"
					NameQuest = "PeanutQuest2"
					QuestLv = 2
					NameMon = "Peanut Presidents"
					CFrameQ = CFrame.new(-2104.453125, 38.129974365234, -10194.0078125)
					CFrameMon = CFrame.new(-2067.33203125, 90.557350158691, -10552.051757812)
				elseif Lv >= 2125 and Lv <= 2149 or SelectMonster == "Ice Cream Chef [Lv. 2125]" then --Ice Cream Chef
					Ms = "Ice Cream Chef [Lv. 2125]"
					NameQuest = "IceCreamQuest1"
					QuestLv = 1
					NameMon = "	Ice Cream Chefs"
					CFrameQ = CFrame.new(-821.35913085938, 65.845329284668, -10965.2578125)
					CFrameMon = CFrame.new(-796.37261962891, 110.95275878906, -10847.473632812)
				elseif Lv >= 2150 and Lv <= 2200 or SelectMonster == "Ice Cream Commander [Lv. 2150]" then -- Ice Cream Commander
					Ms = "Ice Cream Commander [Lv. 2150]"
					NameQuest = "IceCreamIslandQuest"
					QuestLv = 2
					NameMon = "Ice Cream Commanders"
					CFrameQ = CFrame.new(-821.35913085938, 65.845329284668, -10965.2578125)
					CFrameMon = CFrame.new(-697.65338134766, 174.48368835449, -11218.38671875)
				elseif Lv >= 2200 and Lv <= 2250 or SelectMonster == "Ice Cream Commander [Lv. 2150]" then -- Ice Cream Commander
					Ms = "Cookie Crafter [Lv. 2200]"
					NameQuest = "CakeQuest1"
					QuestLv = 1
					NameMon = "Cookie Crafters"
					CFrameQ = CFrame.new(-2017.4874267578125, 36.85276412963867, -12027.53515625)
					CFrameMon = CFrame.new(-2358.5791015625, 36.85615539550781, -12111.052734375)
				elseif Lv >= 2225 or SelectMonster == "Cake Guard [Lv. 2225]" then
					Ms = "Cake Guard [Lv. 2225]"
					NameQuest = "CakeQuest1"
					QuestLv = 2
					NameMon = "Cake Guards"
					CFrameMon = CFrame.new(-1430.4925537109375, 36.85621643066406, -12322.162109375)
					CFrameQ = CFrame.new(-2017.4874267578125, 36.85276412963867, -12027.53515625)
				end
			end
		end

		function CheckLevel2()
			local Lv = game:GetService("Players").LocalPlayer.Data.Level.Value
			if _G.Upto then
				Lv = Lv + 100
			end
			if Old_World and not Auto_Raid then
				if Lv == 1 or Lv <= 9 or SelectMonster == "" then -- Bandit
					Ms = "Bandit [Lv. 5]"
					NameQuest = "BanditQuest1"
					QuestLv = 1
					NameMon = "Bandit"
					CFrameQ = CFrame.new(1059.37195, 15.4495068, 1550.4231, 0.939700544, -0, -0.341998369, 0, 1, -0, 0.341998369, 0, 0.939700544)
					CFrameMon = CFrame.new(1353.44885, 3.40935516, 1376.92029, 0.776053488, -6.97791975e-08, 0.630666852, 6.99138596e-08, 1, 2.4612488e-08, -0.630666852, 2.49917598e-08, 0.776053488)
					TelePBoss(CFrameQ)
				elseif Lv == 10 or Lv <= 14 or SelectMonster == "Monkey [Lv. 14]" then -- Monkey
					 
					Ms = "Monkey [Lv. 14]"
					NameQuest = "JungleQuest"
					QuestLv = 1
					NameMon = "Monkey"
					CFrameQ = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
					CFrameMon = CFrame.new(-1402.74609, 98.5633316, 90.6417007, 0.836947978, 0, 0.547282517, -0, 1, -0, -0.547282517, 0, 0.836947978)
					TelePBoss(CFrameQ)
					
				elseif Lv == 15 or Lv <= 29 or SelectMonster == "Gorilla [Lv. 20]" then -- Gorilla
					Ms = "Gorilla [Lv. 20]"
					NameQuest = "JungleQuest"
					QuestLv = 2
					NameMon = "Gorilla"
					CFrameQ = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
					CFrameMon = CFrame.new(-1267.89001, 66.2034225, -531.818115, -0.813996196, -5.25169774e-08, -0.580869019, -5.58769671e-08, 1, -1.21082593e-08, 0.580869019, 2.26011476e-08, -0.813996196)
					TelePBoss(CFrameQ)
					if Lv >= 25 then
						_G.SelectBoss = "The Gorilla King [Lv. 25] [Boss]" 
					end
					SelectMonster = "Monkey [Lv. 14]"
				elseif Lv >= 30 and Lv <= 40-1 or SelectMonster == "Pirate [Lv. 35]" then
					 
					Ms = "Pirate [Lv. 35]"
					NameQuest = "BuggyQuest1"
					QuestLv = 1
					NameMon = "Pirate"
					CFrameQ = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
					CFrameMon = CFrame.new(-1169.5365, 5.09531212, 3933.84082, -0.971822679, -3.73200315e-09, 0.235713184, -4.16762763e-10, 1, 1.41145424e-08, -0.235713184, 1.3618596e-08, -0.971822679)
					TelePBoss(CFrameQ)
					
				elseif Lv >= 40 and Lv <= 60-1 or SelectMonster == "Brute [Lv. 45]" then
					
					Ms = "Brute [Lv. 45]"
					NameQuest = "BuggyQuest1"
					QuestLv = 2
					NameMon = "Brute"
					CFrameQ = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
					CFrameMon = CFrame.new(-1165.09985, 15.1531372, 4363.51514, -0.962800264, 1.17564889e-06, 0.270213336, 2.60172015e-07, 1, -3.4237969e-06, -0.270213336, -3.22613073e-06, -0.962800264)
					TelePBoss(CFrameQ)
					if Lv >= 55 then
						_G.SelectBoss = "Bobby [Lv. 55] [Boss]"
					end
					SelectMonster = "Pirate [Lv. 35]"
				elseif Lv >= 60 and Lv <= 75-1 or SelectMonster == "Desert Bandit [Lv. 60]" then
					 
					Ms = "Desert Bandit [Lv. 60]"
					NameQuest = "DesertQuest"
					QuestLv = 1
					NameMon = "Desert Bandit"
					CFrameQ = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693)
					CFrameMon = CFrame.new(932.788818, 6.8503746, 4488.24609, -0.998625934, 3.08948351e-08, 0.0524050146, 2.79967303e-08, 1, -5.60361286e-08, -0.0524050146, -5.44919629e-08, -0.998625934)
					TelePBoss(CFrameQ)
					
				elseif Lv >= 75 and Lv <= 100-1 or SelectMonster == "Desert Officer [Lv. 70]" then
					Ms = "Desert Officer [Lv. 70]"
					NameQuest = "DesertQuest"
					QuestLv = 2
					NameMon = "Desert Officer"
					CFrameQ = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693)
					CFrameMon = CFrame.new(1617.07886, 1.5542295, 4295.54932, -0.997540116, -2.26287735e-08, -0.070099175, -1.69377223e-08, 1, -8.17798806e-08, 0.070099175, -8.03913949e-08, -0.997540116)
					TelePBoss(CFrameQ)
					SelectMonster = "Desert Bandit [Lv. 60]"
				elseif SelectMonster == "Snow Bandit [Lv. 90]" then -- Snow Bandits
					Ms = "Snow Bandit [Lv. 90]"
					NameQuest = "SnowQuest"
					QuestLv = 1
					NameMon = "Snow Bandits"
					CFrameQ = CFrame.new(1389.74451, 86.6520844, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685)
					CFrameMon = CFrame.new(1412.92346, 55.3503647, -1260.62036, -0.246266365, -0.0169920288, -0.969053388, 0.000432241941, 0.999844253, -0.0176417865, 0.969202161, -0.00476344163, -0.246220857)
					TelePBoss(CFrameQ)
					
				elseif Lv == 100 or Lv <= 119 or SelectMonster == "Snowman [Lv. 100]" then -- Snowman
					
					Ms = "Snowman [Lv. 100]"
					NameQuest = "SnowQuest"
					QuestLv = 2
					NameMon = "Snowman"
					CFrameQ = CFrame.new(1389.74451, 86.6520844, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685)
					CFrameMon = CFrame.new(1376.86401, 97.2779999, -1396.93115, -0.986755967, 7.71178321e-08, -0.162211925, 7.71531674e-08, 1, 6.08143536e-09, 0.162211925, -6.51427134e-09, -0.986755967)
					TelePBoss(CFrameQ)
					if Lv >= 110 then
						_G.SelectBoss = "Yeti [Lv. 110] [Boss]"
					end
					SelectMonster = "Snow Bandit [Lv. 90]"
					_G.Farm_Mon = true
				elseif Lv == 120 or Lv <= 174 or SelectMonster == "Chief Petty Officer [Lv. 120]" then -- Chief Petty Officer
					Ms = "Chief Petty Officer [Lv. 120]"
					NameQuest = "MarineQuest2"
					QuestLv = 1
					NameMon = "Chief Petty Officer"
					CFrameQ = CFrame.new(-5039.58643, 27.3500385, 4324.68018, 0, 0, -1, 0, 1, 0, 1, 0, 0)
					CFrameMon = CFrame.new(-4882.8623, 22.6520386, 4255.53516, 0.273695946, -5.40380647e-08, -0.96181643, 4.37720793e-08, 1, -4.37274998e-08, 0.96181643, -3.01326679e-08, 0.273695946)
					TelePBoss(CFrameQ)
					if Lv >= 130 then
						_G.SelectBoss = "Vice Admiral [Lv. 130] [Boss]"
					end
					
				elseif SelectMonster == "Sky Bandit [Lv. 150]" then -- Sky Bandit
					Ms = "Sky Bandit [Lv. 150]"
					NameQuest = "SkyQuest"
					QuestLv = 1
					NameMon = "Sky Bandit"
					CFrameQ = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
					CFrameMon = CFrame.new(-4959.51367, 365.39267, -2974.56812, 0.964867651, 7.74418396e-08, 0.262737453, -6.95931988e-08, 1, -3.91783708e-08, -0.262737453, 1.95171506e-08, 0.964867651)
					TelePBoss(CFrameQ)
					
				elseif Lv == 175 or Lv <= 209 or SelectMonster == "Dark Master [Lv. 175]" then -- Dark Master
					 
					Ms = "Dark Master [Lv. 175]"
					NameQuest = "SkyQuest"
					QuestLv = 2
					NameMon = "Dark Master"
					CFrameQ = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
					CFrameMon = CFrame.new(-5079.98096, 376.477356, -2194.17139, 0.465965867, -3.69776352e-08, 0.884802461, 3.40249851e-09, 1, 4.00000886e-08, -0.884802461, -1.56281423e-08, 0.465965867)
					TelePBoss(CFrameQ)
					SelectMonster = "Sky Bandit [Lv. 150]"
				elseif SelectMonster == "Prisoner [Lv. 190]" then
					 
					Ms = "Prisoner [Lv. 190]"
					QuestLv = 1
					NameQuest = "PrisonerQuest"
					NameMon = "Prisoner"
					CFrameQ = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
					CFrameMon = CFrame.new(5433.39307, 88.678093, 514.986877, 0.879988372, 0, -0.474995494, 0, 1, 0, 0.474995494, 0, 0.879988372)
					TelePBoss(CFrameQ)
					
				elseif Lv == 210 or Lv <= 249 or SelectMonster == "Dangerous Prisoner [Lv. 210]" then
					 
					Ms = "Dangerous Prisoner [Lv. 210]"
					QuestLv = 2
					NameQuest = "PrisonerQuest"
					NameMon = "Dangerous Prisoner"
					CFrameQ = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
					CFrameMon = CFrame.new(5433.39307, 88.678093, 514.986877, 0.879988372, 0, -0.474995494, 0, 1, 0, 0.474995494, 0, 0.879988372)
					TelePBoss(CFrameQ)
					if Lv >= 240 then
						_G.SelectBoss = "Swan [Lv. 240] [Boss]"
						
					elseif Lv >= 230 then
						_G.SelectBoss = "Chief Warden [Lv. 230] [Boss]"
						
					elseif Lv >= 220 then
						_G.SelectBoss = "Warden [Lv. 220] [Boss]"
					end
					SelectMonster = "Prisoner [Lv. 190]"
				elseif Lv == 250 or Lv <= 274 or SelectMonster == "Toga Warrior [Lv. 250]" then -- Toga Warrior
					 
					Ms = "Toga Warrior [Lv. 250]"
					NameQuest = "ColosseumQuest"
					QuestLv = 1
					NameMon = "Toga Warrior"
					CFrameQ = CFrame.new(-1576.11743, 7.38933945, -2983.30762, 0.576966345, 1.22114863e-09, 0.816767931, -3.58496594e-10, 1, -1.24185606e-09, -0.816767931, 4.2370063e-10, 0.576966345)
					CFrameMon = CFrame.new(-1779.97583, 44.6077499, -2736.35474, 0.984437346, 4.10396339e-08, 0.175734788, -3.62286876e-08, 1, -3.05844168e-08, -0.175734788, 2.3741821e-08, 0.984437346)
					TelePBoss(CFrameQ)
					
				elseif Lv == 275 or Lv <= 324 or SelectMonster == "Gladiator [Lv. 275]" then -- Gladiato
					 
					Ms = "Gladiator [Lv. 275]"
					NameQuest = "ColosseumQuest"
					QuestLv = 2
					NameMon = "Gladiato"
					CFrameQ = CFrame.new(-1576.11743, 7.38933945, -2983.30762, 0.576966345, 1.22114863e-09, 0.816767931, -3.58496594e-10, 1, -1.24185606e-09, -0.816767931, 4.2370063e-10, 0.576966345)
					CFrameMon = CFrame.new(-1274.75903, 58.1895943, -3188.16309, 0.464524001, 6.21005611e-08, 0.885560572, -4.80449414e-09, 1, -6.76054768e-08, -0.885560572, 2.71497012e-08, 0.464524001)
					TelePBoss(CFrameQ)
					SelectMonster = "Toga Warrior [Lv. 250]"
				elseif SelectMonster == "Military Soldier [Lv. 300]" then -- Military Soldier
					 
					Ms = "Military Soldier [Lv. 300]"
					NameQuest = "MagmaQuest"
					QuestLv = 1
					NameMon = "Military Soldier"
					CFrameQ = CFrame.new(-5316.55859, 12.2370615, 8517.2998, 0.588437557, -1.37880001e-08, -0.808542669, -2.10116209e-08, 1, -3.23446478e-08, 0.808542669, 3.60215964e-08, 0.588437557)
					CFrameMon = CFrame.new(-5363.01123, 41.5056877, 8548.47266, -0.578253984, -3.29503091e-10, 0.815856814, 9.11209668e-08, 1, 6.498761e-08, -0.815856814, 1.11920997e-07, -0.578253984)
					TelePBoss(CFrameQ)
					
				elseif Lv == 325 or Lv <= 374 or SelectMonster == "Military Spy [Lv. 325]" then -- Military Spy
					 
					Ms = "Military Spy [Lv. 325]"
					NameQuest = "MagmaQuest"
					QuestLv = 2
					NameMon = "Military Spy"
					CFrameQ = CFrame.new(-5316.55859, 12.2370615, 8517.2998, 0.588437557, -1.37880001e-08, -0.808542669, -2.10116209e-08, 1, -3.23446478e-08, 0.808542669, 3.60215964e-08, 0.588437557)
					CFrameMon = CFrame.new(-5787.99023, 120.864456, 8762.25293, -0.188358366, -1.84706277e-08, 0.982100308, -1.23782129e-07, 1, -4.93306951e-09, -0.982100308, -1.22495649e-07, -0.188358366)
					TelePBoss(CFrameQ)
					if Lv >= 350 then
						_G.SelectBoss = "Magma Admiral [Lv. 350] [Boss]"
					end
					SelectMonster = "Military Soldier [Lv. 300]"
				elseif Lv == 375 or Lv <= 399 or SelectMonster == "Fishman Warrior [Lv. 375]" then -- Fishman Warrior
					 
					Ms = "Fishman Warrior [Lv. 375]"
					NameQuest = "FishmanQuest"
					QuestLv = 1
					NameMon = "Fishman Warrior"
					CFrameQ = CFrame.new(61122.5625, 18.4716396, 1568.16504, 0.893533468, 3.95251609e-09, 0.448996574, -2.34327455e-08, 1, 3.78297464e-08, -0.448996574, -4.43233645e-08, 0.893533468)
					CFrameMon = CFrame.new(60946.6094, 48.6735229, 1525.91687, -0.0817126185, 8.90751153e-08, 0.996655822, 2.00889794e-08, 1, -8.77269599e-08, -0.996655822, 1.28533992e-08, -0.0817126185)
					if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
						_G.Stop_Tween = true
						TP(CFrameQ)
						wait(.5)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
						wait(.5)
						_G.Stop_Tween = nil
					end
					
				elseif Lv == 400 or Lv <= 449 or SelectMonster == "Fishman Commando [Lv. 400]" then -- Fishman Commando
					 
					Ms = "Fishman Commando [Lv. 400]"
					NameQuest = "FishmanQuest"
					QuestLv = 2
					NameMon = "Fishman Commando"
					CFrameQ = CFrame.new(61122.5625, 18.4716396, 1568.16504)
					CFrameMon = CFrame.new(60946.6094, 48.6735229, 1525.916871)
					if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
						_G.Stop_Tween = true
						TP(CFrameQ)
						wait(.5)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
						wait(.5)
						_G.Stop_Tween = nil
					end
					if Lv >= 425 then
						_G.SelectBoss = "Fishman Lord [Lv. 425] [Boss]"
					end
					SelectMonster = "Fishman Warrior [Lv. 375]"
				elseif Lv == 450 or Lv <= 474 or SelectMonster == "God's Guard [Lv. 450]" then 
					Ms = "God's Guard [Lv. 450]"
					NameQuest = "SkyExp1Quest"
					QuestLv = 1
					NameMon = "God's Guards"
					CFrameQ = CFrame.new(-4721.71436, 845.277161, -1954.20105)
					CFrameMon = CFrame.new(-4716.95703, 853.089722, -1933.925427)
					if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
						_G.Stop_Tween = true
						TP(CFrameQ)
						wait(.5)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
						wait(.5)
						_G.Stop_Tween = nil
					end
					if Lv >= 425 then
						_G.SelectBoss = "Fishman Lord [Lv. 425] [Boss]"
					end
					SelectMonster = "Fishman Commando [Lv. 400]"
				elseif Lv == 475 or Lv <= 524 or SelectMonster == "Shanda [Lv. 475]" then
					Ms = "Shanda [Lv. 475]"
					NameQuest = "SkyExp1Quest"
					QuestLv = 2
					NameMon = "Shandas"
					CFrameQ = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, -0.422592998)
					CFrameMon = CFrame.new(-7904.57373, 5584.37646, -459.62973, 0.65171206, 5.11171692e-08, 0.758466363, -4.76232476e-09, 1, -6.33034247e-08, -0.758466363, 3.76435416e-08, 0.65171206)
					if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
						_G.Stop_Tween = true
						TP(CFrameQ)
						wait(.5)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
						wait(.5)
						_G.Stop_Tween = nil
					end
					if Lv >= 500 then
						_G.SelectBoss = "Wysper [Lv. 500] [Boss]"
					end
					SelectMonster = "God's Guard [Lv. 450]"
				elseif Lv == 525 or Lv <= 549 or SelectMonster == "Royal Squad [Lv. 525]" then -- Royal Squad
					 
					Ms = "Royal Squad [Lv. 525]"
					NameQuest = "SkyExp2Quest"
					QuestLv = 1
					NameMon = "Royal Squad"
					CFrameQ = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
					CFrameMon = CFrame.new(-7555.04199, 5606.90479, -1303.24744, -0.896107852, -9.6057462e-10, -0.443836004, -4.24974544e-09, 1, 6.41599973e-09, 0.443836004, 7.63560326e-09, -0.896107852)
					TelePBoss(CFrameQ) 
					SelectMonster = "Shanda [Lv. 475]"
				elseif Lv == 550 or Lv <= 624 or SelectMonster == "Royal Soldier [Lv. 550]" then -- Royal Soldier
					 
					Ms = "Royal Soldier [Lv. 550]"
					NameQuest = "SkyExp2Quest"
					QuestLv = 2
					NameMon = "Royal Soldier"
					CFrameQ = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
					CFrameMon = CFrame.new(-7837.31152, 5649.65186, -1791.08582, -0.716008604, 0.0104285581, -0.698013008, 5.02521061e-06, 0.99988848, 0.0149335321, 0.69809103, 0.0106890313, -0.715928733)
					TelePBoss(CFrameQ)
					if Lv >= 575 then
						_G.SelectBoss = "Thunder God [Lv. 575] [Boss]"
					end
					SelectMonster = "Royal Squad [Lv. 525]"
				elseif Lv == 625 or Lv <= 649 or SelectMonster == "Galley Pirate [Lv. 625]" then -- Galley Pirate
					 
					Ms = "Galley Pirate [Lv. 625]"
					NameQuest = "FountainQuest"
					QuestLv = 1
					NameMon = "Galley Pirate"
					CFrameQ = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
					CFrameMon = CFrame.new(5569.80518, 38.5269432, 3849.01196, 0.896460414, 3.98027495e-08, 0.443124533, -1.34262139e-08, 1, -6.26611296e-08, -0.443124533, 5.02237434e-08, 0.896460414)
					TelePBoss(CFrameQ)
				elseif Lv >= 650 or SelectMonster == "Galley Captain [Lv. 650]" then -- Galley Captain
					 
					Ms = "Galley Captain [Lv. 650]"
					NameQuest = "FountainQuest"
					QuestLv = 2
					NameMon = "Galley Captain"
					CFrameQ = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
					CFrameMon = CFrame.new(5782.90186, 94.5326462, 4716.78174, 0.361808896, -1.24757526e-06, -0.932252586, 2.16989656e-06, 1, -4.96097414e-07, 0.932252586, -1.84339774e-06, 0.361808896)
					TelePBoss(CFrameQ)
					
					if Lv >= 675 then
						_G.SelectBoss = "Cyborg [Lv. 675] [Boss]"
					end
					SelectMonster = "Galley Pirate [Lv. 625]"
				end
			end
			if New_World and not Auto_Raid then
				 
				if Lv == 700 or Lv <= 724 or SelectMonster == "Raider [Lv. 700]" then -- Raider [Lv. 700]
					Ms = "Raider [Lv. 700]"
					NameQuest = "Area1Quest"
					QuestLv = 1
					NameMon = "Raider"
					CFrameQ = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
					CFrameMon = CFrame.new(-737.026123, 10.1748352, 2392.57959, 0.272128761, 0, -0.962260842, -0, 1, -0, 0.962260842, 0, 0.272128761)
					TelePBoss(CFrameQ)
				elseif Lv == 725 or Lv <= 774 or SelectMonster == "Mercenary [Lv. 725]" then -- Mercenary [Lv. 725]
					Ms = "Mercenary [Lv. 725]"
					NameQuest = "Area1Quest"
					QuestLv = 2
					NameMon = "Mercenary"
					CFrameQ = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
					CFrameMon = CFrame.new(-1022.21271, 72.9855194, 1891.39148, -0.990782857, 0, -0.135460541, 0, 1, 0, 0.135460541, 0, -0.990782857)
					TelePBoss(CFrameQ)
					SelectMonster = "Raider [Lv. 700]"
				elseif Lv == 775 or Lv <= 799 or SelectMonster == "Swan Pirate [Lv. 775]" then -- Swan Pirate [Lv. 775]
					Ms = "Swan Pirate [Lv. 775]"
					NameQuest = "Area2Quest"
					QuestLv = 1
					NameMon = "Swan Pirate"
					CFrameQ = CFrame.new(638.43811, 71.769989, 918.282898, 0.139203906, 0, 0.99026376, 0, 1, 0, -0.99026376, 0, 0.139203906)
					CFrameMon = CFrame.new(976.467651, 111.174057, 1229.1084, 0.00852567982, -4.73897828e-08, -0.999963999, 1.12251888e-08, 1, -4.7295778e-08, 0.999963999, -1.08215579e-08, 0.00852567982)
					TelePBoss(CFrameQ)
				elseif Lv == 800 or Lv <= 874 or SelectMonster == "Factory Staff [Lv. 800]" then -- Factory Staff [Lv. 800]
					Ms = "Factory Staff [Lv. 800]"
					NameQuest = "Area2Quest"
					QuestLv = 2
					NameMon = "Factory Staff"
					CFrameQ = CFrame.new(638.43811, 71.769989, 918.282898, 0.139203906, 0, 0.99026376, 0, 1, 0, -0.99026376, 0, 0.139203906)
					CFrameMon = CFrame.new(336.74585, 73.1620483, -224.129272, 0.993632793, 3.40154607e-08, 0.112668738, -3.87658332e-08, 1, 3.99718729e-08, -0.112668738, -4.40850592e-08, 0.993632793)
					TelePBoss(CFrameQ)
					SelectMonster = "Swan Pirate [Lv. 775]"
				elseif Lv == 875 or Lv <= 899 or SelectMonster == "Marine Lieutenant [Lv. 875]" then -- Marine Lieutenant [Lv. 875]
					Ms = "Marine Lieutenant [Lv. 875]"
					NameQuest = "MarineQuest3"
					QuestLv = 1
					NameMon = "Marine Lieutenant"
					CFrameQ = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
					CFrameMon = CFrame.new(-2842.69922, 72.9919434, -2901.90479, -0.762281299, 0, -0.64724648, 0, 1.00000012, 0, 0.64724648, 0, -0.762281299)
					TelePBoss(CFrameQ)
				elseif Lv == 900 or Lv <= 949 or SelectMonster == "Marine Captain [Lv. 900]" then -- Marine Captain [Lv. 900]
					Ms = "Marine Captain [Lv. 900]"
					NameQuest = "MarineQuest3"
					QuestLv = 2
					NameMon = "Marine Captain"
					CFrameQ = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
					CFrameMon = CFrame.new(-1814.70313, 72.9919434, -3208.86621, -0.900422215, 7.93464423e-08, -0.435017526, 3.68856199e-08, 1, 1.06050372e-07, 0.435017526, 7.94441988e-08, -0.900422215)
					TelePBoss(CFrameQ)
					SelectMonster = "Marine Lieutenant [Lv. 875]"
				elseif Lv == 950 or Lv <= 974 or SelectMonster == "Zombie [Lv. 950]" then -- Zombie [Lv. 950]
					Ms = "Zombie [Lv. 950]"
					NameQuest = "ZombieQuest"
					QuestLv = 1
					NameMon = "Zombie"
					CFrameQ = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
					CFrameMon = CFrame.new(-5649.23438, 126.0578, -737.773743, 0.355238914, -8.10359282e-08, 0.934775114, 1.65461245e-08, 1, 8.04023372e-08, -0.934775114, -1.3095117e-08, 0.355238914)
					TelePBoss(CFrameQ)
				elseif Lv == 975 or Lv <= 999 or SelectMonster == "Vampire [Lv. 975]" then -- Vampire [Lv. 975]
					Ms = "Vampire [Lv. 975]"
					NameQuest = "ZombieQuest"
					QuestLv = 2
					NameMon = "Vampire"
					CFrameQ = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
					CFrameMon = CFrame.new(-6030.32031, 0.4377408, -1313.5564, -0.856965423, 3.9138893e-08, -0.515373945, -1.12178942e-08, 1, 9.45958547e-08, 0.515373945, 8.68467822e-08, -0.856965423)
					TelePBoss(CFrameQ)
					SelectMonster = "Zombie [Lv. 950]"
				elseif Lv == 1000 or Lv <= 1049 or SelectMonster == "Snow Trooper [Lv. 1000]" then -- Snow Trooper [Lv. 1000] **
					Ms = "Snow Trooper [Lv. 1000]"
					NameQuest = "SnowMountainQuest"
					QuestLv = 1
					NameMon = "Snow Trooper"
					CFrameQ = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
					CFrameMon = CFrame.new(621.003418, 391.361053, -5335.43604, 0.481644779, 0, 0.876366913, 0, 1, 0, -0.876366913, 0, 0.481644779)
					TelePBoss(CFrameQ)
				elseif Lv == 1050 or Lv <= 1099 or SelectMonster == "Winter Warrior [Lv. 1050]" then -- Winter Warrior [Lv. 1050]
					Ms = "Winter Warrior [Lv. 1050]"
					NameQuest = "SnowMountainQuest"
					QuestLv = 2
					NameMon = "Winter Warrior"
					CFrameQ = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
					CFrameMon = CFrame.new(1295.62683, 429.447784, -5087.04492, -0.698032081, -8.28980049e-08, -0.71606636, -1.98835952e-08, 1, -9.63858184e-08, 0.71606636, -5.30424877e-08, -0.698032081)
					TelePBoss(CFrameQ)
					SelectMonster = "Snow Trooper [Lv. 1000]"
				elseif Lv == 1100 or Lv <= 1124 or SelectMonster == "Lab Subordinate [Lv. 1100]" then -- Lab Subordinate [Lv. 1100]
					Ms = "Lab Subordinate [Lv. 1100]"
					NameQuest = "IceSideQuest"
					QuestLv = 1
					NameMon = "Lab Subordinate"
					CFrameQ = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578)
					CFrameMon = CFrame.new(-5769.2041, 37.9288292, -4468.38721, -0.569419742, -2.49055017e-08, 0.822046936, -6.96206541e-08, 1, -1.79282633e-08, -0.822046936, -6.74401548e-08, -0.569419742)
					TelePBoss(CFrameQ)
				elseif Lv == 1125 or Lv <= 1174 or SelectMonster == "Horned Warrior [Lv. 1125]" then -- Horned Warrior [Lv. 1125]
					Ms = "Horned Warrior [Lv. 1125]"
					NameQuest = "IceSideQuest"
					QuestLv = 2
					NameMon = "Horned Warrior"
					CFrameQ = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578)
					CFrameMon = CFrame.new(-6401.27979, 15.9775667, -5948.24316, 0.388303697, 0, -0.921531856, 0, 1, 0, 0.921531856, 0, 0.388303697)
					TelePBoss(CFrameQ)
					SelectMonster = "Lab Subordinate [Lv. 1100]"
				elseif Lv == 1175 or Lv <= 1199 or SelectMonster == "Magma Ninja [Lv. 1175]" then -- Magma Ninja [Lv. 1175]
					Ms = "Magma Ninja [Lv. 1175]"
					NameQuest = "FireSideQuest"
					QuestLv = 1
					NameMon = "Magma Ninja"
					CFrameQ = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
					CFrameMon = CFrame.new(-5466.06445, 57.6952019, -5837.42822, -0.988835871, 0, -0.149006829, 0, 1, 0, 0.149006829, 0, -0.988835871)
					TelePBoss(CFrameQ)
				elseif Lv == 1200 or Lv <= 1249 or SelectMonster == "Lava Pirate [Lv. 1200]" then 
					Ms = "Lava Pirate [Lv. 1200]"
					NameQuest = "FireSideQuest"
					QuestLv = 2
					NameMon = "Lava Pirate"
					CFrameQ = CFrame.new(-5431.09473, 15.9868021, -5296.53223, 0.831796765, 1.15322464e-07, -0.555080295, -1.10814341e-07, 1, 4.17010995e-08, 0.555080295, 2.68240168e-08, 0.831796765)
					CFrameMon = CFrame.new(-5169.71729, 34.1234779, -4669.73633, -0.196780294, 0, 0.98044765, 0, 1.00000012, -0, -0.98044765, 0, -0.196780294)
					TelePBoss(CFrameQ)
					SelectMonster = "Magma Ninja [Lv. 1175]"
				elseif Lv == 1250 or Lv <= 1274 or SelectMonster == "Ship Deckhand [Lv. 1250]" then 
					Ms = "Ship Deckhand [Lv. 1250]"
					NameQuest = "ShipQuest1"
					QuestLv = 1
					NameMon = "Ship Deckhand"
					CFrameQ = CFrame.new(1037.80127, 125.092171, 32911.6016, -0.244533166, -0, -0.969640911, -0, 1.00000012, -0, 0.96964103, 0, -0.244533136)
					CFrameMon = CFrame.new(1163.80872, 138.288452, 33058.4258, -0.998580813, 5.49076979e-08, -0.0532564968, 5.57436763e-08, 1, -1.42118655e-08, 0.0532564968, -1.71604082e-08, -0.998580813)
					if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
					end
				elseif Lv == 1275 or Lv <= 1299 or SelectMonster == "Ship Engineer [Lv. 1275]" then 
					Ms = "Ship Engineer [Lv. 1275]"
					NameQuest = "ShipQuest1"
					QuestLv = 2
					NameMon = "Ship Engineer"
					CFrameQ = CFrame.new(1037.80127, 125.092171, 32911.6016, -0.244533166, -0, -0.969640911, -0, 1.00000012, -0, 0.96964103, 0, -0.244533136)
					CFrameMon = CFrame.new(921.30249023438, 125.400390625, 32937.34375)
					if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
					end
					SelectMonster = "Ship Deckhand [Lv. 1250]"
				elseif Lv == 1300 or Lv <= 1324 or SelectMonster == "Ship Steward [Lv. 1300]" then 
					Ms = "Ship Steward [Lv. 1300]"
					NameQuest = "ShipQuest2"
					QuestLv = 1
					NameMon = "Ship Steward"
					CFrameQ = CFrame.new(968.80957, 125.092171, 33244.125, -0.869560242, 1.51905191e-08, -0.493826836, 1.44108379e-08, 1, 5.38534195e-09, 0.493826836, -2.43357912e-09, -0.869560242)
					CFrameMon = CFrame.new(917.96057128906, 136.89932250977, 33343.4140625)
					if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
					end
				elseif Lv == 1325 or Lv <= 1349 or SelectMonster == "Ship Officer [Lv. 1325]" then 
					Ms = "Ship Officer [Lv. 1325]"
					NameQuest = "ShipQuest2"
					QuestLv = 2
					NameMon = "Ship Officer"
					CFrameQ = CFrame.new(968.80957, 125.092171, 33244.125, -0.869560242, 1.51905191e-08, -0.493826836, 1.44108379e-08, 1, 5.38534195e-09, 0.493826836, -2.43357912e-09, -0.869560242)
					CFrameMon = CFrame.new(944.44964599609, 181.40081787109, 33278.9453125)
					if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
					end
					SelectMonster = "Ship Steward [Lv. 1300]"
				elseif Lv == 1350 or Lv <= 1374 or SelectMonster == "Arctic Warrior [Lv. 1350]" then 
					Ms = "Arctic Warrior [Lv. 1350]"
					NameQuest = "FrostQuest"
					QuestLv = 1
					NameMon = "Arctic Warrior"
					CFrameQ = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
					CFrameMon = CFrame.new(5878.23486, 81.3886948, -6136.35596, -0.451037169, 2.3908234e-07, 0.892505825, -1.08168464e-07, 1, -3.22542007e-07, -0.892505825, -2.4201924e-07, -0.451037169)
					if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
					end
				elseif Lv == 1375 or Lv <= 1424 or SelectMonster == "Snow Lurker [Lv. 1375]" then -- Snow Lurker [Lv. 1375]
					Ms = "Snow Lurker [Lv. 1375]"
					NameQuest = "FrostQuest"
					QuestLv = 2
					NameMon = "Snow Lurker"
					CFrameQ = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
					CFrameMon = CFrame.new(5513.36865, 60.546711, -6809.94971, -0.958693981, -1.65617333e-08, 0.284439981, -4.07668654e-09, 1, 4.44854642e-08, -0.284439981, 4.14883701e-08, -0.958693981)
					if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
					end
					SelectMonster = "Arctic Warrior [Lv. 1350]"
				elseif Lv == 1425 or Lv <= 1449 or SelectMonster == "Sea Soldier [Lv. 1425]" then -- Sea Soldier [Lv. 1425]
					Ms = "Sea Soldier [Lv. 1425]"
					NameQuest = "ForgottenQuest"
					QuestLv = 1
					NameMon = "Sea Soldier"
					CFrameQ = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376)
					CFrameMon = CFrame.new(-3115.78223, 63.8785706, -9808.38574, -0.913427353, 3.11199457e-08, 0.407000452, 7.79564235e-09, 1, -5.89660658e-08, -0.407000452, -5.06883708e-08, -0.913427353)
					TelePBoss(CFrameQ)
				elseif Lv >= 1450 or SelectMonster == "Water Fighter [Lv. 1450]" then -- Water Fighter [Lv. 1450]
					Ms = "Water Fighter [Lv. 1450]"
					NameQuest = "ForgottenQuest"
					QuestLv = 2
					NameMon = "Water Fighter"
					CFrameQ = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376)
					CFrameMon = CFrame.new(-3212.99683, 263.809296, -10551.8799, 0.742111444, -5.59139615e-08, -0.670276582, 1.69155214e-08, 1, -6.46908234e-08, 0.670276582, 3.66697037e-08, 0.742111444)
					TelePBoss(CFrameQ)
					SelectMonster = "Sea Soldier [Lv. 1425]"
					if Lv >= 1475 then
						_G.SelectBoss = "Tide Keeper [Lv. 1475] [Boss]"
					end
				end
			end
			if Three_World and not Auto_Raid then
				if Lv >= 1500 and Lv <= 1524 or SelectMonster == "Pirate Millionaire [Lv. 1500]" then -- Pirate Millionaire [Lv. 1500]
					Ms = "Pirate Millionaire [Lv. 1500]"
					NameQuest = "PiratePortQuest"
					QuestLv = 1
					NameMon = "Pirate Millionaire"
					CFrameQ = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
					CFrameMon = CFrame.new(81.164993286133, 43.755737304688, 5724.7021484375)
					TelePBoss(CFrameQ)
				elseif Lv >= 1525 and Lv <= 1574 or SelectMonster == "Pistol Billionaire [Lv. 1525]" then -- Pistol Billionaire [Lv. 1525]
					Ms = "Pistol Billionaire [Lv. 1525]"
					NameQuest = "PiratePortQuest"
					QuestLv = 2
					NameMon = "Pistol Billionaire"
					CFrameQ = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
					CFrameMon = CFrame.new(81.164993286133, 43.755737304688, 5724.7021484375)
					TelePBoss(CFrameQ)
					SelectMonster = "Pirate Millionaire [Lv. 1500]"
				elseif Lv >= 1575 and Lv <= 1599 or SelectMonster == "Dragon Crew Warrior [Lv. 1575]" then -- Dragon Crew Warrior [Lv. 1575]
					Ms = "Dragon Crew Warrior [Lv. 1575]"
					NameQuest = "AmazonQuest"
					QuestLv = 1
					NameMon = "Dragon Crew Warrior"
					CFrameQ = CFrame.new(5832.83594, 51.6806107, -1101.51563, 0.898790359, -0, -0.438378751, 0, 1, -0, 0.438378751, 0, 0.898790359)
					CFrameMon = CFrame.new(6241.9951171875, 51.522083282471, -1243.9771728516)
					TelePBoss(CFrameQ)
				elseif Lv >= 1600 and Lv <= 1624 or SelectMonster == "Dragon Crew Archer [Lv. 1600]" then -- Dragon Crew Archer [Lv. 1600]
					Ms = "Dragon Crew Archer [Lv. 1600]"
					NameQuest = "AmazonQuest"
					QuestLv = 2
					NameMon = "Dragon Crew Archer"
					CFrameQ = CFrame.new(5832.83594, 51.6806107, -1101.51563, 0.898790359, -0, -0.438378751, 0, 1, -0, 0.438378751, 0, 0.898790359)
					CFrameMon = CFrame.new(6488.9155273438, 383.38375854492, -110.66246032715)
					TelePBoss(CFrameQ)
					SelectMonster = "Dragon Crew Warrior [Lv. 1575]"
				elseif Lv >= 1625 and Lv <= 1649 or SelectMonster == "Female Islander [Lv. 1625]" then -- Female Islander [Lv. 1625]
					Ms = "Female Islander [Lv. 1625]"
					NameQuest = "AmazonQuest2"
					QuestLv = 1
					NameMon = "Female Islander"
					CFrameQ = CFrame.new(5448.86133, 601.516174, 751.130676, 0, 0, 1, 0, 1, -0, -1, 0, 0)
					CFrameMon = CFrame.new(4770.4990234375, 758.95520019531, 1069.8680419922)
					TelePBoss(CFrameQ)
				elseif Lv >= 1650 and Lv <= 1699 or SelectMonster == "Giant Islander [Lv. 1650]" then -- Giant Islander [Lv. 1650]
					Ms = "Giant Islander [Lv. 1650]"
					NameQuest = "AmazonQuest2"
					QuestLv = 2
					NameMon = "Giant Islander"
					CFrameQ = CFrame.new(5448.86133, 601.516174, 751.130676, 0, 0, 1, 0, 1, -0, -1, 0, 0)
					CFrameMon = CFrame.new(4530.3540039063, 656.75695800781, -131.60952758789)
					TelePBoss(CFrameQ)
					SelectMonster = "Female Islander [Lv. 1625]"
				elseif Lv >= 1700 and Lv <= 1724 or SelectMonster == "Marine Commodore [Lv. 1700]" then -- Marine Commodore [Lv. 1700]
					Ms = "Marine Commodore [Lv. 1700]"
					NameQuest = "MarineTreeIsland"
					QuestLv = 1
					NameMon = "Marine Commodore"
					CFrameQ = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
					CFrameMon = CFrame.new(2490.0844726563, 190.4232635498, -7160.0502929688)
					TelePBoss(CFrameQ)
				elseif Lv >= 1725 and Lv <= 1774 or SelectMonster == "Marine Rear Admiral [Lv. 1725]" then -- Marine Rear Admiral [Lv. 1725]
					Ms = "Marine Rear Admiral [Lv. 1725]"
					NameQuest = "MarineTreeIsland"
					QuestLv = 2
					NameMon = "Marine Rear Admiral"
					CFrameQ = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
					CFrameMon = CFrame.new(3951.3903808594, 229.11549377441, -6912.81640625)
					TelePBoss(CFrameQ)
					SelectMonster = "Marine Commodore [Lv. 1700]"
				elseif Lv >= 1775 and Lv <= 1799 or SelectMonster == "Fishman Raider [Lv. 1775]" then -- Fishman Raider [Lv. 1775]
					Ms = "Fishman Raider [Lv. 1775]"
					NameQuest = "DeepForestIsland3"
					QuestLv = 1
					NameMon = "Fishman Raider"
					CFrameQ = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
					CFrameMon = CFrame.new(-10322.400390625, 390.94473266602, -8580.0908203125)
					TelePBoss(CFrameQ)
				elseif Lv >= 1800 and Lv <= 1824 or SelectMonster == "Fishman Captain [Lv. 1800]" then -- Fishman Captain [Lv. 1800]
					Ms = "Fishman Captain [Lv. 1800]"
					NameQuest = "DeepForestIsland3"
					QuestLv = 2
					NameMon = "Fishman Captain"
					CFrameQ = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
					CFrameMon = CFrame.new(-11194.541992188, 442.02795410156, -8608.806640625)
					TelePBoss(CFrameQ)
					SelectMonster = "Fishman Raider [Lv. 1775]"
				elseif Lv >= 1825 and Lv <= 1849 or SelectMonster == "Forest Pirate [Lv. 1825]" then -- Forest Pirate [Lv. 1825]
					Ms = "Forest Pirate [Lv. 1825]"
					NameQuest = "DeepForestIsland"
					QuestLv = 1
					NameMon = "Forest Pirate"
					CFrameQ = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)
					CFrameMon = CFrame.new(-13225.809570313, 428.19387817383, -7753.1245117188)
					TelePBoss(CFrameQ)
				elseif Lv >= 1850 and Lv <= 1899 or SelectMonster == "Mythological Pirate [Lv. 1850]" then -- Mythological Pirate [Lv. 1850]
					Ms = "Mythological Pirate [Lv. 1850]"
					NameQuest = "DeepForestIsland"
					QuestLv = 2
					NameMon = "Mythological Pirate"
					CFrameQ = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)
					CFrameMon = CFrame.new(-13869.172851563, 564.95251464844, -7084.4135742188)
					TelePBoss(CFrameQ)
					SelectMonster = "Forest Pirate [Lv. 1825]"
				elseif Lv >= 1900 and Lv <= 1924 or SelectMonster == "Jungle Pirate [Lv. 1900]" then -- Jungle Pirate [Lv. 1900]
					Ms = "Jungle Pirate [Lv. 1900]"
					NameQuest = "DeepForestIsland2"
					QuestLv = 1
					NameMon = "Jungle Pirate"
					CFrameQ = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
					CFrameMon = CFrame.new(-11982.221679688, 376.32522583008, -10451.415039063)
					TelePBoss(CFrameQ)
				elseif Lv >= 1925 and Lv <= 1974 or SelectMonster == "Musketeer Pirate [Lv. 1925]" then -- Musketeer Pirate [Lv. 1925]
					Ms = "Musketeer Pirate [Lv. 1925]"
					NameQuest = "DeepForestIsland2"
					QuestLv = 2
					NameMon = "Musketeer Pirate"
					CFrameQ = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
					CFrameMon = CFrame.new(-13282.3046875, 496.23684692383, -9565.150390625)
					TelePBoss(CFrameQ)
					SelectMonster = "Jungle Pirate [Lv. 1900]"
				elseif Lv >= 1975 and Lv <= 1999 or SelectMonster == "Reborn Skeleton [Lv. 1975]" then
					Ms = "Reborn Skeleton [Lv. 1975]"
					NameQuest = "HauntedQuest1"
					QuestLv = 1
					NameMon = "Reborn Skeleton"
					CFrameQ = CFrame.new(-9480.8271484375, 142.13066101074, 5566.0712890625)
					CFrameMon = CFrame.new(-8817.880859375, 191.16761779785, 6298.6557617188)
					TelePBoss(CFrameQ)
				elseif Lv >= 2000 and Lv <= 2024 or SelectMonster == "Living Zombie [Lv. 2000]" then
					Ms = "Living Zombie [Lv. 2000]"
					NameQuest = "HauntedQuest1"
					QuestLv = 2
					NameMon = "Living Zombie"
					CFrameQ = CFrame.new(-9480.8271484375, 142.13066101074, 5566.0712890625)
					CFrameMon = CFrame.new(-10125.234375, 183.94705200195, 6242.013671875)
					TelePBoss(CFrameQ)
					SelectMonster = "Reborn Skeleton [Lv. 1975]"
				elseif Lv >= 2025 and Lv <= 2049  or  SelectMonster == "Demonic Soul [Lv. 2025]" then
					Ms = "Demonic Soul [Lv. 2025]"
					NameQuest = "HauntedQuest2"
					QuestLv = 1
					NameMon = "Demonic"
					CFrameQ = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
					CFrameMon = CFrame.new(-9712.03125, 204.69589233398, 6193.322265625)
					TelePBoss(CFrameQ)
					SelectMonster = "Living Zombie [Lv. 2000]"
				elseif Lv >= 2050 and Lv <= 2074 or SelectMonster == "Posessed Mummy [Lv. 2050]" then
					Ms = "Posessed Mummy [Lv. 2050]"
					NameQuest = "HauntedQuest2"
					QuestLv = 2
					NameMon = "Posessed Mummy"
					CFrameQ = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
					CFrameMon = CFrame.new(-9545.7763671875, 69.619895935059, 6339.5615234375)    
					TelePBoss(CFrameQ)
					SelectMonster = "Demonic Soul [Lv. 2025]"
				elseif Lv >= 2075 and Lv <= 2099 or SelectMonster == "Peanut Scout [Lv. 2075]" then
					Ms = "Peanut Scout [Lv. 2075]"
					NameQuest = "NutsIslandQuest"
					QuestLv = 1
					NameMon = "Peanut Scout"
					CFrameQ = CFrame.new(-2104.17163, 38.1299706, -10194.418, 0.758814394, -1.38604395e-09, 0.651306927, 2.85280208e-08, 1, -3.1108879e-08, -0.651306927, 4.21863646e-08, 0.758814394)
					CFrameMon = CFrame.new(-2098.07544, 192.611862, -10248.8867, 0.983392298, -9.57031787e-08, 0.181492642, 8.7276355e-08, 1, 5.44169616e-08, -0.181492642, -3.76732068e-08, 0.983392298)
					TelePBoss(CFrameQ)
				elseif Lv >= 2100 and Lv <= 2124 or SelectMonster == "Peanut President [Lv. 2100]" then
					Ms = "Peanut President [Lv. 2100]"
					NameQuest = "NutsIslandQuest"
					QuestLv = 2
					NameMon = "Peanut President"
					CFrameQ = CFrame.new(-2104.17163, 38.1299706, -10194.418, 0.758814394, -1.38604395e-09, 0.651306927, 2.85280208e-08, 1, -3.1108879e-08, -0.651306927, 4.21863646e-08, 0.758814394)
					CFrameMon = CFrame.new(-1876.95959, 192.610947, -10542.2939, 0.0553516336, -2.83836812e-08, 0.998466909, -6.89634405e-10, 1, 2.84654931e-08, -0.998466909, -2.26418861e-09, 0.0553516336)
					SelectMonster = "Peanut Scout [Lv. 2075]"
					TelePBoss(CFrameQ)
				elseif Lv >= 2125 and Lv <= 2149 or SelectMonster == "Ice Cream Chef [Lv. 2125]" then
					Ms = "Ice Cream Chef [Lv. 2125]"
					NameQuest = "IceCreamIslandQuest"
					QuestLv = 1
					NameMon = "Ice Cream Chef"
					CFrameQ = CFrame.new(-820.404358, 65.8453293, -10965.5654, 0.822534859, 5.24448502e-08, -0.568714678, -2.08336317e-08, 1, 6.20846663e-08, 0.568714678, -3.92184099e-08, 0.822534859)
					CFrameMon = CFrame.new(-821.614075, 208.39537, -10990.7617, -0.870096624, 3.18909272e-08, 0.492881238, -1.8357893e-08, 1, -9.71107568e-08, -0.492881238, -9.35439957e-08, -0.870096624)
					TelePBoss(CFrameQ)
				elseif Lv >= 2150 and Lv <= 2199 or SelectMonster == "Ice Cream Commander [Lv. 2150]" then 
					Ms = "Ice Cream Commander [Lv. 2150]"
					NameQuest = "IceCreamIslandQuest"
					QuestLv = 2
					NameMon = "Ice Cream Commander"
					CFrameQ = CFrame.new(-819.376526, 67.4634171, -10967.2832)
					CFrameMon = CFrame.new(-610.11669921875, 208.26904296875, -11253.686523438)
					TelePBoss(CFrameQ)
					SelectMonster = "Ice Cream Chef [Lv. 2125]"
				elseif Lv >= 2200 and Lv <= 2224 or SelectMonster == "Cookie Crafter [Lv. 2200]" then 
					Ms = "Cookie Crafter [Lv. 2200]"
					NameQuest = "CakeQuest1"
					QuestLv = 1
					NameMon = "Cookie Crafter"
					CFrameQ = CFrame.new(-2020.6068115234375, 37.82400894165039, -12027.80859375)
					CFrameMon = CFrame.new(-2286.684326171875, 146.5656280517578, -12226.8818359375)
					TelePBoss(CFrameQ)
				elseif Lv >= 2225 and Lv <= 2249 or SelectMonster == "Cake Guard [Lv. 2225]" then 
					Ms = "Cake Guard [Lv. 2225]"
					NameQuest = "CakeQuest1"
					QuestLv = 2
					NameMon = "Cake Guard"
					CFrameQ = CFrame.new(-2020.6068115234375, 37.82400894165039, -12027.80859375)
					CFrameMon = CFrame.new(-1817.9747314453125, 209.5632781982422, -12288.9228515625)
					SelectMonster = "Cookie Crafter [Lv. 2200]"
					TelePBoss(CFrameQ)
				elseif Lv >= 2250 or SelectMonster == "Baking Staff [Lv. 2250]" then 
					Ms = "Baking Staff [Lv. 2250]"
					NameQuest = "CakeQuest2"
					QuestLv = 1
					NameMon = "Baking Staff"
					CFrameQ = CFrame.new(-1928.31763, 37.7296638, -12840.626)
					CFrameMon = CFrame.new(-1818.347900390625, 93.41275787353516, -12887.66015625)
					TelePBoss(CFrameQ)
				end
			end
		end

		function TP(P1)
			if not _G.Stop_Tween then
				local Distance = (P1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
				Speed = 100
				if Distance < 250 then
					Speed = 5000
				elseif Distance < 500 then
					Speed = 650
				elseif Distance < 1000 then
					Speed = 350
				elseif Distance >= 1000 then
					Speed = 250
				end
				Tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),{CFrame = P1})
				if _G.Stop_Tween or Auto_Raid then
					Tween:Cancel()
				elseif game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
					Tween:Play()
				end
			end
		end
		
function TP3(P1)
	local Distance = (P1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
	if Distance < 250 then
		Speed = 10000
	elseif Distance < 500 then
		Speed = 500
	elseif Distance < 1000 then
		Speed = 250
	elseif Distance >= 1000 then
		Speed = 250
	end
	game:GetService("TweenService"):Create(
		game.Players.LocalPlayer.Character.HumanoidRootPart,
		TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
		{CFrame = P1}
	):Play()
	if _G.Stop_Tween then
		game:GetService("TweenService"):Create(
		game.Players.LocalPlayer.Character.HumanoidRootPart,
		TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
			{CFrame = P1}
		):Cancel()
	end
end

function TP2(P1)
	local Distance = (P1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
	if Distance < 150 then
		Speed = 5000
	elseif Distance < 200 then
		Speed = 1500
	elseif Distance < 300 then
		Speed = 800
	elseif Distance < 500 then
		Speed = 500
	elseif Distance < 1000 then
		Speed = 250
	elseif Distance >= 1000 then
		Speed = 250
	end
	game:GetService("TweenService"):Create(
		game.Players.LocalPlayer.Character.HumanoidRootPart,
		TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
		{CFrame = P1}
	):Play()
	if _G.Stop_Tween then
		game:GetService("TweenService"):Create(
		game.Players.LocalPlayer.Character.HumanoidRootPart,
		TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
			{CFrame = P1}
		):Cancel()
	end
	_G.Clip = true
	wait(Distance/Speed)
	_G.Clip = false
end

function EquipWeapon(ToolSe)
	if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
		local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
		wait(.4)
		game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
	end
end

spawn(function()
    while wait(.1) do
        pcall(function()
            if _G.Clip or Auto_Farm_Bounty or Auto_Twin_Hooks or Auto_Canvander or Auto_Buddy_Sword or Auto_Hallow_Scryte or Auto_Spikey_Trident or Auto_Dark_Dagger or Auto_Serpent_Bow or Auto_Acidum_Rifle or Auto_Swan_Glass or Auto_Pale_Scarf or Auto_Valkyrie_Helmet or Saber_Farm or Pole_Farm or Rengoku_A or Auto_Dragon_Trident or Triple_A or Auto_Yama or Auto_Tushita or Auto_Dark_Coat or _G.Setting_table.Human_Evo or _G.Setting_table.Mink_Evo or _G.Setting_table.Death_Step or _G.Setting_table.Sharkman_Karate or _G.Setting_table.Electric_Claw or _G.Setting_table.Dragon_Talon or _G.Setting_table.Superhuman or Auto_Three_World or Bartlio_Farm or Auto_New_A or Auto_Elite_Hunter or Auto_Phoenix_Awaken or Auto_Raid or _G.Setting_table.Farm_Ken_Hop or _G.Setting_table.Auto_Farm_Boss_Hop or _G.Setting_table.Auto_Farm_Boss_All_Hop or Open_Color_Haki or Auto_Holy_Torch or Grab_Chest or Auto_Farm_Monster or Farm_Ken or Auto_Farm_Bone or Farm_Ken_V2 or Auto_Farm_Melee or Auto_Farm_Sword or Auto_Farm or Auto_Farm_Gun or Auto_Farm_Boss_All or Auto_Farm_Boss or Auto_Farm_Fruit then
				if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
					game.Players.LocalPlayer.Character.Humanoid:ChangeState(15)
					wait(5)
				end
				PIO = false
                if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then 
					local L_1 = Instance.new("BodyVelocity")
                    L_1.Name = "BodyGyrozz"
                    L_1.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart 
                    L_1.MaxForce=Vector3.new(1000000000,1000000000,1000000000)
                    L_1.Velocity=Vector3.new(0,0,0) 
                end
            elseif PIO == false then
				for i,v in pairs(game.Players.LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
					if v.Name == "BodyGyrozz" then
						v:Destroy()
						PIO = true
					end
				end
            end
        end)
    end
end)

IKAI = true
if IKAI then
	do
		local ui = game.CoreGui:FindFirstChild("RippleHUBLIB")
		if ui then
			ui:Destroy()
		end
	end
	
	local UserInputService = game:GetService("UserInputService")
	local TweenService = game:GetService("TweenService")
	local RunService = game:GetService("RunService")
	local LocalPlayer = game:GetService("Players").LocalPlayer
	local Mouse = LocalPlayer:GetMouse()
	local tween = game:GetService("TweenService")
	local Red = {RainbowColorValue = 0, HueSelectionPosition = 0}
	local LogoButton = [[7040391851]]
	
	
	local function Tween(instance, properties,style,wa)
		if style == nil or "" then
			return Back
		end
		tween:Create(instance,TweenInfo.new(wa,Enum.EasingStyle[style]),{properties}):Play()
	end
	
	local ActualTypes = {
		RoundFrame = "ImageLabel",
		Shadow = "ImageLabel",
		Circle = "ImageLabel",
		CircleButton = "ImageButton",
		Frame = "Frame",
		Label = "TextLabel",
		Button = "TextButton",
		SmoothButton = "ImageButton",
		Box = "TextBox",
		ScrollingFrame = "ScrollingFrame",
		Menu = "ImageButton",
		NavBar = "ImageButton"
	}
	
	local Properties = {
		RoundFrame = {
			BackgroundTransparency = 1,
			Image = "http://www.roblox.com/asset/?id=5554237731",
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(3,3,297,297)
		},
		SmoothButton = {
			AutoButtonColor = false,
			BackgroundTransparency = 1,
			Image = "http://www.roblox.com/asset/?id=5554237731",
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(3,3,297,297)
		},
		Shadow = {
			Name = "Shadow",
			BackgroundTransparency = 1,
			Image = "http://www.roblox.com/asset/?id=5554236805",
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(23,23,277,277),
			Size = UDim2.fromScale(1,1) + UDim2.fromOffset(30,30),
			Position = UDim2.fromOffset(-15,-15)
		},
		Circle = {
			BackgroundTransparency = 1,
			Image = "http://www.roblox.com/asset/?id=5554831670"
		},
		CircleButton = {
			BackgroundTransparency = 1,
			AutoButtonColor = false,
			Image = "http://www.roblox.com/asset/?id=5554831670"
		},
		Frame = {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1,1)
		},
		Label = {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(5,0),
			Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left
		},
		Button = {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(5,0),
			Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left
		},
		Box = {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(5,0),
			Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left
		},
		ScrollingFrame = {
			BackgroundTransparency = 1,
			ScrollBarThickness = 0,
			CanvasSize = UDim2.fromScale(0,0),
			Size = UDim2.fromScale(1,1)
		},
		Menu = {
			Name = "More",
			AutoButtonColor = false,
			BackgroundTransparency = 1,
			Image = "http://www.roblox.com/asset/?id=5555108481",
			Size = UDim2.fromOffset(20,20),
			Position = UDim2.fromScale(1,0.5) - UDim2.fromOffset(25,10)
		},
		NavBar = {
			Name = "SheetToggle",
			Image = "http://www.roblox.com/asset/?id=5576439039",
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(20,20),
			Position = UDim2.fromOffset(5,5),
			AutoButtonColor = false
		}
	}
	
	local Types = {
		"RoundFrame",
		"Shadow",
		"Circle",
		"CircleButton",
		"Frame",
		"Label",
		"Button",
		"SmoothButton",
		"Box",
		"ScrollingFrame",
		"Menu",
		"NavBar"
	}
	
	function FindType(String)
		for _, Type in next, Types do
			if Type:sub(1, #String):lower() == String:lower() then
				return Type
			end
		end
		return false
	end
	
	local Objects = {}
	
	function Objects.new(Type)
		local TargetType = FindType(Type)
		if TargetType then
			local NewImage = Instance.new(ActualTypes[TargetType])
			if Properties[TargetType] then
				for Property, Value in next, Properties[TargetType] do
					NewImage[Property] = Value
				end
			end
			return NewImage
		else
			return Instance.new(Type)
		end
	end
	
	local function GetXY(GuiObject)
		local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
		local Px, Py = math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
		return Px/Max, Py/May
	end
	
	local function CircleAnim(GuiObject, EndColour, StartColour)
		local PX, PY = GetXY(GuiObject)
		local Circle = Objects.new("Circle")
		Circle.Size = UDim2.fromScale(0,0)
		Circle.Position = UDim2.fromScale(PX,PY)
		Circle.ImageColor3 = StartColour or GuiObject.ImageColor3
		Circle.ZIndex = 200
		Circle.Parent = GuiObject
		local Size = GuiObject.AbsoluteSize.X
		TweenService:Create(Circle, TweenInfo.new(0.5), {Position = UDim2.fromScale(PX,PY) - UDim2.fromOffset(Size/2,Size/2), ImageTransparency = 1, ImageColor3 = EndColour, Size = UDim2.fromOffset(Size,Size)}):Play()
		spawn(function()
			wait(0.5)
			Circle:Destroy()
		end)
	end
	
	
	local function MakeDraggable(topbarobject, object)
		local Dragging = nil
		local DragInput = nil
		local DragStart = nil
		local StartPosition = nil
	
		local function Update(input)
			local Delta = input.Position - DragStart
			local pos =
				UDim2.new(
					StartPosition.X.Scale,
					StartPosition.X.Offset + Delta.X,
					StartPosition.Y.Scale,
					StartPosition.Y.Offset + Delta.Y
				)
			local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
			Tween:Play()
		end
	
		topbarobject.InputBegan:Connect(
			function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					Dragging = true
					DragStart = input.Position
					StartPosition = object.Position
	
					input.Changed:Connect(
						function()
							if input.UserInputState == Enum.UserInputState.End then
								Dragging = false
							end
						end
					)
				end
			end
		)
	
		topbarobject.InputChanged:Connect(
			function(input)
				if
					input.UserInputType == Enum.UserInputType.MouseMovement or
					input.UserInputType == Enum.UserInputType.Touch
				then
					DragInput = input
				end
			end
		)
	
		UserInputService.InputChanged:Connect(
			function(input)
				if input == DragInput and Dragging then
					Update(input)
				end
			end
		)
	end
	
	library = {}
	
	function library:Window(text,text2,text3,logo,keybind)
		local uihide = false
		local abc = false
		local logo = logo or 0
		local currentpage = ""
		local keybind = keybind or Enum.KeyCode.RightControl
		local yoo = string.gsub(tostring(keybind),"Enum.KeyCode.","")
		
		local RippleHUBLIB = Instance.new("ScreenGui")
		RippleHUBLIB.Name = "RippleHUBLIB"
		RippleHUBLIB.Parent = game.CoreGui
		RippleHUBLIB.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	
		local Main = Instance.new("Frame")
		Main.Name = "Main"
		Main.Parent = RippleHUBLIB
		Main.ClipsDescendants = true
		Main.AnchorPoint = Vector2.new(0.5,0.5)
		Main.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		Main.Position = UDim2.new(0.5, 0, 0.5, 0)
		Main.Size = UDim2.new(0, 0, 0, 0)
		
		Main:TweenSize(UDim2.new(0, 656, 0, 300),"Out","Quad",0.4,true)
	
		local MCNR = Instance.new("UICorner")
		MCNR.Name = "MCNR"
		MCNR.Parent = Main
	
	
		local Top = Instance.new("Frame")
		Top.Name = "Top"
		Top.Parent = Main
		Top.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		Top.Size = UDim2.new(0, 656, 0, 27)
	
		local TCNR = Instance.new("UICorner")
		TCNR.Name = "TCNR"
		TCNR.Parent = Top
	
		local Logo = Instance.new("ImageLabel")
		Logo.Name = "Logo"
		Logo.Parent = Top
		Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Logo.BackgroundTransparency = 1.000
		Logo.Position = UDim2.new(0, 14, 0, 2)
		Logo.Size = UDim2.new(0, 23, 0, 23)
		Logo.Image = "rbxassetid://"..tostring(logo)
	
		local Name = Instance.new("TextLabel")
		Name.Name = "Name"
		Name.Parent = Top
		Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Name.BackgroundTransparency = 1.000
		Name.Position = UDim2.new(0.0609756112, 5, 0, 0.5)
		Name.Size = UDim2.new(0, 61, 0, 27)
		Name.Font = Enum.Font.GothamSemibold
		Name.Text = text
		Name.TextColor3 = Color3.fromRGB(225, 225, 225)
		Name.TextSize = 16.000
	
		local Hub = Instance.new("TextLabel")
		Hub.Name = "Hub"
		Hub.Parent = Top
		Hub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Hub.BackgroundTransparency = 1.000
		Hub.Position = UDim2.new(0, 105, 0, 0.5)
		Hub.Size = UDim2.new(0, 81, 0, 27)
		Hub.Font = Enum.Font.GothamSemibold
		Hub.Text = text2
		Hub.TextColor3 = _G.Color
		Hub.TextSize = 16.000
		Hub.TextXAlignment = Enum.TextXAlignment.Left
	
		local Ver = Instance.new("TextLabel")
		Ver.Name = "Ver"
		Ver.Parent = Top
		Ver.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Ver.BackgroundTransparency = 1.000
		Ver.Position = UDim2.new(0.847561002, 0, 0, 1)
		Ver.Size = UDim2.new(0, 47, 0, 27)
		Ver.Font = Enum.Font.GothamSemibold
		Ver.Text = text3
		Ver.TextColor3 = _G.Color
		Ver.TextSize = 15.000
	
	
		local BindButton = Instance.new("TextButton")
		BindButton.Name = "BindButton"
		BindButton.Parent = Top
		BindButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BindButton.BackgroundTransparency = 1.000
		BindButton.Position = UDim2.new(0.227561002, 0, 0, 1)
		BindButton.Size = UDim2.new(0, 100, 0, 27)
		BindButton.Font = Enum.Font.GothamSemibold
		BindButton.Text = "[ "..string.gsub(tostring(keybind),"Enum.KeyCode.","").." ]"
		BindButton.TextColor3 = Color3.fromRGB(100, 100, 100)
		BindButton.TextSize = 11.000
		
		BindButton.MouseButton1Click:Connect(function ()
			BindButton.Text = "[ ... ]"
			local inputwait = game:GetService("UserInputService").InputBegan:wait()
			local shiba = inputwait.KeyCode == Enum.KeyCode.Unknown and inputwait.UserInputType or inputwait.KeyCode
	
			if shiba.Name ~= "Focus" and shiba.Name ~= "MouseMovement" then
				BindButton.Text = "[ "..shiba.Name.." ]"
				yoo = shiba.Name
			end
		end)
	
		do  local ui =  game:GetService("CoreGui"):FindFirstChild("Ripple")  if ui then ui:Destroy() end end
	
	
		
		end)
	
	do  local ui =  game:GetService("CoreGui"):FindFirstChild("RippleFPS")  if ui then ui:Destroy() end 
	local uix =  game:GetService("CoreGui"):FindFirstChild("Rippletime")  if uix then uix:Destroy() end end
	
	
	
	
	spawn(function()
		while wait() do
			pcall(function()
				TextLabelfps.Text = "FPS:"..string.format("%d",workspace:GetRealPhysicsFPS())
			end)
		end
	end)
	
	ImageLabelfps.Name = "ImageLabelfps"
	ImageLabelfps.Parent = Framefps
	ImageLabelfps.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabelfps.BackgroundTransparency = 1.000
	ImageLabelfps.Position = UDim2.new(0.083989636, 0, 0.15545856, 0)
	ImageLabelfps.Size = UDim2.new(0, 29, 0, 29)
	ImageLabelfps.Image = "rbxassetid://9606070311"
	
	ImageLabeltime.Name = "ImageLabeltime"
	ImageLabeltime.Parent = Frametime
	ImageLabeltime.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabeltime.BackgroundTransparency = 1.000
	ImageLabeltime.Position = UDim2.new(0.083989636, -9, 0.15545856, 0)
	ImageLabeltime.Size = UDim2.new(0, 29, 0, 29)
	ImageLabeltime.Image = "rbxassetid://9606070311"
	
	
	Framefps.MouseEnter:Connect(function()
		TweenService:Create(
			Framefps,
			TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{BackgroundTransparency = 1}
		):Play()
		TweenService:Create(
			Strokefps,
			TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{Transparency = 1}
		):Play()
		TweenService:Create(
			TextLabelfps,
			TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{TextTransparency = 1}
		):Play()
		TweenService:Create(
			ImageLabelfps,
			TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{ImageTransparency = 1}
		):Play()
	end)
	Framefps.MouseLeave:Connect(function()
		TweenService:Create(
			Framefps,
			TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{BackgroundTransparency = 0}
		):Play()
		TweenService:Create(
			Strokefps,
			TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{Transparency = 0}
		):Play()
		TweenService:Create(
			TextLabelfps,
			TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{TextTransparency = 0}
		):Play()
		TweenService:Create(
			ImageLabelfps,
			TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{ImageTransparency = 0}
		):Play()
	end)
	
	Frametime.MouseEnter:Connect(function()
		TweenService:Create(
			Frametime,
			TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{BackgroundTransparency = 1}
		):Play()
		TweenService:Create(
			Stroketime,
			TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{Transparency = 1}
		):Play()
		TweenService:Create(
			TextLabeltime,
			TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{TextTransparency = 1}
		):Play()
		TweenService:Create(
			ImageLabeltime,
			TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{ImageTransparency = 1}
		):Play()
	end)
	Frametime.MouseLeave:Connect(function()
		TweenService:Create(
			Frametime,
			TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{BackgroundTransparency = 0}
		):Play()
		TweenService:Create(
			Stroketime,
			TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{Transparency = 0}
		):Play()
		TweenService:Create(
			TextLabeltime,
			TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{TextTransparency = 0}
		):Play()
		TweenService:Create(
			ImageLabeltime,
			TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{ImageTransparency = 0}
		):Play()
	end)
	
	Yedhee.TextTransparency = 1
		Uitoggle.TextTransparency = 1
		ToggleImgUi.ImageTransparency = 1
		ToggleFrameUi.BackgroundTransparency = 1.000
		SearchStroke.Transparency = 1
		TweenService:Create(
			Framefps,
			TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{BackgroundTransparency = 1}
		):Play()
		TweenService:Create(
			Strokefps,
			TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{Transparency = 1}
		):Play()
		TweenService:Create(
			TextLabelfps,
			TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{TextTransparency = 1}
		):Play()
		TweenService:Create(
			ImageLabelfps,
			TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{ImageTransparency = 1}
		):Play()
	
		UserInputService.InputBegan:Connect(function(input)
			if input.KeyCode == Enum.KeyCode[yoo] then
				if uihide == false then
					ToggleFrameUi:TweenSize(UDim2.new(0, 198, 0, 48),"In","Quad",0.2,true)
					game:GetService("TweenService"):Create(
						ToggleFrameUi,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
					Framefps:TweenSize(UDim2.new(0, 193, 0, 44),"In","Quad",0.2,true)
					TweenService:Create(
						Framefps,
						TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
					TweenService:Create(
						Strokefps,
						TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{Transparency = 0}
					):Play()
					TweenService:Create(
						TextLabelfps,
						TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
					TweenService:Create(
						ImageLabelfps,
						TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{ImageTransparency = 0}
					):Play()
					Yedhee.TextTransparency = 0
					Uitoggle.TextTransparency = 0
					ToggleImgUi.ImageTransparency = 0
					SearchStroke.Transparency = 0
					wait(.2)
					uihide = true
					Main:TweenSize(UDim2.new(0, 0, 0, 0),"In","Quad",0.4,true)
				else
					ToggleFrameUi:TweenSize(UDim2.new(0, 0, 0, 0),"In","Quad",0.2,true)
					game:GetService("TweenService"):Create(
						ToggleFrameUi,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					Framefps:TweenSize(UDim2.new(0, 0, 0, 0),"In","Quad",0.2,true)
					game:GetService("TweenService"):Create(
						Framefps,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Strokefps,
						TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{Transparency = 1}
					):Play()
					TweenService:Create(
						TextLabelfps,
						TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{TextTransparency = 1}
					):Play()
					TweenService:Create(
						ImageLabelfps,
						TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{ImageTransparency = 1}
					):Play()
					Yedhee.TextTransparency = 1
					Uitoggle.TextTransparency = 1
					ToggleImgUi.ImageTransparency = 1
					SearchStroke.Transparency = 1
					wait(.2)
					uihide = false
					Main:TweenSize(UDim2.new(0, 656, 0, 300),"Out","Quad",0.4,true)
				end
			end
		end)
	
		TweenService:Create(
			Frametime,
			TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{BackgroundTransparency = 1}
		):Play()
		TweenService:Create(
			Stroketime,
			TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{Transparency = 1}
		):Play()
		TweenService:Create(
			TextLabeltime,
			TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{TextTransparency = 1}
		):Play()
		TweenService:Create(
			ImageLabeltime,
			TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{ImageTransparency = 1}
		):Play()
	
		UserInputService.InputBegan:Connect(function(input)
			if input.KeyCode == Enum.KeyCode[yoo] then
				if uihide == false then
					ToggleFrameUi:TweenSize(UDim2.new(0, 198, 0, 48),"In","Quad",0.2,true)
					game:GetService("TweenService"):Create(
						ToggleFrameUi,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
					Frametime:TweenSize(UDim2.new(0, 293, 0, 44),"In","Quad",0.2,true)
					TweenService:Create(
						Frametime,
						TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
					TweenService:Create(
						Stroketime,
						TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{Transparency = 0}
					):Play()
					TweenService:Create(
						TextLabeltime,
						TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
					TweenService:Create(
						ImageLabeltime,
						TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{ImageTransparency = 0}
					):Play()
					Yedhee.TextTransparency = 0
					Uitoggle.TextTransparency = 0
					ToggleImgUi.ImageTransparency = 0
					SearchStroke.Transparency = 0
					wait(.2)
					uihide = true
					Main:TweenSize(UDim2.new(0, 0, 0, 0),"In","Quad",0.4,true)
				else
					ToggleFrameUi:TweenSize(UDim2.new(0, 0, 0, 0),"In","Quad",0.2,true)
					game:GetService("TweenService"):Create(
						ToggleFrameUi,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					Framefps:TweenSize(UDim2.new(0, 0, 0, 0),"In","Quad",0.2,true)
					game:GetService("TweenService"):Create(
						Frametime,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						Stroketime,
						TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{Transparency = 1}
					):Play()
					TweenService:Create(
						TextLabeltime,
						TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{TextTransparency = 1}
					):Play()
					TweenService:Create(
						ImageLabeltime,
						TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{ImageTransparency = 1}
					):Play()
					Yedhee.TextTransparency = 1
					Uitoggle.TextTransparency = 1
					ToggleImgUi.ImageTransparency = 1
					SearchStroke.Transparency = 1
					wait(.2)
					uihide = false
					Main:TweenSize(UDim2.new(0, 656, 0, 300),"Out","Quad",0.4,true)
				end
			end
		end)
	
		MakeDraggable(ToggleFrameUi,ToggleFrameUi)
	
	
	
	
	
		local Tab = Instance.new("Frame")
		Tab.Name = "Tab"
		Tab.Parent = Main
		Tab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		Tab.Position = UDim2.new(0, 5, 0, 30)
		Tab.Size = UDim2.new(0, 150, 0, 265)
	
		local TCNR = Instance.new("UICorner")
		TCNR.Name = "TCNR"
		TCNR.Parent = Tab
	
		local ScrollTab = Instance.new("ScrollingFrame")
		ScrollTab.Name = "ScrollTab"
		ScrollTab.Parent = Tab
		ScrollTab.Active = true
		ScrollTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ScrollTab.BackgroundTransparency = 1.000
		ScrollTab.Size = UDim2.new(0, 150, 0, 265)
		ScrollTab.CanvasSize = UDim2.new(0, 0, 0, 0)
		ScrollTab.ScrollBarThickness = 0
	
		local PLL = Instance.new("UIListLayout")
		PLL.Name = "PLL"
		PLL.Parent = ScrollTab
		PLL.SortOrder = Enum.SortOrder.LayoutOrder
		PLL.Padding = UDim.new(0, 15)
	
		local PPD = Instance.new("UIPadding")
		PPD.Name = "PPD"
		PPD.Parent = ScrollTab
		PPD.PaddingLeft = UDim.new(0, 10)
		PPD.PaddingTop = UDim.new(0, 10)
	
		local Page = Instance.new("Frame")
		Page.Name = "Page"
		Page.Parent = Main
		Page.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		Page.Position = UDim2.new(0.245426834, 0, 0, 30)
		Page.Size = UDim2.new(0, 490, 0, 265)
	
		local PCNR = Instance.new("UICorner")
		PCNR.Name = "PCNR"
		PCNR.Parent = Page
	
		local MainPage = Instance.new("Frame")
		MainPage.Name = "MainPage"
		MainPage.Parent = Page
		MainPage.ClipsDescendants = true
		MainPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		MainPage.BackgroundTransparency = 1.000
		MainPage.Size = UDim2.new(0, 490, 0, 365)
	
		local PageList = Instance.new("Folder")
		PageList.Name = "PageList"
		PageList.Parent = MainPage
	
		local UIPageLayout = Instance.new("UIPageLayout")
	
		UIPageLayout.Parent = PageList
		UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIPageLayout.EasingDirection = Enum.EasingDirection.InOut
		UIPageLayout.EasingStyle = Enum.EasingStyle.Quad
		UIPageLayout.FillDirection = Enum.FillDirection.Vertical
		UIPageLayout.Padding = UDim.new(0, 15)
		UIPageLayout.TweenTime = 0.400
		UIPageLayout.GamepadInputEnabled = false
		UIPageLayout.ScrollWheelInputEnabled = false
		UIPageLayout.TouchInputEnabled = false
		
		MakeDraggable(Top,Main)
	
		
		local uitab = {}
		
		function uitab:Tab(text,logo1)
			local TabButton = Instance.new("TextButton")
			TabButton.Parent = ScrollTab
			TabButton.Name = text.."Server"
			TabButton.Text = text
			TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TabButton.BackgroundTransparency = 1.000
			TabButton.Size = UDim2.new(0, 130, 0, 23)
			TabButton.Font = Enum.Font.GothamSemibold
			TabButton.TextColor3 = Color3.fromRGB(225, 225, 225)
			TabButton.TextSize = 15.000
			TabButton.TextTransparency = 0.500
	
			local IDK = Instance.new("ImageLabel")
			IDK.Name = "LogoIDK"
			IDK.Parent = TabButton
			IDK.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			IDK.BackgroundTransparency = 1.000
			IDK.Position = UDim2.new(0, 0, 0, 1)
			IDK.Size = UDim2.new(0, 20, 0, 20)
			IDK.Image = "rbxassetid://"..tostring(logo1)
	
	
			local MainFramePage = Instance.new("ScrollingFrame")
			MainFramePage.Name = text.."_Page"
			MainFramePage.Parent = PageList
			MainFramePage.Active = true
			MainFramePage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			MainFramePage.BackgroundTransparency = 1.000
			MainFramePage.BorderSizePixel = 0
			MainFramePage.Size = UDim2.new(0, 490, 0, 265)
			MainFramePage.CanvasSize = UDim2.new(0, 0, 0, 0)
			MainFramePage.ScrollBarThickness = 0
			
			local UIPadding = Instance.new("UIPadding")
			local UIListLayout = Instance.new("UIListLayout")
			
			UIPadding.Parent = MainFramePage
			UIPadding.PaddingLeft = UDim.new(0, 10)
			UIPadding.PaddingTop = UDim.new(0, 10)
	
			UIListLayout.Padding = UDim.new(0,15)
			UIListLayout.Parent = MainFramePage
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			
			TabButton.MouseButton1Click:Connect(function()
				for i,v in next, ScrollTab:GetChildren() do
					if v:IsA("TextButton") then
						TweenService:Create(
							v,
							TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
							{TextTransparency = 0.5}
						):Play()
					end
					TweenService:Create(
						TabButton,
						TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
				end
				for i,v in next, PageList:GetChildren() do
					currentpage = string.gsub(TabButton.Name,"Server","").."_Page"
					if v.Name == currentpage then
						UIPageLayout:JumpTo(v)
					end
				end
			end)
	
			if abc == false then
				for i,v in next, ScrollTab:GetChildren() do
					if v:IsA("TextButton") then
						TweenService:Create(
							v,
							TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
							{TextTransparency = 0.5}
						):Play()
					end
					TweenService:Create(
						TabButton,
						TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play()
				end
				UIPageLayout:JumpToIndex(1)
				abc = true
			end
			
			game:GetService("RunService").Stepped:Connect(function()
				pcall(function()
					MainFramePage.CanvasSize = UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y + 20)
					ScrollTab.CanvasSize = UDim2.new(0,0,0,PLL.AbsoluteContentSize.Y + 20)
				end)
			end)
	
			
			local main = {}
			function main:Button(text,callback)
				local Button = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local TextBtn = Instance.new("TextButton")
				local UICorner_2 = Instance.new("UICorner")
				local Black = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local IMGBUTTON = Instance.new("ImageLabel")
				
				Button.Name = "Button"
				Button.Parent = MainFramePage
				Button.BackgroundColor3 = _G.Color
				Button.Size = UDim2.new(0, 470, 0, 31)
				
				UICorner.CornerRadius = UDim.new(0, 5)
				UICorner.Parent = Button
				
	
				
				TextBtn.Name = "TextBtn"
				TextBtn.Parent = Button
				TextBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				TextBtn.Position = UDim2.new(0, 1, 0, 1)
				TextBtn.Size = UDim2.new(0, 468, 0, 29)
				TextBtn.AutoButtonColor = false
				TextBtn.Font = Enum.Font.GothamSemibold
				TextBtn.Text = text
				TextBtn.TextColor3 = Color3.fromRGB(225, 225, 225)
				TextBtn.TextSize = 15.000
				TextBtn.ClipsDescendants = true
	
				UICorner_2.CornerRadius = UDim.new(0, 5)
				UICorner_2.Parent = TextBtn
	
				IMGBUTTON.Name = "IconB"
				IMGBUTTON.Parent = TextBtn
				IMGBUTTON.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				IMGBUTTON.BackgroundTransparency = 1.000
				IMGBUTTON.Position = UDim2.new(0, 10, 0, 5)
				IMGBUTTON.Size = UDim2.new(0, 20, 0, 20)
				IMGBUTTON.Image = "http://www.roblox.com/asset/?id=9606312215"
	
	
				Black.Name = "Black"
				Black.Parent = Button
				Black.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				Black.BackgroundTransparency = 1.000
				Black.BorderSizePixel = 0
				Black.Position = UDim2.new(0, 1, 0, 1)
				Black.Size = UDim2.new(0, 468, 0, 29)
				
				UICorner_3.CornerRadius = UDim.new(0, 5)
				UICorner_3.Parent = Black
	
				TextBtn.MouseEnter:Connect(function()
					TweenService:Create(
						Black,
						TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{BackgroundTransparency = 0.7}
					):Play()
				end)
				TextBtn.MouseLeave:Connect(function()
					TweenService:Create(
						Black,
						TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
				end)
				TextBtn.MouseButton1Click:Connect(function()
					CircleAnim(TextBtn, Color3.fromRGB(255,255,255), Color3.fromRGB(255,255,255))
					TextBtn.TextSize = 1
					TweenService:Create(
						TextBtn,
						TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{TextSize = 15}
					):Play()
					callback()
				end)
			end
			function main:Toggle(text,Imgidicon,config,callback)
				config = config or false
				local toggled = config
				local Toggle = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local Button = Instance.new("TextButton")
				local UICorner_2 = Instance.new("UICorner")
				local Label = Instance.new("TextLabel")
				local ToggleImage = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local Circle = Instance.new("Frame")
				local UICorner_4 = Instance.new("UICorner")
				local imgLabelIcon = Instance.new("ImageLabel")
	
	
				Toggle.Name = "Toggle"
				Toggle.Parent = MainFramePage
				Toggle.BackgroundColor3 = Color3.fromRGB(255, 46, 46)
				Toggle.Size = UDim2.new(0, 470, 0, 31)
	
				UICorner.CornerRadius = UDim.new(0, 5)
				UICorner.Parent = Toggle
	
				Button.Name = "Button"
				Button.Parent = Toggle
				Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				Button.Position = UDim2.new(0, 1, 0, 1)
				Button.Size = UDim2.new(0, 468, 0, 29)
				Button.AutoButtonColor = false
				Button.Font = Enum.Font.SourceSans
				Button.Text = ""
				Button.TextColor3 = Color3.fromRGB(0, 0, 0)
				Button.TextSize = 11.000
	
				UICorner_2.CornerRadius = UDim.new(0, 5)
				UICorner_2.Parent = Button
	
				Label.Name = "Label"
				Label.Parent = Toggle
				Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Label.BackgroundTransparency = 1.000
				Label.Position = UDim2.new(0, 1, 0, 1)
				Label.Size = UDim2.new(0, 468, 0, 29)
				Label.Font = Enum.Font.GothamSemibold
				Label.Text = text
				Label.TextColor3 = Color3.fromRGB(225, 225, 225)
				Label.TextSize = 15.000
	
				ToggleImage.Name = "ToggleImage"
				ToggleImage.Parent = Toggle
				ToggleImage.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
				ToggleImage.Position = UDim2.new(0, 415, 0, 5)
				ToggleImage.Size = UDim2.new(0, 45, 0, 20)
	
				UICorner_3.CornerRadius = UDim.new(0, 10)
				UICorner_3.Parent = ToggleImage
	
				Circle.Name = "Circle"
				Circle.Parent = ToggleImage
				Circle.BackgroundColor3 = Color3.fromRGB(255, 46, 46)
				Circle.Position = UDim2.new(0, 2, 0, 2)
				Circle.Size = UDim2.new(0, 16, 0, 16)
	
				UICorner_4.CornerRadius = UDim.new(0, 10)
				UICorner_4.Parent = Circle
	
				imgLabelIcon.Name = "Icon"
				imgLabelIcon.Parent = Toggle
				imgLabelIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				imgLabelIcon.BackgroundTransparency = 1.000
				imgLabelIcon.Position = UDim2.new(0, 10, 0, 5)
				imgLabelIcon.Size = UDim2.new(0, 20, 0, 20)
				imgLabelIcon.Image = "http://www.roblox.com/asset/?id="..Imgidicon
	
				Button.MouseButton1Click:Connect(function()
					if toggled == false then
						toggled = true
						Circle:TweenPosition(UDim2.new(0,27,0,2),"Out","Sine",0.2,true)
						TweenService:Create(
							Toggle,
							TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
							{BackgroundColor3 = _G.Color}
						):Play()
						TweenService:Create(
							Circle,
							TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
							{BackgroundColor3 = _G.Color}
						):Play()
					else
						toggled = false
						Circle:TweenPosition(UDim2.new(0,2,0,2),"Out","Sine",0.2,true)
						TweenService:Create(
							Toggle,
							TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
							{BackgroundColor3 = Color3.fromRGB(255, 46, 46)}
						):Play()
						TweenService:Create(
							Circle,
							TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
							{BackgroundColor3 = Color3.fromRGB(255, 46, 46)}
						):Play()
					end
					pcall(callback,toggled)
				end)
	
				if config == true then
					toggled = true
					Circle:TweenPosition(UDim2.new(0,27,0,2),"Out","Sine",0.4,true)
					TweenService:Create(
						Toggle,
						TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{BackgroundColor3 = _G.Color}
					):Play()
					TweenService:Create(
						Circle,
						TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{BackgroundColor3 = _G.Color}
					):Play()
					pcall(callback,toggled)
				end
			end
			function main:Dropdown(text,old,option,callback)
				local isdropping = false
				local Dropdown = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local DropTitle = Instance.new("TextLabel")
				local DropScroll = Instance.new("ScrollingFrame")
				local UIListLayout = Instance.new("UIListLayout")
				local UIPadding = Instance.new("UIPadding")
				local DropButton = Instance.new("TextButton")
				local DropImage = Instance.new("ImageLabel")
				
				Dropdown.Name = "Dropdown"
				Dropdown.Parent = MainFramePage
				Dropdown.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				Dropdown.ClipsDescendants = true
				Dropdown.Size = UDim2.new(0, 470, 0, 31)
				
				UICorner.CornerRadius = UDim.new(0, 5)
				UICorner.Parent = Dropdown
				
				if type(old) == "string" then
					DropTitle.Name = "DropTitle"
					DropTitle.Parent = Dropdown
					DropTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					DropTitle.BackgroundTransparency = 1.000
					DropTitle.Size = UDim2.new(0, 470, 0, 31)
					DropTitle.Font = Enum.Font.GothamSemibold
					DropTitle.Text = text.. " : "..old
					DropTitle.TextColor3 = Color3.fromRGB(225, 225, 225)
					DropTitle.TextSize = 15.000
				else
					DropTitle.Name = "DropTitle"
					DropTitle.Parent = Dropdown
					DropTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					DropTitle.BackgroundTransparency = 1.000
					DropTitle.Size = UDim2.new(0, 470, 0, 31)
					DropTitle.Font = Enum.Font.GothamSemibold
					DropTitle.Text = text.. " : "
					DropTitle.TextColor3 = Color3.fromRGB(225, 225, 225)
					DropTitle.TextSize = 15.000
				end
				
				DropScroll.Name = "DropScroll"
				DropScroll.Parent = DropTitle
				DropScroll.Active = true
				DropScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DropScroll.BackgroundTransparency = 1.000
				DropScroll.BorderSizePixel = 0
				DropScroll.Position = UDim2.new(0, 0, 0, 31)
				DropScroll.Size = UDim2.new(0, 470, 0, 100)
				DropScroll.CanvasSize = UDim2.new(0, 0, 0, 2)
				DropScroll.ScrollBarThickness = 3
				
				UIListLayout.Parent = DropScroll
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.Padding = UDim.new(0, 5)
				
				UIPadding.Parent = DropScroll
				UIPadding.PaddingLeft = UDim.new(0, 5)
				UIPadding.PaddingTop = UDim.new(0, 5)
				
				DropImage.Name = "DropImage"
				DropImage.Parent = Dropdown
				DropImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DropImage.BackgroundTransparency = 1.000
				DropImage.Position = UDim2.new(0, 445, 0, 6)
				DropImage.Rotation = -90
				DropImage.Size = UDim2.new(0, 20, 0, 20)
				DropImage.Image = "rbxassetid://6031090990"
				
				DropButton.Name = "DropButton"
				DropButton.Parent = Dropdown
				DropButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DropButton.BackgroundTransparency = 1.000
				DropButton.Size = UDim2.new(0, 470, 0, 31)
				DropButton.Font = Enum.Font.SourceSans
				DropButton.Text = ""
				DropButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				DropButton.TextSize = 14.000
	
				for i,v in next,option do
					local Item = Instance.new("TextButton")
	
					Item.Name = "Item"
					Item.Parent = DropScroll
					Item.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Item.BackgroundTransparency = 1.000
					Item.Size = UDim2.new(0, 460, 0, 26)
					Item.Font = Enum.Font.GothamSemibold
					Item.Text = tostring(v)
					Item.TextColor3 = Color3.fromRGB(225, 225, 225)
					Item.TextSize = 13.000
					Item.TextTransparency = 0.500
					Item.ClipsDescendants = true
	
	
					Item.MouseEnter:Connect(function()
						TweenService:Create(
							Item,
							TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
							{TextTransparency = 0}
						):Play()
					end)
	
					Item.MouseLeave:Connect(function()
						TweenService:Create(
							Item,
							TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
							{TextTransparency = 0.5}
						):Play()
					end)
	
					Item.MouseButton1Click:Connect(function()
						CircleAnim(Item, Color3.fromRGB(255,255,255), Color3.fromRGB(255,255,255))
						isdropping = false
						Dropdown:TweenSize(UDim2.new(0,470,0,31),"Out","Quad",0.3,true)
						TweenService:Create(
							DropImage,
							TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
							{Rotation = -90}
						):Play()
						DropScroll.CanvasSize = UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y + 10)
						callback(Item.Text)
						DropTitle.Text = text.." : "..Item.Text
					end)
				end
	
				DropScroll.CanvasSize = UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y + 10)
	
				DropButton.MouseButton1Click:Connect(function()
					if isdropping == false then
						isdropping = true
						Dropdown:TweenSize(UDim2.new(0,470,0,131),"Out","Quad",0.3,true)
						TweenService:Create(
							DropImage,
							TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
							{Rotation = 180}
						):Play()
						DropScroll.CanvasSize = UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y + 10)
					else
						isdropping = false
						Dropdown:TweenSize(UDim2.new(0,470,0,31),"Out","Quad",0.3,true)
						TweenService:Create(
							DropImage,
							TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
							{Rotation = -90}
						):Play()
						DropScroll.CanvasSize = UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y + 10)
					end
				end)
	
				local dropfunc = {}
				function dropfunc:Add(t)
					local Item = Instance.new("TextButton")
					Item.Name = "Item"
					Item.Parent = DropScroll
					Item.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Item.BackgroundTransparency = 1.000
					Item.Size = UDim2.new(0, 470, 0, 26)
					Item.Font = Enum.Font.GothamSemibold
					Item.Text = tostring(t)
					Item.TextColor3 = Color3.fromRGB(225, 225, 225)
					Item.TextSize = 13.000
					Item.TextTransparency = 0.500
					Item.ClipsDescendants = true
	
					Item.MouseEnter:Connect(function()
						TweenService:Create(
							Item,
							TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
							{TextTransparency = 0}
						):Play()
					end)
	
					Item.MouseLeave:Connect(function()
						TweenService:Create(
							Item,
							TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
							{TextTransparency = 0.5}
						):Play()
					end)
	
					Item.MouseButton1Click:Connect(function()
						isdropping = false
						CircleAnim(Item, Color3.fromRGB(255,255,255), Color3.fromRGB(255,255,255))
						Dropdown:TweenSize(UDim2.new(0,470,0,31),"Out","Quad",0.3,true)
						TweenService:Create(
							DropImage,
							TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
							{Rotation = -90}
						):Play()
						DropScroll.CanvasSize = UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y + 10)
						callback(Item.Text)
						DropTitle.Text = text.." : "..Item.Text
					end)
				end
				
				function dropfunc:Clear()
					DropTitle.Text = tostring(text).." : "
					isdropping = false
					Dropdown:TweenSize(UDim2.new(0,470,0,31),"Out","Quad",0.3,true)
					TweenService:Create(
						DropImage,
						TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{Rotation = -90}
					):Play()
					for i,v in next, DropScroll:GetChildren() do
						if v:IsA("TextButton") then
							v:Destroy()
						end
					end
				end
				return dropfunc
			end
	
			function main:Slider(text,min,max,set,callback)
				local Slider = Instance.new("Frame")
				local slidercorner = Instance.new("UICorner")
				local sliderr = Instance.new("Frame")
				local sliderrcorner = Instance.new("UICorner")
				local SliderLabel = Instance.new("TextLabel")
				local HAHA = Instance.new("Frame")
				local AHEHE = Instance.new("TextButton")
				local bar = Instance.new("Frame")
				local bar1 = Instance.new("Frame")
				local bar1corner = Instance.new("UICorner")
				local barcorner = Instance.new("UICorner")
				local circlebar = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local slidervalue = Instance.new("Frame")
				local valuecorner = Instance.new("UICorner")
				local TextBox = Instance.new("TextBox")
				local UICorner_2 = Instance.new("UICorner")
	
				Slider.Name = "Slider"
				Slider.Parent = MainFramePage
				Slider.BackgroundColor3 = _G.Color
				Slider.BackgroundTransparency = 0
				Slider.Size = UDim2.new(0, 470, 0, 51)
	
				slidercorner.CornerRadius = UDim.new(0, 5)
				slidercorner.Name = "slidercorner"
				slidercorner.Parent = Slider
	
				sliderr.Name = "sliderr"
				sliderr.Parent = Slider
				sliderr.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				sliderr.Position = UDim2.new(0, 1, 0, 1)
				sliderr.Size = UDim2.new(0, 468, 0, 49)
	
				sliderrcorner.CornerRadius = UDim.new(0, 5)
				sliderrcorner.Name = "sliderrcorner"
				sliderrcorner.Parent = sliderr
	
				SliderLabel.Name = "SliderLabel"
				SliderLabel.Parent = sliderr
				SliderLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderLabel.BackgroundTransparency = 1.000
				SliderLabel.Position = UDim2.new(0, 15, 0, 0)
				SliderLabel.Size = UDim2.new(0, 180, 0, 26)
				SliderLabel.Font = Enum.Font.GothamSemibold
				SliderLabel.Text = text
				SliderLabel.TextColor3 = Color3.fromRGB(225, 225, 225)
				SliderLabel.TextSize = 16.000
				SliderLabel.TextTransparency = 0
				SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
	
				HAHA.Name = "HAHA"
				HAHA.Parent = sliderr
				HAHA.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				HAHA.BackgroundTransparency = 1.000
				HAHA.Size = UDim2.new(0, 468, 0, 29)
	
				AHEHE.Name = "AHEHE"
				AHEHE.Parent = sliderr
				AHEHE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				AHEHE.BackgroundTransparency = 1.000
				AHEHE.Position = UDim2.new(0, 10, 0, 35)
				AHEHE.Size = UDim2.new(0, 448, 0, 5)
				AHEHE.Font = Enum.Font.SourceSans
				AHEHE.Text = ""
				AHEHE.TextColor3 = Color3.fromRGB(0, 0, 0)
				AHEHE.TextSize = 14.000
	
				bar.Name = "bar"
				bar.Parent = AHEHE
				bar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				bar.Size = UDim2.new(0, 448, 0, 5)
	
				bar1.Name = "bar1"
				bar1.Parent = bar
				bar1.BackgroundColor3 = _G.Color
				bar1.BackgroundTransparency = 0
				bar1.Size = UDim2.new(set/max, 0, 0, 5)
	
				bar1corner.CornerRadius = UDim.new(0, 5)
				bar1corner.Name = "bar1corner"
				bar1corner.Parent = bar1
	
				barcorner.CornerRadius = UDim.new(0, 5)
				barcorner.Name = "barcorner"
				barcorner.Parent = bar
	
				circlebar.Name = "circlebar"
				circlebar.Parent = bar1
				circlebar.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
				circlebar.Position = UDim2.new(1, -2, 0, -3)
				circlebar.Size = UDim2.new(0, 10, 0, 10)
	
				UICorner.CornerRadius = UDim.new(0, 100)
				UICorner.Parent = circlebar
	
				slidervalue.Name = "slidervalue"
				slidervalue.Parent = sliderr
				slidervalue.BackgroundColor3 = _G.Color
				slidervalue.BackgroundTransparency = 0
				slidervalue.Position = UDim2.new(0, 395, 0, 5)
				slidervalue.Size = UDim2.new(0, 65, 0, 18)
	
				valuecorner.CornerRadius = UDim.new(0, 5)
				valuecorner.Name = "valuecorner"
				valuecorner.Parent = slidervalue
	
				TextBox.Parent = slidervalue
				TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				TextBox.Position = UDim2.new(0, 1, 0, 1)
				TextBox.Size = UDim2.new(0, 63, 0, 16)
				TextBox.Font = Enum.Font.GothamSemibold
				TextBox.TextColor3 = Color3.fromRGB(225, 225, 225)
				TextBox.TextSize = 9.000
				TextBox.Text = set
				TextBox.TextTransparency = 0
	
				UICorner_2.CornerRadius = UDim.new(0, 5)
				UICorner_2.Parent = TextBox
	
				local mouse = game.Players.LocalPlayer:GetMouse()
				local uis = game:GetService("UserInputService")
	
				if Value == nil then
					Value = set
					pcall(function()
						callback(Value)
					end)
				end
				
				AHEHE.MouseButton1Down:Connect(function()
					Value = math.floor((((tonumber(max) - tonumber(min)) / 448) * bar1.AbsoluteSize.X) + tonumber(min)) or 0
					pcall(function()
						callback(Value)
					end)
					TweenService:Create(
						bar1,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Size = UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X, 0, 448), 0, 5)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					--bar1.Size = UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X, 0, 448), 0, 5)
					TweenService:Create(
						circlebar,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Position =  UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X - 2, 0, 438), 0, -3)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					--circlebar.Position = UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X - 2, 0, 438), 0, -3)
					moveconnection = mouse.Move:Connect(function()
						TextBox.Text = Value
						Value = math.floor((((tonumber(max) - tonumber(min)) / 448) * bar1.AbsoluteSize.X) + tonumber(min))
						pcall(function()
							callback(Value)
						end)
						TweenService:Create(
							bar1,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Size = UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X, 0, 448), 0, 5)} -- UDim2.new(0, 128, 0, 25)
						):Play()
						--bar1.Size = UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X, 0, 448), 0, 5)
						TweenService:Create(
							circlebar,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Position =  UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X - 2, 0, 438), 0, -3)} -- UDim2.new(0, 128, 0, 25)
						):Play()
						--circlebar.Position = UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X - 2, 0, 438), 0, -3)
					end)
					releaseconnection = uis.InputEnded:Connect(function(Mouse)
						if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
							Value = math.floor((((tonumber(max) - tonumber(min)) / 448) * bar1.AbsoluteSize.X) + tonumber(min))
							pcall(function()
								callback(Value)
							end)
							TweenService:Create(
								bar1,
								TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
								{Size = UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X, 0, 448), 0, 5)} -- UDim2.new(0, 128, 0, 25)
							):Play()
							--bar1.Size = UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X, 0, 448), 0, 5)
							TweenService:Create(
								circlebar,
								TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
								{Position =  UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X - 2, 0, 438), 0, -3)} -- UDim2.new(0, 128, 0, 25)
							):Play()
							--circlebar.Position = UDim2.new(0, math.clamp(mouse.X - bar1.AbsolutePosition.X - 2, 0, 438), 0, -3)
							moveconnection:Disconnect()
							releaseconnection:Disconnect()
						end
					end)
				end)
				releaseconnection = uis.InputEnded:Connect(function(Mouse)
					if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
						Value = math.floor((((tonumber(max) - tonumber(min)) / 448) * bar1.AbsoluteSize.X) + tonumber(min))
						TextBox.Text = Value
					end
				end)
	
				TextBox.FocusLost:Connect(function()
					if tonumber(TextBox.Text) > max then
						TextBox.Text  = max
					end
					bar1.Size = UDim2.new((TextBox.Text or 0) / max, 0, 0, 5)
					circlebar.Position = UDim2.new(1, -2, 0, -3)
					TextBox.Text = tostring(TextBox.Text and math.floor( (TextBox.Text / max) * (max - min) + min) )
					pcall(callback, TextBox.Text)
				end)
			end
	
			function main:Textbox(text,disappear,callback)
				local Textbox = Instance.new("Frame")
				local TextboxCorner = Instance.new("UICorner")
				local Textboxx = Instance.new("Frame")
				local TextboxxCorner = Instance.new("UICorner")
				local TextboxLabel = Instance.new("TextLabel")
				local txtbtn = Instance.new("TextButton")
				local RealTextbox = Instance.new("TextBox")
				local UICorner = Instance.new("UICorner")
	
				Textbox.Name = "Textbox"
				Textbox.Parent = MainFramePage
				Textbox.BackgroundColor3 = _G.Color
				Textbox.BackgroundTransparency = 0
				Textbox.Size = UDim2.new(0, 470, 0, 31)
	
				TextboxCorner.CornerRadius = UDim.new(0, 5)
				TextboxCorner.Name = "TextboxCorner"
				TextboxCorner.Parent = Textbox
	
				Textboxx.Name = "Textboxx"
				Textboxx.Parent = Textbox
				Textboxx.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				Textboxx.Position = UDim2.new(0, 1, 0, 1)
				Textboxx.Size = UDim2.new(0, 468, 0, 29)
	
				TextboxxCorner.CornerRadius = UDim.new(0, 5)
				TextboxxCorner.Name = "TextboxxCorner"
				TextboxxCorner.Parent = Textboxx
	
				TextboxLabel.Name = "TextboxLabel"
				TextboxLabel.Parent = Textbox
				TextboxLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextboxLabel.BackgroundTransparency = 1.000
				TextboxLabel.Position = UDim2.new(0, 15, 0, 0)
				TextboxLabel.Text = text
				TextboxLabel.Size = UDim2.new(0, 145, 0, 31)
				TextboxLabel.Font = Enum.Font.GothamSemibold
				TextboxLabel.TextColor3 = Color3.fromRGB(225, 225, 225)
				TextboxLabel.TextSize = 16.000
				TextboxLabel.TextTransparency = 0
				TextboxLabel.TextXAlignment = Enum.TextXAlignment.Left
	
				txtbtn.Name = "txtbtn"
				txtbtn.Parent = Textbox
				txtbtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				txtbtn.BackgroundTransparency = 1.000
				txtbtn.Position = UDim2.new(0, 1, 0, 1)
				txtbtn.Size = UDim2.new(0, 468, 0, 29)
				txtbtn.Font = Enum.Font.SourceSans
				txtbtn.Text = ""
				txtbtn.TextColor3 = Color3.fromRGB(0, 0, 0)
				txtbtn.TextSize = 14.000
	
				RealTextbox.Name = "RealTextbox"
				RealTextbox.Parent = Textbox
				RealTextbox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				RealTextbox.BackgroundTransparency = 0
				RealTextbox.Position = UDim2.new(0, 360, 0, 4)
				RealTextbox.Size = UDim2.new(0, 100, 0, 24)
				RealTextbox.Font = Enum.Font.GothamSemibold
				RealTextbox.Text = ""
				RealTextbox.TextColor3 = Color3.fromRGB(225, 225, 225)
				RealTextbox.TextSize = 11.000
				RealTextbox.TextTransparency = 0
	
				RealTextbox.FocusLost:Connect(function()
					callback(RealTextbox.Text)
					if disappear then
						RealTextbox.Text = ""
					end
				end)
	
				UICorner.CornerRadius = UDim.new(0, 5)
				UICorner.Parent = RealTextbox
			end
			function main:Label(text)
				local Label = Instance.new("TextLabel")
				local PaddingLabel = Instance.new("UIPadding")
				local labell = {}
		
				Label.Name = "Label"
				Label.Parent = MainFramePage
				Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Label.BackgroundTransparency = 1.000
				Label.Size = UDim2.new(0, 470, 0, 20)
				Label.Font = Enum.Font.GothamSemibold
				Label.TextColor3 = Color3.fromRGB(225, 225, 225)
				Label.TextSize = 16.000
				Label.Text = text
				Label.TextXAlignment = Enum.TextXAlignment.Left
	
				PaddingLabel.PaddingLeft = UDim.new(0,0)
				PaddingLabel.Parent = Label
				PaddingLabel.Name = "PaddingLabel"
		
				function labell:Set(newtext)
					Label.Text = newtext
				end
	
				return labell
			end
			function main:LabelP(text)
				local Label = Instance.new("TextLabel")
				local PaddingLabel = Instance.new("UIPadding")
				local labell = {}
		
				Label.Name = "Label"
				Label.Parent = MainFramePage
				Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Label.BackgroundTransparency = 1.000
				Label.Size = UDim2.new(0, 470, 0, 20)
				Label.Font = Enum.Font.GothamSemibold
				Label.TextColor3 = Color3.fromRGB(195, 195, 195)
				Label.TextSize = 15.000
				Label.Text = text
				Label.TextXAlignment = Enum.TextXAlignment.Left
	
				PaddingLabel.PaddingLeft = UDim.new(0,25)
				PaddingLabel.Parent = Label
				PaddingLabel.Name = "PaddingLabel"
		
				function labell:Set(newtext)
					Label.Text = newtext
				end
	
				return labell
			end
			function main:Seperator(text)
				local Seperator = Instance.new("Frame")
				local Sep1 = Instance.new("Frame")
				local Sep2 = Instance.new("TextLabel")
				local Sep3 = Instance.new("Frame")
				
				Seperator.Name = "Seperator"
				Seperator.Parent = MainFramePage
				Seperator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Seperator.BackgroundTransparency = 1.000
				Seperator.Size = UDim2.new(0, 470, 0, 20)
				
				Sep1.Name = "Sep1"
				Sep1.Parent = Seperator
				Sep1.BackgroundColor3 = _G.Color
				Sep1.BorderSizePixel = 0
				Sep1.Position = UDim2.new(0, 0, 0, 10)
				Sep1.Size = UDim2.new(0, 80, 0, 1)
				
				Sep2.Name = "Sep2"
				Sep2.Parent = Seperator
				Sep2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Sep2.BackgroundTransparency = 1.000
				Sep2.Position = UDim2.new(0, 185, 0, 0)
				Sep2.Size = UDim2.new(0, 100, 0, 20)
				Sep2.Font = Enum.Font.GothamSemibold
				Sep2.Text = text
				Sep2.TextColor3 = Color3.fromRGB(255, 255, 255)
				Sep2.TextSize = 14.000
				
				Sep3.Name = "Sep3"
				Sep3.Parent = Seperator
				Sep3.BackgroundColor3 = _G.Color
				Sep3.BorderSizePixel = 0
				Sep3.Position = UDim2.new(0, 390, 0, 10)
				Sep3.Size = UDim2.new(0, 80, 0, 1)
			end
	
			function main:Line()
				local Linee = Instance.new("Frame")
				local Line = Instance.new("Frame")
				
				Linee.Name = "Linee"
				Linee.Parent = MainFramePage
				Linee.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Linee.BackgroundTransparency = 1.000
				Linee.Position = UDim2.new(0, 0, 0.119999997, 0)
				Linee.Size = UDim2.new(0, 470, 0, 20)
				
				Line.Name = "Line"
				Line.Parent = Linee
				Line.BackgroundColor3 = _G.Color
				Line.BorderSizePixel = 0
				Line.Position = UDim2.new(0, 0, 0, 10)
				Line.Size = UDim2.new(0, 470, 0, 1)
			end
			return main
		end
		return uitab
	end
end

local win = library:Window("xonom",[[ HUB]],[[Mobile]],"",Enum.KeyCode.RightControl)
local General_Tab = win:Tab("Mia",[[]])
local Quest_Tab = win:Tab("Stats",[[]])
General_Tab:Label("Auto Farm Lv")

Waspon = {}
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do  
    if v:IsA("Tool") then
        table.insert(Waspon ,v.Name)
    end
end
for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do  
    if v:IsA("Tool") then
        table.insert(Waspon ,v.Name)
    end
end
if type(_G.Setting_table.Weapon) == 'string' then
else
	_G.Setting_table.Weapon = ""
end
local Select_W = General_Tab:Dropdown("Select Weapon",_G.Setting_table.Weapon,Waspon,function(vu)
	_G.Setting_table.Weapon = vu
	Update_Setting(getgenv()['MyName'])
end)
General_Tab:Button("Refresh Weapon",function(vu)
	Select_W:Clear()
	for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do  
		if v:IsA("Tool") then
			Select_W:Add(v.Name)
		end
	end
	for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do  
		if v:IsA("Tool") then
			Select_W:Add(v.Name)
		end
	end
end)
General_Tab:Toggle("Auto Farm Lv","",_G.Setting_table.AutoFarm,function(vu)
	Auto_Farm = vu
	_G.Setting_table.AutoFarm = vu
	Update_Setting(getgenv()['MyName'])
end)
	local plr = game.Players.LocalPlayer
	local CbFw = getupvalues(require(plr.PlayerScripts.CombatFramework))
	local CbFw2 = CbFw[2]

    function GetCurrentBlade() 
        local p13 = CbFw2.activeController
        local ret = p13.blades[1]
        if not ret then return end
        while ret.Parent~=game.Players.LocalPlayer.Character do ret=ret.Parent end
        return ret
    end
    
    function AttackNoCD()
        if not Auto_Farm_Bounty and not Auto_Farm_Fruit or Mix_Farm then
            if not Auto_Raid then
                local AC = CbFw2.activeController
                for i = 1, 1 do 
                    local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
                        plr.Character,
                        {plr.Character.HumanoidRootPart},
                        60
                    )
                    local cac = {}
                    local hash = {}
                    for k, v in pairs(bladehit) do
                        if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
                            table.insert(cac, v.Parent.HumanoidRootPart)
                            hash[v.Parent] = true
                        end
                    end
                    bladehit = cac
                    if #bladehit > 0 then
                        local u8 = debug.getupvalue(AC.attack, 5)
                        local u9 = debug.getupvalue(AC.attack, 6)
                        local u7 = debug.getupvalue(AC.attack, 4)
                        local u10 = debug.getupvalue(AC.attack, 7)
                        local u12 = (u8 * 798405 + u7 * 727595) % u9
                        local u13 = u7 * 798405
                        (function()
                            u12 = (u12 * u9 + u13) % 1099511627776
                            u8 = math.floor(u12 / u9)
                            u7 = u12 - u8 * u9
                        end)()
                        u10 = u10 + 1
                        debug.setupvalue(AC.attack, 5, u8)
                        debug.setupvalue(AC.attack, 6, u9)
                        debug.setupvalue(AC.attack, 4, u7)
                        debug.setupvalue(AC.attack, 7, u10)
                        pcall(function()
                            if plr.Character:FindFirstChildOfClass("Tool") and AC.blades and AC.blades[1] then
                                AC.animator.anims.basic[1]:Play(0.01,0.01,0.01)
                                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(GetCurrentBlade()))
                                game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u12 / 1099511627776 * 16777215), u10)
                                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, i, "")
                            end
                        end)
                    end
                end
            end
        end
        if Auto_Farm_Bounty or Auto_Farm_Fruit and not Mix_Farm then
            local Fast = getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework))
            local Lop = Fast[2]
            Lop.activeController.timeToNextAttack = (-math.huge^math.huge*math.huge)
            Lop.activeController.attacking = false
            Lop.activeController.timeToNextBlock = 0
            Lop.activeController.humanoid.AutoRotate = 80
            Lop.activeController.increment = 3
            Lop.activeController.blocking = false
            Lop.activeController.hitboxMagnitude = 80
        end
    end
spawn(function()
	while wait(.1) do
		pcall(function()
			if Auto_Farm then
				if not Mix_Farm then
					if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false then
						if _G.Farm_Boss then
							_G.SelectBoss = nil
							_G.Farm_Boss = nil
							SelectMonster = nil
							_G.Farm_Mon = nil
							wait(1)
						end
						if _G.SelectBoss ~= nil and game.Workspace.Enemies:FindFirstChild(_G.SelectBoss) or _G.SelectBoss ~= nil and game.ReplicatedStorage:FindFirstChild(_G.SelectBoss) then
							CheckQuestBoss()
							repeat wait(.2)
								TelePBoss(CFrameQBoss)
								TP(CFrameQBoss)
							until (CFrameQBoss.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 10
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuestBoss, QuestLvBoss)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
							_G.Farm_Boss = true
						elseif SelectMonster ~= nil then
							CheckLevel2()
							repeat wait(.2)
								TelePBoss(CFrameQ)
								TP(CFrameQ)
							until (CFrameQ.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 10
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
							SelectMonster = nil
							_G.Farm_Mon = nil
						else
							StatrMagnet = nil
							CheckLevel2()
							repeat wait(.2)
								TelePBoss(CFrameQ)
								TP(CFrameQ)
							until (CFrameQ.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 10
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
						end
					elseif game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
						if _G.Farm_Boss then
							if game.Workspace.Enemies:FindFirstChild(_G.SelectBoss) then
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if v.Name == _G.SelectBoss and v.Humanoid.Health > 0 then
										if v.Humanoid:FindFirstChild("Animator") then
											v.Humanoid.Animator:Destroy()
										end
										v.Humanoid:ChangeState(11)
										v.Humanoid.JumpPower = 0
										v.Humanoid.WalkSpeed = 0
										v.HumanoidRootPart.CanCollide = false
										v.HumanoidRootPart.Size = Vector3.new(5,5,5)
										StatrMagnet = nil
										repeat wait(_G.Fast_Delay)
											TelePBoss(CFrameQBoss)
											EquipWeapon(_G.Setting_table.Weapon)
											TP(v.HumanoidRootPart.CFrame*CFrame.new(0,30,50))
											AttackNoCD()
										until game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false or not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameBoss) or not v.Parent or v.Humanoid.Health <= 0 or not Auto_Farm or Mix_Farm
										if not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameBoss) then
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
										end
									end
								end
							else
								TP(CFrameBoss*CFrame.new(0,30,0))
								TelePBoss(CFrameBoss)
							end
						else
							if game.Workspace.Enemies:FindFirstChild(Ms) then
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if v.Name == Ms and v.Humanoid.Health > 0 then
										_G.PosMon = v.HumanoidRootPart.CFrame
										StatrMagnet = true
										if v.Humanoid:FindFirstChild("Animator") then
											v.Humanoid.Animator:Destroy()
										end
										v.Humanoid:ChangeState(11)
										v.Humanoid.JumpPower = 0
										v.Humanoid.WalkSpeed = 0
										v.HumanoidRootPart.CanCollide = false
										v.HumanoidRootPart.Size = Vector3.new(5,5,5)
										repeat wait(_G.Fast_Delay)
											TelePBoss(CFrameQ)
											EquipWeapon(_G.Setting_table.Weapon)
											TP(v.HumanoidRootPart.CFrame*CFrame.new(0,30,10))
											AttackNoCD()
										until game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false or not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or not v.Parent or v.Humanoid.Health <= 0 or not Auto_Farm or Mix_Farm
										if not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
										end
										Attack = nil
									end
								end
							elseif game.ReplicatedStorage:FindFirstChild(Ms) then
								TP(game.ReplicatedStorage:FindFirstChild(Ms).HumanoidRootPart.CFrame*CFrame.new(0,30,0))
								TelePBoss(CFrameQ)
							end
						end
					end
				end
			else
				wait(2)
			end
		end)
	end
end)

spawn(function()
	while task.wait() do
		pcall(function()
			if StatrMagnet then
				if Auto_Farm then
					if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
						for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if v.Name == Ms and (v.HumanoidRootPart.Position-_G.PosMon.Position).Magnitude <= 350 then
								if v.Humanoid:FindFirstChild("Animator") then
									v.Humanoid.Animator:Destroy()
								end
								v.Humanoid:ChangeState(11)
								v.Humanoid.JumpPower = 0
								v.Humanoid.WalkSpeed = 0
								v.HumanoidRootPart.CanCollide = false
								v.HumanoidRootPart.Size = Vector3.new(5,5,5)
								v.HumanoidRootPart.CFrame = _G.PosMon
								sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
								Attack = true
							end
						end
					end
				else
					for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
						if (v.HumanoidRootPart.Position-_G.PosMon.Position).Magnitude <= 350 then
							if v.Humanoid:FindFirstChild("Animator") then
								v.Humanoid.Animator:Destroy()
							end
							v.Humanoid:ChangeState(11)
							v.Humanoid.JumpPower = 0
							v.Humanoid.WalkSpeed = 0
							v.HumanoidRootPart.CanCollide = false
							v.HumanoidRootPart.Size = Vector3.new(5,5,5)
							v.HumanoidRootPart.CFrame = _G.PosMon
							sethiddenproperty(game.Players.LocalPlayer, "MaximumSimulationRadius",  math.huge)
							sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  9e20)
						end
					end
				end
			end
		end)
	end
end)
	
if _G.Setting_table.FastAttack_Mode == nil then
	_G.Setting_table.FastAttack_Mode = "Fast"
end
MIo = {
	"Fast",
}
General_Tab:Toggle("Fast Attack ","",_G.Setting_table.FastAttack,function(vu)
	_G.Setting_table.FastAttack = vu
	Update_Setting(getgenv()['MyName'])
end)
spawn(function()
	while wait(.5) do
		pcall(function()
			if _G.Setting_table.FastAttack then
				repeat wait(_G.Fast_Delay)
					AttackNoCD()
				until not _G.Setting_table.FastAttack
			end
		end)
	end
end)
General_Tab:Toggle("Fast Attack x2","Fast",MIo,function(vu)
	_G.Setting_table.FastAttack_Mode = vu
	Update_Setting(getgenv()['MyName'])
	if _G.Setting_table.FastAttack_Mode == "Fast" then
		_G.Fast_Delay = 0.1
end)
local Camera = require(game.ReplicatedStorage.Util.CameraShaker)
Camera:Stop()


Quest_Tab:Label("Stats")
Quest_Tab:Toggle("Melee","",_G.Setting_table.Melee_A,function(vu)
	Melee_A = vu
	_G.Setting_table.Melee_A = vu
	Update_Setting(getgenv()['MyName'])
end)
Quest_Tab:Toggle("Defense","",_G.Setting_table.Defense_A,function(vu)
	Defense_A = vu
	_G.Setting_table.Defense_A = vu
	Update_Setting(getgenv()['MyName'])
end)
Quest_Tab:Toggle("Sword","",_G.Setting_table.Sword_A,function(vu)
	Sword_A = vu
	_G.Setting_table.Sword_A = vu
	Update_Setting(getgenv()['MyName'])
end)
Quest_Tab:Toggle("Fruit","",_G.Setting_table.Fruit_A,function(vu)
	Fruit_A = vu
	_G.Setting_table.Fruit_A = vu
	Update_Setting(getgenv()['MyName'])
end)
Quest_Tab:Toggle("Gun","",_G.Setting_table.Gun_A,function(vu)
	Gun_A = vu
	_G.Setting_table.Gun_A = vu
	Update_Setting(getgenv()['MyName'])
end)
Quest_Tab:Slider("Point",1,100,3,function(vu)
	Points = vu
end)

spawn(function()
    while wait(.5) do
        if Melee_A then
            if game:GetService("Players").LocalPlayer.Data.Points.Value > 0 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", Points)
            end
        end
    end
end)

spawn(function()
    while wait(.5) do
        if Defense_A then
            if game:GetService("Players").LocalPlayer.Data.Points.Value > 0 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", Points)
            end
        end
    end
end)

spawn(function()
    while wait(.5) do
        if Sword_A then
            if game:GetService("Players").LocalPlayer.Data.Points.Value > 0 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Sword", Points)
            end
        end
    end
end)

spawn(function()
    while wait(.5) do
        if Gun_A then
            if game:GetService("Players").LocalPlayer.Data.Points.Value > 0 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Gun", Points)
            end
        end
    end
end)

spawn(function()
    while wait(.5) do
        if Fruit_A then
            if game:GetService("Players").LocalPlayer.Data.Points.Value > 0 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", Points)
            end
        end
    end
end)


