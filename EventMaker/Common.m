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

id daysFromToday(int days, BOOL date) {
    NSDate *theDate = [[NSDate date] dateByAddingTimeInterval:60*60*24*days];
    if (!date)
        return [NSDateFormatter localizedStringFromDate:theDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
    else
        return theDate;
}

id daysAgo(int days, BOOL date) {
    return daysFromToday((days * -1), date); // negative numbers go backwards
}

id nextHour(BOOL date) {
    return hourFromDate([NSDate date], date);
}

id hourFromDate(NSDate *aDate, BOOL date) {
    NSDate *hour = [aDate dateByAddingTimeInterval:(60*60)];
    NSDate *theDate = [aDate dateByAddingTimeInterval:(hour.timeIntervalSinceReferenceDate - aDate.timeIntervalSinceReferenceDate)];
    if (!date)
        return [NSDateFormatter localizedStringFromDate:theDate dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
    else
        return theDate;
}

id nextFiveMinuteInterval(BOOL date) {
    NSDate *now = [NSDate date];
    
    // Find out how many minutes away we are from a five minute interval
    int minutes = (int)(now.timeIntervalSinceReferenceDate / 60);
    int minutesToInterval = (5 - (minutes % 5));
    
    // If we are already on an interval than don't change the time
    if (minutesToInterval % 5 == 0) minutesToInterval = 0;
    
    NSDate *five = [now dateByAddingTimeInterval:(60 * minutesToInterval)];
    NSDate *theDate = [now dateByAddingTimeInterval:(five.timeIntervalSinceReferenceDate - now.timeIntervalSinceReferenceDate)];
    
    if (!date)
        return [NSDateFormatter localizedStringFromDate:theDate dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
    else
        return theDate;
}

int timeDifference(NSDate *firstDate, NSDate *secondDate) {
    if ([[firstDate laterDate:secondDate] isEqualToDate:firstDate])
        return ((int)firstDate.timeIntervalSinceReferenceDate - (int)secondDate.timeIntervalSinceReferenceDate);
    else
        return ((int)secondDate.timeIntervalSinceReferenceDate - (int)firstDate.timeIntervalSinceReferenceDate);
}

NSString* timeApart(NSDate *firstDate, NSDate *secondDate) {
    
    int timeApart = timeDifference(firstDate, secondDate);
    NSString *measurement = @"";
    
    dbgLog(@"time apart: %i",timeApart);
    
    if (timeApart < 60) {
        timeApart = (60 - (60 - timeApart));
        measurement = (timeApart > 1) ?  @"Seconds": @"Second";
    } else if (timeApart < (60 * 60)) {
        timeApart = (3600 - (3600 - (timeApart))) / 60;
        measurement = (timeApart > 1) ?  @"Minutes": @"Minute";
    } else if (timeApart < (60 * 60 * 24)) {
        timeApart = (86400 - (86400 - (timeApart))) / (60*60);
        measurement = (timeApart > 1) ?  @"Hours": @"Hour";
    } else if (timeApart < (60 * 60 * 24 * 7)) {
        timeApart = (604800 - (604800 - (timeApart))) / 86400;
        measurement = (timeApart > 1) ?  @"Days": @"Day";
    } else {
        measurement = @"A very long time apart";
    }
    
    return [NSString stringWithFormat:@"%i %@",timeApart, measurement];
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

