-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Clean up existing GUI to prevent duplicates
local guiName = "CyberBrainrotGUI"
if CoreGui:FindFirstChild(guiName) then
    CoreGui[guiName]:Destroy()
end
if _G.__PodiumESPCleanup then pcall(_G.__PodiumESPCleanup) end
if _G.__NextBaseCleanup then pcall(_G.__NextBaseCleanup) end

-- Create the ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = guiName
ScreenGui.ResetOnSpawn = false
local success = pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not success then
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
end

-- Create Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 310)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -155)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 15, 25) -- Dark background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

-- Add UICorner for rounded edges
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Add UIStroke for Cyber Blue outline
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 255, 255) -- Cyber Blue / Cyan
UIStroke.Thickness = 2
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame

-- Title Label
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "BRAINROT STEALER"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = MainFrame

-- Subtitle/Status Label
local SubTitle = Instance.new("TextLabel")
SubTitle.Name = "SubTitle"
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0, 35)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Status: Ready to steal..."
SubTitle.TextColor3 = Color3.fromRGB(150, 200, 255)
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 12
SubTitle.Parent = MainFrame

-- Helper function to create buttons
local function createButton(name, text, yPos)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0.8, 0, 0, 45)
    btn.Position = UDim2.new(0.1, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(20, 30, 45)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = MainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 255, 255)
    stroke.Thickness = 1.5
    stroke.Parent = btn

    -- Hover effects
    btn.MouseEnter:Connect(function()
        if btn.BackgroundColor3 == Color3.fromRGB(20, 30, 45) then
            btn.BackgroundColor3 = Color3.fromRGB(0, 100, 120)
        end
    end)
    btn.MouseLeave:Connect(function()
        if btn.BackgroundColor3 == Color3.fromRGB(0, 100, 120) then
            btn.BackgroundColor3 = Color3.fromRGB(20, 30, 45)
        end
    end)

    return btn
end

-- Create Buttons
local ExecuteBtn = createButton("ExecuteBtn", "EXECUTE STEAL", 65)
local ServerBtn = createButton("ServerBtn", "JOIN NEW PLAYER SERVER", 120)
local SlotESPBtn = createButton("SlotESPBtn", "SLOT ESP: OFF", 175)
local EmptyBaseBtn = createButton("EmptyBaseBtn", "SHOW EMPTY BASE: OFF", 230)

-- Draggable Logic
local dragging = false
local dragInput
local dragStart
local startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ==========================================
-- BUTTON 1: EXECUTE STEAL
-- ==========================================
ExecuteBtn.MouseButton1Click:Connect(function()
    SubTitle.Text = "Status: Executing..."
    ExecuteBtn.Text = "STEALING..."
    
    -- Replace the print statement below with your existing steal code
    print("Brainrot steal initiated!")
    
    wait(1) -- Simulate execution time
    
    SubTitle.Text = "Status: Success!"
    ExecuteBtn.Text = "EXECUTE STEAL"
end)

-- ==========================================
-- BUTTON 2: JOIN NEW PLAYER SERVER
-- ==========================================
local confirmJoin = false
ServerBtn.MouseButton1Click:Connect(function()
    if not confirmJoin then
        -- First click: Ask for confirmation
        confirmJoin = true
        ServerBtn.Text = "ARE YOU SURE?"
        ServerBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        ServerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        -- Reset button after 3 seconds if not clicked
        task.delay(3, function()
            confirmJoin = false
            ServerBtn.Text = "JOIN NEW PLAYER SERVER"
            ServerBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 45)
            ServerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)
    else
        -- Second click: Execute server hop
        confirmJoin = false
        ServerBtn.Text = "FINDING SERVER..."
        ServerBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 45)
        
        SubTitle.Text = "Status: Searching for empty server..."

        local TeleportService = game:GetService("TeleportService")
        local HttpService = game:GetService("HttpService")
        local PLACE_ID = 96342491571673

        local function getServers(cursor)
            local url = "https://games.roblox.com/v1/games/" .. PLACE_ID .. "/servers/Public?sortOrder=Asc&limit=100"
            if cursor and cursor ~= "" then
                url = url .. "&cursor=" .. cursor
            end
            local ok, result = pcall(function()
                return HttpService:JSONDecode(game:HttpGet(url))
            end)
            if not ok then return nil end
            return result
        end

        local function findServer()
            local best = nil
            local cursor = ""
            repeat
                local data = getServers(cursor)
                if not data or not data.data then break end
                for _, server in ipairs(data.data) do
                    local n = server.playing
                    if n ~= nil and n <= 2 then
                        if n == 1 then
                            return server
                        end
                        if best == nil or n < best.playing then
                            best = server
                        end
                    end
                end
                cursor = data.nextPageCursor or ""
            until cursor == "" or cursor == nil
            return best
        end

        local server = findServer()
        if server then
            SubTitle.Text = "Status: Joining server with " .. server.playing .. " players"
            TeleportService:TeleportToPlaceInstance(PLACE_ID, server.id, Players.LocalPlayer)
        else
            SubTitle.Text = "Status: No servers found under 2 players"
            ServerBtn.Text = "JOIN NEW PLAYER SERVER"
        end
    end
