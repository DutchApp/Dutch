//
//  DUTCellBackgroundView.m
//  Dutch
//
//  Created by rajmohan lokanath on 5/18/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTCellBackgroundView.h"
static const CGFloat kCornerRadius = 10;
@implementation DUTCellBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.fillColor = [UIColor colorWithWhite:137/255. alpha:1.0];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGRect bounds = CGRectInset(self.bounds,
                                0.5 / [UIScreen mainScreen].scale,
                                0.5 / [UIScreen mainScreen].scale);
    UIBezierPath *path;
    if (self.position == CellPositionSingle) {
        path = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:kCornerRadius];
    } else if (self.position == CellPositionTop) {
        bounds.size.height += 1;
        path = [UIBezierPath bezierPathWithRoundedRect:bounds
                                     byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                           cornerRadii:CGSizeMake(kCornerRadius, kCornerRadius)];
    } else if (self.position == CellPositionBottom) {
        path = [UIBezierPath bezierPathWithRoundedRect:bounds
                                     byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
                                           cornerRadii:CGSizeMake(kCornerRadius, kCornerRadius)];
    } else {
        bounds.size.height += 1;
        path = [UIBezierPath bezierPathWithRect:bounds];
    }
    
    [self.fillColor setFill];
    [self.borderColor setStroke];
    [path fill];
    [path stroke];
}


@end
