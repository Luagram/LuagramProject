
-------------------------------------------------------------------
-------------------------------------------------------------------
TDbot = require('tdLua')
-------------------------------------------------------------------
-------------------------------------------------------------------
Token = '5285243942:AAHxbs5X7Fkz0Tctvvl_tG1v2aWvjdp_ew4'
bot_id = 5285243942
bot = TDbot.set_config{
api_id=16097628,
api_hash='d21f327886534832fdf728117ac7b809',
session_name=bot_id,
token=Token
}
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
function Bot(msg)  
local idbot = false  
if tonumber(msg.sender_id.user_id) == tonumber(bot_id) then  
idbot = true    
end  
return idbot  
end
----------------------------------------------------------------------------------------------------
function Call(data)
if data then
print(serpent.block(data, {comment=false}))   
end
if data and data.tdLua and data.tdLua == "updateChatMember" then
print(data.tdLua)
elseif data and data.tdLua and data.tdLua == "updateSupergroup" then
print(data.tdLua)
elseif data and data.tdLua and data.tdLua == "updateNewMessage" then
if data.message.sender_id.tdLua == "messageSenderChat" then
bot.deleteMessages(data.message.chat_id,{[1]= data.message.id})
return false
end
print(data.tdLua)
Run(data.message,data)
elseif data and data.tdLua and data.tdLua == "updateMessageEdited" then
local msg = bot.getMessage(data.chat_id, data.message_id)
if tonumber(msg.sender_id.user_id) ~= tonumber(bot_id) then  
print(data.tdLua)
end
elseif data and data.tdLua and data.tdLua == "updateNewCallbackQuery" then
print(data.tdLua)
Callback(data)
elseif data and data.tdLua and data.tdLua == "updateMessageSendSucceeded" then
print(data.tdLua)
end
----------------------------------------------------------------------------------------------------
end
TDbot.run(Call)