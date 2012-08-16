#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface EventCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *photosCount;
@property (weak, nonatomic) IBOutlet UIImageView *photosIcon;
@end