#import "Event.h"

@implementation Event

- (id)initEventWithName:(NSString *)name startDate:(NSDate *)startDate andEndDate:(NSDate *)endDate {
    self = [super init];
    if (self) {
        _name = name;
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

@end