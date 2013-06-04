//
//  DUTUtility+DUTAlertView.h
//  Dutch
//
//  Created by rajmohan lokanath on 6/2/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTUtility.h"

@interface DUTUtility (DUTAlertView)


+ (id)alertViewWithTitle:(NSString *)title
                   message:(NSString *)message;
+ (void)alertView:(id)alertView addButtonWithTitle:(NSString *)title
           action:(void (^)()) block;

+ (void)alertView:(id)alertView addOkButtonWithAction:(void (^)()) block;

+ (void)alertView:(id)alertView addCancelButtonWithAction:(void (^)()) block;

+ (void)alertViewShow:(id)alertView;

@end
