//
//  DUTAlertView.h
//  Dutch
//
//  Created by rajmohan lokanath on 6/8/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DUTAlertView : NSObject


+ (id)alertViewWithTitle:(NSString *)title
                 message:(NSString *)message;
- (void)addButtonWithTitle:(NSString *)title
                    action:(void (^)()) block;

- (void)addOkButtonWithAction:(void (^)()) block;

- (void)addCancelButtonWithAction:(void (^)()) block;

- (void)show;


@end
