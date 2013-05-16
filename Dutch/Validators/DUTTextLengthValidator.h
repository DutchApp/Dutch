//
//  DUTTextLengthValidator.h
//  Dutch
//
//  Created by rajmohan lokanath on 5/15/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTValidator.h"

@interface DUTTextLengthValidator : DUTValidator

+ (id)validatorWithMinLenth:(NSInteger)minLength maxLength:(NSInteger)maxLength;
@end
