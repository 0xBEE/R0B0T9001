local discordia = require('discordia')
local client = discordia.Client()
local settings = require('../settings.lua')
local help = ""

return {
    name = "Help",
    info = "Shows the list of commands.",
    usage = "help",
    fn = function(msg)
        for k,v in pairs(modules) do
            help = help.."```"..settings.prefix..v.usage.." - "..v.info.."```"
        end
        msg.author:send {
			embed = {
                description = tostring(help),
				author = {
					name = "Commands",
					icon_url = "https://camo.githubusercontent.com/7dad69571d36ad76489ac2c237adce95118ebc10/68747470733a2f2f7468696261756c746a616e62657965722e6769746875622e696f2f4472616753656c6563742f747970657772697465722e676966"
                },
				footer = {
                    text = msg.author.tag,
                    icon_url = msg.author.avatarURL
				},
                color = 0x000000,
                timestamp = discordia.Date():toISO('T', 'Z')
			}
		} 
    end
}