		class ACE_SelfActions {
			class orbisGPWSmodes {
				displayName = "GPWS Modes";
				condition = "(_target getVariable ['orbisGPWSenabled', false]) && (_player isEqualTo driver _target)";
				statement = "";
				showDisabled = 0;
				priority = 0.5;
				icon = "";

				class turnOff {
					displayName = "Turn off GPWS";
					condition = "(_target getVariable ['orbisGPWSenabled', false]) && (_player isEqualTo driver _target) && (_target getVariable ['orbisGPWSmode', ''] != '')";
					statement = "_target setVariable ['orbisGPWSmode', '']";
					showDisabled = 0;
					priority = 1;
					icon = "";
				};
				class f16: turnOff {
					displayName = "Set to Betty (F-16)";
					condition = "(_target getVariable ['orbisGPWSenabled', false]) && (_player isEqualTo driver _target) && (_target getVariable ['orbisGPWSmode', ''] != 'f16')";
					statement = "[_this select 0] spawn orbis_gpws_fnc_f16GPWS";
					priority = 0.5;
				};
				/* class b747: turnOff {
					displayName = "Set to B747 GPWS";
					condition = "(_target getVariable ['orbisGPWSenabled', false]) && (_player isEqualTo driver _target) && (_target getVariable ['orbisGPWSmode', ''] != 'b747')";
					statement = "[_this select 0] spawn orbis_gpws_fnc_b747GPWS";
					priority = 0.5;
				}; */
			};
		};