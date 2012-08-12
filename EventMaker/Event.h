#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *startDate;
@property (nonatomic, strong) NSString *endDate;
@property (nonatomic, strong) NSArray  *photos;

-(id)initEventWithName:(NSString *)name
             startDate:(NSString *)startDate
            andEndDate:(NSString *)endDate;

@end