local QBCore = exports['qb-core']:GetCoreObject()
local SpawnVehicle = false

-- Vehicle Rentals

local comma_value = function(n) -- credit http://richard.warburton.it
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

RegisterNetEvent('qb-rental:client:LicenseCheck', function(data)
    license = data.LicenseType
    if license == "driver" then
        QBCore.Functions.TriggerCallback("qb-rentals:server:getDriverLicenseStatus", function(hasLicense)
            if hasLicense  then
                TriggerEvent('qb-rental:client:openMenu', data)
                MenuType = "vehicle"
            else
                QBCore.Functions.Notify(Lang:t("error.no_driver_license"), "error", 4500)
            end
        end)
    elseif license == "pilot" then
        QBCore.Functions.TriggerCallback("qb-rentals:server:getPilotLicenseStatus", function(hasLicense)
            if hasLicense  then
                TriggerEvent('qb-rental:client:openMenu', data)
                MenuType = "aircraft, heli"
            else
                QBCore.Functions.Notify(Lang:t("error.no_pilot_license"), "error", 4500)
            end
        end)
    end
end)

RegisterNetEvent('qb-rental:client:openMenu', function(data)
    menu = data.MenuType

    local vehMenu = {
        [1] = {
            header = "Rental Vehicles",
            isMenuHeader = true,
        },
    
        [2] = {
            id = 1,
            header = "Return Vehicle ",
            txt = Lang:t("task.return_veh"),
            params = {
                event = "qb-rental:client:return",
            }
        }
    }
    
    if menu == "vehicle" then
        for k=1, #Config.Vehicles.land do
            local veh = QBCore.Shared.Vehicles[Config.Vehicles.land[k].model]
            local name = veh and ('%s %s'):format(veh.brand, veh.name) or Config.Vehicles.land[k].model:sub(1,1):upper()..Config.Vehicles.land[k].model:sub(2)
            vehMenu[#vehMenu+1] = {
                id = k+1,
                header = name,
                txt = ("$%s"):format(comma_value(Config.Vehicles.land[k].money)),
                params = {
                    event = "qb-rental:client:spawncar",
                    args = {
                        model = Config.Vehicles.land[k].model,
                        money = Config.Vehicles.land[k].money,
                    }
                }
            }
        end
    elseif menu == "aircraft" then
        for k=1, #Config.Vehicles.air do
            local veh = QBCore.Shared.Vehicles[Config.Vehicles.air[k].model]
            local name = veh and ('%s'):format(veh.name) or Config.Vehicles.air[k].model:sub(1,1):upper()..Config.Vehicles.air[k].model:sub(2)
            vehMenu[#vehMenu+1] = {
                id = k+1,
                header = name,
                txt = ("$%s"):format(comma_value(Config.Vehicles.air[k].money)),
                params = {
                    event = "qb-rental:client:spawncar",
                    args = {
                        model = Config.Vehicles.air[k].model,
                        money = Config.Vehicles.air[k].money,
                    }
                }
            }
            exports['qb-menu']:openMenu(vehMenu)
        end
    elseif menu == "boat" then
        for k=1, #Config.Vehicles.sea do
            local veh = QBCore.Shared.Vehicles[Config.Vehicles.sea[k].model]
            local name = veh and ('%s %s'):format(veh.brand, veh.name) or Config.Vehicles.sea[k].model:sub(1,1):upper()..Config.Vehicles.sea[k].model:sub(2)
            vehMenu[#vehMenu+1] = {
                id = k+1,
                header = name,
                txt = ("$%s"):format(comma_value(Config.Vehicles.sea[k].money)),
                params = {
                    event = "qb-rental:client:spawncar",
                    args = {
                        model = Config.Vehicles.sea[k].model,
                        money = Config.Vehicles.sea[k].money,
                    }
                }
            }
        end
    elseif menu == "heli" then
        for k=1, #Config.Vehicles.heli do
            local veh = QBCore.Shared.Vehicles[Config.Vehicles.heli[k].model]
            local name = veh and ('%s %s'):format(veh.brand, veh.name) or Config.Vehicles.heli[k].model:sub(1,1):upper()..Config.Vehicles.heli[k].model:sub(2)
            vehMenu[#vehMenu+1] = {
                id = k+1,
                header = name,
                txt = ("$%s"):format(comma_value(Config.Vehicles.heli[k].money)),
                params = {
                    event = "qb-rental:client:spawncar",
                    args = {
                        model = Config.Vehicles.heli[k].model,
                        money = Config.Vehicles.heli[k].money,
                    }
                }
            }
        end
    elseif menu == "bike" then
        for k=1, #Config.Vehicles.bike do
            local veh = QBCore.Shared.Vehicles[Config.Vehicles.bike[k].model]
            local name = veh and ('%s %s'):format(veh.brand, veh.name) or Config.Vehicles.bike[k].model:sub(1,1):upper()..Config.Vehicles.bike[k].model:sub(2)
            vehMenu[#vehMenu+1] = {
                id = k+1,
                header = name,
                txt = ("$%s"):format(comma_value(Config.Vehicles.bike[k].money)),
                params = {
                    event = "qb-rental:client:spawncar",
                    args = {
                        model = Config.Vehicles.bike[k].model,
                        money = Config.Vehicles.bike[k].money,
                    }
                }
            }
        end
    end
    exports['qb-menu']:openMenu(vehMenu)
end)

