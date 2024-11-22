-- FusionExec: Draggable Frame Library
local FusionExec = {}

function FusionExec:CreateDraggableFrame()
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")

    -- ScreenGui settings
    ScreenGui.Name = "FusionExecUI"
    ScreenGui.Parent = game:GetService("CoreGui")

    -- Frame settings
    Frame.Name = "DraggableFrame"
    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(9, 9, 8)
    Frame.Size = UDim2.new(0, 500, 0, 500)
    Frame.Position = UDim2.new(0.5, -250, 0.5, -250)
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    
    -- Make Frame draggable
    local UIS = game:GetService("UserInputService")
    local dragToggle = false
    local dragStart = nil
    local startPos = nil

    local function update(input)
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragToggle = true
            dragStart = input.Position
            startPos = Frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)

    Frame.InputChanged:Connect(function(input)
        if dragToggle and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input)
        end
    end)

    return Frame
end

return FusionExec
