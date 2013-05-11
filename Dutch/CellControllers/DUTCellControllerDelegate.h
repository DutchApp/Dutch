//
//  DUTCellControllerDelegate.h
//  Dutch
//
//  Created by rajmohan lokanath on 4/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DUTCellControllerDelegate <NSObject>


@property(nonatomic,assign,readonly) CGFloat height;

- (UITableViewCell *)tableViewCellForTable:(UITableView *)tableView;
- (NSString *)cellIdentifier;
@end
