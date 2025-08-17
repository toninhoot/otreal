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

    rate = math.max(0, math.min(15, math.floor(rate)))
    db.query(string.format(
        "UPDATE economy_tariffs SET rate=%d, set_by=%d, updated_at=NOW() WHERE scope='FEDERAL'",
        rate, player:getGuid())
    )

    -- igual ao exemplo do VIP: mensagem verde segura
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Federal tax set to %d%%.", rate))
    return false
end

talkaction:separator(" ")
talkaction:groupType("normal")
talkaction:register()
