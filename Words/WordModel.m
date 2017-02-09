//
//  WebService.m
//  Words
//
//  Created by Macbook on 2/8/17.
//  Copyright © 2017 Raihana A. Souleymane. All rights reserved.
//

#import "WordModel.h"
#import "ClientAPICall.h"

NSDictionary *param;
@implementation WordModel

+ (void)passedParams:(NSDictionary *)params{
    param = params;
}


- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }

    self.theWord = [attributes valueForKey:@"lf"];
    self.frequence = [attributes valueForKey:@"freq"];
    self.date = [attributes valueForKey:@"since"];
    self.combinedString = [NSString stringWithFormat:@"%@\nFrequency:%@\nSince:%@",self.theWord, self.frequence, self.date];
    
    return self;
}

#pragma mark -

+ (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block {
    return [[ClientAPICall sharedClient] GET:@"" parameters:param progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:(NSData *)JSON options:kNilOptions error:nil];
         if (json.count != 0) {
        NSArray *result = [[json valueForKeyPath:@"lfs"] valueForKeyPath:@"vars"];
        NSLog(@"%@result",JSON);
        NSArray *final = [result objectAtIndex:0];
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[final count]];
        for (NSDictionary *attributes in final) {
            for (NSDictionary *theAttribute in attributes){
            WordModel *post = [[WordModel alloc] initWithAttributes:theAttribute];
            [mutablePosts addObject:post];
          }
        }
        if (block) {
            block([NSArray arrayWithArray:mutablePosts], nil);
        }
         }
         else{
             block([NSArray arrayWithArray:nil], nil);
         }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}
            

@end

@implementation WordModel (NSCoding)

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.combinedString forKey:@"combinedString"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return nil;
    }

    self.combinedString = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"combinedString"];
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
