//
//  DUTEditableCell.m
//  Dutch
//
//  Created by rajmohan lokanath on 4/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTEditableCell.h"

#import "DUTDescriptiveTextField.h"


@interface DUTEditableCell ()
@property(nonatomic,strong,readwrite) DUTDescriptiveTextField *textField;
@end

@implementation DUTEditableCell

@dynamic editableText;
@dynamic placeHolder;
@dynamic descriptiveFormat;


+ (UITableViewCell *)cellWithIdentifier:(NSString *)identifier {
    UITableViewCell *cell = [[DUTEditableCell alloc]initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textField = [[DUTDescriptiveTextField alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.textField];
        self.textField.controlDelegate = self;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setEditableText:(NSString *)editableText {
    self.textField.text = editableText;
}


- (void)setPlaceHolder:(NSString *)placeHolder {
    self.textField.placeholder = placeHolder;
}

- (NSString *)editableText {
    return self.textField.text;
}

- (NSString *)placeHolder {
    return self.textField.placeholder;
}

- (void)setMask:(BOOL)mask {
    self.textField.secureTextEntry = mask;
}

- (void)setDescriptiveFormat:(NSString *)descriptiveFormat {
    self.textField.formatText = descriptiveFormat;
}

- (UITableViewCell *)cellWithIdentifier:(NSString *)identifier {
    return nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textField.frame = CGRectMake(10, 10, CGRectGetWidth(self.contentView.frame)-20, CGRectGetHeight(self.contentView.frame)-20);
}

- (void)control:(id)control dataChanged:(id)data {
    [self.cellDelegate cell:self dataChanged:data];
}

@end
