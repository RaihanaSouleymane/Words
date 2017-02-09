#import "UIImage+ColorGenerator.h"

@implementation UIImage (ColorGenerator)

+ (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)radius
                      frame:(CGRect)frame {

    UIGraphicsBeginImageContext(frame.size);
    [[UIBezierPath bezierPathWithRoundedRect:frame
                                cornerRadius:radius] addClip];
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, frame);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

@end
