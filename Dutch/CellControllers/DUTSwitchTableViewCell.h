//
//  DUTSwitchTableViewCell.h
//  Dutch
//
//  Created by rajmohan lokanath on 6/8/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTTableViewCell.h"

@interface DUTSwitchTableViewCell : DUTTableViewCell

+ (DUTSwitchTableViewCell *)cellWithMessage:(NSString *)message;

@property(nonatomic,strong,readonly) UISwitch *theSwitch;

@end
