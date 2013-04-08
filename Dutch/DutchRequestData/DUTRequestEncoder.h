//
//  DUTRequestEncoder.h
//  Dutch
//
//  Created by Anuj Chaudhary on 4/7/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DUTRequestEncoder : NSObject


/**
 * Returns the encoded request object that will be transmitted over the transport layer.
 */
+ (NSData *)encodeRequestFromData:(NSDictionary *)requestData withError:(NSError **)error;

@end
