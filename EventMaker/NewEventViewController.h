#import <UIKit/UIKit.h>

@protocol NewEventViewControllerDelegate <NSObject>
-(void)newEventViewControllerDidFinish;
-(void)newEventViewControllerDidCancel;
@end

@interface NewEventViewController : UITableViewController

@property (nonatomic, weak) id <NewEventViewControllerDelegate> delegate;

#pragma mark - Actions
- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
