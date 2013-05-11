//
//  DUTDescriptiveTextFieldDelegate.m
//  Dutch
//
//  Created by rajmohan lokanath on 5/11/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTDescriptiveTextFieldDelegate.h"

#import "DUTDescriptiveTextField.h"
@interface DUTDescriptiveTextFieldDelegate()
@property(nonatomic,weak,readwrite) DUTDescriptiveTextField *textField;
@end

@implementation DUTDescriptiveTextFieldDelegate


+ (DUTDescriptiveTextFieldDelegate *)delegateForTextField:(DUTDescriptiveTextField *)textField {
    DUTDescriptiveTextFieldDelegate *delegate = [[DUTDescriptiveTextFieldDelegate alloc]init];
    delegate.textField = textField;
    return delegate;
}

/*
- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    if (!self.textField.formatText.length) {
        return YES;
    }
    self.textField.valueText = [self.valueText stringByReplacingCharactersInRange:range withString:string];
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (!self.formatText.length) {
        return ;
    }
    [self setText:self.valueText];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (!self.formatText.length) {
        return ;
    }
    _valueText = self.text;
    self.text = [NSString stringWithFormat:self.formatText,self.valueText];
}*/

@end
