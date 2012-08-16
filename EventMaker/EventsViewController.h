#import <UIKit/UIKit.h>
#import "NewEventViewController.h"

@interface EventsViewController : UITableViewController <NewEventViewControllerDelegate>

- (IBAction)refresh:(id)sender;
@end