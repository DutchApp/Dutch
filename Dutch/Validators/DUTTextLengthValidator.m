//
//  DUTTextLengthValidator.m
//  Dutch
//
//  Created by rajmohan lokanath on 5/15/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTTextLengthValidator.h"


@interface DUTTextLengthValidator()
@property(nonatomic,assign,readwrite) NSInteger minLength;
@property(nonatomic,assign,readwrite) NSInteger maxLength;
@end
@implementation DUTTextLengthValidator


+ (id)validatorWithMinLenth:(NSInteger)minLength maxLength:(NSInteger)maxLength {
    DUTTextLengthValidator *validator = [[DUTTextLengthValidator alloc]init];
    validator.minLength = minLength;
    validator.maxLength = maxLength;
    return validator;
}


- (BOOL)validData:(id)data {
    NSString *text = data;
    NSInteger length = [text length];
    return length >= self.minLength && length <= self.maxLength;
}


@end
