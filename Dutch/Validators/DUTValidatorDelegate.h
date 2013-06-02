//
//  DUTValidatorDelegate.h
//  Dutch
//
//  Created by rajmohan lokanath on 5/11/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DUTValidatorDelegate <NSObject>
@optional
+ (id)validator;

@required
- (BOOL)validData:(id)data;

@end
