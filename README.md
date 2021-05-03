# AWESome : Aerial Warfare Enhanced Somehow  

Enhances the ARMA 3's flight environments to be more  
realistic (Aerodynamics, GPWS, ATC, etc.).  

Recommended to use with ACE since AWESome will take  
advantage of ACE when able such as ACE Interactions,  
ACE Weather and more.  

This addon is SP/MP capable and basically works as a  
client-side mod, and gives some additional features when  
used on both client/server.  

Although this addon is licensed under CC BY-NC-ND 4.0,  
feel free to contact me if you need any code from this  
addon for applications.  

----------------

**Features**  

1. Realistic Aerodynamics (drag, lift, etc.)  

Basic drag model is replaced with an enhanced model so  
that it better reflects the drag in real life. This will  
generate drag that's much more complicated than a simple  
polynomial function and create many effects such as the  
so-called 'Sound barrier'.  
Vehicle's fuel status and weapon loadout will now affect  
mass and aerodynamic characteristics of the vehicle,  
resulting in high aerodynamic drag and lowered stability  
when armed heavily.  
This also brings air density and wind into consideration.  
Air density is calculated based on altitude, temperature  
and humidity which gets more accurate if ACE3 weather is  
used together.  

Can enable/disable at addon settings (enabled as default),  
and effects of wind can be adjusted with "Wind Multiplier"  
setting.  
&nbsp;

2. Voice Informer & GPWS  

