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

@optional

- (void)cellContainer:(DUTGroupedCellControllerContainer *)cellContainer
         dataValidity:(BOOL)valid;

- (UIView *)cellContainer:(DUTGroupedCellControllerContainer *)cellContainer
         footerViewForSection:(NSInteger)section;

- (CGFloat)cellContainer:(DUTGroupedCellControllerContainer *)cellContainer
     heightForFooterInSection:(NSInteger)section;

@end


// *************************************************************************************************
#pragma mark -
#pragma mark Interface


@interface DUTGroupedCellControllerContainer : NSObject<UITableViewDelegate,
                                                        UITableViewDataSource,
                                                        DUTCellControllerEventDelegate>


// *************************************************************************************************
#pragma mark -
#pragma mark Properties

@property(nonatomic, strong, readonly) UITableView *table;
@property(nonatomic, weak  , readwrite) id<DUTCellControllerContainerDelegate> delegate;


// *************************************************************************************************
#pragma mark -
#pragma mark Class Methods


+ (DUTGroupedCellControllerContainer *)containerForViewController:(UIViewController *)viewController
                                                   tableViewStyle:(UITableViewStyle)tableViewStyle
                                                            frame:(CGRect)frame;


// *************************************************************************************************
#pragma mark -
#pragma mark Instance Methods

- (id)initWithTableView:(UITableView *)tableView;

- (BOOL)assignSectionWithTitle:(NSString *)title index:(NSInteger)sectionIndex;

- (BOOL)addCellController:(DUTCellController *)controller section:(NSInteger)sectionIndex;

- (void)reloadData;

@end
