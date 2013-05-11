//
//  DUTGroupedCellControllerContainer.h
//  Dutch
//
//  Created by rajmohan lokanath on 4/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DUTCellController;

@interface DUTGroupedCellControllerContainer : NSObject<UITableViewDelegate, UITableViewDataSource>

#pragma mark - Properties

@property(nonatomic, strong, readonly) UITableView *table;

#pragma mark - Class Methods

+ (DUTGroupedCellControllerContainer *)containerForViewController:(UIViewController *)vc frame:(CGRect)frame;


#pragma mark - Instance Methods

- (BOOL)assignSectionWithTitle:(NSString *)title index:(NSInteger)sectionIndex;
- (BOOL)addCellController:(DUTCellController *)controller section:(NSInteger)sectionIndex;


@end
