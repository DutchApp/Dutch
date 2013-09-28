//
//  NSMutableDictionary+DUTExtension.h
//  Dutch
//
//  Created by Anuj Chaudhary on 9/22/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (DUTExtension)


/**
 * nil check before setting the object in a dictionary for key
 */
- (void)setObjectIfNotNil:(id)anObject forKey:(id)aKey;


@end
