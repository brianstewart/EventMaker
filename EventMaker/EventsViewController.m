#import "EventsViewController.h"

@implementation EventsViewController {
    NSMutableArray *_events;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Load the array with all our events
    _events = [NSMutableArray arrayWithObject:@""];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _events.count;
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
    imageView.layer.borderColor   = [UIColor whiteColor].CGColor;
    imageView.layer.borderWidth   = 2.0;
    imageView.layer.shadowColor   = [UIColor blackColor].CGColor;
    imageView.layer.shadowOpacity = 1.0;
    imageView.layer.shadowRadius  = 2.0;
    imageView.layer.shadowOffset  = CGSizeMake(1.0, 1.0);
    
    // Add the text
    name.text = @"Event";
    date.text = @"July 14 - July 15";
    photos.text = @"14 PHOTOS";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_events removeObjectAtIndex:indexPath.row];
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
- (void)newEventViewControllerDidFinish {
    [_events addObject:@""];
    [self.tableView reloadData];
}

- (void)newEventViewControllerDidCancel {
}

@end






