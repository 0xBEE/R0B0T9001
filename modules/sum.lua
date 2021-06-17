local discordia = require('discordia')
local client = discordia.Client()
local embed = require('./internal/embed.lua')

return {
    name = "Sum",
    info = "Sums up the two numbers indicated.",
    usage = "sum [number] [number]",
    fn = function(msg)
        local num1, num2 = msg.cleanContent:match("%S+%s+(%d+)%s+(%d+)"):gsub('```\n?', '') -- This regex (or whatever you wanna call it) is so messy...
        msg.channel:send(embed.load(msg, "Result", num1.." + "..num2.." = "..num1+num2, 0x00FF00))
    end
}