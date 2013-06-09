//
//  DUTSwitchCellController.m
//  Dutch
//
//  Created by rajmohan lokanath on 6/8/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTSwitchCellController.h"

#import "DUTSwitchTableViewCell.h"

@interface DUTSwitchCellController()

@property(nonatomic,strong,readwrite) DUTSwitchTableViewCell *cell;

@end

@implementation DUTSwitchCellController

@dynamic message;

+ (DUTSwitchCellController *)cellControllerWithMessage:(NSString *)message {
    DUTSwitchCellController *controller = [[DUTSwitchCellController alloc]init];
    controller.cell = [DUTSwitchTableViewCell cellWithMessage:message];
    controller.cell.cellDelegate = controller;
    return controller;
}

- (UITableViewCell *)tableViewCellForTable:(UITableView *)tableView {
    return self.cell;
}

- (id)cellData {

    return @(self.cell.theSwitch.on);
}


- (BOOL)isDataValidForCell:(DUTTableViewCell *)cell {
    return [self isValidData];
}

- (void)updateValidityStatus {
    [self.cell updateValidityStatus];
}


- (void)cell:(DUTTableViewCell *)cell dataChanged:(id)data {
    [super cell:cell dataChanged:data];
    
}

-(UISwitch *)theSwitch {
    return self.cell.theSwitch;
}
@end
