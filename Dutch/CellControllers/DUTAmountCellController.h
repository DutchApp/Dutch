//
//  DUTAmountCellController.h
//  Dutch
//
//  Created by rajmohan lokanath on 6/1/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTCellController.h"

@interface DUTAmountCellController : DUTCellController

@property(nonatomic,strong,readwrite) NSString *text;


+ (DUTAmountCellController *)cellControllerWithAmount:(NSDecimalNumber*)amount
                                         currencyCode:(NSString *)currencyCode;
@end
