//
//  DUTUtility+FileOperations.h
//  Dutch
//
//  Created by rajmohan lokanath on 5/16/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTUtility.h"

@interface DUTUtility (FileOperations)
+ (NSURL *)urlOfDocuments;
+ (NSError *)createDocumentDirectory;
+ (NSData *)dataFromDocument:(NSString *)document;
+ (NSURL *)urlForDocument:(NSString *)document;
@end
