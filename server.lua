RegisterNetEvent("rumori_sospetti:playSound", function(sound)
    local src = source
    TriggerClientEvent("rumori_sospetti:play3DSound", src, sound)
end)
