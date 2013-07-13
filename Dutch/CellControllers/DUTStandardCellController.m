//
//  DUTStandardCellController.m
//  Dutch
//
//  Created by Anuj Chaudhary on 6/22/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTStandardCellController.h"

#import "DUTTableViewCell.h"


static NSString *const cellIdentifier = @"standardCell";


@interface DUTStandardCellController ()


@property (nonatomic, strong, readwrite) UITableViewCell *tableViewCell;


@end


@implementation DUTStandardCellController


+ (DUTStandardCellController *)cellControllerWithTitle:(NSString *)title
                                        image:(UIImage *)image
                                accessoryType:(UITableViewCellAccessoryType)accessoryType
                                        block:(BasicBlock)block {
    DUTStandardCellController *cellController = [[DUTStandardCellController alloc] init];
    cellController.block = block;
    
    UITableViewCell *tableViewCell =
        [[DUTTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                               reuseIdentifier:cellIdentifier];
    if (image) {
        tableViewCell.imageView.image = image;
    }
    
    tableViewCell.accessoryType = accessoryType;
    tableViewCell.textLabel.text = title;
    
    cellController.tableViewCell = tableViewCell;
    return cellController;
}


- (NSString *)cellIdentifier {
    return cellIdentifier;
}

@end
