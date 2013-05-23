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
- (NSUInteger)positionOfValue;
- (void)setCursorAtPosition:(NSUInteger)location;
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
    if (!self.textField.formatText.length) {
        return ;
    }
    [self.textField internalSetText:self.textField.valueText];
    
    if ([self.textField.controlDelegate respondsToSelector:@selector(editBegan:)]) {
        [self.textField.controlDelegate editBegan:textField];
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (!self.textField.formatText.length) {
        return ;
    }
    self.textField.text = self.textField.valueText;
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

    NSDictionary *valueAttr = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    NSAttributedString *valueAttrText = [[NSAttributedString alloc]initWithString:text attributes:valueAttr];
    
    NSDictionary *formatAttr = @{NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    NSMutableAttributedString *completeText = [[NSMutableAttributedString alloc]initWithString:self.formatText attributes:formatAttr];

    
    [completeText replaceCharactersInRange:loc withAttributedString:valueAttrText];
    return [[NSAttributedString alloc]initWithAttributedString:completeText];
}


- (void)setCursorAtPosition:(NSUInteger)location {
    UITextPosition *start = [self positionFromPosition:[self beginningOfDocument]
                                                 offset:location];
    UITextPosition *end = [self positionFromPosition:start
                                               offset:0];
    [self setSelectedTextRange:[self textRangeFromPosition:start toPosition:end]];
}

- (NSUInteger)positionOfValue {
    if (self.formatText.length) {
        NSRange range = [self.formatText rangeOfString:@"@"];
        if (range.location != NSNotFound) {
            return range.location + self.valueText.length;
        }
    }
    return self.text.length;
}


- (NSString *)valueTextFromFullText {
    NSRange range = [self.formatText rangeOfString:@"@"];
}


@end
