//
//  DUTStandardCellController.h
//  Dutch
//
//  Created by Anuj Chaudhary on 6/22/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTCellController.h"

@interface DUTStandardCellController : DUTCellController


+ (DUTStandardCellController *)cellControllerWithTitle:(NSString *)title
                                        image:(UIImage *)image
                                accessoryType:(UITableViewCellAccessoryType)accessoryType
                                        block:(BasicBlock)block;

@end
