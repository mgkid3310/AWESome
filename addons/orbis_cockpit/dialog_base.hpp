#define posX 0.1
#define posY 0.2
#define pixelSize 0.0004
#define lineBaseY1 239
#define lineBaseY2 758
#define linePixelY 48
// define doesn't work, just for reference

class checklist_base {
	idd = -1;
	movingenable = 1;
	enableSimulation = 1;
	controlsBackground[] = {};
	objects[] = {};
	duration = 99999999;
	fadein = 0;
	fadeout = 0;
};

class control_base {
	sizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) * 0.03)";
	font = "PuristaSemiBold";
	colorText[] = {1, 1, 1, 1};
	colorBackground[] = {0, 0, 0, 0};
	text = "";
	shadow = 0;
	tooltip = "";
	tooltipColorShade[] = {0, 0, 0, 0};
	tooltipColorText[] = {};
	tooltipColorBox[] = {};
	autocompete = "";
	url = "";
};

class mainTexture_base: control_base {
	idc = 1800;
	moving = 1;
	type = 0;
	style = "48 + 2048";
	x = "0.1 * safezoneW + safezoneX";
	y = "0.2 * safezoneH + safezoneY";
	w = "0.0004 * 950 * safezoneW";
	h = "0.0004 * 1257 * safezoneW";
	text = "";
};
class buttonPrevious_base: control_base {
	idc = 1801;
	moving = 1;
	type = 1;
	style = 0;
	x = "0.0004 * 70 * safezoneW + 0.1 * safezoneW + safezoneX";
	y = "0.0004 * 1101 * safezoneW + 0.2 * safezoneH + safezoneY";
	w = "0.0004 * 151 * safezoneW";
	h = "0.0004 * 53 * safezoneW";
	soundEnter[] = {"", 0.1, 1};
	soundPush[] = {"", 0.1, 1};
	soundClick[] = {"", 0.1, 1};
	soundEscape[] = {"", 0.1, 1};
	colorDisabled[] = {0, 0, 0, 0.3};
	colorBackgroundDisabled[] = {0, 0, 0, 0};
	colorBackgroundActive[] = {0, 0, 0, 0};
	colorFocused[] = {0, 0, 0, 0};
	colorShadow[] = {0, 0, 0, 0};
	colorBorder[] = {0, 0, 0, 0};
	borderSize = 0;
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0;
	offsetPressedY = 0;
	onMouseButtonClick = "[false] call orbis_cockpit_fnc_nextChecklist";
};
class buttonNext_base: buttonPrevious_base {
	idc = 1802;
	x = "0.0004 * 502 * safezoneW + 0.1 * safezoneW + safezoneX";
	y = "0.0004 * 1100 * safezoneW + 0.2 * safezoneH + safezoneY";
	w = "0.0004 * 119 * safezoneW";
	h = "0.0004 * 53 * safezoneW";
	onMouseButtonClick = "[true] call orbis_cockpit_fnc_nextChecklist";
};
class text_static_base: control_base {
	colorText[] = {0.3359375, 0.33984375, 0.35546875, 0.65};
	idc = 1810;
	moving = 1;
	type = 0;
	style = 2;
	x = "0.0004 * 432.6 * safezoneW + 0.1 * safezoneW + safezoneX";
	y = "0.0004 * 240 * safezoneW + 0.2 * safezoneH + safezoneY";
	w = "0.0004 * 233 * safezoneW";
	h = "0.0004 * 46 * safezoneW";
	onLoad = "";
};
