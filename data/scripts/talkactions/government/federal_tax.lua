local talkaction = TalkAction("/federaltax")

function talkaction.onSay(player, words, param)
    if not player:isPresident() then
        player:sendCancelMessage("Only the president can set the federal tax.")
        return false
    end
    local rate = tonumber(param)
    if not rate then
        player:sendCancelMessage("Usage: /federaltax <0-15>")
        return false
    end
    rate = math.floor(rate)
    if rate < 0 then
        rate = 0
    elseif rate > 15 then
        rate = 15
    end
    db.query(string.format("UPDATE economy_tariffs SET rate=%d, set_by=%d, updated_at=NOW() WHERE scope='FEDERAL'", rate, player:getGuid()))
    player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Federal tax set to %d%%.", rate))
    return false
end

talkaction:separator(" ")
talkaction:groupType("normal")
talkaction:register()
