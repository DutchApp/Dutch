//
//  DUTSwitchTableViewCell.m
//  Dutch
//
//  Created by rajmohan lokanath on 6/8/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTSwitchTableViewCell.h"

static NSString *const kCellIdentifier = @"switchCell";

static const CGFloat kGroupCellWidth = 300.0f;
static const CGFloat kUIEdgeXYOffset = 10.0f;

@interface DUTSwitchTableViewCell   ()


@end


@implementation DUTSwitchTableViewCell


+ (DUTSwitchTableViewCell *)cellWithMessage:(NSString *)message {
    DUTSwitchTableViewCell *cell = [[DUTSwitchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    cell.textLabel.text = message;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _theSwitch = [[UISwitch alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.theSwitch];
        [_theSwitch addTarget:self action:@selector(switchTurned:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat cellWidth = CGRectGetWidth(self.contentView.frame);
    CGFloat cellHeight = CGRectGetHeight(self.contentView.frame);
    
    // layout Segment
    CGRect segmentRect = self.theSwitch.frame;
    CGFloat segmentWidth = CGRectGetWidth(segmentRect);
    CGFloat segmentHeight = CGRectGetHeight(segmentRect);
    
    // Layout answer
    CGFloat textWidth = cellWidth - segmentWidth - 3 * kUIEdgeXYOffset;
    self.textLabel.frame = CGRectMake(kUIEdgeXYOffset, kUIEdgeXYOffset, textWidth, 0);
    [self.textLabel sizeToFit];
    CGFloat textHeight = CGRectGetHeight(self.textLabel.frame);
    CGFloat textY = (cellHeight - textHeight)/2.0f;
    self.textLabel.frame = CGRectMake(kUIEdgeXYOffset, textY, textWidth, CGRectGetHeight(self.textLabel.frame));
    
    segmentRect.origin.x = cellWidth - segmentWidth - kUIEdgeXYOffset;
    segmentRect.origin.y = (CGRectGetHeight(self.contentView.frame) - segmentHeight)/2.0f;
    self.theSwitch.frame = segmentRect;

}

- (void)switchTurned:(id)sender {
    [self.cellDelegate cell:self dataChanged:@(_theSwitch.on)];
}

@end
