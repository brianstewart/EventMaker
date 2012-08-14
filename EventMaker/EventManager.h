#import <Foundation/Foundation.h>
#import "PhotoLibrary.h"

@interface EventManager : NSObject <PhotoLibraryDelegate>

@property (nonatomic, strong) NSMutableArray *events;
@property (nonatomic, strong) NSMutableArray *finishedEvents;
@property (nonatomic, strong) NSMutableArray *currentEvents;

#pragma mark - Update
-(void)updateEvents;

@end