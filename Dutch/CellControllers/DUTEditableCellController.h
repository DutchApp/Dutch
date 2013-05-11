//
//  DUTEditableCellController.h
//  Dutch
//
//  Created by rajmohan lokanath on 4/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DUTCellController.h"
#pragma mark  Enums


typedef NS_ENUM(NSInteger,DUTEnumCellType) {
    DUTEnumCellTypeDefault,
    DUTEnumCellTypeEMail
};


#pragma mark - Interface


@interface DUTEditableCellController : DUTCellController


@property(nonatomic, assign, readwrite) DUTEnumCellType cellType;
@property(nonatomic,strong,readwrite) NSString *text;
@property(nonatomic,assign,readwrite) BOOL mask;
@property(nonatomic,strong,readwrite) NSString *descriptiveFormat;


#pragma mark - Class Methods


+ (DUTEditableCellController *)cellControllerWithText:(NSString*)text
                                          placeHolder:(NSString *)placeHolder;


@end
