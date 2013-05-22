//
//  NSData+Document.m
//  Dutch
//
//  Created by rajmohan lokanath on 5/18/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "NSData+Document.h"

#import "DUTUtility+FileOperations.h"
@implementation NSData (Document)


- (BOOL)writeToDocument:(NSString *)document {
    NSURL *url = [DUTUtility urlForDocument:document];
    return [self writeToURL:url atomically:YES];
}


@end
