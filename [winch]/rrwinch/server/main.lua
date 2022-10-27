RegisterServerEvent('rrwinch:CreateRope')
RegisterServerEvent('rrwinch:RemoveRope')
RegisterServerEvent('rrwinch:LoadRopes')
RegisterServerEvent('rrwinch:UpdateRopeLength')

_g = {
    ropeList = {},
}

function IsRopeExists(netId1, netId2)
    for _, rope in pairs(_g.ropeList) do
        if (rope.netId1 == netId1 and rope.netId2 == netId2) or (rope.netId1 == netId2 and rope.netId2 == netId1) then
            return true
        end
    end
    return false
end

AddEventHandler('rrwinch:CreateRope', function(netId1, netId2)
    if not IsRopeExists(netId1, netId2) then
        table.insert(_g.ropeList, {
            netId1 = netId1,
            netId2 = netId2,
        })
        TriggerClientEvent("rrwinch:CreateRope", -1, netId1, netId2)
    end
end)

AddEventHandler('rrwinch:RemoveRope', function(netId1, netId2)
    for k,v in pairs(_g.ropeList) do
        if v.netId1 == netId1 and v.netId2 == netId2 then
            table.remove(_g.ropeList, k)
            TriggerClientEvent("rrwinch:RemoveRope", -1, netId1, netId2)
            break
        end
    end
end)

AddEventHandler('rrwinch:UpdateRopeLength', function(netId1, netId2, length)
    for k, v in pairs(_g.ropeList) do
        if v.netId1 == netId1 and v.netId2 == netId2 then
            _g.ropeList[k].length = length
            TriggerClientEvent("rrwinch:UpdateRopeLength", -1, netId1, netId2, length)
            break
        end
    end
end)

AddEventHandler('rrwinch:LoadRopes', function()
    TriggerClientEvent("rrwinch:LoadRopes", -1, _g.ropeList)
end)
