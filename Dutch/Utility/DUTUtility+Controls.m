//
//  DUTUtility+Controls.m
//  Dutch
//
//  Created by rajmohan lokanath on 6/2/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTUtility+Controls.h"
#import "DUTLocalizations.h"

@implementation DUTUtility (Controls)


+ (UIButton *)roundButton:(UIButton *)button width:(CGFloat)width {
    CGRect buttonRect;
    
    buttonRect = button.frame;
    buttonRect.size = CGSizeMake(width, CGRectGetHeight(buttonRect));
    button.frame = buttonRect;
    UIImage *bgImage = [UIImage imageNamed:@"button_gradient.png"];
    if ([[button titleForState:UIControlStateNormal] caseInsensitiveCompare:TXT_CANCEL] == NSOrderedSame) {
        bgImage = [UIImage imageNamed:@"button_black_gradient.png"];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else {
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
    
    [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    UIBezierPath *bezPath;
    CAShapeLayer *shapeLayer;
    shapeLayer = [[CAShapeLayer alloc]init];
    CGRect maskRect = buttonRect;
    maskRect.origin = CGPointMake(0, 0);
    bezPath = [UIBezierPath bezierPathWithRoundedRect:maskRect cornerRadius:8];
    shapeLayer.path = bezPath.CGPath;
    button.layer.mask = shapeLayer;
    return button;
}


@end
