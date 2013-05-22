//
//  DUTTableViewCell.h
//  Dutch
//
//  Created by rajmohan lokanath on 5/11/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DUTCellDelegate.h"
#import "DUTControlDelegate.h"

@class DUTTableViewCell;

@protocol DUTTableViewCellDelegate <NSObject>

@optional
- (void)cell:(DUTTableViewCell *)cell dataChanged:(id)data;
- (BOOL)cell:(DUTTableViewCell *)cell validData:(id)data;
- (BOOL)isDataValidForCell:(DUTTableViewCell *)cell;

@end


@interface DUTTableViewCell : UITableViewCell<DUTCellDelegate,DUTControlDelegate>

@property(nonatomic,weak,readwrite) id<DUTTableViewCellDelegate> cellDelegate;
@property(nonatomic,assign,readwrite) BOOL dataIsValid;

@end
