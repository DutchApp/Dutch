//
//  UILabel+DUT.m
//  Dutch
//
//  Created by rajmohan lokanath on 6/3/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "UILabel+DUT.h"

@implementation UILabel (DUT)


- (void)fitToWidth:(CGFloat)fixedWidth {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, fixedWidth, 0);
    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.numberOfLines = 0;
    [self sizeToFit];
    CGRect rect = self.frame;
    rect.size.width = fixedWidth;
    self.frame = rect;
}

-(NSInteger)computeNumberOfLines {
    NSInteger lineCount = 0;
    UILabel *label = self;
    CGSize requiredSize = [label.text sizeWithFont:label.font constrainedToSize:label.frame.size lineBreakMode:label.lineBreakMode];
    
    int charSize = label.font.leading;
    int rHeight = requiredSize.height;
    
    lineCount = rHeight/charSize;
    
    return lineCount;
}


@end
