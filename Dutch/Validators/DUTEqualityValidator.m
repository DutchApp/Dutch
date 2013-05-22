//
//  DUTEqualityValidator.m
//  Dutch
//
//  Created by rajmohan lokanath on 5/20/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTEqualityValidator.h"

@interface DUTEqualityValidator()
@property(nonatomic,weak,readwrite) id  source;
@property(nonatomic,assign,readwrite) SEL selector;
@end

@implementation DUTEqualityValidator

+ (id)validatorWithSource:(id)source selector:(SEL)selector {
    DUTEqualityValidator *validator = [[ DUTEqualityValidator alloc]init];
    validator.source = source;
    validator.selector = selector;
    return validator;
}


- (BOOL)validData:(id)data {
    if (!data) {
        return NO;
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    id sourceData = [self.source performSelector:self.selector];
#pragma clang diagnostic pop
    return [data isEqual:sourceData];
}


@end
