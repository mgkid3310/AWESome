// #define DEV_MODE 1

#ifdef DEV_MODE
	#define DEV_CHAT(TEXT) systemChat TEXT
	#define DEV_LOG(TEXT) diag_log TEXT
#else
	#define DEV_CHAT(TEXT)
	#define DEV_LOG(TEXT)
#endif
