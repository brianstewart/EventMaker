#import "EventsViewController.h"
#import "EventCell.h"
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
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell"];
    
    // Get the currect event
    Event *event;
    if (indexPath.section == 0)
        event = [_eventManager.finishedEvents objectAtIndex:indexPath.row];
    else
        event = [_eventManager.currentEvents objectAtIndex:indexPath.row];
    
    cell.name.text = event.name;
    cell.date.text = [event dateRange];
    if (event.photos.count > 0) cell.thumbnail.image = ((Photo *)[event.photos objectAtIndex:0]).thumbnail;
    cell.photosCount.text = [NSString stringWithFormat:@"%i",event.photos.count];
    cell.photosIcon.image = (event.photos.count <= 1) ? [UIImage imageNamed:@"single_photo_icon.png"] : [UIImage imageNamed:@"double_photo_icon.png"];
    
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
    [self.tableView reloadData];
}

#pragma mark - Actions
- (IBAction)refresh:(id)sender {
    [_eventManager updateEvents];
    
    // Refresh after a few seconds
    [self performBlock:^{
        [self.tableView reloadData];
    } AfterTimeInterval:3.0];
}
@end






