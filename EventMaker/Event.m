#import "Event.h"

@implementation Event {
    NSDate *_eventStartDate;
    NSDate *_eventEndDate;
}

- (id)initEventWithName:(NSString *)name startDate:(NSDate *)startDate andEndDate:(NSDate *)endDate {
    self = [super init];
    if (self) {
        _name = name;
        
        _eventStartDate = startDate;
        _eventEndDate = endDate;
        
        _photos = [NSMutableArray array];
        
        _startDate = [NSDateFormatter localizedStringFromDate:startDate dateStyle:NSDateFormatterLongStyle
                                                    timeStyle:NSDateFormatterNoStyle];
        _endDate = [NSDateFormatter localizedStringFromDate:endDate dateStyle:NSDateFormatterLongStyle
                                                  timeStyle:NSDateFormatterNoStyle];
    }
    return self;
}

#pragma mark - Date range
- (NSString *)dateRange {
    return [NSString stringWithFormat:@"%@ - %@",_startDate,_endDate];
}

#pragma mark - Contains date
- (BOOL)containsDate:(NSDate *)date {
    
    if ([[_eventStartDate laterDate:date] isEqualToDate:date] && [[_eventEndDate laterDate:date] isEqualToDate:_eventEndDate])
        return YES;
    return NO;
}

@end