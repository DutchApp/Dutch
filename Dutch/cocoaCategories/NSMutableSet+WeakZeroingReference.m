//
//  NSMutableSet+WeakZeroingReference.m
//  Dutch
//
//  Created by rajmohan lokanath on 5/15/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "NSMutableSet+WeakZeroingReference.h"


@interface DUTWeakReference : NSObject
@property(nonatomic, weak,readwrite) id weakReference;
@end

@implementation DUTWeakReference

+ (DUTWeakReference *)weakReference:(id)weakReference {
    DUTWeakReference *obj = [[DUTWeakReference alloc]init];
    obj.weakReference = weakReference;
    return obj;
}

@end


@implementation NSMutableSet (WeakZeroingReference)

- (void)addWeakReference:(id)object {
    [self addObject:[DUTWeakReference weakReference:object]];
}


- (void)addWeakReferences:(NSArray *)objects {
    [objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addWeakReference:obj];
    }];
}

-(NSSet *)weakReferences {
    NSMutableSet *mutableSet = [NSMutableSet set];
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        DUTWeakReference *ref = obj;
        if (ref.weakReference) {
            [mutableSet addObject:ref];
        }
    }];
    return [NSSet setWithSet:mutableSet];
}

- (void)removeAllZeroedReferences {
    
    NSSet *zeroedReferences = [self objectsPassingTest:^BOOL(id obj, BOOL *stop) {
        DUTWeakReference *weakRefObj = obj;
        return !!!weakRefObj.weakReference;
    }];

    [zeroedReferences enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        [self removeObject:obj];
    }];
}

@end
