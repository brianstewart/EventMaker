#import "Photo.h"

@implementation Photo {
    NSDate *_photoDate;
}

- (id)initPhotoWithName:(NSString *)name andDate:(NSDate *)date {
    self = [super init];
    if (self) {
        _name = name;
        _date = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
        
        _photoDate = date;
    }
    return self;
}

- (NSDate *)photoDate {
    return _photoDate;
}

@end