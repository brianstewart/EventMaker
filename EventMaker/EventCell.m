#import "EventCell.h"

@implementation EventCell

- (void)awakeFromNib {
    _thumbnail.layer.borderColor   = [UIColor whiteColor].CGColor;
    _thumbnail.layer.borderWidth   = 2.0;
    _thumbnail.layer.shadowColor   = [UIColor blackColor].CGColor;
    _thumbnail.layer.shadowOpacity = 1.0;
    _thumbnail.layer.shadowRadius  = 2.0;
    _thumbnail.layer.shadowOffset  = CGSizeMake(1.0, 1.0);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end