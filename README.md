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

&nbsp;

2. Realistic Aerodynamics (drag, lift, etc.)  

Brings air density and wind into consideration. Air density  
is calulated based on altitude, temperature and humidity.  
This requires landing speed to be set based on TAS (True  
Air Speed), and have air density (altimeter) considered.  
In case of crosswinds, de-crab or sideslip landings will be  
needed. Can enable/disable at addon settings (enabled as  
default), and effects of wind can be adjusted with "Wind  
Multiplier" setting.  
NOTICE : in low-FPS and high-speed situation, this feature  
MAY cause some sutters. if it does so, please temporarily  
disable this feature in addon settings.  
&nbsp;

3. ATC (Air Traffic Controller) radar screen  

Shows friendly & civilian planes on map with name, speed,  
altitude, and heading. Useful when commanding multiple  
planes. Information lines are consisted of the following  
three lines :  
Pilot's Name  
Speed(km/h) Altitude(m)  
Heading(deg)  

To enable this feature, you need to add the following code  
to the target object's init field:  
[this] call orbis_atc_fnc_addRadarScreen;  
&nbsp;

4. ATIS (Automatic Terminal Information Service)  

Plays ATIS radio boradcast using real in-game atmospheric  
data. Provides wind, visibility, etc. Temperature, dew point,  
QFE will ve provided when ACE Weather is enabled.  
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

Provides checklists for fixed-wing pilots, with decision  
speed, rotate speed, etc. automatically filled in. This helps  
pilots to check if they have anything missing and gives  
reference speeds for takeoff and landing.  
NOTICE : opening a checklist will put the plane to autopilot  
mode. In this mode, the plane will level itself but may crash  
when happened during takeoff or landing. Because of this,  
opening a checklist while engine on is recommended to be  
conducted by the co-pilot (or gunner).  
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
