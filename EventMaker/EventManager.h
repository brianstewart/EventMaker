#import <Foundation/Foundation.h>
#import "PhotoLibrary.h"

@class Event;

@interface EventManager : NSObject <PhotoLibraryDelegate>

@property (nonatomic, strong) NSMutableArray *events;
@property (nonatomic, strong) NSMutableArray *finishedEvents;
@property (nonatomic, strong) NSMutableArray *currentEvents;

#pragma mark - Singleton
+(EventManager *)sharedManager;

#pragma - Event store
-(void)saveEvent:(Event *)event;

#pragma mark - Update
-(void)updateEvents;

@end