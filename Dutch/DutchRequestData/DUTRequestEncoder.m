//
//  DUTRequestEncoder.m
//  Dutch
//
//  Created by Anuj Chaudhary on 4/7/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTRequestEncoder.h"

@implementation DUTRequestEncoder


+ (NSData *)encodeRequestFromData:(NSDictionary *)requestData withError:(NSError **)error {
    NSData *encodedData = nil;
    if ([NSJSONSerialization isValidJSONObject:requestData]) {
        encodedData = [NSJSONSerialization dataWithJSONObject:requestData options:0 error:error];
    }
    
    return encodedData;
}

@end
