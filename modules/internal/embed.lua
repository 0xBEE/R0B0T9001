local discordia = require('discordia')
local client = discordia.Client()
local module = {}

function module.load(msg, f1_title, f1_val, color, f2_title, f2_val, author_name, icon, thumbnail_url, image_url)
    result = {
        embed = {
            author = {
                name = author_name or nil,
                icon_url = icon or nil
            },
            fields = {
                {
                    name = tostring(f1_title),
                    value = tostring(f1_val),
                    inline = false
                },
            },
            thumbnail = {
                url = thumbnail_url or nil
            },
            image = {
                url = image_url or nil
            },
            footer = {
                text = msg.author.tag,
                icon_url = msg.author.avatarURL
            },
            color = color,
            timestamp = discordia.Date():toISO('T', 'Z')
        }
    }
    if f2_title ~= nil then table.insert(result.embed.fields, {name = tostring(f2_title), value = tostring(f2_val), inline = false}) end
    return result
end

return module