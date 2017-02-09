// ClientAPICall.h
//
//  Words
//
//  Created by Macbook on 2/8/17.
//  Copyright © 2017 Raihana A. Souleymane. All rights reserved.
//


#import <Foundation/Foundation.h>
@import AFNetworking;

@interface ClientAPICall : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
