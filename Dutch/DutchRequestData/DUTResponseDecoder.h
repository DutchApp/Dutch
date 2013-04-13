//
//  DUTRequestDecoder.h
//  Dutch
//
//  Created by rajmohan lokanath on 4/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DUTResponseDecoder : NSObject


/**
 * Returns the decoded response dictionary.
 */
+ (NSDictionary *)decodeFromData:(NSData *)responseData withError:(NSError **)error;


@end
