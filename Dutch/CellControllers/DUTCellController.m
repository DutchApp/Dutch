//
//  DUTCellController.m
//  Dutch
//
//  Created by rajmohan lokanath on 4/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTCellController.h"

#import "DUTEditableCell.h"


@interface DUTCellController()
@property (nonatomic,strong,readwrite) NSMutableSet *validators;
@end

@implementation DUTCellController

@synthesize height = _height;

- (id)init {
    self = [super init];
    
    if (self) {
        _height = 44.0f;
        self.validators = [NSMutableSet set];
    }
    return self;
}


- (void)addValidator:(id<DUTValidatorDelegate>)validator {
    [self.validators addObject:validator];
}


- (void)addValidators:(NSArray *)validators {
    [self.validators addObjectsFromArray:validators];
}


- (UITableViewCell *)tableViewCellForTable:(UITableView *)tableView {
    
    return nil;
}

- (NSString *)cellIdentifier {
    return nil;
}

- (BOOL)isValidData {
    if (!self.validators.count) {
        return YES;
    }
    BOOL valid = YES;
    for (id<DUTValidatorDelegate> validator in self.validators) {
        if (![validator validData:self.cellData]) {
            valid = NO;
            break;
        }
    }
    return valid;
}

- (void)cell:(DUTTableViewCell *)cell dataChanged:(id)data {
    BOOL valid = YES;
    for (id<DUTValidatorDelegate> validator in self.validators) {
        if (![validator validData:data]) {
            valid = NO;
            break;
        }
    }
    [self.eventDelegate cellController:self dataValid:valid];
}

- (BOOL)cell:(DUTTableViewCell *)cell validData:(id)data {
    BOOL valid = YES;
    for (id<DUTValidatorDelegate> validator in self.validators) {
        if (![validator validData:data]) {
            valid = NO;
            break;
        }
    }
    return valid;
}

- (BOOL)isDataValidForCell:(DUTTableViewCell *)cell {
    return [self isValidData];
}
@end
