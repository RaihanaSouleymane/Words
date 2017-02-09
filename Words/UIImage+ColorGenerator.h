#import <UIKit/UIKit.h>

@interface UIImage (ColorGenerator)
+ (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)radius
                      frame:(CGRect)frame;
@end
