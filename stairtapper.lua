local fakeStairs = {}
local vim = game:GetService("VirtualInputManager")
local players = game:GetService("Players")
local player = players.LocalPlayer
local playerCharacter = workspace[player.Name]
local title = player.PlayerGui.GameplayGUI.Timer.Title.Text

function hold(keyCode, time)
  vim:SendKeyEvent(true, keyCode, false, game)
  task.wait(time)
  vim:SendKeyEvent(false, keyCode, false, game)
end

function check()
    local pos = playerCharacter.HumanoidRootPart.Position
    local rayOrigin = pos
    local rayDirection = Vector3.new(0, 8, 6)
    local raycastParams = RaycastParams.new()
    if #fakeStairs > 0 then fakeStairs = {} end
    for i,v in pairs(workspace.Stairs:GetChildren()) do
        if v.Transparency == 0 then
            table.insert(fakeStairs,v)
        end
    end
    raycastParams.FilterDescendantsInstances = fakeStairs
    raycastParams.FilterType = Enum.RaycastFilterType.Whitelist
    local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    if raycastResult then
        else
        return false
    end
    return true
end

local DiscordLib =loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/discord"))()
local win = DiscordLib:Window("discord library")
local serv = win:Server("Main", "")
local btns = serv:Channel("Main")

--btns:Seperator()

local sliderValue = 75
local sldr = btns:Slider(
    "AutoTap Speed",
    1,
    150,
    78,
    function(t)
        sliderValue = t
    end
)

local AutoTap = false
btns:Toggle(
    "Auto-Tap",
    false,
    function(bool)
        AutoTap = not AutoTap
        while AutoTap == true and wait() do
            if #player.PlayerGui.SpectateGUI:GetChildren() <= 0 then
                if #workspace.Stairs:GetChildren() > 0 then
                    if title == "Beginning In..." or title == "Intermission" then
                        
                        else
                        if check() == true then
                            hold(Enum.KeyCode.Left,0.005)
                        else
                            hold(Enum.KeyCode.Right,0.005)
                        end
                        wait((sliderValue - math.random(-2,2)) / 1000)
                    end
                end
            end
        end
    end
)

btns:Seperator()

local AutoRebirth = false
btns:Toggle(
    "Auto-Rebirth",
    false,
    function(bool)
        AutoRebirth = not AutoRebirth
        while AutoRebirth == true and wait() do
            game:GetService("ReplicatedStorage").Remotes.RebirthRF:InvokeServer()
        end
    end
)

local fire = serv:Channel("credits")

fire:Label("Made by 688914786154840096 on discord")

win:Server("Main", "http://www.roblox.com/asset/?id=6031075938")
