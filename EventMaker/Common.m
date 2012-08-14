#import "Common.h"

#pragma mark - General
NSString* currentVersion(void) {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

#pragma mark - Date stuff
NSString* timeStamp(void) {
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [formatter stringFromDate:now];
}

id todaysDate(BOOL date) {
    NSDate *theDate = [NSDate date];
    if (!date)
        return [NSDateFormatter localizedStringFromDate:theDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
    else
        return theDate;
}

id tomorrowsDate(BOOL date) {
    NSDate *theDate = [[NSDate date] dateByAddingTimeInterval:60*60*24];
    if (!date)
        return [NSDateFormatter localizedStringFromDate:theDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
    else
        return theDate;
}

id dateFromToday(int days, BOOL date) {
    if (days == 0) return todaysDate(date);
    NSDate *theDate = [[NSDate date] dateByAddingTimeInterval:60*60*24*days];
    if (!date)
        return [NSDateFormatter localizedStringFromDate:theDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
    else
        return theDate;
}

id daysAgo(int days, BOOL date) {
    if (days == 0) return todaysDate(date);
    NSDate *theDate = [[NSDate date] dateByAddingTimeInterval:60*60*24*(days * -1)];
    if (!date)
        return [NSDateFormatter localizedStringFromDate:theDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
    else
        return theDate;
}

#pragma mark - Math
double degreesToRadians (double angle) {
    return angle * (M_PI/180);
}

double radiansToDegrees(double radians) {
    return radians * (180/M_PI);
}

#pragma mark - Logging
#if DEBUG

void _dbgLog(const char* pszFile, int line, NSString* fmt, ...) {
    char threadname[32] = "main";
    if (!pthread_main_np()) {
        mach_port_t tid = pthread_mach_thread_np(pthread_self());
        sprintf(threadname, "%d", tid);
    }
    
    va_list ap;
    va_start(ap, fmt);
    NSString* log = [[NSString alloc] initWithFormat:fmt arguments:ap];
    va_end(ap);
    
    const char* end = strrchr(pszFile, '/');
    fprintf(stderr, "[dbgLog %s-%s:%d] %s\n", threadname, end ? end+1 : pszFile, line, [log UTF8String]);
}

#endif

