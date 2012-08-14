#import "EventsViewController.h"
#import "EventManager.h"
#import "Event.h"
#import "Photo.h"

@implementation EventsViewController {
    EventManager *_eventManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Get the event manager
    _eventManager = [EventManager sharedManager];
    
    // Refresh after a few seconds
    [self performBlock:^{
        [self.tableView reloadData];
    } AfterTimeInterval:3.0];
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
        return _eventManager.finishedEvents.count;
    return _eventManager.currentEvents.count;
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
    
    // Get the currect event
    Event *event;
    if (indexPath.section == 0) {
        event = [_eventManager.finishedEvents objectAtIndex:indexPath.row];
    } else {
        event = [_eventManager.currentEvents objectAtIndex:indexPath.row];
    }
    
    if (event.photos.count > 0)
        imageView.image = ((Photo *)[event.photos objectAtIndex:0]).thumbnail;
    
    // Add the text
    name.text = event.name;
    date.text = [event dateRange];
    
    int numberOfPhotos = event.photos.count;
    NSString *photosString = [NSString stringWithFormat:@"%i %@",numberOfPhotos, (numberOfPhotos == 1) ? @"Photo": @"Photos"];
    
    photos.text = photosString;
    
    return cell;
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0)
//        return NO;
//    return YES;
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == 0)
            [_eventManager.finishedEvents removeObjectAtIndex:indexPath.row];
        else
            [_eventManager.currentEvents removeObjectAtIndex:indexPath.row];
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
    [_eventManager saveEvent:event];
    [self.tableView reloadData];
}

- (void)newEventViewControllerDidCancel {
}

@end






