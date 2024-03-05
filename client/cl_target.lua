CreateThread(function(data)
    exports['qb-target']:AddCircleZone("VehiclePed", vector3(109.9739, -1088.61, 28.302), 0.4, { 
        name = "vehicleped", 
        debugPoly = false,
      }, {
        options = {
            {
                type = "client",
                event = "qb-rental:client:LicenseCheck",
                icon = "fas fa-car",
                label = "Rent Vehicle",
                LicenseType = "driver",
                MenuType = "vehicle",
            },
        },
        distance = 3.0
      })
    
    exports['qb-target']:AddCircleZone("AircraftPed", vector3(-1686.57, -3149.22, 12.99), 0.4, { 
        name = "aircraftped", 
        debugPoly = false,
      }, {
        options = {
            {
                type = "client",
                event = "qb-rental:client:LicenseCheck",
                icon = "fas fa-car",
                label = "Rent Airplane",
                LicenseType = "pilot",
                MenuType = "aircraft",
            },
        },
        distance = 3.0
        })

    exports['qb-target']:AddCircleZone("BoatPed", vector3(-753.5, -1512.27, 4.02), 0.4, { 
        name = "boatped", 
        debugPoly = false,
        }, {
        options = {
            {
                type = "client",
                event = "qb-rental:client:openMenu",
                icon = "fas fa-car",
                label = "Rent Boat",
                MenuType = "boat"
            },
        },
        distance = 3.0
        })

    exports['qb-target']:AddCircleZone("HeliPed", vector3(-700.05, -1401.57, 4.5), 0.4, { 
        name = "heliped", 
        debugPoly = false,
        }, {
        options = {
            {
                type = "client",
                event = "qb-rental:client:openMenu",
                icon = "fas fa-car",
                label = "Rent Helicopter",
                MenuType = "heli"
            },
        },
        distance = 3.0
        })

    exports['qb-target']:AddCircleZone("BikePed", vector3(-1670.06, -997.84, 6.39), 0.4, { 
        name = "bikeped", 
        debugPoly = false,
        }, {
        options = {
            {
                type = "client",
                event = "qb-rental:client:openMenu",
                icon = "fas fa-car",
                label = "Rent Bike",
                MenuType = "bike"
            },
        },
        distance = 3.0
        })
end)
