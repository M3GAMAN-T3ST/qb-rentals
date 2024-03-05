Config = {}

Config.FuelExport = 'LegacyFuel'

Config.Locations = {
    vehicle = {
        coords = vector4(109.9739, -1088.61, 28.302, 345.64),
        pedhash = `a_m_y_business_03`,
        spawnpoint = vector4(111.4223, -1081.24, 29.192, 340.0),
    },

    aircraft = {
        coords = vector4(-1686.57, -3149.22, 12.99, 240.88),
        pedhash = `s_m_y_airworker`,
        spawnpoint = vector4(-1647.68, -3130.36, 13.99, 329.89),
    },

    boat = {
        coords = vector4(-753.5, -1512.27, 4.02, 25.61),
        pedhash = `mp_m_boatstaff_01`,
        spawnpoint = vector4(-794.95, -1506.27, 1.08, 107.79),
    },

    heli = {
        coords = vector4(-700.05, -1401.57, 4.5, 125.86),
        pedhash = `s_m_y_airworker`,
        spawnpoint = vector4(-700.73, -1447.19, 5.0, 51.1),
    },

    bike = {
        coords = vector4(-1670.06, -997.84, 6.39, 90.26),
        pedhash = `a_m_y_roadcyc_01`,
        spawnpoint = vector4(-1674.99, -1000.22, 7.38, 117.93),
    },
}

Config.Blips = {
    {title= Lang:t("info.land_veh"), colour= 50, id= 56, x= 111.0112, y= -1088.67, z= 29.302},
    {title= Lang:t("info.air_veh"), colour= 50, id= 578, x= -1673.39, y= -3158.45, z= 13.99},
    {title= Lang:t("info.sea_veh"), colour= 50, id= 410, x= -753.55, y= -1512.24, z= 5.02},
    {title= Lang:t("info.heli_veh"), colour= 50, id= 43, x= -700.05, y= -1401.57, z= 4.5},
    {title= Lang:t("info.bike_veh"), colour= 50, id= 559, x= -1670.06, y= -997.84, z= 6.39},
}

Config.Vehicles = {
    land = {
        [1] = {
            model = 'futo',
            money = 1200,
        },
        [2] = {
            model = 'bison',
            money = 1600,
        },
        [3] = {
            model = 'bjxl',
            money = 2000,
        },
    },
    air = {
        [1] = {
            model = 'mammatus',
            money = 7500,
        },
        [2] = {
            model = 'vestra',
            money = 9500,
        },
        [3] = {
            model = 'velum',
            money = 11000,
        },
    },
    sea = {
        [1] = {
            model = 'seashark3',
            money = 5000,
        },
        [2] = {
            model = 'dinghy3',
            money = 7500,
        },
        [3] = {
            model = 'longfin',
            money = 11000,
        },
    },
    heli = {
        [1] = {
            model = 'seasparrow',
            money = 5000,
        },
        [2] = {
            model = 'frogger2',
            money = 7500,
        },
        [3] = {
            model = 'swift',
            money = 11000,
        },
    },
    bike = {
        [1] = {
            model = 'bmx',
            money = 300,
        },
        [2] = {
            model = 'sanchez',
            money = 600,
        },
        [3] = {
            model = 'blazer',
            money = 800,
        },
    }
}
