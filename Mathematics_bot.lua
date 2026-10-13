local http = game:GetService("HttpService")
local tcs = game:GetService("TextChatService")
local ts = game:GetService("TeleportService")

tcs.TextChannels.RBXGeneral:SendAsync("Hello! I am a mathematics bot. Use the `!calculate` command followed by an expression. I will attempt to solve it! 🤓")
tcs.TextChannels.RBXGeneral:SendAsync("Use an asterisk for multiplication, a slash for division, a dash for subtraction and a plus for addition. Here is an example:")
tcs.TextChannels.RBXGeneral:SendAsync("!calculate 2+4-7*3/2")

local disconnect_timer = 0

tcs.MessageReceived:Connect(function(message)
	if string.lower(message.Text):sub(1, 10) == "!calculate"then
		local expression = string.match(message.Text, "^%s*.-%s+(.*)$")
		
		local request = request({
			Url = "http://api.mathjs.org/v4/?expr=" .. http:UrlEncode(expression),
			Method = "GET",
		})

		tcs.TextChannels.RBXGeneral:SendAsync(request.Body)
	end
end)

task.spawn(function()
	while task.wait() do
		if disconnect_timer == 170 then
			tcs.TextChannels.RBXGeneral:SendAsync("Thank you for using the bot! Switching servers...")
			queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/watering-can/Roblox_scripts/refs/heads/main/Mathematics_bot.lua'))()")
		end

		if disconnect_timer == 180 then
			ts:TeleportAsync(game.PlaceId, game.Players.LocalPlayer)
		end
	end
end)
