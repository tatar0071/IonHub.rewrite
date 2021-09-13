--[[--
	зачем ты смотришь мою ui библиотеку? хахахаха
	made by: scripting & design - tatar0071, idea - methamphetamine.solutions, some chunks or chunks idea - WetCheezit
--]] --

local Lib = {}
getgenv().SlidingColor = false
getgenv().SlidingSlider = false

function Lib:CreateWindow(name)
    local Win = {}

    local s_p_g = syn and syn.protect_gui and function(ins)
            syn.protect_gui(ins)
            ins.Name = game:GetService("HttpService"):GenerateGUID(false)
            ins.Parent = game:GetService("CoreGui")
        end or function(ins)
            warn("studio/no syn")
            ins.Name = game:GetService("HttpService"):GenerateGUID(false)
            ins.Parent = game:GetService("Players").LocalPlayer.PlayerGui
        end
    local IonLib = Instance.new("ScreenGui")
    s_p_g(IonLib)
    local Window = Instance.new("Frame")
    local TopBar = Instance.new("TextLabel")
    local LineUnderTabs = Instance.new("Frame")
    local TabButtons = Instance.new("Frame")
    local TabButtonsLayout = Instance.new("UIListLayout")

    Window.Name = "Window"
    Window.Parent = IonLib
    Window.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    Window.BorderColor3 = Color3.fromRGB(80, 80, 80)
    Window.Size = UDim2.new(0, 637, 0, 459)
    Window.Position = UDim2.new(0.5, -Window.Size.X.Offset / 2, 0.5, -Window.Size.Y.Offset / 2)

    TopBar.Name = "TopBar"
    TopBar.Parent = Window
    TopBar.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    TopBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TopBar.BorderSizePixel = 0
    TopBar.Size = UDim2.new(1, 0, 0, 17)
    TopBar.Font = Enum.Font.Nunito
    TopBar.Text = name
    TopBar.TextColor3 = Color3.fromRGB(247, 247, 247)
    TopBar.TextSize = 16.0
    TopBar.TextStrokeColor3 = Color3.fromRGB(50, 50, 50)
    TopBar.TextWrapped = true

    local Mouse, dragPos, windowPos, UIDragger = game:GetService("Players").LocalPlayer:GetMouse(), nil, nil, nil
    TopBar.InputBegan:Connect(
        function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                Mouse = game:GetService("Players").LocalPlayer:GetMouse()
                dragPos = {X = inp.Position.X, Y = inp.Position.Y}
                windowPos = {
                    X = Window.Position.X.Offset,
                    Y = Window.Position.Y.Offset,
                    Xs = Window.Position.X.Scale,
                    Ys = Window.Position.X.Scale
                }
                UIDragger =
                    Mouse.Move:Connect(
                    function()
                        local newMouse = game:GetService("Players").LocalPlayer:GetMouse()
                        Window.Position =
                            UDim2.new(
                            0.5,
                            newMouse.X - (dragPos.X - windowPos.X),
                            0.5,
                            newMouse.Y - (dragPos.Y - windowPos.Y)
                        )
                    end
                )
            end
        end
    )

    TopBar.InputEnded:Connect(
        function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                UIDragger:Disconnect()
                Mouse, dragPos, windowPos, UIDragger = game:GetService("Players").LocalPlayer:GetMouse(), nil, nil, nil
            end
        end
    )

    LineUnderTabs.Name = "LineUnderTabs"
    LineUnderTabs.Parent = Window
    LineUnderTabs.BackgroundColor3 = Color3.fromRGB(103, 103, 103)
    LineUnderTabs.BorderSizePixel = 0
    LineUnderTabs.Position = UDim2.new(0, 3, 0, 42)
    LineUnderTabs.Size = UDim2.new(1, -6, 0, 1)

    TabButtons.Name = "TabButtons"
    TabButtons.Parent = Window
    TabButtons.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    TabButtons.BackgroundTransparency = 1.000
    TabButtons.BorderSizePixel = 0
    TabButtons.Position = UDim2.new(0, 7, 0, 26)
    TabButtons.Size = UDim2.new(1, -14, 0, 16)

    TabButtonsLayout.Name = "TabButtonsLayout"
    TabButtonsLayout.Parent = TabButtons
    TabButtonsLayout.FillDirection = Enum.FillDirection.Horizontal
    TabButtonsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabButtonsLayout.Padding = UDim.new(0, 2)

    function Win:AddTab(name, istabintab)
        local Tab = {}

        local TabButton = Instance.new("TextButton")
        local TabName = Instance.new("Frame")

        TabButton.Name = "TabButton"
        TabButton.Parent = TabButtons
        TabButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(0, 1, 0, 16)
        TabButton.AutoButtonColor = false
        TabButton.Font = Enum.Font.Nunito
        TabButton:GetPropertyChangedSignal("TextBounds"):Connect(
            function()
                TabButton.Size = UDim2.new(0, TabButton.TextBounds.X + 10, 0, 16)
            end
        )
        TabButton.Text = name
        TabButton.TextColor3 = Color3.fromRGB(225, 225, 225)
        TabButton.TextSize = 16.000

        TabName.Name = name
        TabName.Parent = Window
        TabName.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
        TabName.BorderSizePixel = 0
        TabName.Position = UDim2.new(0, 3, 0, 46)
        TabName.Size = UDim2.new(0, 629, 0, 406)
        TabName.Visible = false

        local libinstances = {
            "LineUnderTabs",
            "TabButtons",
            "TopBar",
            "TabButtonsLayout",
            "TabInTabButtonsLayout",
            "LineUnderTabs_TabInTab"
        }

        TabButton.MouseButton1Down:Connect(
            function()
                for i, v in next, Window:GetChildren() do
                    if not table.find(libinstances, v.Name) and v ~= TabName then
                        v.Visible = false
                    end
                end
                for x, d in next, TabButtons:GetChildren() do
                    if not table.find(libinstances, d.Name) and d ~= TabButton then
                        d.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                    end
                end
                TabName.Visible = true
                TabButton.BackgroundColor3 = Color3.fromRGB(103, 103, 103)
            end
        )

        if istabintab then
            local LineUnderTabs_TabInTab = Instance.new("Frame")
            local TabInTabButtons = Instance.new("Frame")
            local TabInTabButtonsLayout = Instance.new("UIListLayout")

            LineUnderTabs_TabInTab.Name = "LineUnderTabs_TabInTab"
            LineUnderTabs_TabInTab.Parent = TabName
            LineUnderTabs_TabInTab.BackgroundColor3 = Color3.fromRGB(103, 103, 103)
            LineUnderTabs_TabInTab.BorderSizePixel = 0
            LineUnderTabs_TabInTab.Position = UDim2.new(0, 0, 0, 16)
            LineUnderTabs_TabInTab.Size = UDim2.new(1, 2, 0, 1)

            TabInTabButtons.Name = "TabInTabButtons"
            TabInTabButtons.Parent = LineUnderTabs_TabInTab
            TabInTabButtons.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
            TabInTabButtons.BackgroundTransparency = 1.000
            TabInTabButtons.BorderColor3 = Color3.fromRGB(27, 42, 53)
            TabInTabButtons.BorderSizePixel = 0
            TabInTabButtons.Position = UDim2.new(0, 4, 0, -16)
            TabInTabButtons.Size = UDim2.new(0, 622, 0, 16)

            TabInTabButtonsLayout.Name = "TabInTabButtonsLayout"
            TabInTabButtonsLayout.Parent = TabInTabButtons
            TabInTabButtonsLayout.FillDirection = Enum.FillDirection.Horizontal
            TabInTabButtonsLayout.SortOrder = Enum.SortOrder.LayoutOrder
            TabInTabButtonsLayout.Padding = UDim.new(0, 2)
        end

        function Tab:AddTabInTab(name)
            local TabInTab = {}

            if not TabName:FindFirstChild("LineUnderTabs_TabInTab") then
                return error("tab is not tab in tab")
            end

            local TabInTabButtons = TabName["LineUnderTabs_TabInTab"]["TabInTabButtons"]

            local TabButton_2 = Instance.new("TextButton")
            local TabName_2 = Instance.new("Frame")
            local TabInTabLayout = Instance.new("UIListLayout")

            TabButton_2.Name = "TabButton"
            TabButton_2.Parent = TabInTabButtons
            TabButton_2.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            TabButton_2.BorderSizePixel = 0
            TabButton_2.Size = UDim2.new(0, 50, 0, 16)
            TabButton_2.AutoButtonColor = false
            TabButton_2.Font = Enum.Font.Nunito
            TabButton_2.Text = name
            TabButton_2.TextColor3 = Color3.fromRGB(225, 225, 225)
            TabButton_2.TextSize = 16.000
            TabButton_2:GetPropertyChangedSignal("TextBounds"):Connect(
                function()
                    TabButton_2.Size = UDim2.new(0, TabButton_2.TextBounds.X + 10, 0, 16)
                end
            )

            TabName_2.Name = name
            TabName_2.Parent = TabName
            TabName_2.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
            TabName_2.BorderColor3 = Color3.fromRGB(80, 80, 80)
            TabName_2.BorderSizePixel = 0
            TabName_2.Position = UDim2.new(0, 4, 0, 24)
            TabName_2.Size = UDim2.new(1, -9, 0, 379)
            TabName_2.Visible = false

            TabInTabLayout.Name = "TabInTabLayout"
            TabInTabLayout.Parent = TabName_2
            TabInTabLayout.FillDirection = Enum.FillDirection.Horizontal
            TabInTabLayout.SortOrder = Enum.SortOrder.LayoutOrder
            TabInTabLayout.Padding = UDim.new(0, 6)
            TabInTabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
                function()
                    local pfix = {3, -3, -9}
                    local groupboxes = (#TabName_2:GetChildren()) - 1
                    local lastframe, lastframe_x = nil, 0
                    for x, d in next, TabName_2:GetChildren() do
                        if d:IsA("Frame") then
                            if d.AbsoluteSize.X > lastframe_x then
                                lastframe, lastframe_x = d, d.AbsoluteSize.X
                            end
                        end
                    end
                    local rightframe = lastframe
                    for i, v in next, TabName_2:GetChildren() do
                        local scale = 1 / groupboxes
                        if v:IsA("Frame") and v ~= rightframe then
                            v.Size = UDim2.new(scale, 0, 1, 0)
                        elseif v == rightframe then
                            v.Size = UDim2.new(scale, pfix[groupboxes], 1, 0)
                        end
                    end
                end
            )

            TabButton_2.MouseButton1Down:Connect(
                function()
                    for i, v in next, TabName:GetChildren() do
                        if not table.find(libinstances, v.Name) and v ~= TabName_2 then
                            v.Visible = false
                        end
                    end
                    for x, d in next, TabInTabButtons:GetChildren() do
                        if not table.find(libinstances, d.Name) and d ~= TabButton then
                            d.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                        end
                    end
                    TabName_2.Visible = true
                    TabButton_2.BackgroundColor3 = Color3.fromRGB(103, 103, 103)
                end
            )

            function TabInTab:CreateGroupbox(name)
                local GroupBox = {}

                local Groupbox = Instance.new("Frame")
                local GroupBoxDelimiter = Instance.new("Frame")
                local GroupBoxTitle = Instance.new("TextLabel")
                local GroupBoxFeaturesBox = Instance.new("Frame")
                local GroupBoxLayout = Instance.new("UIListLayout")

                Groupbox.Name = "Groupbox"
                Groupbox.Parent = TabName_2
                Groupbox.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                Groupbox.BorderColor3 = Color3.fromRGB(80, 80, 80)
                Groupbox.Size = UDim2.new(1, 0, 1, 0)

                GroupBoxDelimiter.Name = "GroupBoxDelimiter"
                GroupBoxDelimiter.Parent = Groupbox
                GroupBoxDelimiter.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                GroupBoxDelimiter.BorderSizePixel = 0
                GroupBoxDelimiter.Position = UDim2.new(0, 3, 0, 20)
                GroupBoxDelimiter.Size = UDim2.new(1, -6, 0, 1)

                GroupBoxTitle.Name = "GroupBoxTitle"
                GroupBoxTitle.Parent = GroupBoxDelimiter
                GroupBoxTitle.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                GroupBoxTitle.BorderColor3 = Color3.fromRGB(80, 80, 80)
                GroupBoxTitle.BorderSizePixel = 0
                GroupBoxTitle.Position = UDim2.new(0, 5, 0, -20)
                GroupBoxTitle.Size = UDim2.new(1, -6, 0, 20)
                GroupBoxTitle.Font = Enum.Font.Nunito
                GroupBoxTitle.Text = name
                GroupBoxTitle.TextColor3 = Color3.fromRGB(225, 225, 225)
                GroupBoxTitle.TextSize = 16.000
                GroupBoxTitle.TextXAlignment = Enum.TextXAlignment.Left
                GroupBoxTitle.TextYAlignment = Enum.TextYAlignment.Bottom

                GroupBoxFeaturesBox.Name = "GroupBoxFeaturesBox"
                GroupBoxFeaturesBox.Parent = Groupbox
                GroupBoxFeaturesBox.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                GroupBoxFeaturesBox.BorderColor3 = Color3.fromRGB(80, 80, 80)
                GroupBoxFeaturesBox.BorderSizePixel = 0
                GroupBoxFeaturesBox.Position = UDim2.new(0, 9, 0, 26)
                GroupBoxFeaturesBox.Size = UDim2.new(1, -9, 1, -26)

                GroupBoxLayout.Name = "GroupBoxLayout"
                GroupBoxLayout.Parent = GroupBoxFeaturesBox
                GroupBoxLayout.SortOrder = Enum.SortOrder.LayoutOrder
                GroupBoxLayout.Padding = UDim.new(0, 2)

                function GroupBox:AddToggle(name, default, callback)
                    local _Toggle = {}

                    local isToggled = default
                    local Toggle = Instance.new("Frame")
                    local ToggleButton = Instance.new("TextButton")
                    local ToggleLabel = Instance.new("TextLabel")

                    Toggle.Name = "Toggle"
                    Toggle.Parent = GroupBoxFeaturesBox
                    Toggle.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                    Toggle.BorderColor3 = Color3.fromRGB(80, 80, 80)
                    Toggle.BorderSizePixel = 0
                    Toggle.Size = UDim2.new(1, 0, 0, 18)

                    ToggleButton.Name = "ToggleButton"
                    ToggleButton.Parent = Toggle
                    ToggleButton.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
                    ToggleButton.BorderSizePixel = 0
                    ToggleButton.Size = UDim2.new(0, 18, 0, 18)
                    ToggleButton.AutoButtonColor = false
                    ToggleButton.Font = Enum.Font.SourceSans
                    ToggleButton.Text = ""
                    ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                    ToggleButton.TextSize = 1.000
                    ToggleButton.MouseButton1Down:Connect(
                        function()
                            isToggled = not isToggled
                            if isToggled then
                                ToggleButton.BackgroundColor3 = Color3.fromRGB(103, 103, 103)
                            else
                                ToggleButton.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
                            end
                            callback(isToggled)
                        end
                    )

                    ToggleLabel.Name = "ToggleLabel"
                    ToggleLabel.Parent = Toggle
                    ToggleLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                    ToggleLabel.BorderColor3 = Color3.fromRGB(80, 80, 80)
                    ToggleLabel.BorderSizePixel = 0
                    ToggleLabel.Position = UDim2.new(0, 23, 0, 0)
                    ToggleLabel.Size = UDim2.new(0, 36, 0, 18)
                    ToggleLabel.Font = Enum.Font.Nunito
                    ToggleLabel.Text = name
                    ToggleLabel.TextColor3 = Color3.fromRGB(225, 225, 225)
                    ToggleLabel.TextSize = 16.000
                    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                    ToggleLabel.TextYAlignment = Enum.TextYAlignment.Top

                    function _Toggle:Set(value, nocallback)
                        if value then
                            ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                        else
                            ToggleButton.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
                        end
                        callback(value)
                    end
                    if default then
                        _Toggle:Set(default)
                    end

                    function _Toggle:AddColorpicker(default, callback)
                        if typeof(default) ~= "Color3" then
                            return error(("Color3 expected, got %s"):format(typeof(default)))
                        end
                        local _Colorpicker = {}

                        local ColorButton = Instance.new("TextButton")
                        local Colorpicker = Instance.new("Frame")
                        local Colorgradient = Instance.new("ImageLabel")
                        local ImageLabel = Instance.new("ImageLabel")
                        local Colorslider = Instance.new("Frame")
                        local UIGradient = Instance.new("UIGradient")
                        local slidebar = Instance.new("Frame")
                        local isPickerOnScreen = false

                        ColorButton.Name = "ColorButton"
                        ColorButton.Parent = Toggle
                        ColorButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        local bounds = ToggleLabel.TextBounds
                        ColorButton.Position = UDim2.new(0, bounds.X + 50, 0, 0)
                        ColorButton.Size = UDim2.new(0, 18, 0, 18)
                        ColorButton.AutoButtonColor = false
                        ColorButton.Font = Enum.Font.SourceSans
                        ColorButton.Text = ""
                        ColorButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                        ColorButton.TextSize = 14.000
                        ColorButton.MouseButton1Down:Connect(
                            function()
                                isPickerOnScreen = not isPickerOnScreen
                                Colorpicker.Visible = isPickerOnScreen
                            end
                        )

                        Colorpicker.Name = "Colorpicker"
                        Colorpicker.Parent = ColorButton
                        Colorpicker.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                        Colorpicker.BorderColor3 = Color3.fromRGB(80, 80, 80)
                        Colorpicker.Position = UDim2.new(0, 19, 0, 0)
                        Colorpicker.Size = UDim2.new(0, 240, 0, 215)
                        Colorpicker.ZIndex = 2
                        Colorpicker.Visible = false

                        Colorgradient.Name = "Colorgradient"
                        Colorgradient.Parent = Colorpicker
                        Colorgradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        Colorgradient.BorderSizePixel = 0
                        Colorgradient.Position = UDim2.new(0, 7, 0, 7)
                        Colorgradient.Size = UDim2.new(0, 200, 0, 200)
                        Colorgradient.ZIndex = 2
                        Colorgradient.Image = "rbxassetid://1433361550"
                        Colorgradient.ScaleType = Enum.ScaleType.Crop

                        ImageLabel.Parent = Colorgradient
                        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                        ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        ImageLabel.BackgroundTransparency = 1.000
                        ImageLabel.BorderSizePixel = 0
                        ImageLabel.Selectable = true
                        ImageLabel.Size = UDim2.new(0, 18, 0, 18)
                        ImageLabel.ZIndex = 2
                        ImageLabel.Image = "rbxassetid://4953646208"

                        Colorslider.Name = "Colorslider"
                        Colorslider.Parent = Colorpicker
                        Colorslider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        Colorslider.BorderSizePixel = 0
                        Colorslider.Position = UDim2.new(0, 210, 0, 7)
                        Colorslider.Size = UDim2.new(0, 22, 0, 200)
                        Colorslider.ZIndex = 2

                        UIGradient.Color =
                            ColorSequence.new {
                            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
                            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))
                        }
                        UIGradient.Rotation = 90
                        UIGradient.Parent = Colorslider

                        slidebar.Name = "slidebar"
                        slidebar.Parent = Colorslider
                        slidebar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        slidebar.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        slidebar.Size = UDim2.new(1, 0, 0, 1)
                        slidebar.ZIndex = 2
                        local colorHueStore = select(1, default:ToHSV())
                        local colorSaturationStore = select(2, default:ToHSV())
                        local colorValueStore = select(3, default:ToHSV())
                        function _Colorpicker:Set(hue, sat, val, nocallback)
                            local colorargs = {
                                hue or colorHueStore,
                                sat or colorSaturationStore,
                                val or colorValueStore
                            }
                            local color = Color3.fromHSV(colorargs[1], colorargs[2], colorargs[3])
                            Colorslider.BackgroundColor3 = color
                            ColorButton.BackgroundColor3 = color
                            callback(color)
                        end
                        _Colorpicker:Set(colorHueStore, colorSaturationStore, colorValueStore)
                        local Mouse = game:GetService("Players").LocalPlayer:GetMouse()

                        local HueSaturationInput
                        Colorgradient.InputBegan:Connect(
                            function(input)
                                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    HueSaturationInput =
                                        Mouse.Move:Connect(
                                        function()
                                            local ColorHue =
                                                math.clamp(
                                                Mouse.X - Colorgradient.AbsolutePosition.X,
                                                0,
                                                Colorgradient.AbsoluteSize.X
                                            ) / Colorgradient.AbsoluteSize.X
                                            local ColorSaturation =
                                                math.clamp(
                                                Mouse.Y - Colorgradient.AbsolutePosition.Y,
                                                0,
                                                Colorgradient.AbsoluteSize.Y
                                            ) / Colorgradient.AbsoluteSize.Y
                                            ImageLabel.Position = UDim2.new(ColorHue, 0, ColorSaturation, 0)
                                            ColorHue = 1 - ColorHue
                                            ColorSaturation = 1 - ColorSaturation
                                            colorHueStore = ColorHue
                                            colorSaturationStore = ColorSaturation
                                            _Colorpicker:Set(ColorHue, ColorSaturation, nil)
                                        end
                                    )
                                end
                            end
                        )

                        Colorgradient.InputEnded:Connect(
                            function(uit)
                                if uit.UserInputType == Enum.UserInputType.MouseButton1 then
                                    if HueSaturationInput then
                                        HueSaturationInput:Disconnect()
                                    end
                                end
                            end
                        )

                        local colorValue
                        Colorslider.InputBegan:Connect(
                            function(uit)
                                if uit.UserInputType == Enum.UserInputType.MouseButton1 then
                                    colorValue =
                                        Mouse.Move:Connect(
                                        function()
                                            local hsvV =
                                                math.clamp(
                                                Mouse.Y - Colorslider.AbsolutePosition.Y,
                                                0,
                                                Colorslider.AbsoluteSize.Y
                                            ) / Colorslider.AbsoluteSize.Y
                                            slidebar.Position = UDim2.new(0, 0, hsvV, 0)
                                            hsvV = 1 - hsvV
                                            colorValueStore = hsvV
                                            _Colorpicker:Set(nil, nil, hsvV)
                                        end
                                    )
                                end
                            end
                        )

                        Colorslider.InputEnded:Connect(
                            function(uit)
                                if uit.UserInputType == Enum.UserInputType.MouseButton1 then
                                    if colorValue then
                                        colorValue:Disconnect()
                                    end
                                end
                            end
                        )

                        return _Colorpicker
                    end

                    return _Toggle
                end

                function GroupBox:AddSlider(name, min, max, default, isrounded, callback)
                    local _Slider = {}

                    local SliderValue = default

                    local Slider = Instance.new("Frame")
                    local SliderLabel = Instance.new("TextLabel")
                    local SliderObject = Instance.new("Frame")
                    local SliderMover = Instance.new("Frame")
                    local SliderText = Instance.new("TextLabel")

                    Slider.Name = "Slider"
                    Slider.Parent = GroupBoxFeaturesBox
                    Slider.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                    Slider.BorderColor3 = Color3.fromRGB(80, 80, 80)
                    Slider.BorderSizePixel = 0
                    Slider.Position = UDim2.new(0, 0, 0.0569800586, 0)
                    Slider.Size = UDim2.new(1, 0, 0, 34)

                    SliderLabel.Name = "SliderLabel"
                    SliderLabel.Parent = Slider
                    SliderLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                    SliderLabel.BorderColor3 = Color3.fromRGB(80, 80, 80)
                    SliderLabel.BorderSizePixel = 0
                    SliderLabel.Size = UDim2.new(1, 0, 0, 18)
                    SliderLabel.Font = Enum.Font.Nunito
                    SliderLabel.Text = name
                    SliderLabel.TextColor3 = Color3.fromRGB(225, 225, 225)
                    SliderLabel.TextSize = 16.000
                    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                    SliderLabel.TextYAlignment = Enum.TextYAlignment.Top

                    SliderObject.Name = "SliderObject"
                    SliderObject.Parent = Slider
                    SliderObject.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
                    SliderObject.BorderSizePixel = 0
                    SliderObject.Position = UDim2.new(0, 0, 0, 18)
                    SliderObject.Size = UDim2.new(0, 150, 0, 18)

                    SliderMover.Name = "SliderMover"
                    SliderMover.Parent = SliderObject
                    SliderMover.BackgroundColor3 = Color3.fromRGB(103, 103, 103)
                    SliderMover.BorderSizePixel = 0
                    SliderMover.Position = UDim2.new(0, 2, 0, 2)
                    SliderMover.Selectable = true
                    SliderMover.Size = UDim2.new(0, 2, 0, 14)

                    SliderText.Name = "SliderText"
                    SliderText.Parent = SliderObject
                    SliderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    SliderText.BackgroundTransparency = 1.000
                    SliderText.Position = UDim2.new(0.5, -20, 0, 0)
                    SliderText.Size = UDim2.new(0, 40, 0, 18)
                    SliderText.Font = Enum.Font.Nunito
                    SliderText.Text = tostring(default)
                    SliderText.TextColor3 = Color3.fromRGB(225, 225, 225)
                    SliderText.TextSize = 14.000
                    local function MoveSlider(inp)
                        local slidermath =
                            math.clamp(inp.X - SliderObject.AbsolutePosition.X, 0, SliderObject.AbsoluteSize.X) /
                            SliderObject.AbsoluteSize.X
                        local pos =
                            UDim2.new(
                            math.clamp((inp.X - SliderObject.AbsolutePosition.X) / SliderObject.AbsoluteSize.X, 0, 1),
                            0,
                            0,
                            2
                        )
                        SliderMover.Position =
                            UDim2.new(
                            math.clamp(
                                (inp.X - SliderObject.AbsolutePosition.X) / SliderObject.AbsoluteSize.X,
                                0.01,
                                0.97
                            ),
                            0,
                            0,
                            2
                        )
                        if isrounded then
                            SliderValue = math.floor(min + ((max - min) * slidermath))
                        else
                            SliderValue = min + ((max - min) * slidermath)
                        end
                        SliderText.Text = tostring(SliderValue)
                        callback(SliderValue)
                    end

                    SliderObject.InputBegan:Connect(
                        function(inp)
                            if inp.UserInputType == Enum.UserInputType.MouseButton1 and not getgenv().SlidingColor then
                                getgenv().SlidingSlider = true
                                game:GetService("RunService"):BindToRenderStep(
                                    "sliderdrag",
                                    1,
                                    function()
                                        if
                                            not game:GetService("UserInputService"):IsMouseButtonPressed(
                                                Enum.UserInputType.MouseButton1
                                            )
                                         then
                                            getgenv().SlidingSlider = false
                                            game:GetService("RunService"):UnbindFromRenderStep("sliderdrag")
                                        end
                                        MoveSlider(game:GetService("Players").LocalPlayer:GetMouse())
                                    end
                                )
                            end
                        end
                    )

                    function _Slider:Set(value)
                        SliderValue = value
                        SliderText.Text = tostring(SliderValue)
                        callback(SliderValue)
                    end
                    _Slider:Set(default)
                    SliderMover.Position = UDim2.new(math.clamp((default - min) / (max - min), 0.01, 0.97), 0, 0, 2)

                    return _Slider
                end

                function GroupBox:AddDropdown(name, options, default, callback)
                    local _Dropdown = {}

                    local DropdownValue = nil

                    if type(options) ~= "table" then
                        return error(("table expected, got %s"):format(type(options)))
                    end

                    local Dropdown = Instance.new("Frame")
                    local DropdownLabel = Instance.new("TextLabel")
                    local DropdownObject = Instance.new("Frame")
                    local DropdownArrow = Instance.new("Frame")
                    local DropdownArrowImage = Instance.new("ImageLabel")
                    local DropdownText = Instance.new("TextLabel")
                    local DropdownCombobox = Instance.new("Frame")
                    local List = Instance.new("Frame")
                    local ListDDLayout = Instance.new("UIListLayout")

                    Dropdown.Name = "Dropdown"
                    Dropdown.Parent = GroupBoxFeaturesBox
                    Dropdown.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                    Dropdown.BorderColor3 = Color3.fromRGB(80, 80, 80)
                    Dropdown.BorderSizePixel = 0
                    Dropdown.Position = UDim2.new(0, 0, 0.0569800586, 0)
                    Dropdown.Size = UDim2.new(1, 0, 0, 36)

                    DropdownLabel.Name = "DropdownLabel"
                    DropdownLabel.Parent = Dropdown
                    DropdownLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                    DropdownLabel.BorderColor3 = Color3.fromRGB(80, 80, 80)
                    DropdownLabel.BorderSizePixel = 0
                    DropdownLabel.Size = UDim2.new(1, 0, 0, 18)
                    DropdownLabel.Font = Enum.Font.Nunito
                    DropdownLabel.Text = name
                    DropdownLabel.TextColor3 = Color3.fromRGB(225, 225, 225)
                    DropdownLabel.TextSize = 16.000
                    DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
                    DropdownLabel.TextYAlignment = Enum.TextYAlignment.Top

                    DropdownObject.Name = "DropdownObject"
                    DropdownObject.Parent = Dropdown
                    DropdownObject.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
                    DropdownObject.BorderSizePixel = 0
                    DropdownObject.Position = UDim2.new(0, 0, 0, 18)
                    DropdownObject.Size = UDim2.new(0, 160, 0, 18)

                    DropdownArrow.Name = "DropdownArrow"
                    DropdownArrow.Parent = DropdownObject
                    DropdownArrow.BackgroundColor3 = Color3.fromRGB(103, 103, 103)
                    DropdownArrow.BorderSizePixel = 0
                    DropdownArrow.Position = UDim2.new(1, -17, 0, 0)
                    DropdownArrow.Size = UDim2.new(0, 17, 0, 18)

                    DropdownArrowImage.Name = "DropdownArrowImage"
                    DropdownArrowImage.Parent = DropdownArrow
                    DropdownArrowImage.BackgroundColor3 = Color3.fromRGB(103, 103, 103)
                    DropdownArrowImage.BackgroundTransparency = 0.2
                    DropdownArrowImage.BorderSizePixel = 0
                    DropdownArrowImage.Position = UDim2.new(0, 0, 0, 0)
                    DropdownArrowImage.Size = UDim2.new(1, 0, 1, 0)
                    DropdownArrowImage.Image = "rbxassetid://4430382124"

                    DropdownText.Name = "DropdownText"
                    DropdownText.Parent = DropdownObject
                    DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DropdownText.BackgroundTransparency = 1.000
                    DropdownText.BorderSizePixel = 0
                    DropdownText.Position = UDim2.new(0, 4, 0, 0)
                    DropdownText.Size = UDim2.new(0, 72, 0, 18)
                    DropdownText.Font = Enum.Font.Nunito
                    DropdownText.Text = ""
                    DropdownText.TextColor3 = Color3.fromRGB(225, 225, 225)
                    DropdownText.TextSize = 16.000
                    DropdownText.TextXAlignment = Enum.TextXAlignment.Left

                    DropdownCombobox.Name = "DropdownCombobox"
                    DropdownCombobox.Parent = DropdownObject
                    DropdownCombobox.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                    DropdownCombobox.BorderColor3 = Color3.fromRGB(80, 80, 80)
                    DropdownCombobox.BorderSizePixel = 1
                    DropdownCombobox.Position = UDim2.new(0, 0, 0, 18)
                    DropdownCombobox.BorderMode = Enum.BorderMode.Inset
                    DropdownCombobox.Size = UDim2.new(0, 120, 0, 18)
                    DropdownCombobox.Visible = false
                    DropdownCombobox.ZIndex = 2

                    List.Name = "DropdownList"
                    List.Parent = DropdownCombobox
                    List.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
                    List.BorderColor3 = Color3.fromRGB(80, 80, 80)
                    List.BackgroundTransparency = 1
                    List.BorderSizePixel = 0
                    List.Position = UDim2.new(0, 2, 0, 4)
                    List.Size = UDim2.new(0, 100, 0, 1)
                    List.Visible = false
                    List.ZIndex = 2

                    ListDDLayout.Name = "DropdownListLayout"
                    ListDDLayout.Parent = List
                    ListDDLayout.FillDirection = Enum.FillDirection.Vertical
                    ListDDLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    ListDDLayout.Padding = UDim.new(0, 0)
                    ListDDLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
                        function()
                            local ListSize = ListDDLayout.AbsoluteContentSize
                            List.Size = UDim2.new(0, 118, 0, ListSize.Y)
                            DropdownCombobox.Size = UDim2.new(0, ListSize.X + 4, 0, ListSize.Y + 10)
                        end
                    )

                    local isDropdownOpen = false
                    DropdownObject.InputBegan:Connect(
                        function(inp)
                            if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                                isDropdownOpen = not isDropdownOpen
                                DropdownCombobox.Visible = isDropdownOpen
                                List.Visible = isDropdownOpen
                            end
                        end
                    )

                    function _Dropdown:Add(name)
                        local dropdownbutton = Instance.new("TextButton")
                        dropdownbutton.Position = UDim2.new(0, 0, 0, 0)
                        dropdownbutton.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                        dropdownbutton.BorderSizePixel = 0
                        dropdownbutton.Parent = List
                        dropdownbutton.Text = name
                        dropdownbutton.Font = Enum.Font.Nunito
                        dropdownbutton.TextColor3 = Color3.fromRGB(225, 225, 225)
                        dropdownbutton.TextSize = 16.000
                        dropdownbutton.TextXAlignment = Enum.TextXAlignment.Left
                        dropdownbutton.ZIndex = 2
                        local bounds = dropdownbutton.TextBounds
                        dropdownbutton.Size = UDim2.new(0, 156, 0, bounds.Y)
                        dropdownbutton.MouseButton1Down:Connect(
                            function()
                                DropdownValue = name
                                DropdownText.Text = name
                                callback(name)
                                isDropdownOpen = not isDropdownOpen
                                DropdownCombobox.Visible = isDropdownOpen
                                List.Visible = isDropdownOpen
                            end
                        )
                    end

                    function _Dropdown:Reset()
                        for i, v in next, List:GetChildren() do
                            v:Remove()
                        end
                        DropdownValue = nil
                        DropdownText.Text = ""
                        callback(DropdownValue)
                    end

                    for i, v in next, options do
                        _Dropdown:Add(v)
                    end

                    function _Dropdown:Set(value)
                        DropdownValue = value
                        DropdownText.Text = value
                        callback(value)
                        isDropdownOpen = false
                        DropdownCombobox.Visible = false
                        List.Visible = false
                    end

                    _Dropdown:Set(default)

                    function _Dropdown:GetValue()
                        return DropdownValue
                    end

                    return _Dropdown
                end

                function GroupBox:AddKeybind(name, callback)
                    local _Keybind = {}

                    local Keybind = Instance.new("Frame")
                    local KeybindLabel = Instance.new("TextLabel")
                    local KeybindButton = Instance.new("TextButton")
                    local KeybindValue = nil

                    Keybind.Name = "Keybind"
                    Keybind.Parent = GroupBoxFeaturesBox
                    Keybind.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                    Keybind.BorderColor3 = Color3.fromRGB(80, 80, 80)
                    Keybind.BorderSizePixel = 0
                    Keybind.Position = UDim2.new(0, 0, 0.0569800586, 0)
                    Keybind.Size = UDim2.new(1, 0, 0, 38)

                    KeybindLabel.Name = "KeybindLabel"
                    KeybindLabel.Parent = Keybind
                    KeybindLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                    KeybindLabel.BorderColor3 = Color3.fromRGB(80, 80, 80)
                    KeybindLabel.BorderSizePixel = 0
                    KeybindLabel.Size = UDim2.new(1, 0, 0, 18)
                    KeybindLabel.Font = Enum.Font.Nunito
                    KeybindLabel.Text = name
                    KeybindLabel.TextColor3 = Color3.fromRGB(225, 225, 225)
                    KeybindLabel.TextSize = 16.000
                    KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
                    KeybindLabel.TextYAlignment = Enum.TextYAlignment.Top

                    KeybindButton.Name = "KeybindButton"
                    KeybindButton.Parent = Keybind
                    KeybindButton.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
                    KeybindButton.BorderColor3 = Color3.fromRGB(80, 80, 80)
                    KeybindButton.BorderSizePixel = 0
                    KeybindButton.Position = UDim2.new(0, 0, 0, 18)
                    KeybindButton.Size = UDim2.new(0, 75, 0, 20)
                    KeybindButton.AutoButtonColor = false
                    KeybindButton.Font = Enum.Font.Nunito
                    KeybindButton.Text = "NONE"
                    KeybindButton.TextColor3 = Color3.fromRGB(225, 225, 225)
                    KeybindButton.TextSize = 16.000

                    local bindnone = {Enum.KeyCode.Backspace}
                    local bindalways = {Enum.KeyCode.Escape}
                    local bindnotbinded = {}
                    local isListening = false

                    KeybindButton.MouseButton1Up:Connect(
                        function()
                            if not isListening then
                                KeybindButton.Text = "..."
                                isListening = true
                                local InputListener
                                InputListener =
                                    game:GetService("UserInputService").InputBegan:Connect(
                                    function(k)
                                        if
                                            not table.find(bindnotbinded, k.KeyCode) and
                                                not table.find(bindnotbinded, k.UserInputType)
                                         then
                                            if
                                                table.find(bindalways, k.KeyCode) or
                                                    table.find(bindalways, k.UserInputType)
                                             then
                                                KeybindValue = "NONE"
                                                callback(KeybindValue)
                                                KeybindButton.Text = KeybindValue
                                                isListening = false
                                                InputListener:Disconnect()
                                                return
                                            end
                                            if table.find(bindnone, k.KeyCode) or table.find(bindnone, k.UserInputType) then
                                                KeybindValue = "Always"
                                                callback(KeybindValue)
                                                KeybindButton.Text = KeybindValue
                                                isListening = false
                                                InputListener:Disconnect()
                                                return
                                            end
                                            local inputtype =
                                                tostring(k.KeyCode):find("Enum.KeyCode.") and
                                                tostring(k.KeyCode) ~= "Enum.KeyCode.Unknown" and
                                                "KeyCode" or
                                                "UserInputType"
                                            KeybindValue = k[inputtype]
                                            callback(k[inputtype])
                                            KeybindButton.Text =
                                                tostring(k[inputtype]):gsub("Enum.KeyCode.", ""):gsub(
                                                "Enum.UserInputType.",
                                                ""
                                            ):gsub("Button", "")
                                            isListening = false
                                            InputListener:Disconnect()
                                        end
                                    end
                                )
                            end
                        end
                    )

                    function _Keybind:Set(value)
                        KeybindValue = value
                        local bind = tostring(value)
                        if tostring(value):find("KeyCode") then
                            KeybindValue = value
                            callback(KeybindValue)
                        elseif tostring(value):find("UserInputType") then
                            KeybindValue = value
                            callback(KeybindValue)
                        elseif tostring(value) == "NONE" then
                            KeybindValue = value
                            callback(KeybindValue)
                        elseif tostring(value) == "Always" then
                            KeybindValue = value
                            callback(KeybindValue)
                        end
                        KeybindButton.Text =
                            tostring(value):gsub("Enum.KeyCode.", ""):gsub("Enum.UserInputType.", ""):gsub("Button", "")
                    end

                    function _Keybind:GetValue()
                        return KeybindValue
                    end

                    return _Keybind
                end

                function GroupBox:AddButton(name, callback)
                    local _Button = {}

                    local ButtonInstance = Instance.new("TextButton")

                    ButtonInstance.Name = "Button"
                    ButtonInstance.Parent = GroupBoxFeaturesBox
                    ButtonInstance.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                    ButtonInstance.BorderSizePixel = 0
                    ButtonInstance.Size = UDim2.new(0, 50, 0, 16)
                    ButtonInstance.AutoButtonColor = false
                    ButtonInstance.Font = Enum.Font.Nunito
                    ButtonInstance.Text = name
                    ButtonInstance.TextColor3 = Color3.fromRGB(225, 225, 225)
                    ButtonInstance.TextSize = 16.000
                    ButtonInstance:GetPropertyChangedSignal("TextBounds"):Connect(
                        function()
                            ButtonInstance.Size = UDim2.new(0, ButtonInstance.TextBounds.X + 10, 0, 16)
                        end
                    )
                    task.wait()
                    ButtonInstance.Size = UDim2.new(0, ButtonInstance.TextBounds.X + 10, 0, 16)

                    local ButtonConnection
                    ButtonConnection =
                        ButtonInstance.MouseButton1Down:Connect(
                        function()
                            callback()
                        end
                    )

                    return _Button
                end

                function GroupBox:AddMenuButton(name)
                    local _MenuButton = {}

                    local MenuButtonInstance = Instance.new("TextButton")
                    local ButtonMenu = Instance.new("Frame")
                    local ButtonMenuLayout = Instance.new("UIListLayout")
                    local isMenuVisible = false

                    MenuButtonInstance.Name = "MenuButton"
                    MenuButtonInstance.Parent = GroupBoxFeaturesBox
                    MenuButtonInstance.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                    MenuButtonInstance.BorderSizePixel = 0
                    MenuButtonInstance.Size = UDim2.new(0, 50, 0, 16)
                    MenuButtonInstance.AutoButtonColor = false
                    MenuButtonInstance.Font = Enum.Font.Nunito
                    MenuButtonInstance.Text = name
                    MenuButtonInstance.TextColor3 = Color3.fromRGB(225, 225, 225)
                    MenuButtonInstance.TextSize = 16.000
                    MenuButtonInstance:GetPropertyChangedSignal("TextBounds"):Connect(
                        function()
                            MenuButtonInstance.Size = UDim2.new(0, MenuButtonInstance.TextBounds.X + 10, 0, 16)
                        end
                    )
                    task.wait()
                    MenuButtonInstance.Size = UDim2.new(0, MenuButtonInstance.TextBounds.X + 10, 0, 16)

                    ButtonMenu.Visible = false
                    ButtonMenu.Name = "ButtonMenu"
                    ButtonMenu.Parent = IonLib
                    ButtonMenu.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                    ButtonMenu.BorderColor3 = Color3.fromRGB(80, 80, 80)
                    ButtonMenu.BorderSizePixel = 1

                    ButtonMenuLayout.Name = "ButtonMenuLayout"
                    ButtonMenuLayout.Parent = ButtonMenu
                    ButtonMenuLayout.FillDirection = Enum.FillDirection.Vertical
                    ButtonMenuLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    ButtonMenuLayout.Padding = UDim.new(0, 2)
                    ButtonMenuLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
                        function()
                            ButtonMenu.Size =
                                UDim2.new(
                                0,
                                ButtonMenuLayout.AbsoluteContentSize.X + 4,
                                0,
                                ButtonMenuLayout.AbsoluteContentSize.Y + 4
                            )
                        end
                    )

                    MenuButtonInstance.MouseButton1Down:Connect(
                        function()
                            isMenuVisible = not isMenuVisible
                            ButtonMenu.Visible = isMenuVisible
                            local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
                            ButtonMenu.Position = UDim2.new(0, Mouse.X, 0, Mouse.Y)
                        end
                    )

                    function _MenuButton:AddToggle(name, default, callback)
                        local _Toggle = {}

                        local isToggled = default
                        local Toggle = Instance.new("Frame")
                        local ToggleButton = Instance.new("TextButton")
                        local ToggleLabel = Instance.new("TextLabel")

                        Toggle.Name = "Toggle"
                        Toggle.Parent = ButtonMenu
                        Toggle.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                        Toggle.BorderColor3 = Color3.fromRGB(80, 80, 80)
                        Toggle.BorderSizePixel = 0
                        Toggle.Size = UDim2.new(0, 77, 0, 18)

                        ToggleButton.Name = "ToggleButton"
                        ToggleButton.Parent = Toggle
                        ToggleButton.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
                        ToggleButton.BorderSizePixel = 0
                        ToggleButton.Size = UDim2.new(0, 18, 0, 18)
                        ToggleButton.AutoButtonColor = false
                        ToggleButton.Font = Enum.Font.SourceSans
                        ToggleButton.Text = ""
                        ToggleButton.Position = UDim2.new(0, 2, 0, 2)
                        ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                        ToggleButton.TextSize = 1.000
                        ToggleButton.MouseButton1Down:Connect(
                            function()
                                isToggled = not isToggled
                                if isToggled then
                                    ToggleButton.BackgroundColor3 = Color3.fromRGB(103, 103, 103)
                                else
                                    ToggleButton.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
                                end
                                callback(isToggled)
                            end
                        )

                        ToggleLabel.Name = "ToggleLabel"
                        ToggleLabel.Parent = Toggle
                        ToggleLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                        ToggleLabel.BorderColor3 = Color3.fromRGB(80, 80, 80)
                        ToggleLabel.BorderSizePixel = 0
                        ToggleLabel.Position = UDim2.new(0, 25, 0, 2)
                        ToggleLabel.Size = UDim2.new(0, 36, 0, 18)
                        ToggleLabel.Font = Enum.Font.Nunito
                        ToggleLabel.Text = name
                        ToggleLabel.TextColor3 = Color3.fromRGB(225, 225, 225)
                        ToggleLabel.TextSize = 16.000
                        ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                        ToggleLabel.TextYAlignment = Enum.TextYAlignment.Top

                        task.wait()
                        Toggle.Size = UDim2.new(0, ToggleLabel.TextBounds.X + 66, 0, 18)

                        function _Toggle:Set(value, nocallback)
                            if value then
                                ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                            else
                                ToggleButton.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
                            end
                            callback(value)
                        end
                        if default then
                            _Toggle:Set(default)
                        end

                        function _Toggle:AddColorpicker(default, callback)
                            if typeof(default) ~= "Color3" then
                                return error(("Color3 expected, got %s"):format(typeof(default)))
                            end
                            local _Colorpicker = {}

                            local ColorButton = Instance.new("TextButton")
                            local Colorpicker = Instance.new("Frame")
                            local Colorgradient = Instance.new("ImageLabel")
                            local ImageLabel = Instance.new("ImageLabel")
                            local Colorslider = Instance.new("Frame")
                            local UIGradient = Instance.new("UIGradient")
                            local slidebar = Instance.new("Frame")
                            local isPickerOnScreen = false

                            ColorButton.Name = "ColorButton"
                            ColorButton.Parent = Toggle
                            ColorButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            local bounds = ToggleLabel.TextBounds
                            ColorButton.Position = UDim2.new(0, bounds.X + 50, 0, 2)
                            ColorButton.Size = UDim2.new(0, 18, 0, 18)
                            ColorButton.AutoButtonColor = false
                            ColorButton.Font = Enum.Font.SourceSans
                            ColorButton.Text = ""
                            ColorButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                            ColorButton.TextSize = 14.000
                            ColorButton.MouseButton1Down:Connect(
                                function()
                                    isPickerOnScreen = not isPickerOnScreen
                                    Colorpicker.Visible = isPickerOnScreen
                                end
                            )

                            Colorpicker.Name = "Colorpicker"
                            Colorpicker.Parent = ColorButton
                            Colorpicker.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                            Colorpicker.BorderColor3 = Color3.fromRGB(80, 80, 80)
                            Colorpicker.Position = UDim2.new(0, 19, 0, 0)
                            Colorpicker.Size = UDim2.new(0, 240, 0, 215)
                            Colorpicker.ZIndex = 2
                            Colorpicker.Visible = false

                            Colorgradient.Name = "Colorgradient"
                            Colorgradient.Parent = Colorpicker
                            Colorgradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            Colorgradient.BorderSizePixel = 0
                            Colorgradient.Position = UDim2.new(0, 7, 0, 7)
                            Colorgradient.Size = UDim2.new(0, 200, 0, 200)
                            Colorgradient.ZIndex = 2
                            Colorgradient.Image = "rbxassetid://1433361550"
                            Colorgradient.ScaleType = Enum.ScaleType.Crop

                            ImageLabel.Parent = Colorgradient
                            ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                            ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            ImageLabel.BackgroundTransparency = 1.000
                            ImageLabel.BorderSizePixel = 0
                            ImageLabel.Selectable = true
                            ImageLabel.Size = UDim2.new(0, 18, 0, 18)
                            ImageLabel.ZIndex = 2
                            ImageLabel.Image = "rbxassetid://4953646208"

                            Colorslider.Name = "Colorslider"
                            Colorslider.Parent = Colorpicker
                            Colorslider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            Colorslider.BorderSizePixel = 0
                            Colorslider.Position = UDim2.new(0, 210, 0, 7)
                            Colorslider.Size = UDim2.new(0, 22, 0, 200)
                            Colorslider.ZIndex = 2

                            UIGradient.Color =
                                ColorSequence.new {
                                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
                                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))
                            }
                            UIGradient.Rotation = 90
                            UIGradient.Parent = Colorslider

                            slidebar.Name = "slidebar"
                            slidebar.Parent = Colorslider
                            slidebar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            slidebar.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            slidebar.Size = UDim2.new(1, 0, 0, 1)
                            slidebar.ZIndex = 2
                            local colorHueStore = select(1, default:ToHSV())
                            local colorSaturationStore = select(2, default:ToHSV())
                            local colorValueStore = select(3, default:ToHSV())
                            function _Colorpicker:Set(hue, sat, val, nocallback)
                                local colorargs = {
                                    hue or colorHueStore,
                                    sat or colorSaturationStore,
                                    val or colorValueStore
                                }
                                local color = Color3.fromHSV(colorargs[1], colorargs[2], colorargs[3])
                                Colorslider.BackgroundColor3 = color
                                ColorButton.BackgroundColor3 = color
                                callback(color)
                            end
                            _Colorpicker:Set(colorHueStore, colorSaturationStore, colorValueStore)
                            repeat
                                task.wait()
                            until game:GetService("Players").LocalPlayer
                            local Mouse = game:GetService("Players").LocalPlayer:GetMouse()

                            local HueSaturationInput
                            Colorgradient.InputBegan:Connect(
                                function(input)
                                    if
                                        input.UserInputType == Enum.UserInputType.MouseButton1 and Colorpicker.Visible and
                                            not getgenv().SlidingSlider
                                     then
                                        getgenv().SlidingColor = true
                                        HueSaturationInput =
                                            Mouse.Move:Connect(
                                            function()
                                                local ColorHue =
                                                    math.clamp(
                                                    Mouse.X - Colorgradient.AbsolutePosition.X,
                                                    0,
                                                    Colorgradient.AbsoluteSize.X
                                                ) / Colorgradient.AbsoluteSize.X
                                                local ColorSaturation =
                                                    math.clamp(
                                                    Mouse.Y - Colorgradient.AbsolutePosition.Y,
                                                    0,
                                                    Colorgradient.AbsoluteSize.Y
                                                ) / Colorgradient.AbsoluteSize.Y
                                                ImageLabel.Position = UDim2.new(ColorHue, 0, ColorSaturation, 0)
                                                ColorHue = 1 - ColorHue
                                                ColorSaturation = 1 - ColorSaturation
                                                colorHueStore = ColorHue
                                                colorSaturationStore = ColorSaturation
                                                _Colorpicker:Set(ColorHue, ColorSaturation, nil)
                                            end
                                        )
                                    end
                                end
                            )

                            Colorgradient.InputEnded:Connect(
                                function(uit)
                                    if uit.UserInputType == Enum.UserInputType.MouseButton1 then
                                        getgenv().SlidingColor = false
                                        if HueSaturationInput then
                                            HueSaturationInput:Disconnect()
                                        end
                                    end
                                end
                            )

                            local colorValue
                            Colorslider.InputBegan:Connect(
                                function(uit)
                                    if
                                        uit.UserInputType == Enum.UserInputType.MouseButton1 and Colorpicker.Visible and
                                            not getgenv().SlidingSlider
                                     then
                                        getgenv().SlidingColor = true
                                        colorValue =
                                            Mouse.Move:Connect(
                                            function()
                                                local hsvV =
                                                    math.clamp(
                                                    Mouse.Y - Colorslider.AbsolutePosition.Y,
                                                    0,
                                                    Colorslider.AbsoluteSize.Y
                                                ) / Colorslider.AbsoluteSize.Y
                                                slidebar.Position = UDim2.new(0, 0, hsvV, 0)
                                                hsvV = 1 - hsvV
                                                colorValueStore = hsvV
                                                _Colorpicker:Set(nil, nil, hsvV)
                                            end
                                        )
                                    end
                                end
                            )

                            Colorslider.InputEnded:Connect(
                                function(uit)
                                    if uit.UserInputType == Enum.UserInputType.MouseButton1 then
                                        getgenv().SlidingColor = false
                                        if colorValue then
                                            colorValue:Disconnect()
                                        end
                                    end
                                end
                            )

                            return _Colorpicker
                        end

                        return _Toggle
                    end

                    function _MenuButton:AddSlider(name, min, max, default, isrounded, callback)
                        local _Slider = {}

                        local SliderValue = default

                        local Slider = Instance.new("Frame")
                        local SliderLabel = Instance.new("TextLabel")
                        local SliderObject = Instance.new("Frame")
                        local SliderMover = Instance.new("Frame")
                        local SliderText = Instance.new("TextLabel")

                        Slider.Name = "Slider"
                        Slider.Parent = GroupBoxFeaturesBox
                        Slider.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                        Slider.BorderColor3 = Color3.fromRGB(80, 80, 80)
                        Slider.BorderSizePixel = 0
                        Slider.Position = UDim2.new(0, 0, 0.0569800586, 0)
                        Slider.Size = UDim2.new(1, 0, 0, 34)

                        SliderLabel.Name = "SliderLabel"
                        SliderLabel.Parent = Slider
                        SliderLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                        SliderLabel.BorderColor3 = Color3.fromRGB(80, 80, 80)
                        SliderLabel.BorderSizePixel = 0
                        SliderLabel.Size = UDim2.new(1, 0, 0, 18)
                        SliderLabel.Font = Enum.Font.Nunito
                        SliderLabel.Text = name
                        SliderLabel.TextColor3 = Color3.fromRGB(225, 225, 225)
                        SliderLabel.TextSize = 16.000
                        SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                        SliderLabel.TextYAlignment = Enum.TextYAlignment.Top

                        SliderObject.Name = "SliderObject"
                        SliderObject.Parent = Slider
                        SliderObject.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
                        SliderObject.BorderSizePixel = 0
                        SliderObject.Position = UDim2.new(0, 0, 0, 18)
                        SliderObject.Size = UDim2.new(0, 150, 0, 18)

                        SliderMover.Name = "SliderMover"
                        SliderMover.Parent = SliderObject
                        SliderMover.BackgroundColor3 = Color3.fromRGB(103, 103, 103)
                        SliderMover.BorderSizePixel = 0
                        SliderMover.Position = UDim2.new(0, 2, 0, 2)
                        SliderMover.Selectable = true
                        SliderMover.Size = UDim2.new(0, 2, 0, 14)

                        SliderText.Name = "SliderText"
                        SliderText.Parent = SliderObject
                        SliderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        SliderText.BackgroundTransparency = 1.000
                        SliderText.Position = UDim2.new(0.5, -20, 0, 0)
                        SliderText.Size = UDim2.new(0, 40, 0, 18)
                        SliderText.Font = Enum.Font.Nunito
                        SliderText.Text = tostring(default)
                        SliderText.TextColor3 = Color3.fromRGB(225, 225, 225)
                        SliderText.TextSize = 14.000
                        local function MoveSlider(inp)
                            local slidermath =
                                math.clamp(inp.X - SliderObject.AbsolutePosition.X, 0, SliderObject.AbsoluteSize.X) /
                                SliderObject.AbsoluteSize.X
                            local pos =
                                UDim2.new(
                                math.clamp(
                                    (inp.X - SliderObject.AbsolutePosition.X) / SliderObject.AbsoluteSize.X,
                                    0,
                                    1
                                ),
                                0,
                                0,
                                2
                            )
                            SliderMover.Position =
                                UDim2.new(
                                math.clamp(
                                    (inp.X - SliderObject.AbsolutePosition.X) / SliderObject.AbsoluteSize.X,
                                    0.01,
                                    0.97
                                ),
                                0,
                                0,
                                2
                            )
                            if isrounded then
                                SliderValue = math.floor(min + ((max - min) * slidermath))
                            else
                                SliderValue = min + ((max - min) * slidermath)
                            end
                            SliderText.Text = tostring(SliderValue)
                            callback(SliderValue)
                        end

                        SliderObject.InputBegan:Connect(
                            function(inp)
                                if inp.UserInputType == Enum.UserInputType.MouseButton1 and not getgenv().SlidingColor then
                                    getgenv().SlidingSlider = true
                                    game:GetService("RunService"):BindToRenderStep(
                                        "sliderdrag",
                                        1,
                                        function()
                                            if
                                                not game:GetService("UserInputService"):IsMouseButtonPressed(
                                                    Enum.UserInputType.MouseButton1
                                                )
                                             then
                                                getgenv().SlidingSlider = false
                                                game:GetService("RunService"):UnbindFromRenderStep("sliderdrag")
                                            end
                                            MoveSlider(game:GetService("Players").LocalPlayer:GetMouse())
                                        end
                                    )
                                end
                            end
                        )

                        function _Slider:Set(value)
                            SliderValue = value
                            SliderText.Text = tostring(SliderValue)
                            callback(SliderValue)
                        end
                        _Slider:Set(default)
                        SliderMover.Position = UDim2.new(math.clamp((default - min) / (max - min), 0.01, 0.97), 0, 0, 2)

                        return _Slider
                    end

                    function _MenuButton:AddDropdown(name, options, default, callback)
                        local _Dropdown = {}

                        local DropdownValue = nil

                        if type(options) ~= "table" then
                            return error(("table expected, got %s"):format(type(options)))
                        end

                        local Dropdown = Instance.new("Frame")
                        local DropdownLabel = Instance.new("TextLabel")
                        local DropdownObject = Instance.new("Frame")
                        local DropdownArrow = Instance.new("Frame")
                        local DropdownText = Instance.new("TextLabel")
                        local DropdownCombobox = Instance.new("Frame")
                        local List = Instance.new("Frame")
                        local ListDDLayout = Instance.new("UIListLayout")

                        Dropdown.Name = "Dropdown"
                        Dropdown.Parent = ButtonMenu
                        Dropdown.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                        Dropdown.BorderColor3 = Color3.fromRGB(80, 80, 80)
                        Dropdown.BorderSizePixel = 0
                        Dropdown.Position = UDim2.new(0, 0, 0.0569800586, 0)
                        Dropdown.Size = UDim2.new(0, 160, 0, 36)

                        DropdownLabel.Name = "DropdownLabel"
                        DropdownLabel.Parent = Dropdown
                        DropdownLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                        DropdownLabel.BorderColor3 = Color3.fromRGB(80, 80, 80)
                        DropdownLabel.BorderSizePixel = 0
                        DropdownLabel.Size = UDim2.new(1, 0, 0, 18)
                        DropdownLabel.Font = Enum.Font.Nunito
                        DropdownLabel.Text = name
                        DropdownLabel.TextColor3 = Color3.fromRGB(225, 225, 225)
                        DropdownLabel.TextSize = 16.000
                        DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
                        DropdownLabel.TextYAlignment = Enum.TextYAlignment.Top
                        DropdownLabel.Position = UDim2.new(0, 2, 0, 0)

                        DropdownObject.Name = "DropdownObject"
                        DropdownObject.Parent = Dropdown
                        DropdownObject.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
                        DropdownObject.BorderSizePixel = 0
                        DropdownObject.Position = UDim2.new(0, 2, 0, 18)
                        DropdownObject.Size = UDim2.new(0, 160, 0, 18)

                        DropdownArrow.Name = "DropdownArrow"
                        DropdownArrow.Parent = DropdownObject
                        DropdownArrow.BackgroundColor3 = Color3.fromRGB(103, 103, 103)
                        DropdownArrow.BorderSizePixel = 0
                        DropdownArrow.Position = UDim2.new(1, -17, 0, 0)
                        DropdownArrow.Size = UDim2.new(0, 17, 0, 18)

                        DropdownText.Name = "DropdownText"
                        DropdownText.Parent = DropdownObject
                        DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        DropdownText.BackgroundTransparency = 1.000
                        DropdownText.BorderSizePixel = 0
                        DropdownText.Position = UDim2.new(0, 4, 0, 0)
                        DropdownText.Size = UDim2.new(0, 72, 0, 18)
                        DropdownText.Font = Enum.Font.Nunito
                        DropdownText.Text = ""
                        DropdownText.TextColor3 = Color3.fromRGB(225, 225, 225)
                        DropdownText.TextSize = 16.000
                        DropdownText.TextXAlignment = Enum.TextXAlignment.Left

                        DropdownCombobox.Name = "DropdownCombobox"
                        DropdownCombobox.Parent = DropdownObject
                        DropdownCombobox.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                        DropdownCombobox.BorderColor3 = Color3.fromRGB(80, 80, 80)
                        DropdownCombobox.BorderSizePixel = 1
                        DropdownCombobox.Position = UDim2.new(0, 0, 0, 18)
                        DropdownCombobox.BorderMode = Enum.BorderMode.Inset
                        DropdownCombobox.Size = UDim2.new(0, 120, 0, 18)
                        DropdownCombobox.Visible = false
                        DropdownCombobox.ZIndex = 2

                        List.Name = "DropdownList"
                        List.Parent = DropdownCombobox
                        List.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
                        List.BorderColor3 = Color3.fromRGB(80, 80, 80)
                        List.BackgroundTransparency = 1
                        List.BorderSizePixel = 0
                        List.Position = UDim2.new(0, 2, 0, 4)
                        List.Size = UDim2.new(0, 100, 0, 1)
                        List.Visible = false
                        List.ZIndex = 2

                        ListDDLayout.Name = "DropdownListLayout"
                        ListDDLayout.Parent = List
                        ListDDLayout.FillDirection = Enum.FillDirection.Vertical
                        ListDDLayout.SortOrder = Enum.SortOrder.LayoutOrder
                        ListDDLayout.Padding = UDim.new(0, 0)
                        ListDDLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
                            function()
                                local ListSize = ListDDLayout.AbsoluteContentSize
                                List.Size = UDim2.new(0, 118, 0, ListSize.Y)
                                DropdownCombobox.Size = UDim2.new(0, ListSize.X + 4, 0, ListSize.Y + 10)
                            end
                        )

                        local isDropdownOpen = false
                        DropdownObject.InputBegan:Connect(
                            function(inp)
                                if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                                    isDropdownOpen = not isDropdownOpen
                                    DropdownCombobox.Visible = isDropdownOpen
                                    List.Visible = isDropdownOpen
                                end
                            end
                        )

                        function _Dropdown:Add(name)
                            local dropdownbutton = Instance.new("TextButton")
                            dropdownbutton.Position = UDim2.new(0, 0, 0, 0)
                            dropdownbutton.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                            dropdownbutton.BorderSizePixel = 0
                            dropdownbutton.Parent = List
                            dropdownbutton.Text = name
                            dropdownbutton.Font = Enum.Font.Nunito
                            dropdownbutton.TextColor3 = Color3.fromRGB(225, 225, 225)
                            dropdownbutton.TextSize = 16.000
                            dropdownbutton.TextXAlignment = Enum.TextXAlignment.Left
                            dropdownbutton.ZIndex = 2
                            local bounds = dropdownbutton.TextBounds
                            dropdownbutton.Size = UDim2.new(0, 156, 0, bounds.Y)
                            dropdownbutton.MouseButton1Down:Connect(
                                function()
                                    DropdownValue = name
                                    DropdownText.Text = name
                                    callback(name)
                                    isDropdownOpen = not isDropdownOpen
                                    DropdownCombobox.Visible = isDropdownOpen
                                    List.Visible = isDropdownOpen
                                end
                            )
                        end

                        function _Dropdown:Reset()
                            for i, v in next, List:GetChildren() do
                                v:Remove()
                            end
                            DropdownValue = nil
                            DropdownText.Text = ""
                            callback(DropdownValue)
                        end

                        for i, v in next, options do
                            _Dropdown:Add(v)
                        end

                        function _Dropdown:Set(value)
                            DropdownValue = value
                            DropdownText.Text = value
                            callback(value)
                            isDropdownOpen = false
                            DropdownCombobox.Visible = false
                            List.Visible = false
                        end

                        _Dropdown:Set(default)

                        function _Dropdown:GetValue()
                            return DropdownValue
                        end

                        return _Dropdown
                    end

                    function _MenuButton:AddKeybind(name, callback)
                        local _Keybind = {}

                        local Keybind = Instance.new("Frame")
                        local KeybindLabel = Instance.new("TextLabel")
                        local KeybindButton = Instance.new("TextButton")
                        local KeybindValue = nil

                        Keybind.Name = "Keybind"
                        Keybind.Parent = ButtonMenu
                        Keybind.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                        Keybind.BorderColor3 = Color3.fromRGB(80, 80, 80)
                        Keybind.BorderSizePixel = 0
                        Keybind.Position = UDim2.new(0, 0, 0.0569800586, 0)
                        Keybind.Size = UDim2.new(0, 75, 0, 38)

                        KeybindLabel.Name = "KeybindLabel"
                        KeybindLabel.Parent = Keybind
                        KeybindLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                        KeybindLabel.BorderColor3 = Color3.fromRGB(80, 80, 80)
                        KeybindLabel.BorderSizePixel = 0
                        KeybindLabel.Size = UDim2.new(1, 0, 0, 18)
                        KeybindLabel.Font = Enum.Font.Nunito
                        KeybindLabel.Text = name
                        KeybindLabel.Position = UDim2.new(0, 2, 0, 0)
                        KeybindLabel.TextColor3 = Color3.fromRGB(225, 225, 225)
                        KeybindLabel.TextSize = 16.000
                        KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
                        KeybindLabel.TextYAlignment = Enum.TextYAlignment.Top

                        KeybindButton.Name = "KeybindButton"
                        KeybindButton.Parent = Keybind
                        KeybindButton.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
                        KeybindButton.BorderColor3 = Color3.fromRGB(80, 80, 80)
                        KeybindButton.BorderSizePixel = 0
                        KeybindButton.Position = UDim2.new(0, 2, 0, 18)
                        KeybindButton.Size = UDim2.new(0, 75, 0, 20)
                        KeybindButton.AutoButtonColor = false
                        KeybindButton.Font = Enum.Font.Nunito
                        KeybindButton.Text = "NONE"
                        KeybindButton.TextColor3 = Color3.fromRGB(225, 225, 225)
                        KeybindButton.TextSize = 16.000

                        local bindnone = {Enum.KeyCode.Backspace}
                        local bindalways = {Enum.KeyCode.Escape}
                        local bindnotbinded = {}
                        local isListening = false

                        KeybindButton.MouseButton1Up:Connect(
                            function()
                                if not isListening then
                                    KeybindButton.Text = "..."
                                    isListening = true
                                    local InputListener
                                    InputListener =
                                        game:GetService("UserInputService").InputBegan:Connect(
                                        function(k)
                                            if
                                                not table.find(bindnotbinded, k.KeyCode) and
                                                    not table.find(bindnotbinded, k.UserInputType)
                                             then
                                                if
                                                    table.find(bindalways, k.KeyCode) or
                                                        table.find(bindalways, k.UserInputType)
                                                 then
                                                    KeybindValue = "NONE"
                                                    callback(KeybindValue)
                                                    KeybindButton.Text = KeybindValue
                                                    isListening = false
                                                    InputListener:Disconnect()
                                                    return
                                                end
                                                if
                                                    table.find(bindnone, k.KeyCode) or
                                                        table.find(bindnone, k.UserInputType)
                                                 then
                                                    KeybindValue = "Always"
                                                    callback(KeybindValue)
                                                    KeybindButton.Text = KeybindValue
                                                    isListening = false
                                                    InputListener:Disconnect()
                                                    return
                                                end
                                                local inputtype =
                                                    tostring(k.KeyCode):find("Enum.KeyCode.") and
                                                    tostring(k.KeyCode) ~= "Enum.KeyCode.Unknown" and
                                                    "KeyCode" or
                                                    "UserInputType"
                                                KeybindValue = k[inputtype]
                                                callback(k[inputtype])
                                                KeybindButton.Text =
                                                    tostring(k[inputtype]):gsub("Enum.KeyCode.", ""):gsub(
                                                    "Enum.UserInputType.",
                                                    ""
                                                ):gsub("Button", "")
                                                isListening = false
                                                InputListener:Disconnect()
                                            end
                                        end
                                    )
                                end
                            end
                        )

                        function _Keybind:Set(value)
                            KeybindValue = value
                            local bind = tostring(value)
                            if tostring(value):find("KeyCode") then
                                KeybindValue = value
                                callback(KeybindValue)
                            elseif tostring(value):find("UserInputType") then
                                KeybindValue = value
                                callback(KeybindValue)
                            elseif tostring(value) == "NONE" then
                                KeybindValue = value
                                callback(KeybindValue)
                            elseif tostring(value) == "Always" then
                                KeybindValue = value
                                callback(KeybindValue)
                            end
                            KeybindButton.Text =
                                tostring(value):gsub("Enum.KeyCode.", ""):gsub("Enum.UserInputType.", ""):gsub(
                                "Button",
                                ""
                            )
                        end

                        function _Keybind:GetValue()
                            return KeybindValue
                        end

                        return _Keybind
                    end

                    function _MenuButton:AddButton(name, callback)
                        local _Button = {}

                        local FrameButton_ = Instance.new("Frame")
                        FrameButton_.BackgroundTransparency = 1
                        FrameButton_.Size = UDim2.new(0, 60, 0, 16)
                        FrameButton_.Parent = ButtonMenu
                        local ButtonInstance = Instance.new("TextButton")

                        ButtonInstance.Name = "Button"
                        ButtonInstance.Parent = FrameButton_
                        ButtonInstance.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                        ButtonInstance.BorderSizePixel = 0
                        ButtonInstance.Size = UDim2.new(0, 50, 0, 16)
                        ButtonInstance.Position = UDim2.new(0, 2, 0, 2)
                        ButtonInstance.AutoButtonColor = false
                        ButtonInstance.Font = Enum.Font.Nunito
                        ButtonInstance.Text = name
                        ButtonInstance.TextColor3 = Color3.fromRGB(225, 225, 225)
                        ButtonInstance.TextSize = 16.000
                        ButtonInstance:GetPropertyChangedSignal("TextBounds"):Connect(
                            function()
                                ButtonInstance.Size = UDim2.new(0, ButtonInstance.TextBounds.X + 10, 0, 16)
                            end
                        )
                        task.wait()
                        ButtonInstance.Size = UDim2.new(0, ButtonInstance.TextBounds.X + 10, 0, 16)

                        local ButtonConnection
                        ButtonConnection =
                            ButtonInstance.MouseButton1Down:Connect(
                            function()
                                callback()
                            end
                        )

                        return _Button
                    end

                    return _MenuButton
                end

                return GroupBox
            end

            return TabInTab
        end

        return Tab
    end

    return Win
end

return Lib, IonLib
