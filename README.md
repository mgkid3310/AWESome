# AWESome : Aerial Warfare Enhanced Somehow  

Makes ARMA 3's flight environments more realistic (GWPS,  
wind effect, etc.). Recommended to use with ACE since it  
will enable ACE Interaction instead of vanilla actions  
and give more specific weather data on ATIS.  

This addon is SP/MP capable and basically works as a  
client-side mod, and gives some additional features when  
used on both client/server.  

Although this addon is licensed under CC BY-NC-ND 4.0,  
feel free to contact me if you need any code from this  
addon for applications.  

----------------

**Features**  

1. Voice Informer, GPWS(Ground Proximity Warning)  

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

2. Realistic Aerodynamics (drag, lift, etc.)  

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

3. ATC (Air Traffic Controller) Radar Screen  

Shows friendly & civilian planes on map with name, speed,  
altitude, and heading. Useful when commanding multiple  
planes. Information lines are consisted of the following  
three lines :  
Pilot's Name or Callsign  
Speed Altitude  
Heading(deg)  

Pilot name/callsign setting and units for speed & altitude  
can be changed at addon settings tab. Supports kph/knot  
for speed and meter/feet for altitude. Note that unit  
callsign uses the unit's group ID and therefore cannot  
distinguish between planes in a same group.  

To enable this feature, you need to add the following code  
to the target object's init field:  
[this] call orbis_atc_fnc_addRadarScreen;  
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
[this] call orbis_atc_fnc_addATCConsole;  
&nbsp;

5. Ground System  

Provides towing vehicle & system for all planes. Works in  
MP and does not require other players to use this addon for  
towing their planes.  
Offroad vehicles are used as towing cars, and can tow  
planes by deploying towbar via Interaction / Action outside  
the vehicle. Once the towbar is deployed, place target  
plane's front gear at the end of the towbar, then use Action  
to connect target plane to the towbar. After towing around,  
stop the vehicle and disconnect target plane using Action.  

NOTICE : moving too fast may occur collisions, so drive  
with caution when towing.  
&nbsp;

6. Cockpit Utility  

Adds camera shake feature reflecting the vehicle's speed and  
status including the touchdown speed, and checklists feature  
for fixed-wing pilots which provides decision speed, rotate  
speed, landing speed and many more automatically filled in.  
This helps pilots to check if they have anything forgotten  
and gives reference speeds for takeoff and landing.  
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

**Authors (Contributors)**  

Orbis2358 (mgkid3310@naver.com) : Project Manager & Programmer  
