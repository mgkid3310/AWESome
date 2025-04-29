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
	style = 2096;		// "48 + 2048"
	x = "0.1 * safezoneW + safezoneX";
	y = "0.2 * safezoneH + safezoneY";
	w = "0.0004 * 900 * safezoneW";
	h = "0.0004 * 1200 * safezoneW";
	text = "";
};
class text_static_base: control_base {
	colorText[] = {0.3359375, 0.33984375, 0.35546875, 0.65};
	idc = 1810;
	moving = 1;
	type = 0;
	style = 2;
	x = "0.0004 * 409.8 * safezoneW + 0.1 * safezoneW + safezoneX";
	y = "0.0004 * 229.1 * safezoneW + 0.2 * safezoneH + safezoneY";
	w = "0.0004 * 221 * safezoneW";
	h = "0.0004 * 44 * safezoneW";
	onLoad = "";
};
/* class buttonPrevious_base: control_base {
	idc = 1801;
	moving = 1;
	type = 1;
	style = 0;
	x = "0.0004 * 66 * safezoneW + 0.1 * safezoneW + safezoneX";
	y = "0.0004 * 1051 * safezoneW + 0.2 * safezoneH + safezoneY";
	w = "0.0004 * 143 * safezoneW";
	h = "0.0004 * 51 * safezoneW";
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
	onButtonClick = QUOTE([-1] call FUNC(nextChecklist));
};
class buttonNext_base: buttonPrevious_base {
	idc = 1802;
	x = "0.0004 * 476 * safezoneW + 0.1 * safezoneW + safezoneX";
	y = "0.0004 * 1051 * safezoneW + 0.2 * safezoneH + safezoneY";
	w = "0.0004 * 113 * safezoneW";
	h = "0.0004 * 51 * safezoneW";
	onButtonClick = QUOTE([1] call FUNC(nextChecklist));
}; */
