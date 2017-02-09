//
//  WordModel.h
//  Words
//
//  Created by Macbook on 2/8/17.
//  Copyright © 2017 Raihana A. Souleymane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordModel : NSObject
@property (nonatomic, assign) NSString *theWord;
@property (nonatomic, strong) NSString *frequence;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *combinedString;
@property (nonatomic, strong) NSDictionary *param;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
+ (void)passedParams:(NSDictionary *)params;
+ (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block;

@end

@interface WordModel (NSCoding) <NSSecureCoding>
@end
