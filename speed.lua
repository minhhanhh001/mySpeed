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

while getgenv().Enabled and task.wait() do
    local char = players.LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        local target
        if hum.MoveDirection.Magnitude > 0 then
            target = getgenv().RunSpeed
        else
            target = getgenv().Speed
        end

        if hum.WalkSpeed ~= target then
            hum.WalkSpeed = target
        end
    end
end

