#import <UIKit/UIKit.h>

@class Event;

@protocol NewEventViewControllerDelegate <NSObject>
-(void)newEventViewControllerDidFinishEvent:(Event *)event;
-(void)newEventViewControllerDidCancel;
@end

@interface NewEventViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, weak) id <NewEventViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *startDate;
@property (weak, nonatomic) IBOutlet UILabel *endDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

#pragma mark - Actions
- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)dateChanged:(id)sender;

@end
