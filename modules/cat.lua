local http = require("coro-http")
local json = require("json")
local discordia = require('discordia')
local client = discordia.Client()
local embed = require('./internal/embed.lua')

return {
    name = "Cat",
    info = "Shows you a random cat!",
    usage = "cat",
    fn = function(msg)
        coroutine.wrap(function()
            local res, body = http.request('GET', "http://aws.random.cat/meow")
            local cat = json.parse(body).file
            msg.channel:send(embed.load(msg, "Here's your random cat!", cat, 0x00FF00, nil, nil, nil, nil, nil, cat))
        end)()
    end
}