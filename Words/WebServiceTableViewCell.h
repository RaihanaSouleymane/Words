// WebService.h
//  Words
//
//  Created by Macbook on 2/8/17.
//  Copyright © 2017 Raihana A. Souleymane. All rights reserved.
//

#import <UIKit/UIKit.h>



@class WordModel;

@interface WebServiceTableViewCell : UITableViewCell

@property (nonatomic, strong) WordModel *post;

+ (CGFloat)heightForCellWithPost:(WordModel *)post;

@end
