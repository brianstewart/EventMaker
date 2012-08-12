#import "Event.h"

@implementation Event

- (id)initEventWithName:(NSString *)name startDate:(NSString *)startDate andEndDate:(NSString *)endDate {
    self = [super init];
    if (self) {
        _name = name;
        _startDate = startDate;
        _endDate = endDate;
    }
    return self;
}

@end