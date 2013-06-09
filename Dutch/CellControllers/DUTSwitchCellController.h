//
//  DUTSwitchCellController.h
//  Dutch
//
//  Created by rajmohan lokanath on 6/8/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTCellController.h"

@interface DUTSwitchCellController : DUTCellController


@property(nonatomic,strong,readonly) UISwitch *theSwitch;
@property(nonatomic,strong,readwrite) NSString *message;

+ (DUTSwitchCellController *)cellControllerWithMessage:(NSString *)message;

@end
