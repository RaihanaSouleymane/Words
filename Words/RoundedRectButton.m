#import "RoundedRectButton.h"
#import "UIImage+ColorGenerator.h"

@implementation RoundedRectButton

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupButton];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = backgroundColor;
        [self setupButton];
    }
    return self;
}

- (void)setupButton {
    UIColor *shadowColor = [self shadowColorForBackgroundColor:self.backgroundColor];
    [self setCornerRadius:5.0 shadowColor:shadowColor shadowWidth:1.5f];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    [self setupButton];
}

- (UIColor *)shadowColorForBackgroundColor:(UIColor *)backgroundColor {
    CGFloat redColor;
    CGFloat greenColor;
    CGFloat blueColor;
    CGFloat alphaColor;

    [backgroundColor getRed:&redColor green:&greenColor blue:&blueColor alpha:&alphaColor];
    return [UIColor colorWithRed:redColor - 0.2
                           green:greenColor - 0.2
                            blue:blueColor - 0.2
                           alpha:1.0];
}

- (void)setCornerRadius:(CGFloat)radius
            shadowColor:(UIColor *)color
            shadowWidth:(CGFloat)shadowWidth {

    [self.layer setCornerRadius:radius];
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0f, shadowWidth);
    self.layer.shadowRadius = 0.0f;
    self.layer.shadowOpacity = 1.0;

    CGRect rect = self.bounds;
    CGRect rectWithShadow = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height + shadowWidth);
    UIImage *highlightedImage = [UIImage imageWithColor:[UIColor colorWithWhite:0.0 alpha:0.1]
                                           cornerRadius:radius
                                                  frame:rectWithShadow];

    [self setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];

    [self setTitleColor:[UIColor colorWithWhite:0.9 alpha:1.0]
               forState:UIControlStateHighlighted];
}

@end
