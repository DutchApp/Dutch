//
//  DUTUtility+DUTAlertView.m
//  Dutch
//
//  Created by rajmohan lokanath on 6/2/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTUtility+DUTAlertView.h"
#import "DUTAlertViewController.h"
#import "DUTLocalizations.h"

@implementation DUTUtility (DUTAlertView)



+ (id)alertViewWithTitle:(NSString *)title
                 message:(NSString *)message {
    DUTAlertViewController *vc = [self alertView];
    vc.alertTitle = title;
    vc.alertMessage = message;
    return vc;
}

+ (void)alertView:(id)alertView addButtonWithTitle:(NSString *)title
           action:(void (^)()) block {
    DUTAlertViewController *vc = alertView;
    [vc addButtonWithTitle:title action:block];
}

+ (void)alertView:(id)alertView addOkButtonWithAction:(void (^)()) block {
    DUTAlertViewController *vc = alertView;
    [vc addButtonWithTitle:TXT_OK action:block];
}


+ (void)alertView:(id)alertView addCancelButtonWithAction:(void (^)()) block {
    DUTAlertViewController *vc = alertView;
    [vc addButtonWithTitle:TXT_CANCEL action:block];
}

+ (void)alertViewShow:(id)alertView {
    UIViewController *topVC = [self topMostController];
    DUTAlertViewController *alertVC = alertView;
    [alertVC show:topVC];
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


+ (UIImage *)applyBlurOnView:(UIView *)myView {
    CGRect sourceRect = myView.frame;
    sourceRect.origin = CGPointMake(0, 0);
    UIGraphicsBeginImageContext(sourceRect.size);
    [myView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *imageToBlur = [CIImage imageWithCGImage:viewImage.CGImage];
    CIFilter *gaussianBlur = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlur setValue:imageToBlur forKey: @"inputImage"];
    [gaussianBlur setValue: [NSNumber numberWithFloat: 10] forKey: @"inputRadius"];
    CIImage *resultImage = [gaussianBlur valueForKey: @"outputImage"];
    CGImageRef cgimg = [context createCGImage:resultImage fromRect:[imageToBlur extent]];
    UIImage *out = [UIImage imageWithCGImage:cgimg];
    return out;
}


@end
