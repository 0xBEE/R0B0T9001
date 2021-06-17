local http = require("coro-http")
local json = require("json")
local discordia = require('discordia')
local client = discordia.Client()
local embed = require('./internal/embed.lua')

return {
    name = "Cowsay",
    info = "Makes an ASCII cow say whatever you want.",
    usage = "cowsay [text]",
    fn = function(msg)
        coroutine.wrap(function()
            local input = msg.cleanContent:match("%S+%s+(.+)"):gsub('```\n?', '')
            res, body = http.request('GET', "http://cowsay.morecode.org/say?message="..input.."&format=text")
            msg.channel:send(embed.load(msg, "Cowsay", "```"..body.."```", 0x00FF00))
        end)()
    end
}