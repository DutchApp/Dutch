//
//  DUTSession.h
//  Dutch
//
//  Created by Anuj Chaudhary on 6/1/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DUTSession : NSObject


// *************************************************************************************************
#pragma mark -
#pragma mark Singleton Methods


+ (DUTSession *)sharedSession;


// *************************************************************************************************
#pragma mark -
#pragma mark Properties


/**
 * To store the auth token send by the server in login response.
 */
@property (nonatomic, strong, readwrite) id authToken;


/**
 * To store the user_id send by the server in login response.
 */
@property (nonatomic, strong, readwrite) id userId;


// *************************************************************************************************
#pragma mark -
#pragma mark Public Methods


- (void)reset;

- (void)cache;

- (BOOL)loadCache;


@end
