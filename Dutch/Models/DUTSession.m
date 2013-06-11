//
//  DUTSession.m
//  Dutch
//
//  Created by Anuj Chaudhary on 6/1/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import "DUTSession.h"


// *************************************************************************************************
#pragma mark -
#pragma mark Implementation


@implementation DUTSession


// *************************************************************************************************
#pragma mark -
#pragma mark Singleton Methods


+ (DUTSession *)sharedSession {
    static DUTSession *sharedSession = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedSession = [DUTSession new];
    });
    
    return sharedSession;
}


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


- (void)reset {
    self.authToken = nil;
    self.userId = nil;
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user_id"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"auth_token"];
    [[NSUserDefaults standardUserDefaults]synchronize];    
}


- (void)cache {
    [[NSUserDefaults standardUserDefaults]setObject:self.userId forKey:@"user_id"];
    [[NSUserDefaults standardUserDefaults]setObject:self.authToken forKey:@"auth_token"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


- (BOOL)loadCache {
    self.userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"];
    self.authToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"auth_token"];
    return self.userId && self.authToken;
}


@end
