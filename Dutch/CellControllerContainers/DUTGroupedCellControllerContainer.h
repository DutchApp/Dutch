//
//  DUTGroupedCellControllerContainer.h
//  Dutch
//
//  Created by rajmohan lokanath on 4/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DUTCellControllerDelegate.h"

@class DUTCellController;
@class DUTGroupedCellControllerContainer;


@protocol DUTCellControllerContainerDelegate <NSObject>

- (void)cellContainer:(DUTGroupedCellControllerContainer *)cellContainer
         dataValidity:(BOOL)valid;
@end

@interface DUTGroupedCellControllerContainer : NSObject<UITableViewDelegate, UITableViewDataSource,DUTCellControllerEventDelegate>

#pragma mark - Properties

@property(nonatomic, strong, readonly) UITableView *table;
@property(nonatomic, weak  , readwrite) id<DUTCellControllerContainerDelegate> delegate;

#pragma mark - Class Methods

+ (DUTGroupedCellControllerContainer *)containerForViewController:(UIViewController *)vc frame:(CGRect)frame;


#pragma mark - Instance Methods

- (BOOL)assignSectionWithTitle:(NSString *)title index:(NSInteger)sectionIndex;
- (BOOL)addCellController:(DUTCellController *)controller section:(NSInteger)sectionIndex;
- (void)reloadData;

@end
