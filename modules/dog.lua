local http = require("coro-http")
local json = require("json")
local discordia = require('discordia')
local client = discordia.Client()
local embed = require('./internal/embed.lua')

return {
    name = "Dog",
    info = "Shows you a random dog!",
    usage = "dog",
    fn = function(msg)
        coroutine.wrap(function()
            local res, body = http.request('GET', "https://random.dog/woof.json")
            local dog = json.parse(body).url
            msg.channel:send(embed.load(msg, "Here's your random dog!", dog, 0x00FF00, nil, nil, nil, nil, nil, dog))
            --msg.channel:send {file = "./test.txt"}
        end)()
    end
}