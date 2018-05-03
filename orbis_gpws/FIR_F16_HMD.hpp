		class HMCS_ALL
		{
			topLeft="HUD_top_left";
			topRight="HUD_top_right";
			bottomLeft="HUD_bottom_left";
			borderLeft=0;
			borderRight=0;
			borderTop=0;
			borderBottom=0;
			color[]={0,1,0,1};

			class Bones
			{
				class Fixed_Horizon
				{
					type="fixed";
					pos[]={0.90,0.80};
				};
				class Planeori_fix
				{
					type="fixed";
					pos[]={0.5,0.5};
				};			
				class WeaponAim
				{
					type="vector";
					source="weapon";
					pos0[]={0.50,0.50};
					pos10[]={1.382,1.382};
				};
				class PlaneOrientation {
					type = "vector";
					source = "forward";
					pos[] = {0.5, 0.5};
					pos0[] = {0.5, 0.4};
					// pos10[] = {0.774, 0.77};
					pos10[] = {0, 0};				
				};						
				class RangeBone
				{
					type="linear";
					source="targetDist";
					sourceScale=1; //meters
					min=0;
					max=10000;
					minPos[]={0.8,0.40};
					maxPos[]={0.8,0.60};
				};
				class HorizonIndicatorBank
				{
					type = "rotational";
					source = "horizonBank";
					sourceScale = 1.0;
					center[] = {0.90,0.80};
					min = "-3.1415927";
					max = "3.1415927";
					minAngle = 180;
					maxAngle = -180;
					aspectRatio = 1;
				};
				class HorizonDive_Left
				{
					source = "horizonDive";
					type = "rotational";
					center[] = {0.90,0.80};
					min = "-3.14159265359 / 2";
					max = "3.14159265359 / 2";
					minAngle = 90;
					maxAngle = -90;
					aspectRatio = 1;
				};
				class HorizonDive_Right
				{
					source = "horizonDive";
					type = "rotational";
					center[] = {0.90,0.80};
					min = "-3.14159265359 / 2";
					max = "3.14159265359 / 2";
					minAngle = -90;
					maxAngle = 90;
					aspectRatio = 1;
				};
				/*class VspeedBone
				{
					type="linear";
					source="vspeed";
					sourceScale=1; // m/s
					min=-50;
					max=50;
					minPos[]={0.94,0.60};
					maxPos[]={0.94,0.60};
				};*/
			};
			class Draw
			{
				color[]={0,1,0,0.7};
				alpha = "user1";		
				condition="on";
				//------------------------------------------------------------ Speed
				class Left_box
				{
					type = "line";
					width = 3.0;
					points[] = 
					{
						{ { 0.16,0.4 },1 },
						{ { "0.16 - 0.12",0.4 },1 },
						{ { "0.16 - 0.12","0.4 + 0.06" },1 },
						{ { 0.16,"0.4 + 0.06" },1 },
						{ { 0.16,0.4 },1 }
					};
				};
				class SpeedNumber
				{
					type="text";
					align="left";
					scale=1;
					source="speed";
					width = 2.0;
					sourceScale=3.6;
					pos[]=
					{
						{0.15,0.40},
						1
					};
					right[]=
					{
						{0.20,0.40},
						1
					};
					down[]=
					{
						{0.15,0.45},
						1
					};
				};
				class MachText_Dot
				{
					type="text";
					source="static";
					text="0.";
					align="left";
					scale=1;
					pos[]=
					{
						{"0.09 + 0.0",0.48},
						1
					};
					right[]=
					{
						{"0.12 + 0.0",0.48},
						1
					};
					down[]=
					{
						{"0.09 + 0.0",0.51},
						1
					};
				};
				class MachNumber
				{
					type="text";
					align="left";
					scale=1;
					source="speed";
					sourceScale=0.0288;
					pos[]=
					{
						{"0.11 + 0.0",0.48},
						1
					};
					right[]=
					{
						{"0.14 + 0.0",0.48},
						1
					};
					down[]=
					{
						{"0.11 + 0.0",0.51},
						1
					};
				};
				class MachText_M
				{
					type="text";
					source="static";
					text="M";
					align="left";
					scale=1;
					pos[]=
					{
						{"0.14 + 0.0",0.48},
						1
					};
					right[]=
					{
						{"0.17 + 0.0",0.48},
						1
					};
					down[]=
					{
						{"0.14 + 0.0",0.51},
						1
					};
				};
				//------------------------------------------------------------ Altitude
				class Right_box
				{
					type = "line";
					width = 3.0;
					points[] = 
					{
						{ { 0.84,0.4 },1 },
						{ { "0.84 + 0.12",0.4 },1 },
						{ { "0.84 + 0.12","0.4 + 0.06" },1 },
						{ { 0.84,"0.4 + 0.06" },1 },
						{ { 0.84,0.4 },1 }
					};
				};
				class AltNumber: SpeedNumber
				{
					align="right";
					source="altitudeASL";
					sourceScale=1;
					pos[]=
					{
						{0.85,0.40},
						1
					};
					right[]=
					{
						{0.90,0.40},
						1
					};
					down[]=
					{
						{0.85,0.45},
						1
					};
				};
				class RadarAltitude_Text
				{
					type="text";
					source="static";
					text="R";
					align="right";
					scale=1;
					pos[]=
					{
						{0.85,0.48},
						1
					};
					right[]=
					{
						{0.88,0.48},
						1
					};
					down[]=
					{
						{0.85,0.51},
						1
					};
				};
				class RadarAltitude_Number
				{
					type="text";
					source="altitudeAGL";
					sourceScale=1;
					align="right";
					scale=1;
					pos[]=
					{
						{0.871,0.48},
						1
					};
					right[]=
					{
						{0.901,0.48},
						1
					};
					down[]=
					{
						{0.871,0.51},
						1
					};
				};
				//------------------------------------------------------------ Heading
				class Center_box
				{
					type = "line";
					width = 3.0;
					points[] = 
					{
						{ { 0.46			,0.89 			},1 },
						{ { "0.46 + 0.03"	,0.89 			},1 },
						{ { "0.46 + 0.04"	,"0.89 - 0.01"	},1 },
						{ { "0.46 + 0.05"	,0.89 			},1 },
						{ { "0.46 + 0.08"	,0.89 			},1 },
						{ { "0.46 + 0.08"	,"0.89 + 0.05" 	},1 },
						{ { 0.46			,"0.89 + 0.05" 	},1 },
						{ { 0.46			,0.89 			},1 }
					};
				};
				class Heading_Number: SpeedNumber
				{
					source="heading";
					sourceScale=1;
					align="center";
					pos[]=
					{
						{0.5,0.89},
						1
					};
					right[]=
					{
						{0.55,0.89},
						1
					};
					down[]=
					{
						{0.5,0.94},
						1
					};
				};
				class Heading_Scale_Top
				{
					clipTL[]={0.00,0.00};
					clipBR[]={1.00,0.89};
					type="group";
					class Heading_tape
					{
						type="scale";
						horizontal=1;
						source="heading";
						sourceScale=1;
						width=5;
						top=0.35;
						center=0.50;
						bottom=0.65;
						lineXleft="0.89 - 0.03";
						lineYright="0.89 - 0.02";
						lineXleftMajor="0.89 - 0.03";
						lineYrightMajor="0.89 - 0.01";
						majorLineEach=2;
						numberEach=2;
						step=5;
						stepSize="(0.65 - 0.35) / 5";
						align="center";
						scale=1;
						pos[]=
						{
							0.35,
							"0.0 + 0.89"
						};
						right[]=
						{
							0.38,
							"0.0 + 0.89"
						};
						down[]=
						{
							0.35,
							"0.03 + 0.89"
						};
					};
				};
				class Heading_Scale_Right
				{
					clipTL[]={"0.46 + 0.08",0.89};
					clipBR[]={1.00,"0.89 + 0.05"};
					type="group";
					class Heading_tape
					{
						type="scale";
						horizontal=1;
						source="heading";
						sourceScale=1;
						width=5;
						top=0.35;
						center=0.50;
						bottom=0.65;
						lineXleft="0.89 - 0.03";
						lineYright="0.89 - 0.02";
						lineXleftMajor="0.89 - 0.03";
						lineYrightMajor="0.89 - 0.01";
						majorLineEach=2;
						numberEach=2;
						step=5;
						stepSize="(0.65 - 0.35) / 5";
						align="center";
						scale=1;
						pos[]=
						{
							0.35,
							"0.0 + 0.89"
						};
						right[]=
						{
							0.38,
							"0.0 + 0.89"
						};
						down[]=
						{
							0.35,
							"0.03 + 0.89"
						};
					};
				};
				class Heading_Scale_Bottom
				{
					clipTL[]={0.00,"0.89 + 0.05"};
					clipBR[]={1.00,1.00};
					type="group";
					class Heading_tape
					{
						type="scale";
						horizontal=1;
						source="heading";
						sourceScale=1;
						width=5;
						top=0.35;
						center=0.50;
						bottom=0.65;
						lineXleft="0.89 - 0.03";
						lineYright="0.89 - 0.02";
						lineXleftMajor="0.89 - 0.03";
						lineYrightMajor="0.89 - 0.01";
						majorLineEach=2;
						numberEach=2;
						step=5;
						stepSize="(0.65 - 0.35) / 5";
						align="center";
						scale=1;
						pos[]=
						{
							0.35,
							"0.0 + 0.89"
						};
						right[]=
						{
							0.38,
							"0.0 + 0.89"
						};
						down[]=
						{
							0.35,
							"0.03 + 0.89"
						};
					};
				};
				class Heading_Scale_Left
				{
					clipTL[]={0.00,0.89};
					clipBR[]={0.46,"0.89 + 0.05"};
					type="group";
					class Heading_tape
					{
						type="scale";
						horizontal=1;
						source="heading";
						sourceScale=1;
						width=5;
						top=0.35;
						center=0.50;
						bottom=0.65;
						lineXleft="0.89 - 0.03";
						lineYright="0.89 - 0.02";
						lineXleftMajor="0.89 - 0.03";
						lineYrightMajor="0.89 - 0.01";
						majorLineEach=2;
						numberEach=2;
						step=5;
						stepSize="(0.65 - 0.35) / 5";
						align="center";
						scale=1;
						pos[]=
						{
							0.35,
							"0.0 + 0.89"
						};
						right[]=
						{
							0.38,
							"0.0 + 0.89"
						};
						down[]=
						{
							0.35,
							"0.03 + 0.89"
						};
					};
				};
				//------------------------------------------------------------ Miscellaneous
				class Bank_Indicator
				{
					type = "line";
					width = 4.0;
					points[] = 
					{
						/*{ "HorizonDive",{-0.046,0 },1 },
						{ "HorizonDive",{ 0.046,0 },1 },*/
						{"HorizonIndicatorBank",{"0 *1 /3","-0.02 *1 /3"},1},							
						{"HorizonIndicatorBank",{"0.0099999998 *1 /3","-0.01732 *1 /3"},1},							
						{"HorizonIndicatorBank",{"0.01732 *1 /3","-0.0099999998 *1 /3"},1},		
						{"HorizonIndicatorBank",{"0.02 *1 /3","0 *1 /3"},1},							
						{"HorizonIndicatorBank",{"0.01732 *1 /3","0.0099999998 *1 /3"},1},
						{"HorizonIndicatorBank",{"0.0099999998 *1 /3","0.01732 *1 /3"},1},							
						{"HorizonIndicatorBank",{"0 *1 /3","0.02 *1 /3"},1},							
						{"HorizonIndicatorBank",{"-0.0099999998 *1 /3","0.01732 *1 /3"},1},					
						{"HorizonIndicatorBank",{"-0.01732 *1 /3","0.0099999998 *1 /3"},1},							
						{"HorizonIndicatorBank",{"-0.02 *1 /3","0 *1 /3"},1},						
						{"HorizonIndicatorBank",{"-0.01732 *1 /3","-0.0099999998 *1 /3"},1},							
						{"HorizonIndicatorBank",{"-0.0099999998 *1 /3","-0.01732 *1 /3"},1},							
						{"HorizonIndicatorBank",{"0 *1 /3","-0.02 *1 /3"},1},
						{},							
						{"HorizonIndicatorBank",{0.046,0},1},							
						{"HorizonIndicatorBank",{"0.02 *1 /3",0},1},
						{},							
						{"HorizonIndicatorBank",{-0.046,0},1},							
						{"HorizonIndicatorBank",{"-0.02 *1 /3",0},1},
						{},							
						{"HorizonIndicatorBank",{0,"0.06 *1 /3"},1},
						{"HorizonIndicatorBank",{0,"0.02 *1 /3"},1}
					};
				};
				class Pitch_circle_Left
				{
					type="group";
					clipTL[]={0.0,0.0};
					clipBR[]={0.9,1.0};
					class Pitch_Circle_Group_Left
					{
						type = "line";
						width = 4.0;
						points[] = 
						{
							{"HorizonDive_Left",{"-1.0000 * 0.0500","-0.0000 * 0.0450"},1},			//180
							//----------------------------------------------------------------------------------
							{"HorizonDive_Left",{"-1.0000 * 0.0450","-0.0000 * 0.0450"},1},			//180
							{"HorizonDive_Left",{"-0.9962 * 0.0450","-0.0872 * 0.0450"},1},			//185
							{"HorizonDive_Left",{"-0.9848 * 0.0450","-0.1736 * 0.0450"},1},			//190
							{"HorizonDive_Left",{"-0.9659 * 0.0450","-0.2588 * 0.0450"},1},			//195
							{"HorizonDive_Left",{"-0.9397 * 0.0450","-0.3420 * 0.0450"},1},			//200
							{"HorizonDive_Left",{"-0.9063 * 0.0450","-0.4226 * 0.0450"},1},			//205
							{"HorizonDive_Left",{"-0.8660 * 0.0450","-0.5000 * 0.0450"},1},			//210
							{"HorizonDive_Left",{"-0.8192 * 0.0450","-0.5736 * 0.0450"},1},			//215
							{"HorizonDive_Left",{"-0.7660 * 0.0450","-0.6428 * 0.0450"},1},			//220
							{"HorizonDive_Left",{"-0.7071 * 0.0450","-0.7071 * 0.0450"},1},			//225
							{"HorizonDive_Left",{"-0.6428 * 0.0450","-0.7660 * 0.0450"},1},			//230
							{"HorizonDive_Left",{"-0.5736 * 0.0450","-0.8192 * 0.0450"},1},			//235
							{"HorizonDive_Left",{"-0.5000 * 0.0450","-0.8660 * 0.0450"},1},			//240
							{"HorizonDive_Left",{"-0.4226 * 0.0450","-0.9063 * 0.0450"},1},			//245
							{"HorizonDive_Left",{"-0.3420 * 0.0450","-0.9397 * 0.0450"},1},			//250
							{"HorizonDive_Left",{"-0.2588 * 0.0450","-0.9659 * 0.0450"},1},			//255
							{"HorizonDive_Left",{"-0.1736 * 0.0450","-0.9848 * 0.0450"},1},			//260
							{"HorizonDive_Left",{"-0.0872 * 0.0450","-0.9962 * 0.0450"},1},			//265
							{"HorizonDive_Left",{"-0.0000 * 0.0450","-1.0000 * 0.0450"},1},			//270
							//----------------------------------------------------------------------------------
							{"HorizonDive_Left",{"0.0872 * 0.0450","-0.9962 * 0.0450"},1},			//275
							{"HorizonDive_Left",{"0.1736 * 0.0450","-0.9848 * 0.0450"},1},			//280
							{"HorizonDive_Left",{"0.2588 * 0.0450","-0.9659 * 0.0450"},1},			//285
							{"HorizonDive_Left",{"0.3420 * 0.0450","-0.9397 * 0.0450"},1},			//290
							{"HorizonDive_Left",{"0.4226 * 0.0450","-0.9063 * 0.0450"},1},			//295
							{"HorizonDive_Left",{"0.5000 * 0.0450","-0.8660 * 0.0450"},1},			//300
							{"HorizonDive_Left",{"0.5736 * 0.0450","-0.8192 * 0.0450"},1},			//305
							{"HorizonDive_Left",{"0.6428 * 0.0450","-0.7660 * 0.0450"},1},			//310
							{"HorizonDive_Left",{"0.7071 * 0.0450","-0.7071 * 0.0450"},1},			//315
							{"HorizonDive_Left",{"0.7660 * 0.0450","-0.6428 * 0.0450"},1},			//320
							{"HorizonDive_Left",{"0.8192 * 0.0450","-0.5736 * 0.0450"},1},			//325
							{"HorizonDive_Left",{"0.8660 * 0.0450","-0.5000 * 0.0450"},1},			//330
							{"HorizonDive_Left",{"0.9063 * 0.0450","-0.4226 * 0.0450"},1},			//335
							{"HorizonDive_Left",{"0.9397 * 0.0450","-0.3420 * 0.0450"},1},			//340
							{"HorizonDive_Left",{"0.9659 * 0.0450","-0.2588 * 0.0450"},1},			//345
							{"HorizonDive_Left",{"0.9848 * 0.0450","-0.1736 * 0.0450"},1},			//350
							{"HorizonDive_Left",{"0.9962 * 0.0450","-0.0872 * 0.0450"},1},			//355
							{"HorizonDive_Left",{"1.0000 * 0.0450","-0.0000 * 0.0450"},1},			//360
							//----------------------------------------------------------------------------------
							{"HorizonDive_Left",{"1.0000 * 0.0500","-0.0000 * 0.0450"},1}			//360
						};
					};
				};
				class Pitch_circle_Right
				{
					type="group";
					clipTL[]={0.9,0.0};
					clipBR[]={1.0,1.0};
					class Pitch_Circle_Group_Right
					{
						type = "line";
						width = 4.0;
						points[] = 
						{
							{"HorizonDive_Right",{"-1.0000 * 0.0500","-0.0000 * 0.0450"},1},			//180
							//----------------------------------------------------------------------------------
							{"HorizonDive_Right",{"-1.0000 * 0.0450","-0.0000 * 0.0450"},1},			//180
							{"HorizonDive_Right",{"-0.9962 * 0.0450","-0.0872 * 0.0450"},1},			//185
							{"HorizonDive_Right",{"-0.9848 * 0.0450","-0.1736 * 0.0450"},1},			//190
							{"HorizonDive_Right",{"-0.9659 * 0.0450","-0.2588 * 0.0450"},1},			//195
							{"HorizonDive_Right",{"-0.9397 * 0.0450","-0.3420 * 0.0450"},1},			//200
							{"HorizonDive_Right",{"-0.9063 * 0.0450","-0.4226 * 0.0450"},1},			//205
							{"HorizonDive_Right",{"-0.8660 * 0.0450","-0.5000 * 0.0450"},1},			//210
							{"HorizonDive_Right",{"-0.8192 * 0.0450","-0.5736 * 0.0450"},1},			//215
							{"HorizonDive_Right",{"-0.7660 * 0.0450","-0.6428 * 0.0450"},1},			//220
							{"HorizonDive_Right",{"-0.7071 * 0.0450","-0.7071 * 0.0450"},1},			//225
							{"HorizonDive_Right",{"-0.6428 * 0.0450","-0.7660 * 0.0450"},1},			//230
							{"HorizonDive_Right",{"-0.5736 * 0.0450","-0.8192 * 0.0450"},1},			//235
							{"HorizonDive_Right",{"-0.5000 * 0.0450","-0.8660 * 0.0450"},1},			//240
							{"HorizonDive_Right",{"-0.4226 * 0.0450","-0.9063 * 0.0450"},1},			//245
							{"HorizonDive_Right",{"-0.3420 * 0.0450","-0.9397 * 0.0450"},1},			//250
							{"HorizonDive_Right",{"-0.2588 * 0.0450","-0.9659 * 0.0450"},1},			//255
							{"HorizonDive_Right",{"-0.1736 * 0.0450","-0.9848 * 0.0450"},1},			//260
							{"HorizonDive_Right",{"-0.0872 * 0.0450","-0.9962 * 0.0450"},1},			//265
							{"HorizonDive_Right",{"-0.0000 * 0.0450","-1.0000 * 0.0450"},1},			//270
							//----------------------------------------------------------------------------------
							{"HorizonDive_Right",{"0.0872 * 0.0450","-0.9962 * 0.0450"},1},			//275
							{"HorizonDive_Right",{"0.1736 * 0.0450","-0.9848 * 0.0450"},1},			//280
							{"HorizonDive_Right",{"0.2588 * 0.0450","-0.9659 * 0.0450"},1},			//285
							{"HorizonDive_Right",{"0.3420 * 0.0450","-0.9397 * 0.0450"},1},			//290
							{"HorizonDive_Right",{"0.4226 * 0.0450","-0.9063 * 0.0450"},1},			//295
							{"HorizonDive_Right",{"0.5000 * 0.0450","-0.8660 * 0.0450"},1},			//300
							{"HorizonDive_Right",{"0.5736 * 0.0450","-0.8192 * 0.0450"},1},			//305
							{"HorizonDive_Right",{"0.6428 * 0.0450","-0.7660 * 0.0450"},1},			//310
							{"HorizonDive_Right",{"0.7071 * 0.0450","-0.7071 * 0.0450"},1},			//315
							{"HorizonDive_Right",{"0.7660 * 0.0450","-0.6428 * 0.0450"},1},			//320
							{"HorizonDive_Right",{"0.8192 * 0.0450","-0.5736 * 0.0450"},1},			//325
							{"HorizonDive_Right",{"0.8660 * 0.0450","-0.5000 * 0.0450"},1},			//330
							{"HorizonDive_Right",{"0.9063 * 0.0450","-0.4226 * 0.0450"},1},			//335
							{"HorizonDive_Right",{"0.9397 * 0.0450","-0.3420 * 0.0450"},1},			//340
							{"HorizonDive_Right",{"0.9659 * 0.0450","-0.2588 * 0.0450"},1},			//345
							{"HorizonDive_Right",{"0.9848 * 0.0450","-0.1736 * 0.0450"},1},			//350
							{"HorizonDive_Right",{"0.9962 * 0.0450","-0.0872 * 0.0450"},1},			//355
							{"HorizonDive_Right",{"1.0000 * 0.0450","-0.0000 * 0.0450"},1},			//360
							//----------------------------------------------------------------------------------
							{"HorizonDive_Right",{"1.0000 * 0.0500","-0.0000 * 0.0450"},1}			//360
						};
					};
				};
				class Stall_Group
				{
					type = "group";
					condition = "stall";
					color[] = {1.0,0.0,0.0};
					blinkingPattern[] = {0.2,0.2};
					blinkingStartsOn = 1;
					class StallText
					{
						type = "text";
						source = "static";
						text = "STALL";
						align = "center";
						scale = 1;
						pos[] = {{ 0.5,"0.53 - 0.25" },1};
						right[] = {{ 0.55,"0.53 - 0.25" },1};
						down[] = {{ 0.5,"0.53 - 0.20" },1};
					};
				};
				/*class Vertical_Speed_Band
				{
					type = "group";
					condition="ils";
					class Vspeed_band
					{
						type="line";
						width=3;
						points[]=
						{
							{
								"VspeedBone",
								{0.007,-0.007},
								1
							},
							{
								"VspeedBone",
								{0,0},
								1
							},
							{
								"VspeedBone",
								{0.007,0.007},
								1
							},
							{ },
							{
								"VspeedBone",
								{0,0},
								1
							},
							{
								"VspeedBone",
								{0.012,0},
								1
							},
							{{ 0.952,0.50 },1 },
							{ },
							
							{{ 0.92,0.40 },1 },  //
							{{ 0.94,0.40 },1 },
							{ },
							{{ 0.92,0.42 },1 },  
							{{ 0.93,0.42 },1 },
							{ },
							{{ 0.92,0.44 },1 },  
							{{ 0.93,0.44 },1 },
							{ },
							{{ 0.92,0.46 },1 },  
							{{ 0.93,0.46 },1 },
							{ },
							{{ 0.92,0.48 },1 },  
							{{ 0.93,0.48 },1 },
							{ },
							{{ 0.92,0.50 },1 },  //
							{{ 0.94,0.50 },1 },
							{ },
							{{ 0.92,0.52 },1 },  
							{{ 0.93,0.52 },1 },
							{ },
							{{ 0.92,0.54 },1 },  
							{{ 0.93,0.54 },1 },
							{ },
							{{ 0.92,0.56 },1 },  
							{{ 0.93,0.56 },1 },
							{ },
							{{ 0.92,0.58 },1 },  
							{{ 0.93,0.58 },1 },
							{ },
							{{ 0.92,0.60 },1 },  //
							{{ 0.94,0.60 },1 },
						};
					};
				};*/
				//------------------------------------------------------------ Weapons
				class AimingCrosshair
				{
					type="group";
					condition="on";
					class HMCS_Crosshair
					{
						type="line";
						width=3;
						points[] = 
						{
							{ { "0.020 + 0.5 + 0.02",0.5 },1 },
							{ { "0.010 + 0.5 + 0.02",0.5 },1 },
							{},
							{ { 0.5,"0.020 + 0.5 + 0.02" },1 },
							{ { 0.5,"0.010 + 0.5 + 0.02"},1 },
							{},
							{ { "-0.020 + 0.5 - 0.02", 0.5 },1 },
							{ { "-0.010 + 0.5 - 0.02", 0.5 },1 },
							{},
							{ { 0.5,"-0.020 + 0.5 - 0.02" },1 },
							{ { 0.5,"-0.010 + 0.5 - 0.02" },1 }
						};
					};					
				};
				class WeaponName
				{
					type="text";
					source="weapon";
					sourceScale=1;
					align="left";
					scale=1;
					pos[]=	{{0.14,0.75},1};
					right[]={{0.18,0.75},1};
					down[]=	{{0.14,0.79},1};
				};
				class GUN_Group
				{
					condition="mgun";
					type="group";
					class AmmoCount
					{
						type="text";
						source="ammo";
						sourceScale=1;
						align="right";
						scale=1;
						pos[]=
						{
							{0.15,0.75},
							1
						};
						right[]=
						{
							{0.19,0.75},
							1
						};
						down[]=
						{
							{0.15,0.79},
							1
						};
					};
					class Separating_stick
					{
						type="line";
						width=4;
						points[] = 
						{
							{ { 0.1455,"0.885 - 0.14" },1 },
							{ { 0.1455,"0.935 - 0.14" },1 }
						};
					};
					class ARMtext
					{
						type="text";
						align="center";
						source="static";
						text="ARM";
						scale=1;
						pos[]=
						{
							{0.09,"0.93 - 0.14"},
							1
						};
						right[]=
						{
							{0.13,"0.93 - 0.14"},
							1
						};
						down[]=
						{
							{0.09,"0.97 - 0.14"},
							1
						};
					};
					class Master_MODE
					{
						type="text";
						align="center";
						source="static";
						text="GUNS";
						scale=1;
						pos[]=
						{
							{0.09,"0.85 - 0.14"},
							1
						};
						right[]=
						{
							{0.13,"0.85 - 0.14"},
							1
						};
						down[]=
						{
							{0.09,"0.89 - 0.14"},
							1
						};
					};
					/*class RangeNumber
					{
						type="text";
						source="targetDist";
						sourceScale=1;
						align="right";
						scale=1;
						pos[]=
						{
							{0.50999999,0.94},
							1
						};
						right[]=
						{
							{0.56,0.94},
							1
						};
						down[]=
						{
							{0.50999999,0.98000002},
							1
						};
					};
					class RangeText
					{
						type="text";
						source="static";
						text="RNG";
						align="left";
						scale=1;
						pos[]=
						{
							{0.49000001,0.94},
							1
						};
						right[]=
						{
							{0.54000002,0.94},
							1
						};
						down[]=
						{
							{0.49000001,0.98000002},
							1
						};
					};
					*/
				};
				class RKT_Group
				{
					condition="rocket";
					type="group";
					class AmmoCount
					{
						type="text";
						source="ammo";
						sourceScale=1;
						align="right";
						scale=1;
						pos[]=
						{
							{0.15,0.75},
							1
						};
						right[]=
						{
							{0.19,0.75},
							1
						};
						down[]=
						{
							{0.15,0.79},
							1
						};
					};
					class Separating_stick
					{
						type="line";
						width=4;
						points[] = 
						{
							{ { 0.1455,"0.885 - 0.14" },1 },
							{ { 0.1455,"0.935 - 0.14" },1 }
						};
					};
					class ARMtext
					{
						type="text";
						align="center";
						source="static";
						text="ARM";
						scale=1;
						pos[]=
						{
							{0.09,"0.93 - 0.14"},
							1
						};
						right[]=
						{
							{0.13,"0.93 - 0.14"},
							1
						};
						down[]=
						{
							{0.09,"0.97 - 0.14"},
							1
						};
					};
					class Master_MODE
					{
						type="text";
						align="center";
						source="static";
						text="A-G";
						scale=1;
						pos[]=
						{
							{0.09,"0.85 - 0.14"},
							1
						};
						right[]=
						{
							{0.13,"0.85 - 0.14"},
							1
						};
						down[]=
						{
							{0.09,"0.89 - 0.14"},
							1
						};
					};
					/*class RangeNumber
					{
						type="text";
						source="targetDist";
						sourceScale=1;
						align="right";
						scale=1;
						pos[]=
						{
							{0.50999999,0.94},
							1
						};
						right[]=
						{
							{0.56,0.94},
							1
						};
						down[]=
						{
							{0.50999999,0.98000002},
							1
						};
					};
					class RangeText
					{
						type="text";
						source="static";
						text="RNG";
						align="left";
						scale=1;
						pos[]=
						{
							{0.49000001,0.94},
							1
						};
						right[]=
						{
							{0.54000002,0.94},
							1
						};
						down[]=
						{
							{0.49000001,0.98000002},
							1
						};
					};
					*/
				};
				class AGM_Group
				{
					condition="ATmissile";
					type="group";
					class AmmoCount
					{
						type="text";
						source="ammo";
						sourceScale=1;
						align="right";
						scale=1;
						pos[]=
						{
							{0.15,0.75},
							1
						};
						right[]=
						{
							{0.19,0.75},
							1
						};
						down[]=
						{
							{0.15,0.79},
							1
						};
					};
					class Separating_stick
					{
						type="line";
						width=4;
						points[] = 
						{
							{ { 0.1455,"0.885 - 0.14" },1 },
							{ { 0.1455,"0.935 - 0.14" },1 }
						};
					};
					class ARMtext
					{
						type="text";
						align="center";
						source="static";
						text="ARM";
						scale=1;
						pos[]=
						{
							{0.09,"0.93 - 0.14"},
							1
						};
						right[]=
						{
							{0.13,"0.93 - 0.14"},
							1
						};
						down[]=
						{
							{0.09,"0.97 - 0.14"},
							1
						};
					};
					class Master_MODE
					{
						type="text";
						align="center";
						source="static";
						text="A-G";
						scale=1;
						pos[]=
						{
							{0.09,"0.85 - 0.14"},
							1
						};
						right[]=
						{
							{0.13,"0.85 - 0.14"},
							1
						};
						down[]=
						{
							{0.09,"0.89 - 0.14"},
							1
						};
					};
					class AGM_Crosshair
					{
						type="line";
						width=4;
						points[] = 
						{
							{ { 0.41,0.43 },1 },
							{ { 0.41,0.41 },1 },
							{ { 0.43,0.41 },1 },
							{},
							{ { 0.57,0.41 },1 },
							{ { 0.59,0.41 },1 },
							{ { 0.59,0.43 },1 },
							{},
							{ { 0.59,0.57 },1 },
							{ { 0.59,0.59 },1 },
							{ { 0.57,0.59 },1 },
							{},
							{ { 0.43,0.59 },1 },
							{ { 0.41,0.59 },1 },
							{ { 0.41,0.57 },1 }
						};
					};
					class AGM_Range_Marks
					{
						type="line";
						width=4;
						points[] = 
						{	
							{ { 0.805,0.40 },1 },
							{ { 0.795,0.40 },1 },
							{},
							{ { 0.805,0.45 },1 },
							{ { 0.795,0.45 },1 },
							{},
							/*{ { 0.805,0.50 },1 },
							{ { 0.795,0.50 },1 },
							{},*/
							{ { 0.805,0.55 },1 },
							{ { 0.795,0.55 },1 },
							{},
							{ { 0.805,0.60 },1 },
							{ { 0.795,0.60 },1 },
							{},
							{ { 0.795,0.45 },1 }, // line
							{ { 0.795,0.55 },1 },
						};
					};
					class RangerNumber
					{
						type="text";
						source="targetdist";
						sourceScale=1;
						align="center";
						scale=1;
						pos[]=	{{0.80,0.615},1};
						right[]={{0.83,0.615},1};
						down[]=	{{0.80,0.645},1};
					};
					class RangeBand
					{
						type="line";
						width=2;
						points[]=
						{
							{"RangeBone",{-0.005	,0.0		},1},
							{"RangeBone",{-0.015	,-0.005		},1},
							{"RangeBone",{-0.015	,0.005		},1},
							{"RangeBone",{-0.005	,0.0		},1}
						};
					};
					class TOFtext
					{
						type="text";
						align="left";
						source="static";
						text="TOF=";
						scale=1;
						pos[]=
						{
							{0.795,0.65},
							1
						};
						right[]=
						{
							{0.825,0.65},
							1
						};
						down[]=
						{
							{0.795,0.68},
							1
						};
					};
					class TOFnumber
					{
						type="text";
						source="targetDist";
						sourcescale = 0.0025;
						align="right";
						scale=1;
						pos[]=
						{
							{0.805,0.65},
							1
						};
						right[]=
						{
							{0.835,0.65},
							1
						};
						down[]=
						{
							{0.805,0.68},
							1
						};
					};
				};
				class AAM_Group
				{
					condition="AAmissile";
					type="group";
					class AmmoCount
					{
						type="text";
						source="ammo";
						sourceScale=1;
						align="right";
						scale=1;
						pos[]=
						{
							{0.15,0.75},
							1
						};
						right[]=
						{
							{0.19,0.75},
							1
						};
						down[]=
						{
							{0.15,0.79},
							1
						};
					};
					class Separating_stick
					{
						type="line";
						width=4;
						points[] = 
						{
							{ { 0.1455,"0.885 - 0.14" },1 },
							{ { 0.1455,"0.935 - 0.14" },1 }
						};
					};
					class ARMtext
					{
						type="text";
						align="center";
						source="static";
						text="ARM";
						scale=1;
						pos[]=
						{
							{0.09,"0.93 - 0.14"},
							1
						};
						right[]=
						{
							{0.13,"0.93 - 0.14"},
							1
						};
						down[]=
						{
							{0.09,"0.97 - 0.14"},
							1
						};
					};
					class Master_MODE
					{
						type="text";
						align="center";
						source="static";
						text="A-A";
						scale=1;
						pos[]=
						{
							{0.09,"0.85 - 0.14"},
							1
						};
						right[]=
						{
							{0.13,"0.85 - 0.14"},
							1
						};
						down[]=
						{
							{0.09,"0.89 - 0.14"},
							1
						};
					};
					class RangeBand
					{
						type="line";
						width=2;
						points[]=
						{
							{"RangeBone",{-0.005	,0.0		},1},
							{"RangeBone",{-0.015	,-0.005		},1},
							{"RangeBone",{-0.015	,0.005		},1},
							{"RangeBone",{-0.005	,0.0		},1}
						};
					};
					class AAM_Range_Marks
					{
						type="line";
						width=2;
						points[] = 
						{
							{ { 0.805,0.40 },1 },
							{ { 0.795,0.40 },1 },
							{},
							{ { 0.805,0.45 },1 },
							{ { 0.795,0.45 },1 },
							{},
							{ { 0.805,0.50 },1 },
							{ { 0.795,0.50 },1 },
							{},
							{ { 0.805,0.55 },1 },
							{ { 0.795,0.55 },1 },
							{},
							{ { 0.805,0.60 },1 },
							{ { 0.795,0.60 },1 },
							{},
							{ { 0.80,0.40 },1 }, // line
							{ { 0.80,0.50 },1 },
							{},
							{ { 0.795,0.50 },1 }, // line
							{ { 0.795,0.60 },1 },
							{},
							{ { 0.805,0.50 },1 }, // line
							{ { 0.805,0.60 },1 }
						};
					};
					class AAM_Perfect_Circle
					{
						type="line";
						width=3;
						points[]=
						{
							{"Planeori_fix",{"1.0000 * 0.1750","0.0000 * 0.1750"},1},			//0
							{"Planeori_fix",{"0.9962 * 0.1750","0.0872 * 0.1750"},1},			//5
							{"Planeori_fix",{"0.9848 * 0.1750","0.1736 * 0.1750"},1},			//10
							{"Planeori_fix",{"0.9659 * 0.1750","0.2588 * 0.1750"},1},			//15
							{"Planeori_fix",{"0.9397 * 0.1750","0.3420 * 0.1750"},1},			//20
							{"Planeori_fix",{"0.9063 * 0.1750","0.4226 * 0.1750"},1},			//25
							{"Planeori_fix",{"0.8660 * 0.1750","0.5000 * 0.1750"},1},			//30
							{"Planeori_fix",{"0.8192 * 0.1750","0.5736 * 0.1750"},1},			//35
							{"Planeori_fix",{"0.7660 * 0.1750","0.6428 * 0.1750"},1},			//40
							{"Planeori_fix",{"0.7071 * 0.1750","0.7071 * 0.1750"},1},			//45
							{"Planeori_fix",{"0.6428 * 0.1750","0.7660 * 0.1750"},1},			//50
							{"Planeori_fix",{"0.5736 * 0.1750","0.8192 * 0.1750"},1},			//55
							{"Planeori_fix",{"0.5000 * 0.1750","0.8660 * 0.1750"},1},			//60
							{"Planeori_fix",{"0.4226 * 0.1750","0.9063 * 0.1750"},1},			//65
							{"Planeori_fix",{"0.3420 * 0.1750","0.9397 * 0.1750"},1},			//70
							{"Planeori_fix",{"0.2588 * 0.1750","0.9659 * 0.1750"},1},			//75
							{"Planeori_fix",{"0.1736 * 0.1750","0.9848 * 0.1750"},1},			//80
							{"Planeori_fix",{"0.0872 * 0.1750","0.9962 * 0.1750"},1},			//85
							{"Planeori_fix",{"0.0000 * 0.1750","1.0000 * 0.1750"},1},			//90
							//----------------------------------------------------------------------------------
							{"Planeori_fix",{"-0.0872 * 0.1750","0.9962 * 0.1750"},1},			//95
							{"Planeori_fix",{"-0.1736 * 0.1750","0.9848 * 0.1750"},1},			//100
							{"Planeori_fix",{"-0.2588 * 0.1750","0.9659 * 0.1750"},1},			//105
							{"Planeori_fix",{"-0.3420 * 0.1750","0.9397 * 0.1750"},1},			//110
							{"Planeori_fix",{"-0.4226 * 0.1750","0.9063 * 0.1750"},1},			//115
							{"Planeori_fix",{"-0.5000 * 0.1750","0.8660 * 0.1750"},1},			//120
							{"Planeori_fix",{"-0.5736 * 0.1750","0.8192 * 0.1750"},1},			//125
							{"Planeori_fix",{"-0.6428 * 0.1750","0.7660 * 0.1750"},1},			//130
							{"Planeori_fix",{"-0.7071 * 0.1750","0.7071 * 0.1750"},1},			//135
							{"Planeori_fix",{"-0.7660 * 0.1750","0.6428 * 0.1750"},1},			//140
							{"Planeori_fix",{"-0.8192 * 0.1750","0.5736 * 0.1750"},1},			//145
							{"Planeori_fix",{"-0.8660 * 0.1750","0.5000 * 0.1750"},1},			//150
							{"Planeori_fix",{"-0.9063 * 0.1750","0.4226 * 0.1750"},1},			//155
							{"Planeori_fix",{"-0.9397 * 0.1750","0.3420 * 0.1750"},1},			//160
							{"Planeori_fix",{"-0.9659 * 0.1750","0.2588 * 0.1750"},1},			//165
							{"Planeori_fix",{"-0.9848 * 0.1750","0.1736 * 0.1750"},1},			//170
							{"Planeori_fix",{"-0.9962 * 0.1750","0.0872 * 0.1750"},1},			//175
							{"Planeori_fix",{"-1.0000 * 0.1750","0.0000 * 0.1750"},1},			//180
							//----------------------------------------------------------------------------------
							{"Planeori_fix",{"-0.9962 * 0.1750","-0.0872 * 0.1750"},1},		//185
							{"Planeori_fix",{"-0.9848 * 0.1750","-0.1736 * 0.1750"},1},		//190
							{"Planeori_fix",{"-0.9659 * 0.1750","-0.2588 * 0.1750"},1},		//195
							{"Planeori_fix",{"-0.9397 * 0.1750","-0.3420 * 0.1750"},1},		//200
							{"Planeori_fix",{"-0.9063 * 0.1750","-0.4226 * 0.1750"},1},		//205
							{"Planeori_fix",{"-0.8660 * 0.1750","-0.5000 * 0.1750"},1},		//210
							{"Planeori_fix",{"-0.8192 * 0.1750","-0.5736 * 0.1750"},1},		//215
							{"Planeori_fix",{"-0.7660 * 0.1750","-0.6428 * 0.1750"},1},		//220
							{"Planeori_fix",{"-0.7071 * 0.1750","-0.7071 * 0.1750"},1},		//225
							{"Planeori_fix",{"-0.6428 * 0.1750","-0.7660 * 0.1750"},1},		//230
							{"Planeori_fix",{"-0.5736 * 0.1750","-0.8192 * 0.1750"},1},		//235
							{"Planeori_fix",{"-0.5000 * 0.1750","-0.8660 * 0.1750"},1},		//240
							{"Planeori_fix",{"-0.4226 * 0.1750","-0.9063 * 0.1750"},1},		//245
							{"Planeori_fix",{"-0.3420 * 0.1750","-0.9397 * 0.1750"},1},		//250
							{"Planeori_fix",{"-0.2588 * 0.1750","-0.9659 * 0.1750"},1},		//255
							{"Planeori_fix",{"-0.1736 * 0.1750","-0.9848 * 0.1750"},1},		//260
							{"Planeori_fix",{"-0.0872 * 0.1750","-0.9962 * 0.1750"},1},		//265
							{"Planeori_fix",{"-0.0000 * 0.1750","-1.0000 * 0.1750"},1},		//270
							//----------------------------------------------------------------------------------
							{"Planeori_fix",{"0.0872 * 0.1750","-0.9962 * 0.1750"},1},			//275
							{"Planeori_fix",{"0.1736 * 0.1750","-0.9848 * 0.1750"},1},			//280
							{"Planeori_fix",{"0.2588 * 0.1750","-0.9659 * 0.1750"},1},			//285
							{"Planeori_fix",{"0.3420 * 0.1750","-0.9397 * 0.1750"},1},			//290
							{"Planeori_fix",{"0.4226 * 0.1750","-0.9063 * 0.1750"},1},			//295
							{"Planeori_fix",{"0.5000 * 0.1750","-0.8660 * 0.1750"},1},			//300
							{"Planeori_fix",{"0.5736 * 0.1750","-0.8192 * 0.1750"},1},			//305
							{"Planeori_fix",{"0.6428 * 0.1750","-0.7660 * 0.1750"},1},			//310
							{"Planeori_fix",{"0.7071 * 0.1750","-0.7071 * 0.1750"},1},			//315
							{"Planeori_fix",{"0.7660 * 0.1750","-0.6428 * 0.1750"},1},			//320
							{"Planeori_fix",{"0.8192 * 0.1750","-0.5736 * 0.1750"},1},			//325
							{"Planeori_fix",{"0.8660 * 0.1750","-0.5000 * 0.1750"},1},			//330
							{"Planeori_fix",{"0.9063 * 0.1750","-0.4226 * 0.1750"},1},			//335
							{"Planeori_fix",{"0.9397 * 0.1750","-0.3420 * 0.1750"},1},			//340
							{"Planeori_fix",{"0.9659 * 0.1750","-0.2588 * 0.1750"},1},			//345
							{"Planeori_fix",{"0.9848 * 0.1750","-0.1736 * 0.1750"},1},			//350
							{"Planeori_fix",{"0.9962 * 0.1750","-0.0872 * 0.1750"},1},			//355
							{"Planeori_fix",{"1.0000 * 0.1750","-0.0000 * 0.1750"},1}			//360
						};
					};
					class RangerNumber
					{
						type="text";
						source="targetdist";
						sourceScale=1;
						align="center";
						scale=1;
						pos[]=	{{0.80,0.615},1};
						right[]={{0.83,0.615},1};
						down[]=	{{0.80,0.645},1};
					};
				};
				class Bomb_Group
				{
					condition="Bomb";
					type="group";
					class AmmoCount
					{
						type="text";
						source="ammo";
						sourceScale=1;
						align="right";
						scale=1;
						pos[]=
						{
							{0.15,0.75},
							1
						};
						right[]=
						{
							{0.19,0.75},
							1
						};
						down[]=
						{
							{0.15,0.79},
							1
						};
					};
					class Separating_stick
					{
						type="line";
						width=4;
						points[] = 
						{
							{ { 0.1455,"0.885 - 0.14" },1 },
							{ { 0.1455,"0.935 - 0.14" },1 }
						};
					};
					class ARMtext
					{
						type="text";
						align="center";
						source="static";
						text="ARM";
						scale=1;
						pos[]=
						{
							{0.09,"0.93 - 0.14"},
							1
						};
						right[]=
						{
							{0.13,"0.93 - 0.14"},
							1
						};
						down[]=
						{
							{0.09,"0.97 - 0.14"},
							1
						};
					};
					class Master_MODE
					{
						type="text";
						align="center";
						source="static";
						text="A-G";
						scale=1;
						pos[]=
						{
							{0.09,"0.85 - 0.14"},
							1
						};
						right[]=
						{
							{0.13,"0.85 - 0.14"},
							1
						};
						down[]=
						{
							{0.09,"0.89 - 0.14"},
							1
						};
					};
					class Range_marks_Bomb
					{
						type="line";
						width=4;
						points[] = 
						{
							{ { 0.805,0.40 },1 },
							{ { 0.795,0.40 },1 },
							{},
							{ { 0.805,0.45 },1 },
							{ { 0.795,0.45 },1 },
							{},
							{ { 0.805,0.50 },1 },
							{ { 0.795,0.50 },1 },
							{},
							{ { 0.805,0.55 },1 },
							{ { 0.795,0.55 },1 },
							{},
							{ { 0.805,0.60 },1 },
							{ { 0.795,0.60 },1 },
							{},
							{ { 0.805,0.40 },1 }, // line
							{ { 0.805,0.60 },1 }
						};
					};
					class RangeBand
					{
						type="line";
						width=2;
						points[]=
						{
							{"RangeBone",{-0.005	,0.0		},1},
							{"RangeBone",{-0.015	,-0.005		},1},
							{"RangeBone",{-0.015	,0.005		},1},
							{"RangeBone",{-0.005	,0.0		},1}
						};
					};
					class RangerNumber
					{
						type="text";
						source="targetdist";
						sourceScale=1;
						align="center";
						scale=1;
						pos[]=	{{0.80,0.615},1};
						right[]={{0.83,0.615},1};
						down[]=	{{0.80,0.645},1};
					};
					class TOFtext
					{
						type="text";
						align="left";
						source="static";
						text="TOF=";
						scale=1;
						pos[]=
						{
							{0.795,0.65},
							1
						};
						right[]=
						{
							{0.825,0.65},
							1
						};
						down[]=
						{
							{0.795,0.68},
							1
						};
					};
					class TOFnumber
					{
						type="text";
						source="targetDist";
						sourcescale = 0.013;
						align="right";
						scale=1;
						pos[]=
						{
							{0.805,0.65},
							1
						};
						right[]=
						{
							{0.835,0.65},
							1
						};
						down[]=
						{
							{0.805,0.68},
							1
						};
					};
				};
			};
			helmetMountedDisplay=1;
			helmetPosition[]={-0.035,0.035,0.1};
			helmetRight[]={0.070000001,0,0};
			helmetDown[]={-0,-0.070000001,0};
		};