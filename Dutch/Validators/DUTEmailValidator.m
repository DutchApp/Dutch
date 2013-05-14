//
//  DUTEmailValidator.m
//  Dutch
//
//  Created by rajmohan lokanath on 5/11/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTEmailValidator.h"

#import "DUTUtility+Validation.h"

@implementation DUTEmailValidator


- (BOOL)validData:(id)data {
    NSString *email = data;
    return [DUTUtility isValidEMail:email];
}
@end
