//
//  DUTCellController.m
//  Dutch
//
//  Created by rajmohan lokanath on 4/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTCellController.h"

#import "DUTEditableCell.h"
@implementation DUTCellController

@synthesize height = _height;

- (id)init {
    self = [super init];
    
    if (self) {
        _height = 44.0f;
    }
    return self;
}


- (UITableViewCell *)tableViewCellForTable:(UITableView *)tableView {
    
    return nil;
}

- (NSString *)cellIdentifier {
    return nil;
}
@end
