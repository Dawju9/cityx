Config = require(script.Parent.Parent.Parent.Parent.Parent.CustomLabel)
CustomLabel = Config["CUSTOMFLOORLABEL"][tonumber(script.Parent.Parent.Name)]
script.Parent.SurfaceGui.Frame.TextLabel.Text = CustomLabel or script.Parent.Parent.Name