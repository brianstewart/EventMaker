#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) UIImage *thumbnail;

-(id)initPhotoWithName:(NSString *)name andDate:(NSDate *)date;

-(NSDate *)photoDate;
@end