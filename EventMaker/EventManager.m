#import "EventManager.h"
#import "Event.h"
#import "Photo.h"

static EventManager *inst = nil;

@implementation EventManager {
    PhotoLibrary *_photoLibrary;
}

#pragma mark - Singleton
+ (EventManager *)sharedManager {
    if (!inst)
        inst = [[EventManager alloc] init];
    return inst;
}

#pragma mark - Initialization
- (id)init {
    self = [super init];
    if (self) {
        _photoLibrary = [[PhotoLibrary alloc] init];
        [_photoLibrary setDelegate:self];
        [self loadEvents];
    }
    return self;
}

#pragma mark - Event store
- (void)loadEvents {
    
    Event *finishedEvent = [[Event alloc] initEventWithName:@"Test" startDate:daysAgo(6, YES) andEndDate:daysAgo(2, YES)];
    
    _finishedEvents = [NSMutableArray arrayWithObject:finishedEvent];
    _currentEvents = [NSMutableArray array];
    
//    TODO: Load events
    
    
    // Only load photos if we need to
//    if (_currentEvents.count > 0) [_photoLibrary loadPhotos];
    [_photoLibrary loadPhotos];
}

- (void)saveEvent:(Event *)event {
    [_currentEvents addObject:event];
    
//    TODO: Save events
}

#pragma mark - Update
- (void)updateEvents {
    [_photoLibrary loadPhotos];
}

- (void)updateCurrentEvents:(NSArray *)photos {
//    TODO: Filter old photos
//    TODO: Save new photos
    
    for (int i = 0; i < _currentEvents.count; i++) {
        Event *event = [_currentEvents objectAtIndex:i];
        [event.photos removeAllObjects]; // TEMP
        for (Photo *photo in photos) {
            if ([event containsDate:[photo photoDate]])
                [event.photos addObject:photo];
        }
    }
    
    // TEMP PROBABLY
    for (int i = 0; i < _finishedEvents.count; i++) {
        Event *event = [_finishedEvents objectAtIndex:i];
        [event.photos removeAllObjects]; // TEMP
        for (Photo *photo in photos) {
            if ([event containsDate:[photo photoDate]])
                [event.photos addObject:photo];
        }
    }
    
    // If any events have passed their time, then place them in the finished pile
//    for (Event *event in _currentEvents) {
//        if (![event containsDate:[NSDate date]]) {
//            [_finishedEvents addObject:event];
//            [_currentEvents removeObject:event];
//        }
//    }
}

#pragma mark - Photo library delegate
- (void)photoLibraryDidLoadPhotos:(NSArray *)photos {
    [self updateCurrentEvents:photos];
}

@end