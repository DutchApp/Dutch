//
//  DUTEditableCellController.m
//  Dutch
//
//  Created by rajmohan lokanath on 4/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTEditableCellController.h"
#import "DUTEditableCell.h"

NSString *const cellIdentifier = @"editableCell";

@interface DUTEditableCellController ()

@property(nonatomic,strong,readwrite) NSString *placeHolder;
@property(nonatomic,strong,readwrite) DUTEditableCell *cell;

@end

@implementation DUTEditableCellController

@dynamic text;
@dynamic mask;
@dynamic descriptiveFormat;

+ (DUTEditableCellController *)cellControllerWithText:(NSString*)text
                                          placeHolder:(NSString *)placeHolder {
    DUTEditableCellController *controller = [[DUTEditableCellController alloc]init];
    
    controller.text = text;
    controller.placeHolder = placeHolder;
    DUTEditableCell * cell =
        (DUTEditableCell *)[DUTEditableCell cellWithIdentifier:cellIdentifier];
    cell.editableText = text;
    cell.placeHolder = placeHolder;
    controller.cell = cell;
    return controller;
}


- (NSString *)cellIdentifier {
    return cellIdentifier;
}


- (UITableViewCell *)tableViewCellForTable:(UITableView *)tableView {
    return self.cell;
}


- (NSString *)text {
    return self.cell.editableText;
}


- (void)setText:(NSString *)text {
    self.cell.editableText = text;
}


- (void)setMask:(BOOL)mask {
    self.cell.mask = mask;
}

- (void)setDescriptiveFormat:(NSString *)descriptiveFormat {
    self.cell.descriptiveFormat = descriptiveFormat;
}

@end
