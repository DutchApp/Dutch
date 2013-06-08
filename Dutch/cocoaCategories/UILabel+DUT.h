//
//  UILabel+DUT.h
//  Dutch
//
//  Created by rajmohan lokanath on 6/3/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DUT)

- (void)fitToWidth:(CGFloat)fixedWidth;

- (NSInteger)computeNumberOfLines;

@end
