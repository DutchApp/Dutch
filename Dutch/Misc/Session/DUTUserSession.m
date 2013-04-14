//
//  DUTUserSession.m
//  Dutch
//
//  Created by Anuj Chaudhary on 4/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTUserSession.h"

@implementation DUTUserSession


+ (DUTUserSession *)sharedSession {
    static DUTUserSession *session = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        session = [DUTUserSession new];
    });
    
    return session;
}

@end
