function setKey()
    spawn(
        function()
            local key = game:HttpGet("https://raw.githubusercontent.com/pixelheadx/KEYSTEM2/main/Polakya%20key.txt")
            game:GetService("CoreGui").ScreenGui.KeySystem.TextBox.Text = key
        end
    )
end
if game:GetService("CoreGui"):FindFirstChild("ScreenGui") and game:GetService("CoreGui"):FindFirstChild("Lib") then
    print("already ran")
elseif game:GetService("CoreGui"):FindFirstChild("ScreenGui") then
    setKey()
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/pixelheadx/Polakya/main/Bestscript.md"))()
end
