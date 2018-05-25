class CfgVehicles {
    class EventHandlers;
    class Car_F;
    class Offroad_01_base_F: Car_F {
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
};
