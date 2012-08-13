#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *startDate;
@property (nonatomic, strong) NSString *endDate;
@property (nonatomic, strong) NSArray  *photos;

-(id)initEventWithName:(NSString *)name
             startDate:(NSDate *)startDate
            andEndDate:(NSDate *)endDate;

#pragma mark - Date range
-(NSString *)dateRange;

@end