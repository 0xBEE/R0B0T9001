local discordia = require('discordia')
local client = discordia.Client()
local embed = require('./internal/embed.lua')

return {
    name = "8Ball",
    info = "Ask the 8ball any question and it shall answer!",
    usage = "8ball [question]",
    fn = function(msg)
        local question = msg.cleanContent:match("%S+%s+(.+)"):gsub('```\n?', '')
        local answers = {
            "It is certain",
            "It is decidedly so",
            "Cannot predict now",
            "Don't count on it",
            "My sources say no",
            "Outlook not so good",
            "Signs point to yes",
            "You are in grave danger"
        }
        msg.channel:send(embed.load(msg, msg.author.username.." asked:", question, 0x000000, "The 8ball has responded...", answers[math.random(#answers)], "8Ball", "http://www.mystic8ball.com/img/ajax-8ball.gif"))
    end
}