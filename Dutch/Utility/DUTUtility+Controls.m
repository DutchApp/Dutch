//
//  DUTUtility+Controls.m
//  Dutch
//
//  Created by rajmohan lokanath on 6/2/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTUtility+Controls.h"

@implementation DUTUtility (Controls)


+ (UIButton *)roundButton:(UIButton *)button width:(CGFloat)width {
    CGRect buttonRect;
    
    buttonRect = button.frame;
    buttonRect.size = CGSizeMake(width, 40);
    button.frame = buttonRect;
    
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
