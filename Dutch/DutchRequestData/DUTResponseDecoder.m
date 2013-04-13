//
//  DUTRequestDecoder.m
//  Dutch
//
//  Created by rajmohan lokanath on 4/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTResponseDecoder.h"

@implementation DUTResponseDecoder


+ (NSDictionary *)decodeFromData:(NSData *)responseData withError:(NSError **)error {
    NSDictionary *jsonDict =
    (NSDictionary *) [NSJSONSerialization JSONObjectWithData:responseData
                                                     options:NSJSONReadingMutableContainers
                                                       error:error];
    return jsonDict;
}


@end
