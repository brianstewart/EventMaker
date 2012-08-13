#import "Photo.h"

@implementation Photo

- (id)initPhotoWithName:(NSString *)name andDate:(NSDate *)date {
    self = [super init];
    if (self) {
        _name = name;
        _date = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
    }
    return self;
}

@end