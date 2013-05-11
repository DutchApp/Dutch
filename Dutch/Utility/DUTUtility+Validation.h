//
//  DUTUtility+Validation.h
//  Dutch
//
//  Created by rajmohan lokanath on 4/7/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTUtility.h"

@interface DUTUtility (Validation)


/**
 * Documentation
 */
+ (BOOL)isValidEMail:(NSString *)emailAddress;


/**
 * Documentation
 */
+ (BOOL)isContentValid:(NSString *)content;

@end
