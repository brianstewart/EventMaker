#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *date;

-(id)initPhotoWithName:(NSString *)name andDate:(NSDate *)date;
@end