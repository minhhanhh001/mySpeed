local players = game:GetService("Players")

local function bypassWalkSpeed()
    if getgenv().executed then
        if not getgenv().Enabled then return end
    else
        getgenv().executed = true

        local mt = getrawmetatable(game)
        setreadonly(mt, false)

        local oldindex = mt.__index
        mt.__index = newcclosure(function(self, b)
            if b == "WalkSpeed" then
                return 16
            end
            return oldindex(self, b)
        end)
    end
end

bypassWalkSpeed()

players.LocalPlayer.CharacterAdded:Connect(function(char)
    bypassWalkSpeed()
    char:WaitForChild("Humanoid").WalkSpeed = getgenv().Speed
end)

local lastSpeed = nil

while getgenv().Enabled and wait() do
    local hum = players.LocalPlayer.Character:WaitForChild("Humanoid")
    if lastSpeed ~= getgenv().Speed then
        hum.WalkSpeed = getgenv().Speed
        lastSpeed = getgenv().Speed
    end
end


