//
//  DUTAlertViewController.h
//  Dutch
//
//  Created by rajmohan lokanath on 6/2/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DUTAlertViewController : UIViewController

@property(nonatomic,strong,readwrite) NSString *alertTitle;
@property(nonatomic,strong,readwrite) NSString *alertMessage;

- (void)addButtonWithTitle:(NSString *)title action:(void (^)()) block ;
- (void)show:(UIViewController *)presentingVC;

@end
