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


+ (id)sharedSession;


// *************************************************************************************************
#pragma mark -
#pragma mark Properties


/**
 * To store the auth token send by the server in login response.
 */
@property (nonatomic, strong, readwrite) NSString *authToken;


// *************************************************************************************************
#pragma mark -
#pragma mark Public Methods


- (void)reset;


@end
