local GetName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)

script.Parent.Text = GetName.Name