GPWS(incl. Voice Informer) has three modes: B747, F-16  
and Rita. B747's GPWS has more familiar sounds from  
commercial airliners including altitude informers during  
landing. Suitable for large transport or support planes.  
F-16's Bitching Betty GPWS includes missile warning and  
other sound-warnings (voice informers). Gives basic  
warnings such as: Counter; Warning; Caution; etc., and is  
suitable for fighter planes.  
Rita is a Russian voice informer which works similar to  
Bitching Betty, but speaks Russian and has fewer  
features(it's mainly because I don't speak Russian, and  
therefore I can't find enough sound files).  

You can set default setting for GPWS in addon settings  
which will override plane's default GPWS mode setting  
and set GPWS mode to what you want when getting in a  
plane. However, if someone with this addon is in or has  
been in the plane, the GPWS mode will not change and  
stay as it was.  
&nbsp;

3. ATC (Air Traffic Controller) Systems  

Shows friendly & civilian planes on map with name, speed,  
altitude, and heading. Useful when commanding multiple  
planes. Information lines are consisted of the following  
three lines:  

Pilot's Name or Callsign  
Altitude Speed  
Heading  

Here, altitude is displayed in multiples of 10m or 100ft,  
so if the unit is set to "feet (x100ft)" and 083 is displayed  
as altitude, the actual altitude would be 8300ft.  

Pilot name/callsign & Vehicle callsign setting and units for  
speed & altitude can be changed at addon settings tab.  
Supports kph/knot for speed and meter/feet for altitude.  
To set a vehicle callsign, add this to the plane's init field:  
`[this, "My Callsign"] call orbis_atc_fnc_setCustomCallsign;`  
If no vehicle callsign is set, it defaults to the unit's  
group ID.  

To enable this feature, you need to add the following code  
to the target object's init field:  
`[this, _radarMode, _distance] call orbis_atc_fnc_addRadarScreen;`  

The `_radarMode` (default: 0) parameter works in 3 modes:  
0: Civilian, same side or civilian side aircrafts only  
1: Military, civilian mode plus radar detected aircrafts  
2: Observer, all alive aircrafts  

The `_distance` (default: 10) parameter is a number type  
parameter which determines how far the controller can move  
from the radar monitor. zero or negative `_distance` value  
will allow an infinite distance.  

When using Military mode, custom parameters can be used:  
`monitor setVariable ["orbis_atc_radarParams", [radarObject, isMaster]]`  
monitor: Monitor object the atc radar was added  
radarObject: Radar object (default: monitor)  
isMaster: displays all airborne objects if true (default: false)  

`radar setVariable ["orbis_atc_performanceParams", [radarPos, radarRange, counterStealth, volumeCR, groundCR]]`  
radar: radarObject from "orbis_atc_radarParams"  
radarPos: Position of the radar, can be object or position ASL (default: radar)  
radarRange: Standard detecting range for RCS 5m^2 vehicle in km (default: 30)  
counterStealth: No effect for now (default: 0)  
volumeCR: Volume clutter reduction ratio (default: 1000)  
groundCR: Ground clutter reduction ratio (default: 1000)  

`radar setVariable ["orbis_atc_radarDetailParams", radarDetailParams]`  
radar: Radar object  
radarDetailParams: Radar detail parameters (default: [])  

`radarDetailParams` can be used in two modes: preset/custom.  
There are two presets available, `"AN/APG76"` and `"AN/APS145"`.  
APG76 was used in A-6 aircraft, and APS145 is used in E-2A/B/C.  
APG76 works well against ground clutter but is weak against rain.  
APS145 has almost no effect from rain, but gets highter ground  
clutter values and therefore cannot detect low-altitude aircrafts  
in certain situations.  

When using custom values, the parameters are as follows:  
`radarDetailParams = [radarFrequency, pulseWidth, azimuthBeamwidth, elevationBeamwidth]`  
radarFrequency: Frequency of radar beam in GHz (default: 16.5)  
pulseWidth: Pulse width of radar beam in micro seconds (default: 1.25)  
azimuthBeamwidth: Azimuth beam width in degrees (default: 2.2)  
elevationBeamwidth: Elevation beam width in degrees (default: 3.8)  
&nbsp;

4. ATIS (Automatic Terminal Information Service)  

Plays ATIS radio broadcast using real in-game atmospheric  
data. Provides wind, visibility, etc. Temperature, dew point,  
QNH will be provided when ACE Weather is enabled.  
With basic settings, ATIS provides real-time data, but with  
addon setting changed, ATIS data should be updated on  
ground  

To let the controller manually update the data, disable  
'Real-time ATIS data update' option in addon setting, and  
add the following code to the target object's init field:  
`[this] call orbis_atc_fnc_addATCConsole;`  
&nbsp;

5. Cockpit Utility  

Adds camera shake feature reflecting the vehicle's speed and  
status including the touchdown speed, and checklists feature  
for fixed-wing pilots which provides decision speed, rotate  
speed, landing speed and many more automatically filled in.  
This helps pilots to check if they have anything forgotten  
and gives reference speeds for takeoff and landing.  
&nbsp;

6. Ground System  

Provides towing vehicle & system for all planes. Works in  
MP and does not require other players to use this addon for  
towing their planes.  
Offroad vehicles are used as towing cars, and can tow  
planes by deploying towbar via Interaction / Action outside  
the vehicle. Once the towbar is deployed, place target  
plane's front gear at the end of the towbar, then use Action  
to connect target plane to the towbar. After towing around,  
stop the vehicle and disconnect target plane using Action.  

NOTICE: moving too fast may occur collisions, so drive  
with caution when towing.  
&nbsp;

----------------

**Issue Tracking**  

To report issues, please use Github's issue tracker  

https://github.com/mgkid3310/AWESome/issues  

----------------

**Steam Workshop**  

You can subscribe this addon on Steam Workshop  

https://steamcommunity.com/sharedfiles/filedetails/?id=1301399507  

----------------

**BI Forum thread**  

For more specific update notes, please visit BI forum thread  

https://forums.bohemia.net/forums/topic/217012-awesome-aerial-warfare-enhanced-somehow/  

----------------

**Authors**  

Orbis2358 (mgkid3310@naver.com) : Project Manager & Programmer  
&nbsp;

**Contributors**  

N/A  
