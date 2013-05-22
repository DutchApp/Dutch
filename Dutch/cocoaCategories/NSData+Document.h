//
//  NSData+Document.h
//  Dutch
//
//  Created by rajmohan lokanath on 5/18/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Document)

- (BOOL)writeToDocument:(NSString *)document;
@end
