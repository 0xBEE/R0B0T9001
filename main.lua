-- Run with "luvit"
local module_dir = "./modules/"
local private_module_dir = module_dir.."private/"
local settings = require('./settings.lua')
local prefix = settings.prefix
_G.modules = {}
_G.private_modules = {}
local fs = require("fs")
local discordia = require('discordia')
local client = discordia.Client()

client:on('ready', function()
    print(client.user.username.." is up and running! The current prefix is: "..prefix)
    client:setGame("with humans!")
end)

function loadModules(dir, table)
    for i,v in fs.scandirSync(dir) do
        local filename = i:match("(%S+).lua")
        if v == "file" then
            local module = require(dir..i)
            table[module.name:lower()] = module
            print("Loaded command: "..filename)
        end
    end
end

loadModules(module_dir, modules)
loadModules(private_module_dir, private_modules)

function runCommand(cmd, msg, priv)
    local tbl
    if priv == true then
        tbl = private_modules
    else
        tbl = modules
    end

    for k,v in pairs(tbl) do
        if v.name:lower() == cmd:lower() then
            if msg ~= nil then
                return v.fn(msg)
            else
                return v.fn()
            end
        end
    end
end

client:on("messageCreate", function(msg)
    if msg.content:sub(1,#prefix) == prefix and msg.guild and not msg.author.bot then
        for k,v in pairs(modules) do
            for char in msg.content:lower():gmatch(v.name:lower()) do
                pcall(function() runCommand(v.name, msg, false) end)
            end
        end
        for k,v in pairs(private_modules) do
            if msg.author == client.owner then
                for char in msg.content:lower():gmatch(v.name:lower()) do
                    pcall(function() runCommand(v.name, msg, true) end)
                end
            end
        end
    end
end)

client:run("Bot "..settings.token)
