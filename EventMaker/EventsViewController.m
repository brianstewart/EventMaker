#import "EventsViewController.h"
#import "Event.h"

@implementation EventsViewController {
    NSMutableArray *_events;
    NSMutableArray *_finishedEvents;
    NSMutableArray *_currentEvents;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    Event *event1 = [[Event alloc] initEventWithName:@"Event" startDate:@"July 1, 2012" andEndDate:@"July 2, 2012"];
    Event *event2 = [[Event alloc] initEventWithName:@"Something" startDate:@"July 3, 2012" andEndDate:@"July 8, 2012"];
    Event *event3 = [[Event alloc] initEventWithName:@"Unfinished event" startDate:@"July 9, 2012" andEndDate:@"July 27, 2012"];
    
    // Load the array with all our events
    _events = [NSMutableArray arrayWithObject:event1];
    
    _finishedEvents = [NSMutableArray arrayWithArray:_events];
    _currentEvents  = [NSMutableArray arrayWithObjects:event2,event3, nil];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return @"Finished events";
    return @"Current events";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return _finishedEvents.count;
    return _currentEvents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell"];
    
#define kImageViewTag 99
#define kNameTag      100
#define kDateTag      101
#define kPhotosTag    102
    
    // Grab the parts of the cell
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:kImageViewTag];
    UILabel *name = (UILabel *)[cell viewWithTag:kNameTag];
    UILabel *date = (UILabel *)[cell viewWithTag:kDateTag];
    UILabel *photos = (UILabel *)[cell viewWithTag:kPhotosTag];
    
    // Style the image view
//    imageView.backgroundColor = [UIColor whiteColor];
    imageView.layer.borderColor   = [UIColor whiteColor].CGColor;
    imageView.layer.borderWidth   = 2.0;
    imageView.layer.shadowColor   = [UIColor blackColor].CGColor;
    imageView.layer.shadowOpacity = 1.0;
    imageView.layer.shadowRadius  = 2.0;
    imageView.layer.shadowOffset  = CGSizeMake(1.0, 1.0);
    
    Event *event;
    
    // Add the text
    if (indexPath.section == 0) {
        event = [_finishedEvents objectAtIndex:indexPath.row];
    } else {
        event = [_currentEvents objectAtIndex:indexPath.row];
    }
    
    name.text = event.name;
    date.text = [event.startDate stringByAppendingFormat:@" - %@",event.endDate];
    photos.text = @"14 PHOTOS";
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
        return NO;
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_currentEvents removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }   
}

//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
//}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Prepare for segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"NewEvent"]) {
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        NewEventViewController *viewController = (NewEventViewController *)[[navController viewControllers] objectAtIndex:0];
        viewController.delegate = self;
    }
}

#pragma mark - NewEvent delegate
- (void)newEventViewControllerDidFinishEvent:(Event *)event {
    [_currentEvents addObject:event];
    [self.tableView reloadData];
}

- (void)newEventViewControllerDidCancel {
}

@end






