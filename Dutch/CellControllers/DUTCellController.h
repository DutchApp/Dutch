//
//  DUTCellController.h
//  Dutch
//
//  Created by rajmohan lokanath on 4/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DUTCellControllerDelegate.h"
#import "DUTValidatorDelegate.h"
#include "DUTTableViewCell.h"


@interface DUTCellController : NSObject<DUTCellControllerDelegate,  DUTTableViewCellDelegate>


@property (nonatomic,strong,readonly) id cellData;
@property (nonatomic,weak,readwrite) id<DUTCellControllerEventDelegate> eventDelegate;


- (void)addValidator:(id<DUTValidatorDelegate>)validator;
- (void)addValidators:(NSArray *)validators;
- (BOOL)isValidData;
- (void)updateValidityStatus;

@end
