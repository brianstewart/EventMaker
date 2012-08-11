#import "UIColor+BSColors.h"

@implementation UIColor (BSColors)

+ (UIColor *)offWhiteColorWithAlpha:(CGFloat)alpha {
    return [[UIColor alloc] initWithRed:(249.0 / 255.0) green:(246.0 / 255.0) blue:(228.0 / 255.0) alpha:alpha];
}

+ (UIColor *)niceGreenColorWithAlpha:(CGFloat)alpha {
    return [[UIColor alloc] initWithRed:(42.0 / 255.0) green:(194.0 / 255.0) blue:(10.0 / 255.0) alpha:alpha];
}

+ (UIColor *)niceRedColorWithAlpha:(CGFloat)alpha {
    return [[UIColor alloc] initWithRed:(232.0 / 255.0) green:(12.0 / 255.0) blue:(31.0 / 255.0) alpha:alpha];
}

#pragma mark - Luscher colors
+ (UIColor *)luscherGreenColor {
    return [UIColor colorWithRed:(36.0 / 255.0) green:(73.0 / 255.0) blue:(66.0 / 255.0) alpha:1.0];
}

+ (UIColor *)luscherBlueColor {
    return [UIColor colorWithRed:(27.0 / 255.0) green:(27.0 / 255.0) blue:(91.0 / 255.0) alpha:1.0];
}

+ (UIColor *)luscherBlackColor {
    return [UIColor colorWithRed:(21.0 / 255.0) green:(8.0 / 255.0) blue:(17.0 / 255.0) alpha:1.0];
}

+ (UIColor *)luscherYellowColor {
    return [UIColor colorWithRed:(244.0 / 255.0) green:(218.0 / 255.0) blue:(59.0 / 255.0) alpha:1.0];
}

+ (UIColor *)luscherGrayColor {
    return [UIColor colorWithRed:(117.0 / 255.0) green:(113.0 / 255.0) blue:(102.0 / 255.0) alpha:1.0];
}

+ (UIColor *)luscherPurpleColor {
    return [UIColor colorWithRed:(156.0 / 255.0) green:(35.0 / 255.0) blue:(78.0 / 255.0) alpha:1.0];
}

+ (UIColor *)luscherOrangeColor {
    return [UIColor colorWithRed:(222.0 / 255.0) green:(69.0 / 255.0) blue:(35.0 / 255.0) alpha:1.0];
}

+ (UIColor *)luscherBrownColor {
    return [UIColor colorWithRed:(175.0 / 255.0) green:(94.0 / 255.0) blue:(41.0 / 255.0) alpha:1.0];
}
@end


