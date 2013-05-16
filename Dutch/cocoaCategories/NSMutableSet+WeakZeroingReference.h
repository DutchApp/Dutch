//
//  NSMutableSet+WeakZeroingReference.h
//  Dutch
//
//  Created by rajmohan lokanath on 5/15/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableSet (WeakZeroingReference)
- (NSSet *)weakReferences;
- (void)addWeakReference:(id)object;
- (void)addWeakReferences:(NSArray *)objects;
@end
