//
//  DUTEqualityValidator.h
//  Dutch
//
//  Created by rajmohan lokanath on 5/20/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTValidator.h"

@interface DUTEqualityValidator : DUTValidator

+ (id)validatorWithSource:(id)source selector:(SEL)selector;
@end
