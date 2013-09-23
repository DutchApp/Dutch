//
//  NSMutableDictionary+DUTExtension.m
//  Dutch
//
//  Created by Anuj Chaudhary on 9/22/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "NSMutableDictionary+DUTExtension.h"

@implementation NSMutableDictionary (DUTExtension)


- (void)setObjectIfNotNil:(id)anObject forKey:(id)aKey {
    if (anObject) {
        [self setObject:anObject forKey:aKey];
    }
}


@end
