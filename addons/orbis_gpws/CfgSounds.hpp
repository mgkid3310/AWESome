#define F16_VOL 20
#define F16_VOL_LOW 6
#define B747_VOL 15
#define B747_VOL_LOW 4

class CfgSounds {
	// F16 GPWS
	class f16_altitude {
		name = "F16 Altitude";
		length = 2.14;
		sound[] = {"orbis_gpws\sounds\f16\ALTITUDE.ogg", F16_VOL, 1};
		titles[] = {};
	};
	class f16_altitude_low: f16_altitude {
		sound[] = {"orbis_gpws\sounds\f16\ALTITUDE.ogg", F16_VOL_LOW, 1};
	};
	class f16_bingo {
		name = "F16 Bingo";
		length = 1.73;
		sound[] = {"orbis_gpws\sounds\f16\BINGO.ogg", F16_VOL, 1};
		titles[] = {};
	};
	class f16_bingo_low: f16_bingo {
		sound[] = {"orbis_gpws\sounds\f16\BINGO.ogg", F16_VOL_LOW, 1};
	};
	class f16_caution {
		name = "F16 Caution";
		length = 1.90;
		sound[] = {"orbis_gpws\sounds\f16\CAUTION.ogg", F16_VOL, 1};
		titles[] = {};
	};
	class f16_caution_low: f16_caution {
		sound[] = {"orbis_gpws\sounds\f16\CAUTION.ogg", F16_VOL_LOW, 1};
	};
	class f16_chaffFlare {
		name = "F16 Chaff Flare";
		length = 0.86;
		sound[] = {"orbis_gpws\sounds\f16\CHAFF_FLARE.ogg", F16_VOL, 1};
		titles[] = {};
	};
	class f16_chaffFlare_low: f16_chaffFlare {
		sound[] = {"orbis_gpws\sounds\f16\CHAFF_FLARE.ogg", F16_VOL_LOW, 1};
	};
	class f16_chaffFlareLow {
		name = "F16 Chaff Flare Low";
		length = 1.34;
		sound[] = {"orbis_gpws\sounds\f16\CHAFF_FLARE_LOW.ogg", F16_VOL, 1};
		titles[] = {};
	};
	class f16_chaffFlareLow_low: f16_chaffFlareLow {
		sound[] = {"orbis_gpws\sounds\f16\CHAFF_FLARE_LOW.ogg", F16_VOL_LOW, 1};
	};
	class f16_chaffFlareOut {
		name = "F16 Chaff Flare Out";
		length = 1.26;
		sound[] = {"orbis_gpws\sounds\f16\CHAFF_FLARE_OUT.ogg", F16_VOL, 1};
		titles[] = {};
	};
	class f16_chaffFlareOut_low: f16_chaffFlareOut {
		sound[] = {"orbis_gpws\sounds\f16\CHAFF_FLARE_OUT.ogg", F16_VOL_LOW, 1};
	};
	class f16_counter {
		name = "F16 Counter";
		length = 0.67;
		sound[] = {"orbis_gpws\sounds\f16\COUNTER.ogg", F16_VOL, 1};
		titles[] = {};
	};
	class f16_counter_low: f16_counter {
		sound[] = {"orbis_gpws\sounds\f16\COUNTER.ogg", F16_VOL_LOW, 1};
	};
	class f16_data {
		name = "F16 Data";
		length = 0.42;
		sound[] = {"orbis_gpws\sounds\f16\DATA.ogg", F16_VOL, 1};
		titles[] = {};
	};
	class f16_data_low: f16_data {
		sound[] = {"orbis_gpws\sounds\f16\DATA.ogg", F16_VOL_LOW, 1};
	};
	class f16_highAOA {
		name = "F16 High AOA";
		length = 0.999;
		sound[] = {"orbis_gpws\sounds\f16\HIGH_AOA.ogg", F16_VOL, 1};
		titles[] = {};
	};
	class f16_highAOA_low: f16_highAOA {
		sound[] = {"orbis_gpws\sounds\f16\HIGH_AOA.ogg", F16_VOL_LOW, 1};
	};
	class f16_IFF {
		name = "F16 IFF";
		length = 0.97;
		sound[] = {"orbis_gpws\sounds\f16\IFF.ogg", F16_VOL, 1};
		titles[] = {};
	};
	class f16_IFF_low: f16_IFF {
		sound[] = {"orbis_gpws\sounds\f16\IFF.ogg", F16_VOL_LOW, 1};
	};
	class f16_jammer {
		name = "F16 Jammer";
		length = 0.54;
		sound[] = {"orbis_gpws\sounds\f16\JAMMER.ogg", F16_VOL, 1};
		titles[] = {};
	};
	class f16_jammer_low: f16_jammer {
		sound[] = {"orbis_gpws\sounds\f16\JAMMER.ogg", F16_VOL_LOW, 1};
	};
	class f16_lock {
		name = "F16 Lock";
		length = 0.61;
		sound[] = {"orbis_gpws\sounds\f16\LOCK.ogg", F16_VOL, 1};
		titles[] = {};
	};
	class f16_lock_low: f16_lock {
		sound[] = {"orbis_gpws\sounds\f16\LOCK.ogg", F16_VOL_LOW, 1};
	};
	class f16_lowSpeed {
		name = "F16 Low Speed";
		length = 1.50;
		sound[] = {"orbis_gpws\sounds\f16\LOW_SPEED.ogg", F16_VOL, 1};
		titles[] = {};
	};
	class f16_lowSpeed_low: f16_lowSpeed {
		sound[] = {"orbis_gpws\sounds\f16\LOW_SPEED.ogg", F16_VOL_LOW, 1};
	};
	class f16_pullUp {
		name = "F16 Pull Up";
		length = 1.58;
		sound[] = {"orbis_gpws\sounds\f16\PULL_UP.ogg", F16_VOL, 1};
		titles[] = {};
	};
	class f16_pullUp_low: f16_pullUp {
		sound[] = {"orbis_gpws\sounds\f16\PULL_UP.ogg", F16_VOL_LOW, 1};
	};
	class f16_SAM {
		name = "F16 SAM";
		length = 0.80;
		sound[] = {"orbis_gpws\sounds\f16\SAM.ogg", F16_VOL, 1.005};
		titles[] = {};
	};
	class f16_SAM_low: f16_SAM {
		sound[] = {"orbis_gpws\sounds\f16\SAM.ogg", F16_VOL_LOW, 1};
	};
	class f16_warning {
		name = "F16 Warning";
		length = 2.20;
		sound[] = {"orbis_gpws\sounds\f16\WARNING.ogg", F16_VOL, 1};
		titles[] = {};
	};
	class f16_warning_low: f16_warning {
		sound[] = {"orbis_gpws\sounds\f16\WARNING.ogg", F16_VOL_LOW, 1};
	};

