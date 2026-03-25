-- FPS BOOST + MAP TRƠN + PIXEL FONT + FPS COUNTER

local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ===== OPTIMIZE MAP =====

local function optimize(v)

    if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
        v.Material = Enum.Material.SmoothPlastic
        v.CastShadow = false
        v.Reflectance = 0
    end

    if v:IsA("SurfaceAppearance") then
        v:Destroy()
    end

    if v:IsA("ParticleEmitter")
    or v:IsA("Trail")
    or v:IsA("Beam")
    or v:IsA("Fire")
    or v:IsA("Smoke")
    or v:IsA("Sparkles") then
        v.Enabled = false
    end

    if v:IsA("PointLight")
    or v:IsA("SpotLight")
    or v:IsA("SurfaceLight") then
        v.Enabled = false
    end

end

for _,v in pairs(game:GetDescendants()) do
    optimize(v)
end

game.DescendantAdded:Connect(function(v)
    optimize(v)
end)

-- ===== LIGHTING =====

for _,v in pairs(Lighting:GetChildren()) do
    if v:IsA("BlurEffect")
    or v:IsA("SunRaysEffect")
    or v:IsA("BloomEffect")
    or v:IsA("DepthOfFieldEffect")
    or v:IsA("ColorCorrectionEffect") then
        v.Enabled = false
    end
end

Lighting.GlobalShadows = false
Lighting.FogEnd = 100000
Lighting.Brightness = 1

-- ===== TERRAIN =====

workspace.Terrain.Decoration = false
workspace.Terrain.WaterWaveSize = 0
workspace.Terrain.WaterWaveSpeed = 0
workspace.Terrain.WaterReflectance = 0

-- ===== PIXEL FONT (ÉP LIÊN TỤC) =====

local function pixelFont(v)

    if v:IsA("TextLabel")
    or v:IsA("TextButton")
    or v:IsA("TextBox") then
        
        v.Font = Enum.Font.Arcade
        
        if v.TextSize < 14 then
            v.TextSize = 14
        end
        
        v.TextStrokeTransparency = 0.6
        
    end

end

task.spawn(function()
    while true do
        for _,v in pairs(playerGui:GetDescendants()) do
            pixelFont(v)
        end
        task.wait(1)
    end
end)

-- ===== FPS COUNTER =====

local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui

local fps = Instance.new("TextLabel")
fps.Parent = gui
fps.Position = UDim2.new(0,10,0,10)
fps.Size = UDim2.new(0,120,0,30)
fps.BackgroundTransparency = 1
fps.TextColor3 = Color3.new(1,1,1)
fps.Font = Enum.Font.Arcade
fps.TextSize = 16

RunService.RenderStepped:Connect(function(delta)
    local currentFPS = math.floor(1/delta)
    fps.Text = "FPS: "..currentFPS
end)
