//
//  MyTextField.m
//  BMQSP
//
//  Created by rajmohan lokanath on 5/5/13.
//  Copyright (c) 2013 MirageApps. All rights reserved.
//

#import "DUTDescriptiveTextField.h"


@interface DUTDescriptiveTextFieldDelegate:NSObject<UITextFieldDelegate>
@property(nonatomic,weak,readwrite) DUTDescriptiveTextField *textField;
@end

@interface DUTDescriptiveTextField()
@property(nonatomic,readwrite,strong) NSString *valueText;
@property(nonatomic,readwrite,strong) DUTDescriptiveTextFieldDelegate *descDelegate;

- (void) internalSetText:(NSString *)text;
- (NSString *)internalText;
@end


@implementation DUTDescriptiveTextFieldDelegate


+ (DUTDescriptiveTextFieldDelegate *)delegateForTextField:(DUTDescriptiveTextField *)textField {
    DUTDescriptiveTextFieldDelegate *delegate = [[DUTDescriptiveTextFieldDelegate alloc]init];
    delegate.textField = textField;
    return delegate;
}


- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    NSString *text;
    text = [[self.textField internalText]stringByReplacingCharactersInRange:range       withString:string];
    self.textField.valueText = text;
    [self.textField.controlDelegate control:self dataChanged:text];
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.textField.formatText.length) {
        [self.textField internalSetText:self.textField.valueText];
    }

    if ([self.textField.controlDelegate respondsToSelector:@selector(editBegan:)]) {
        [self.textField.controlDelegate editBegan:textField];
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.textField.formatText.length) {
        self.textField.text = self.textField.valueText;
    }
    if ([self.textField.controlDelegate respondsToSelector:@selector(editEnded:)]) {
        [self.textField.controlDelegate editEnded:textField];
    }
}

@end


@implementation DUTDescriptiveTextField

@dynamic text;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.descDelegate = [DUTDescriptiveTextFieldDelegate delegateForTextField:self];
        self.delegate = self.descDelegate;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.spellCheckingType = UITextSpellCheckingTypeNo;
        self.textColor = [UIColor darkGrayColor];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    self.descDelegate = [DUTDescriptiveTextFieldDelegate delegateForTextField:self];
    self.delegate = self.descDelegate;
    return self;
}


- (void)setFormatText:(NSString *)formatText {
    _formatText = formatText;
    if (self.valueText.length) {
        super.attributedText = [self attributedTextWithValue:self.valueText];
    }

}


- (NSString *)text {
    return self.valueText;
}

- (void)setText:(NSString *)text {
    if (!self.formatText.length) {
        super.text = text;
    }
    else if (text.length){
        super.attributedText = [self attributedTextWithValue:self.valueText];
    }

}

- (void) internalSetText:(NSString *)text {
    super.text = text;
}

- (NSString *)internalText {
    return super.text;
}


-(NSAttributedString *)attributedTextWithValue:(NSString *)text {
    NSRange loc = [self.formatText rangeOfString:@"%@"];

    NSDictionary *valueAttr = @{NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    NSAttributedString *valueAttrText = [[NSAttributedString alloc]initWithString:text attributes:valueAttr];
    
    NSDictionary *formatAttr = @{NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    NSMutableAttributedString *completeText = [[NSMutableAttributedString alloc]initWithString:self.formatText attributes:formatAttr];

    
    [completeText replaceCharactersInRange:loc withAttributedString:valueAttrText];
    return [[NSAttributedString alloc]initWithAttributedString:completeText];
}


@end
