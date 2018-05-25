class CfgVehicles {
    class EventHandlers;
    class Car_F;

    class Offroad_01_base_F: Car_F {
        orbis_towBarAngle = -1;
        orbis_towBarPosRel[] = {-0.042, 4.98, -0.88};
        orbis_towBarCheckStart[] = {-0.3, 7.46, -0.87};
        orbis_towBarCheckEnd[] = {0.22, 7.46, -0.87};
        class UserActions {
            class attachTowBar {
				displayName = "Attach Towbar to Plane";
				priority = 1.5;
				radius = 2;
				position = "temp";
                showWindow = 1;
				hideOnUse = 1;
				onlyForplayer = 0;
				condition = "[this] call orbis_ground_fnc_canAttachTowingVehicle";
				statement = "[this] call orbis_ground_fnc_attachTowingVehicle";
            };
            class detachTowBar: attachTowBar {
				displayName = "Attach Towbar to Plane";
				condition = "[this] call orbis_ground_fnc_canDetachTowingVehicle";
				statement = "[this] call orbis_ground_fnc_detachTowingVehicle";
            };
			/* class beacons_start {
				condition = "driver this == player AND {this animationPhase 'hidePolice' < 0.5 OR this animationPhase 'hideServices' < 0.5} AND {this animationSourcePhase 'Beacons' < 0.5}";
				statement = "this animateSource ['Beacons',1];";
			};
			class beacons_stop: beacons_start {
				condition = "driver this == player AND {this animationPhase 'hidePolice' < 0.5 OR this animationPhase 'hideServices' < 0.5} AND {this animationSourcePhase 'Beacons' > 0.5}";
				statement = "this animateSource ['Beacons',0];";
			}; */
		};
    };
    class Offroad_01_repair_base_F: Offroad_01_base_F {
        orbis_towBarAngle = -1;
        orbis_towBarPosRel[] = {-0.042, 5.10, -0.95};
        orbis_towBarCheckStart[] = {-0.3, 7.58, -0.94};
        orbis_towBarCheckEnd[] = {0.22, 7.58, -0.94};
    };
};
