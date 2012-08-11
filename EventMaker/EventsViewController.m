#import "EventsViewController.h"

@implementation EventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell"];
    
#define kImageViewTag 99
#define kNameTag      100
#define kDateTag      101
#define kPhotosTag    102
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:kImageViewTag];
    UILabel *name = (UILabel *)[cell viewWithTag:kNameTag];
    UILabel *date = (UILabel *)[cell viewWithTag:kDateTag];
    UILabel *photos = (UILabel *)[cell viewWithTag:kPhotosTag];
    
    imageView.layer.borderColor   = [UIColor whiteColor].CGColor;
    imageView.layer.borderWidth   = 2.0;
    imageView.layer.shadowColor   = [UIColor blackColor].CGColor;
    imageView.layer.shadowOpacity = 1.0;
    imageView.layer.shadowRadius  = 2.0;
    imageView.layer.shadowOffset  = CGSizeMake(1.0, 1.0);
    
    name.text = @"EVENT";
    date.text = @"WHENEVER";
    photos.text = @"14 PHOTOS";
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Actions
- (IBAction)newEvent:(id)sender {
    [BSAlert alert];
}
@end
