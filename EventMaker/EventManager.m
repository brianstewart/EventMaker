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
        [_photoLibrary loadPhotos];
        [self loadEvents];
    }
    return self;
}

#pragma mark - Event store
- (void)loadEvents {
    _finishedEvents = [NSMutableArray array];
    _currentEvents = [NSMutableArray array];
    
//    TODO: Load events
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
}

#pragma mark - Photo library delegate
- (void)photoLibraryDidLoadPhotos:(NSArray *)photos {
    [self updateCurrentEvents:photos];
}

@end