//
//  DUTAlertView.m
//  Dutch
//
//  Created by rajmohan lokanath on 6/8/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTAlertView.h"

#import "DUTAlertViewController.h"
#import "DUTLocalizations.h"

@interface DUTAlertView ()
@property(nonatomic,strong,readwrite) DUTAlertViewController *alertViewController;
@end


@implementation DUTAlertView


+ (id)alertViewWithTitle:(NSString *)title
                 message:(NSString *)message {
    DUTAlertView *alertView = [[DUTAlertView alloc]init];
    DUTAlertViewController *vc = [self alertView];
    alertView.alertViewController = vc;
    vc.alertTitle = title;
    vc.alertMessage = message;
    return alertView;
}


- (void)addButtonWithTitle:(NSString *)title
           action:(void (^)()) block {
    [self.alertViewController addButtonWithTitle:title action:block];
}


- (void)addOkButtonWithAction:(void (^)()) block {
    [self.alertViewController addButtonWithTitle:TXT_OK action:block];
}


- (void)addCancelButtonWithAction:(void (^)()) block {
    [self.alertViewController addButtonWithTitle:TXT_CANCEL action:block];
}

- (void)show {
    self.alertViewController.interfaceObject = self; // Hold now and release after button is selected.
    UIViewController *topVC = [DUTAlertView topMostController];
    [self.alertViewController show:topVC];
}

+ (DUTAlertViewController *)alertView {
    
    DUTAlertViewController *alertView = [[DUTAlertViewController alloc]initWithNibName:@"DUTAlertViewController" bundle:nil];
    
    alertView.view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.7];
    alertView.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    return alertView;
}


+ (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}
@end