	// Large planes GPWS (C130 & larger)
	class b747_10 {
		name = "Large 10";
		length = 0.356;
		sound[] = {"orbis_gpws\sounds\b747\10.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_10_low: b747_10 {
		sound[] = {"orbis_gpws\sounds\b747\10.ogg", B747_VOL_LOW, 1};
	};
	class b747_20 {
		name = "Large 20";
		length = 0.413;
		sound[] = {"orbis_gpws\sounds\b747\20.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_20_low: b747_20 {
		sound[] = {"orbis_gpws\sounds\b747\20.ogg", B747_VOL_LOW, 1};
	};
	class b747_30 {
		name = "Large 30";
		length = 0.400;
		sound[] = {"orbis_gpws\sounds\b747\30.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_30_low: b747_30 {
		sound[] = {"orbis_gpws\sounds\b747\30.ogg", B747_VOL_LOW, 1};
	};
	class b747_40 {
		name = "Large 40";
		length = 0.450;
		sound[] = {"orbis_gpws\sounds\b747\40.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_40_low: b747_40 {
		sound[] = {"orbis_gpws\sounds\b747\40.ogg", B747_VOL_LOW, 1};
	};
	class b747_50 {
		name = "Large 50";
		length = 0.472;
		sound[] = {"orbis_gpws\sounds\b747\50.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_50_low: b747_50 {
		sound[] = {"orbis_gpws\sounds\b747\50.ogg", B747_VOL_LOW, 1};
	};
	class b747_100 {
		name = "Large 100";
		length = 0.834;
		sound[] = {"orbis_gpws\sounds\b747\100.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_100_low: b747_100 {
		sound[] = {"orbis_gpws\sounds\b747\100.ogg", B747_VOL_LOW, 1};
	};
	class b747_200 {
		name = "Large 200";
		length = 0.772;
		sound[] = {"orbis_gpws\sounds\b747\200.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_200_low: b747_200 {
		sound[] = {"orbis_gpws\sounds\b747\200.ogg", B747_VOL_LOW, 1};
	};
	class b747_300 {
		name = "Large 300";
		length = 0.960;
		sound[] = {"orbis_gpws\sounds\b747\300.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_300_low: b747_300 {
		sound[] = {"orbis_gpws\sounds\b747\300.ogg", B747_VOL_LOW, 1};
	};
	class b747_400 {
		name = "Large 400";
		length = 0.853;
		sound[] = {"orbis_gpws\sounds\b747\400.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_400_low: b747_400 {
		sound[] = {"orbis_gpws\sounds\b747\400.ogg", B747_VOL_LOW, 1};
	};
	class b747_500 {
		name = "Large 500";
		length = 0.967;
		sound[] = {"orbis_gpws\sounds\b747\500.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_500_low: b747_500 {
		sound[] = {"orbis_gpws\sounds\b747\500.ogg", B747_VOL_LOW, 1};
	};
	class b747_1000 {
		name = "Large 1000";
		length = 0.934;
		sound[] = {"orbis_gpws\sounds\b747\1000.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_1000_low: b747_1000 {
		sound[] = {"orbis_gpws\sounds\b747\1000.ogg", B747_VOL_LOW, 1};
	};
	class b747_ALTALRT {
		name = "Large ALTALRT";
		length = 0.763;
		sound[] = {"orbis_gpws\sounds\b747\ALTALRT.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_ALTALRT_low: b747_ALTALRT {
		sound[] = {"orbis_gpws\sounds\b747\ALTALRT.ogg", B747_VOL_LOW, 1};
	};
	class b747_ALTENTR {
		name = "Large ALTENTR";
		length = 1.083;
		sound[] = {"orbis_gpws\sounds\b747\ALTENTR.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_ALTENTR_low: b747_ALTENTR {
		sound[] = {"orbis_gpws\sounds\b747\ALTENTR.ogg", B747_VOL_LOW, 1};
	};
	class b747_APDISCO {
		name = "Large APDISCO";
		length = 1.311;
		sound[] = {"orbis_gpws\sounds\b747\APDISCO.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_APDISCO_low: b747_APDISCO {
		sound[] = {"orbis_gpws\sounds\b747\APDISCO.ogg", B747_VOL_LOW, 1};
	};
	class b747_APPRMIN {
		name = "Large APPRMIN";
		length = 1.414;
		sound[] = {"orbis_gpws\sounds\b747\APPRMIN.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_APPRMIN_low: b747_APPRMIN {
		sound[] = {"orbis_gpws\sounds\b747\APPRMIN.ogg", B747_VOL_LOW, 1};
	};
	class b747_ATTEND {
		name = "Large ATTEND";
		length = 1.000;
		sound[] = {"orbis_gpws\sounds\b747\ATTEND.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_ATTEND_low: b747_ATTEND {
		sound[] = {"orbis_gpws\sounds\b747\ATTEND.ogg", B747_VOL_LOW, 1};
	};
	class b747_BNKANGL {
		name = "Large BNKANGL";
		length = 0.891;
		sound[] = {"orbis_gpws\sounds\b747\BNKANGL.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_BNKANGL_low: b747_BNKANGL {
		sound[] = {"orbis_gpws\sounds\b747\BNKANGL.ogg", B747_VOL_LOW, 1};
	};
	class b747_CHIME {
		name = "Large CHIME";
		length = 0.612;
		sound[] = {"orbis_gpws\sounds\b747\CHIME.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_CHIME_low: b747_CHIME {
		sound[] = {"orbis_gpws\sounds\b747\CHIME.ogg", B747_VOL_LOW, 1};
	};
	class b747_DONTSNK {
		name = "Large DONTSNK";
		length = 0.758;
		sound[] = {"orbis_gpws\sounds\b747\DONTSNK.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_DONTSNK_low: b747_DONTSNK {
		sound[] = {"orbis_gpws\sounds\b747\DONTSNK.ogg", B747_VOL_LOW, 1};
	};
	class b747_FLAPS {
		name = "Large FLAPS";
		length = 1.182;
		sound[] = {"orbis_gpws\sounds\b747\FLAPS.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_FLAPS_low: b747_FLAPS {
		sound[] = {"orbis_gpws\sounds\b747\FLAPS.ogg", B747_VOL_LOW, 1};
	};
	class b747_GEAR {
		name = "Large GEAR";
		length = 0.941;
		sound[] = {"orbis_gpws\sounds\b747\GEAR.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_GEAR_low: b747_GEAR {
		sound[] = {"orbis_gpws\sounds\b747\GEAR.ogg", B747_VOL_LOW, 1};
	};
	class b747_GLIDESLOPE {
		name = "Large GLIDESLOPE";
		length = 0.833;
		sound[] = {"orbis_gpws\sounds\b747\GLIDESLOPE.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_GLIDESLOPE_low: b747_GLIDESLOPE {
		sound[] = {"orbis_gpws\sounds\b747\GLIDESLOPE.ogg", B747_VOL_LOW, 1};
	};
	class b747_MIN {
		name = "Large MIN";
		length = 0.754;
		sound[] = {"orbis_gpws\sounds\b747\MIN.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_MIN_low: b747_MIN {
		sound[] = {"orbis_gpws\sounds\b747\MIN.ogg", B747_VOL_LOW, 1};
	};
	class b747_PULLUP {
		name = "Large PULLUP";
		length = 1.265;
		sound[] = {"orbis_gpws\sounds\b747\PULLUP.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_PULLUP_low: b747_PULLUP {
		sound[] = {"orbis_gpws\sounds\b747\PULLUP.ogg", B747_VOL_LOW, 1};
	};
	class b747_SNKRATE {
		name = "Large SNKRATE";
		length = 0.730;
		sound[] = {"orbis_gpws\sounds\b747\SNKRATE.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_SNKRATE_low: b747_SNKRATE {
		sound[] = {"orbis_gpws\sounds\b747\SNKRATE.ogg", B747_VOL_LOW, 1};
	};
	class b747_TERRAIN {
		name = "Large TERRAIN";
		length = 0.511;
		sound[] = {"orbis_gpws\sounds\b747\TERRAIN.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_TERRAIN_low: b747_TERRAIN {
		sound[] = {"orbis_gpws\sounds\b747\TERRAIN.ogg", B747_VOL_LOW, 1};
	};
	class b747_TOOLOWT {
		name = "Large TOOLOWT";
		length = 1.007;
		sound[] = {"orbis_gpws\sounds\b747\TOOLOWT.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_TOOLOWT_low: b747_TOOLOWT {
		sound[] = {"orbis_gpws\sounds\b747\TOOLOWT.ogg", B747_VOL_LOW, 1};
	};
	class b747_TOWARN {
		name = "Large TOWARN";
		length = 1.751;
		sound[] = {"orbis_gpws\sounds\b747\TOWARN.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_TOWARN_low: b747_TOWARN {
		sound[] = {"orbis_gpws\sounds\b747\TOWARN.ogg", B747_VOL_LOW, 1};
	};
	class b747_TRIM {
		name = "Large TRIM";
		length = 0.686;
		sound[] = {"orbis_gpws\sounds\b747\TRIM.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_TRIM_low: b747_TRIM {
		sound[] = {"orbis_gpws\sounds\b747\TRIM.ogg", B747_VOL_LOW, 1};
	};
	class b747_WINDSHR {
		name = "Large WINDSHR";
		length = 3.000;
		sound[] = {"orbis_gpws\sounds\b747\WINDSHR.ogg", B747_VOL, 1};
		titles[] = {};
	};
	class b747_WINDSHR_low: b747_WINDSHR {
		sound[] = {"orbis_gpws\sounds\b747\WINDSHR.ogg", B747_VOL_LOW, 1};
	};
};
