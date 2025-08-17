local talkaction = TalkAction("/statetax")

function talkaction.onSay(player, words, param)
    if not player:isGovernor() then
        player:sendCancelMessage("Only a governor can set the state tax.")
        return false
    end

    local rate = tonumber(param)
    if not rate then
        player:sendCancelMessage("Usage: /statetax <0-10>")
        return false
    end

    rate = math.max(0, math.min(10, math.floor(rate)))
    local kingdom = player:getKingdom()

    db.query(string.format(
        "UPDATE economy_tariffs SET rate=%d, set_by=%d, updated_at=NOW() WHERE scope='KINGDOM' AND kingdom_id=%d",
        rate, player:getGuid(), kingdom
    ))

    -- mensagem verde padrão, segura
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("State tax set to %d%%.", rate))
    return false
end

talkaction:separator(" ")
talkaction:groupType("normal")
talkaction:register()
