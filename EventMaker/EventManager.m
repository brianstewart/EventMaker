#import "EventManager.h"
#import "Event.h"
#import "Photo.h"

@implementation EventManager {
    PhotoLibrary *_photoLibrary;
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

#pragma mark - Load events
- (void)loadEvents {
    
//    TODO: Load the finished and current events
    
    Event *finishedEvent = [[Event alloc] initEventWithName:@"finished" startDate:todaysDate(YES) andEndDate:tomorrowsDate(YES)];
    Event *currentEvent  = [[Event alloc]  initEventWithName:@"Camping" startDate:daysAgo(3, YES) andEndDate:todaysDate(YES)];
    _finishedEvents = [NSMutableArray arrayWithObject:finishedEvent];
    _currentEvents = [NSMutableArray arrayWithObject:currentEvent];
}

#pragma mark - Update
- (void)updateEvents {
    [_photoLibrary loadPhotos];
}

- (void)updateCurrentEvents:(NSArray *)photos {
    // TODO: Filter old photos
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