end)

-- ==========================================
-- BUTTON 3: SLOT ESP (TOGGLE)
-- ==========================================
local slotESP_On = false
SlotESPBtn.MouseButton1Click:Connect(function()
    slotESP_On = not slotESP_On
    
    if slotESP_On then
        SlotESPBtn.Text = "SLOT ESP: ON"
        SlotESPBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        SlotESPBtn.TextColor3 = Color3.fromRGB(10, 15, 25)
        SubTitle.Text = "Status: Slot ESP Enabled"
        
        -- Run Slot ESP Code
        if _G.__PodiumESPCleanup then pcall(_G.__PodiumESPCleanup) end

        local RunService = game:GetService("RunService")
        local hui = (gethui and gethui()) or game:GetService("CoreGui")
        local Plots = workspace:WaitForChild("Plots")

        local PALETTE = {
            RED    = Color3.fromRGB(255, 60, 60),
            ORANGE = Color3.fromRGB(255, 150, 40),
            YELLOW = Color3.fromRGB(255, 225, 60),
            GREEN  = Color3.fromRGB(70, 235, 110),
            CYAN   = Color3.fromRGB(55, 225, 235),
            BLUE   = Color3.fromRGB(55, 185, 255),
            PURPLE = Color3.fromRGB(175, 95, 255),
            PINK   = Color3.fromRGB(255, 95, 190),
            WHITE  = Color3.fromRGB(255, 255, 255),
            BLACK  = Color3.fromRGB(20, 20, 20),
        }

        local CFG = {
            FLOOR_COLOR = { PALETTE.RED, PALETTE.RED, PALETTE.RED },
            COLLIDE     = true,
        }

        local FILL_T, INNER_T, MISS_T, THICK = 0.55, 0.42, 0.10, 0.05
        local PULSE_SPEED, PULSE_AMOUNT = 2, 0.12

        local TEMPLATE = {
            { 18.500,  1.531, -14.476,  90}, { 18.500,  1.531,  -6.976,  90}, { 18.500,  1.531,   0.524,  90},
            { 18.500,  1.531,   8.024,  90}, { 18.500,  1.531,  15.524,  90},
            {-18.536,  1.531,  15.524, -90}, {-18.536,  1.531,   8.024, -90}, {-18.536,  1.531,   0.524, -90},
            {-18.536,  1.531,  -6.976, -90}, {-18.536,  1.531, -14.476, -90},
            { 18.500, 19.531, -14.476,  90}, { 18.500, 19.531,  -6.976,  90}, { 18.500, 19.531,   0.524,  90},
            { 18.500, 19.531,   8.024,  90}, { 18.500, 19.531,  15.524,  90},
            {-18.380, 19.531, -14.452, -90}, {-18.380, 19.531,  -6.952, -90}, {-18.380, 19.531,   0.548, -90},
            { 18.500, 36.531, -12.476,  90}, { 18.500, 36.531,  -4.976,  90}, { 18.500, 36.531,   2.524,  90},
            { 18.500, 36.531,  10.024,  90}, { 18.500, 36.531,  17.524,  90},
            {-18.472, 36.531, -12.501, -90}, {-18.471, 36.531,  -5.001, -90}, {-18.471, 36.531,   2.499, -90},
            {-18.471, 36.531,   9.999, -90}, {-18.471, 36.531,  17.499, -90},
        }

        local OUTER, INNER_SZ, INNER_UP = Vector3.new(6, 0.25, 6), Vector3.new(4, 0.25, 4), 0.25

        for _, where in ipairs({workspace, game:GetService("CoreGui"), hui}) do
            for _, n in ipairs({"__PodiumMarkers", "__PodiumTest", "__PodiumCollide"}) do
                local o = where:FindFirstChild(n)
                if o then o:Destroy() end
            end
        end

        local markers, fills, conns = {}, {}, {}
        local alive = true
        local solids

        local function keep(x) markers[#markers + 1] = x x.Parent = hui return x end

        local function clear()
            for _, m in ipairs(markers) do pcall(function() m:Destroy() end) end
            table.clear(markers)
            table.clear(fills)
            if solids then solids:ClearAllChildren() end
        end

        local function box(adornee, cf, size, color, trans, isFill)
            local a = Instance.new("BoxHandleAdornment")
            a.Adornee = adornee
            a.Size = size
            a.CFrame = cf
            a.Color3 = color
            a.Transparency = trans
            a.AlwaysOnTop = false
            a.ZIndex = 0
            keep(a)
            if isFill then fills[#fills + 1] = { a = a, base = trans } end
            return a
        end

        local function outline(part, color)
            local b = Instance.new("SelectionBox")
            b.Adornee = part
            b.Color3 = color
            b.SurfaceColor3 = color
            b.LineThickness = THICK
            b.Transparency = 0
            b.SurfaceTransparency = 1
            return keep(b)
        end

        local function edges(root, cf, size, color)
            local t = THICK * 1.6
            local hx, hz, y = size.X * 0.5, size.Z * 0.5, size.Y * 0.5
            box(root, cf * CFrame.new(0, y,  hz), Vector3.new(size.X, t, t), color, 0)
            box(root, cf * CFrame.new(0, y, -hz), Vector3.new(size.X, t, t), color, 0)
            box(root, cf * CFrame.new( hx, y, 0), Vector3.new(t, t, size.Z), color, 0)
            box(root, cf * CFrame.new(-hx, y, 0), Vector3.new(t, t, size.Z), color, 0)
        end

        local function solid(worldCF)
            if not CFG.COLLIDE then return end
            if not solids then
                solids = Instance.new("Folder")
                solids.Name = "__PodiumCollide"
                solids.Parent = workspace
            end
            local p = Instance.new("Part")
            p.Anchored = true
            p.CanCollide = true
            p.CanQuery = false
            p.CanTouch = false
            p.Transparency = 1
            p.Size = OUTER
            p.CFrame = worldCF
            p.Parent = solids
        end

        local function colorFor(i)
            if i <= 10 then return CFG.FLOOR_COLOR[1] elseif i <= 18 then return CFG.FLOOR_COLOR[2] end
            return CFG.FLOOR_COLOR[3]
        end

        local function slabsOf(slot)
            local base = slot:FindFirstChild("Base") or slot
            local decos = base:FindFirstChild("Decorations")
            local parts = {}
            if decos then
                for _, c in ipairs(decos:GetChildren()) do
                    if c:IsA("BasePart") and c.Transparency < 1 then parts[#parts + 1] = c end
                end
            end
            table.sort(parts, function(a, b) return a.Size.X * a.Size.Z > b.Size.X * b.Size.Z end)
            return parts
        end

        local function drawReal(parts, color)
            local anchor = parts[1]
            for i, p in ipairs(parts) do
                local rel = anchor.CFrame:Inverse() * p.CFrame
                box(anchor, rel, p.Size + Vector3.new(0.03, 0.03, 0.03), color, i == 1 and FILL_T or INNER_T, true)
                outline(p, color)
            end
        end

        local function drawGhost(root, e, color)
            local cf = CFrame.new(e[1], e[2], e[3]) * CFrame.Angles(0, math.rad(e[4]), 0)
            box(root, cf, OUTER, color, FILL_T + MISS_T, true)
            box(root, cf * CFrame.new(0, INNER_UP, 0), INNER_SZ, color, INNER_T + MISS_T, true)
            edges(root, cf, OUTER, color)
            solid(root.CFrame * cf)
        end

        local function build()
            if not alive then return end
            clear()
            for _, plot in ipairs(Plots:GetChildren()) do
                local root = plot:FindFirstChild("MainRoot")
                local pods = plot:FindFirstChild("AnimalPodiums")
                if root and pods then
                    for i = 1, #TEMPLATE do
                        local sl = pods:FindFirstChild(tostring(i))
                        local parts = sl and slabsOf(sl)
                        local c = colorFor(i)
                        if parts and parts[1] then
                            drawReal(parts, c)
                        else
                            drawGhost(root, TEMPLATE[i], c)
                        end
                    end
                end
            end
        end

        build()

        local pending = false
        local function rebuild()
            if pending or not alive then return end
            pending = true
            task.delay(0.4, function() pending = false build() end)
        end
        local function watch(plot)
            local pods = plot:WaitForChild("AnimalPodiums", 20)
            if pods and alive then
                conns[#conns + 1] = pods.ChildAdded:Connect(rebuild)
                conns[#conns + 1] = pods.ChildRemoved:Connect(rebuild)
            end
        end
        for _, plot in ipairs(Plots:GetChildren()) do task.spawn(watch, plot) end
        conns[#conns + 1] = Plots.ChildAdded:Connect(function(plot)
            task.spawn(watch, plot)
            rebuild()
        end)

        do
            local acc = 0
            conns[#conns + 1] = RunService.Heartbeat:Connect(function(dt)
                acc = acc + dt
                if acc < 0.05 then return end
                acc = 0
                local w = math.sin(os.clock() * PULSE_SPEED) * PULSE_AMOUNT
                for _, f in ipairs(fills) do
                    if f.a.Parent then f.a.Transparency = math.clamp(f.base + w, 0, 1) end
                end
            end)
        end

        _G.__PodiumESPCleanup = function()
            alive = false
            for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
            table.clear(conns)
            clear()
            if solids then solids:Destroy() solids = nil end
            _G.__PodiumESPCleanup = nil
        end

    else
        SlotESPBtn.Text = "SLOT ESP: OFF"
        SlotESPBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 45)
        SlotESPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        SubTitle.Text = "Status: Slot ESP Disabled"
        
        if _G.__PodiumESPCleanup then pcall(_G.__PodiumESPCleanup) end
    end
end)

-- ==========================================
-- BUTTON 4: SHOW EMPTY BASE (TOGGLE)
-- ==========================================
local emptyBase_On = false
EmptyBaseBtn.MouseButton1Click:Connect(function()
    emptyBase_On = not emptyBase_On
    
    if emptyBase_On then
        EmptyBaseBtn.Text = "EMPTY BASE: ON"
        EmptyBaseBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        EmptyBaseBtn.TextColor3 = Color3.fromRGB(10, 15, 25)
        SubTitle.Text = "Status: Empty Base Tracker Enabled"

        if _G.__NextBaseCleanup then pcall(_G.__NextBaseCleanup) end
        local CoreGui = game:GetService("CoreGui")
        local Plots = workspace:WaitForChild("Plots")
        local BASE_POSITIONS = {
            Vector3.new(-342.439, 10.399, 113.107),
            Vector3.new(-342.439, 10.465,   6.107),
            Vector3.new(-476.752, 10.465, 114.107),
            Vector3.new(-476.752, 10.465,   7.107),
            Vector3.new(-342.440, 10.464, 220.107),
            Vector3.new(-476.752, 10.465, 221.107),
            Vector3.new(-342.439, 10.465,-100.893),
            Vector3.new(-476.752, 10.465, -99.893),
        }
        local MATCH_TOL = 6
        local EMPTY_TEXT = "Empty Base"
        local ARROW = utf8.char(0x2B07)
        
        local function baseIndexFor(model)
            local ok, cf = pcall(function() return (model:GetBoundingBox()) end)
            if not ok then return nil end
            local p, bestI, bestD = cf.Position
            for i, bp in ipairs(BASE_POSITIONS) do
                local dx, dz = p.X - bp.X, p.Z - bp.Z
                local d = math.sqrt(dx * dx + dz * dz)
                if not bestD or d < bestD then bestI, bestD = i, d end
            end
            return (bestD and bestD <= MATCH_TOL) and bestI or nil
        end
        
        local bases = {}
        local connected = {}
        local conns = {}
        
        local anchor = Instance.new("Part")
        anchor.Name = "__NextBaseAnchor"
        anchor.Anchored, anchor.CanCollide, anchor.CanQuery, anchor.CanTouch = true, false, false, false
        anchor.Transparency = 1
        anchor.Size = Vector3.new(1, 1, 1)
        anchor.Parent = CoreGui
        
        local bb = Instance.new("BillboardGui")
        bb.Name = "NextBaseBillboard"
        bb.Adornee = anchor
        bb.Size = UDim2.fromScale(32, 13)
        bb.StudsOffset = Vector3.new(0, 10, 0)
        bb.MaxDistance = math.huge
        bb.AlwaysOnTop = true
        bb.LightInfluence = 0
        bb.Enabled = false
        bb.Parent = anchor
        
        local top = Instance.new("TextLabel", bb)
        top.BackgroundTransparency = 1
        top.AnchorPoint = Vector2.new(0.5, 0.5)
        top.Position = UDim2.fromScale(0.5, 0.30)
        top.Size = UDim2.fromScale(0.95, 0.50)
        top.Font = Enum.Font.GothamBlack
        top.Text = ARROW .. "  NEXT  " .. ARROW
        top.TextScaled = true
        top.TextColor3 = Color3.fromRGB(255, 60, 60)
        top.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        top.TextStrokeTransparency = 0
        
        local bottom = Instance.new("TextLabel", bb)
        bottom.BackgroundTransparency = 1
        bottom.AnchorPoint = Vector2.new(0.5, 0.5)
        bottom.Position = UDim2.fromScale(0.5, 0.72)
        bottom.Size = UDim2.fromScale(0.95, 0.42)
        bottom.Font = Enum.Font.GothamBlack
        bottom.Text = "EMPTY BASE"
        bottom.TextScaled = true
        bottom.TextColor3 = Color3.fromRGB(255, 255, 255)
        bottom.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        bottom.TextStrokeTransparency = 0
        
        local function isEmpty(label)
            return (label.Text:gsub("^%s+", ""):gsub("%s+$", "")) == EMPTY_TEXT
        end
        
        local function recompute()
            local targetIdx
            for i = 1, #BASE_POSITIONS do
                local b = bases[i]
                if b and b.label and isEmpty(b.label) then targetIdx = i break end
            end
            if targetIdx then
                anchor.CFrame = bases[targetIdx].cf
                bb.Enabled = true
            else
                bb.Enabled = false
            end
        end
        
        local function connectLabel(label)
            if connected[label] then return end
            connected[label] = true
            table.insert(conns, label:GetPropertyChangedSignal("Text"):Connect(recompute))
        end
        
        local function scan()
            for _, plot in ipairs(Plots:GetChildren()) do
                local sign  = plot:FindFirstChild("PlotSign")
                local model = sign and sign:FindFirstChild("Model")
                local gui   = sign and sign:FindFirstChild("SurfaceGui")
                local fr    = gui and gui:FindFirstChild("Frame")
                local label = fr and fr:FindFirstChild("TextLabel")
                if model and label then
                    local idx = baseIndexFor(model)
                    if idx then
                        bases[idx] = { label = label, cf = (select(1, model:GetBoundingBox())) }
                        connectLabel(label)
                    end
                end
            end
            recompute()
        end
        
        scan()
        table.insert(conns, Plots.DescendantAdded:Connect(function(d)
            if d:IsA("TextLabel") then task.defer(scan) end
        end))
        table.insert(conns, Plots.ChildAdded:Connect(function() task.defer(scan) end))
        
        _G.__NextBaseCleanup = function()
            for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
            if anchor then anchor:Destroy() end
            _G.__NextBaseCleanup = nil
        end

    else
        EmptyBaseBtn.Text = "EMPTY BASE: OFF"
        EmptyBaseBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 45)
        EmptyBaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        SubTitle.Text = "Status: Empty Base Tracker Disabled"
        
        if _G.__NextBaseCleanup then pcall(_G.__NextBaseCleanup) end
    end
end)
