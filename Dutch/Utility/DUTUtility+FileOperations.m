//
//  DUTUtility+FileOperations.m
//  Dutch
//
//  Created by rajmohan lokanath on 5/16/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTUtility+FileOperations.h"

@implementation DUTUtility (FileOperations)


+ (NSURL *)urlOfDocuments {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

+ (NSError *)createDocumentDirectory {

    NSError *error;
    [[self fileMgr]createDirectoryAtURL:[self urlOfDocuments]
            withIntermediateDirectories:NO
                             attributes:nil error:&error];
    return error;
}


+ (NSData *)dataFromDocument:(NSString *)document {
    NSURL *localeFileURL = [self urlForDocument:document];
    NSData *data = [NSData dataWithContentsOfURL:localeFileURL];
    return data;
}


+ (NSURL *)urlForDocument:(NSString *)document {
    return [[self urlOfDocuments] URLByAppendingPathComponent:document];
}


+ (NSFileManager *)fileMgr {
    return [NSFileManager defaultManager];
}

@end