local CreateNPC = function()
    -- Vehicle Rentals
    created_ped = CreatePed(5, Config.Locations.vehicle.pedhash, Config.Locations.vehicle.coords.x, Config.Locations.vehicle.coords.y, Config.Locations.vehicle.coords.z, Config.Locations.vehicle.coords.w, false, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    TaskStartScenarioInPlace(created_ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)

    -- Aircraft Rentals
    created_ped = CreatePed(5, Config.Locations.aircraft.pedhash, Config.Locations.aircraft.coords.x, Config.Locations.aircraft.coords.y, Config.Locations.aircraft.coords.z, Config.Locations.aircraft.coords.w, false, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    TaskStartScenarioInPlace(created_ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)

    -- Boat Rentals
    created_ped = CreatePed(5, Config.Locations.boat.pedhash, Config.Locations.boat.coords.x, Config.Locations.boat.coords.y, Config.Locations.boat.coords.z, Config.Locations.boat.coords.w, false, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    TaskStartScenarioInPlace(created_ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)

    -- Heli Rentals
    created_ped = CreatePed(5, Config.Locations.heli.pedhash, Config.Locations.heli.coords.x, Config.Locations.heli.coords.y, Config.Locations.heli.coords.z, Config.Locations.heli.coords.w, false, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    TaskStartScenarioInPlace(created_ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)

    -- Bike Rentals
    created_ped = CreatePed(5, Config.Locations.bike.pedhash, Config.Locations.bike.coords.x, Config.Locations.bike.coords.y, Config.Locations.bike.coords.z, Config.Locations.bike.coords.w, false, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    TaskStartScenarioInPlace(created_ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)
end

local SpawnNPC = function()
    CreateThread(function()
        -- Vehicle Rentals
        RequestModel(Config.Locations.vehicle.pedhash)
        while not HasModelLoaded(Config.Locations.vehicle.pedhash) do
            Wait(1)
        end
        -- Aircraft Rentals
        RequestModel(Config.Locations.aircraft.pedhash)
        while not HasModelLoaded(Config.Locations.aircraft.pedhash) do
            Wait(1)
        end
        -- Boat Rentals
        RequestModel(Config.Locations.boat.pedhash)
        while not HasModelLoaded(Config.Locations.boat.pedhash) do
            Wait(1)
        end
        -- Heli Rentals
        RequestModel(Config.Locations.heli.pedhash)
        while not HasModelLoaded(Config.Locations.heli.pedhash) do
            Wait(1)
        end
        -- Bike Rentals
        RequestModel(Config.Locations.bike.pedhash)
        while not HasModelLoaded(Config.Locations.bike.pedhash) do
            Wait(1)
        end
        CreateNPC() 
    end)
end

CreateThread(function()
    SpawnNPC()
end)

RegisterNetEvent('qb-rental:client:spawncar', function(data)
    local player = PlayerPedId()
    local money = data.money
    local model = data.model
    local label = Lang:t("error.not_enough_space", {vehicle = menu:sub(1,1):upper()..menu:sub(2)})
    if menu == "vehicle" then
        if IsAnyVehicleNearPoint(Config.Locations.vehicle.spawnpoint.x, Config.Locations.vehicle.spawnpoint.y, Config.Locations.vehicle.spawnpoint.z, 2.0) then
            QBCore.Functions.Notify(label, "error", 4500)
            return
        end
    elseif menu == "aircraft" then
        if IsAnyVehicleNearPoint(Config.Locations.aircraft.spawnpoint.x, Config.Locations.aircraft.spawnpoint.y, Config.Locations.aircraft.spawnpoint.z, 15.0) then 
            QBCore.Functions.Notify(label, "error", 4500)
            return
        end 
    elseif menu == "boat" then
        if IsAnyVehicleNearPoint(Config.Locations.boat.spawnpoint.x, Config.Locations.boat.spawnpoint.y, Config.Locations.boat.spawnpoint.z, 10.0) then 
            QBCore.Functions.Notify(label, "error", 4500)
            return
        end  
    elseif menu == "heli" then
        if IsAnyVehicleNearPoint(Config.Locations.heli.spawnpoint.x, Config.Locations.heli.spawnpoint.y, Config.Locations.heli.spawnpoint.z, 10.0) then 
            QBCore.Functions.Notify(label, "error", 4500)
            return
        end  
    elseif menu == "bike" then
        if IsAnyVehicleNearPoint(Config.Locations.bike.spawnpoint.x, Config.Locations.bike.spawnpoint.y, Config.Locations.bike.spawnpoint.z, 10.0) then 
            QBCore.Functions.Notify(label, "error", 4500)
            return
        end  
    end

    QBCore.Functions.TriggerCallback("qb-rental:server:CashCheck",function(money)
        if money then
            if menu == "vehicle" then
                QBCore.Functions.SpawnVehicle(model, function(vehicle)
                    SetEntityHeading(vehicle, Config.Locations.vehicle.spawnpoint.w)
                    TaskWarpPedIntoVehicle(player, vehicle, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                    SetVehicleEngineOn(vehicle, true, true)
                    SetVehicleDirtLevel(vehicle, 0.0)
                    exports[Config.FuelExport]:SetFuel(vehicle, 100)
                    SpawnVehicle = true
                    print()
                end, Config.Locations.vehicle.spawnpoint, true)
            elseif menu == "aircraft" then
                QBCore.Functions.SpawnVehicle(model, function(vehicle)
                    SetEntityHeading(vehicle, Config.Locations.aircraft.spawnpoint.w)
                    TaskWarpPedIntoVehicle(player, vehicle, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                    SetVehicleEngineOn(vehicle, true, true)
                    SetVehicleDirtLevel(vehicle, 0.0)
                    exports[Config.FuelExport]:SetFuel(vehicle, 100)
                    SpawnVehicle = true
                end, Config.Locations.aircraft.spawnpoint, true)
            elseif menu == "boat" then
                QBCore.Functions.SpawnVehicle(model, function(vehicle)
                    SetEntityHeading(vehicle, Config.Locations.boat.spawnpoint.w)
                    TaskWarpPedIntoVehicle(player, vehicle, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                    SetVehicleEngineOn(vehicle, true, true)
                    SetVehicleDirtLevel(vehicle, 0.0)
                    exports[Config.FuelExport]:SetFuel(vehicle, 100)
                    SpawnVehicle = true
                end, Config.Locations.boat.spawnpoint, true)
            elseif menu == "heli" then
                QBCore.Functions.SpawnVehicle(model, function(vehicle)
                    SetEntityHeading(vehicle, Config.Locations.heli.spawnpoint.w)
                    TaskWarpPedIntoVehicle(player, vehicle, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                    SetVehicleEngineOn(vehicle, true, true)
                    SetVehicleDirtLevel(vehicle, 0.0)
                    exports[Config.FuelExport]:SetFuel(vehicle, 100)
                    SpawnVehicle = true
                end, Config.Locations.heli.spawnpoint, true)
            elseif menu == "bike" then
                QBCore.Functions.SpawnVehicle(model, function(vehicle)
                    SetEntityHeading(vehicle, Config.Locations.bike.spawnpoint.w)
                    TaskWarpPedIntoVehicle(player, vehicle, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                    SetVehicleEngineOn(vehicle, true, true)
                    SetVehicleDirtLevel(vehicle, 0.0)
                    exports[Config.FuelExport]:SetFuel(vehicle, 100)
                    SpawnVehicle = true
                end, Config.Locations.bike.spawnpoint, true)
            end 
            Wait(1000)
            local vehicle = GetVehiclePedIsIn(player, false)
            local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            vehicleLabel = GetLabelText(vehicleLabel)
            local plate = GetVehicleNumberPlateText(vehicle)
            TriggerServerEvent('qb-rental:server:rentalpapers', plate, vehicleLabel)
        else
            QBCore.Functions.Notify(Lang:t("error.not_enough_money"), "error", 4500)
        end
    end, money)
end)

RegisterNetEvent('qb-rental:client:return', function()
    if SpawnVehicle then
        local Player = QBCore.Functions.GetPlayerData()
        QBCore.Functions.Notify(Lang:t("task.veh_returned"), 'success')
        TriggerServerEvent('qb-rental:server:removepapers')
        local car = GetVehiclePedIsIn(PlayerPedId(),true)
        NetworkFadeOutEntity(car, true,false)
        Citizen.Wait(2000)
        QBCore.Functions.DeleteVehicle(car)
    else 
        QBCore.Functions.Notify(Lang:t("error.no_vehicle"), "error")
    end
    SpawnVehicle = false
end)

Citizen.CreateThread(function()
    for _, info in pairs(Config.Blips) do
    info.blip = AddBlipForCoord(info.x, info.y, info.z)
    SetBlipSprite(info.blip, info.id)
    SetBlipDisplay(info.blip, 4)
    SetBlipScale(info.blip, 0.65)
    SetBlipColour(info.blip, info.colour)
    SetBlipAsShortRange(info.blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.title)
    EndTextCommandSetBlipName(info.blip)
    end
end)
