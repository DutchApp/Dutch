//
//  DUTUtility+Validation.m
//  Dutch
//
//  Created by rajmohan lokanath on 4/7/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTUtility+Validation.h"

@implementation DUTUtility (Validation)


+ (BOOL)isValidEMail:(NSString *)emailAddress {
    // RFC 3696
    NSString *emailRegex =
    @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [predicate evaluateWithObject:emailAddress];
}


+ (BOOL)isContentValid:(NSString *)content {
    return content != nil && [content length] > 0;
}

@end
