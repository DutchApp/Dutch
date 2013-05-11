//
//  DUTCellContainerSection.h
//  Dutch
//
//  Created by rajmohan lokanath on 4/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DUTCellController;
@interface DUTCellContainerSection : NSObject

@property(nonatomic,assign,readonly) NSInteger numberOfControllers;
@property(nonatomic,copy,readwrite) NSString *title;

+ (DUTCellContainerSection *)containerSectionWithTitle:(NSString *)title;


- (void)addCellController:(DUTCellController *)controller;
- (DUTCellController *)controllerAtIndex:(NSInteger)index;
@end
