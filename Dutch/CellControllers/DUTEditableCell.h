//
//  DUTEditableCell.h
//  Dutch
//
//  Created by rajmohan lokanath on 4/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DUTTableViewCell.h"


@interface DUTEditableCell : DUTTableViewCell

@property(nonatomic, strong,readwrite) NSString *editableText;
@property(nonatomic, strong,readwrite) NSString *placeHolder;
@property(nonatomic, assign,readwrite) BOOL mask;
@property(nonatomic,strong,readwrite) NSString *descriptiveFormat;

+ (UITableViewCell *)cellWithIdentifier:(NSString *)identifier;


@end
