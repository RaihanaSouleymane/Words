#import <UIKit/UIKit.h>

@interface RoundedRectButton : UIButton
- (id)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor;

- (void)setCornerRadius:(CGFloat)radius
            shadowColor:(UIColor *)color
            shadowWidth:(CGFloat)shadowWidth;
@end
