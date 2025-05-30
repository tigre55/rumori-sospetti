local zones = {
    {
        name = "casa_abbandonata",
        coords = vector3(1850.5, 3690.0, 34.2),
        radius = 30.0
    },
    {
        name = "fabbrica_vecchia",
        coords = vector3(2715.0, 1350.0, 24.0),
        radius = 40.0
    }
}

local creepySounds = {
    "creepy1.ogg",
    "creaky_door.ogg",
    "whisper.ogg",
    "footsteps.ogg",
    "breathe.ogg"
}

local inZone = false

function playRandomCreepySound()
    local sound = creepySounds[math.random(#creepySounds)]
    TriggerServerEvent("rumori_sospetti:playSound", sound)
end

CreateThread(function()
    while true do
        local sleep = 2000
        local playerCoords = GetEntityCoords(PlayerPedId())

        for _, zone in pairs(zones) do
            local distance = #(playerCoords - zone.coords)
            if distance <= zone.radius then
                if not inZone then
                    inZone = true
                    print("🧠 Sei entrato nella zona misteriosa...")
                    CreateThread(function()
                        while inZone do
                            Wait(math.random(5000, 15000))
                            playRandomCreepySound()
                        end
                    end)
                end
            else
                if inZone then
                    inZone = false
                    print("👣 Sei uscito dalla zona.")
                end
            end
        end

        Wait(sleep)
    end
end)

RegisterNetEvent("rumori_sospetti:play3DSound", function(sound)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    exports.xsound:PlayUrlPos("rumore_"..math.random(1000), "nui://rumori_sospetti/html/sounds/"..sound, 0.4, coords)
end)
