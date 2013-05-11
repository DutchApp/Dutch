//
//  DUTUserSession.m
//  Dutch
//
//  Created by Anuj Chaudhary on 4/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTUserSession.h"


// *************************************************************************************************
#pragma mark -
#pragma mark Implementation


@implementation DUTUserSession


// *************************************************************************************************
#pragma mark -
#pragma mark Initialization


- (id)init {
    self = [super init];
    if (self) {
        self.authToken = nil;
    }
    
    return self;
}


// *************************************************************************************************
#pragma mark -
#pragma mark Public Methods


+ (DUTUserSession *)sharedSession {
    static DUTUserSession *session = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        session = [DUTUserSession new];
    });
    
    return session;
}


- (void)reset {
    self.authToken = nil;
}

@end
