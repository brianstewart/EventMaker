
#pragma mark - General
NSString* currentVersion(void);

#pragma mark - Date stuff
NSString* timeStamp(void);

// simplifies date stuff
// YES returns a date
// NO  returns a string
id todaysDate(BOOL);
id tomorrowsDate(BOOL);

// Returns a date the specified number of days from the today
// 1st parameter is number of days
// 2nd parameter is same as the rest
id dateFromToday(int,BOOL);

// Same as dateFromToday except it goes backward
id daysAgo(int, BOOL);

#pragma mark - Math

// 2*Pi; handy for trig math
#define M_PI_X_2 3.14159265358979323846264338327950288 * 2
double degreesToRadians(double);
double radiansToDegrees(double);

#pragma mark - Logging
// Does some craziness I don't understand
#if DEBUG
#include "pthread.h"
#define dbgLog(args...) _dbgLog(__FILE__, __LINE__, args)
void _dbgLog(const char* pszFile, int line, NSString* fmt, ...);
#define dbgAssert(arg) assert(arg)
#else
#define dbgLog(args...)	{}
#define dbgAssert(arg) {}
#endif