// WebService.h
//  Words
//
//  Created by Macbook on 2/8/17.
//  Copyright © 2017 Raihana A. Souleymane. All rights reserved.
//

#import "WebServiceTableViewCell.h"
#import "WordModel.h"


@import AFNetworking;

@implementation WebServiceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    self.textLabel.adjustsFontSizeToFitWidth = YES;
    self.textLabel.textColor = [UIColor darkGrayColor];
    self.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
    self.detailTextLabel.numberOfLines = 0;
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return self;
}

- (void)setPost:(WordModel *)post {
    _post = post;
    self.textLabel.text = @"";
    self.detailTextLabel.text =_post.combinedString;
    [self setNeedsLayout];
}

+ (CGFloat)heightForCellWithPost:(WordModel *)post {
    return (CGFloat)fmaxf(70.0f, (float)[self detailTextHeight:post.combinedString] + 45.0f);
}

+ (CGFloat)detailTextHeight:(NSString *)text {
    CGRect rectToFit = [text boundingRectWithSize:CGSizeMake(240.0f, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]} context:nil];
    return rectToFit.size.height;
}

#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(10.0f, 10.0f, 50.0f, 50.0f);
    self.textLabel.frame = CGRectMake(70.0f, 6.0f, 240.0f, 20.0f);
    
    CGRect detailTextLabelFrame = CGRectOffset(self.textLabel.frame, 0.0f, 25.0f);
    CGFloat calculatedHeight = [[self class] detailTextHeight:_post.combinedString];
    detailTextLabelFrame.size.height = calculatedHeight;
    self.detailTextLabel.frame = detailTextLabelFrame;
}

@end
