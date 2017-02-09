// ClientAPICall.h
//  Words
//
//  Created by Macbook on 2/8/17.
//  Copyright © 2017 Raihana A. Souleymane. All rights reserved.
//


#import "ClientAPICall.h"

static NSString * const clientAPIBaseURLString = @"http://www.nactem.ac.uk/software/acromine/dictionary.py";

@implementation ClientAPICall

+ (instancetype)sharedClient {
    static ClientAPICall *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ClientAPICall alloc] initWithBaseURL:[NSURL URLWithString:clientAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    
    });
    
    return _sharedClient;
}

@end
