//
//  DUTAmountCellController.m
//  Dutch
//
//  Created by rajmohan lokanath on 6/1/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTAmountCellController.h"
#import "DUTUtility+Localization.h"

static NSString *const cellIdentifier = @"amountCell";

#import "DUTEditableCell.h"

@interface DUTAmountCellController()

@property(nonatomic,strong,readwrite) DUTEditableCell *cell;
@property(nonatomic,strong,readwrite) NSDecimalNumber *amount;

@end


@implementation DUTAmountCellController

@dynamic text;

+ (DUTAmountCellController *)cellControllerWithAmount:(NSDecimalNumber*)amount
                                          currencyCode:(NSString *)currencyCode {
    DUTAmountCellController *controller = [[DUTAmountCellController alloc]init];
    
    controller.amount = amount;
    DUTEditableCell * cell =
    (DUTEditableCell *)[DUTEditableCell cellWithIdentifier:cellIdentifier];
    cell.editableText = amount.stringValue;
    cell.cellDelegate = controller;
    NSString *descriptiveFormat = [DUTUtility currencySymbolForCurrencyCode:currencyCode];
    descriptiveFormat = [descriptiveFormat stringByAppendingString:@" "];
    descriptiveFormat = [descriptiveFormat stringByAppendingString:@"%@"];
    cell.descriptiveFormat = descriptiveFormat;
    controller.cell = cell;
    controller.text = amount.stringValue;
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

- (id)cellData {
    if (!self.cell.editableText.length) {
        return nil;
    }
    return self.cell.editableText;
}

- (BOOL)isDataValidForCell:(DUTTableViewCell *)cell {
    return [self isValidData];
}

- (void)updateValidityStatus {
    [self.cell updateValidityStatus];
}
@end
