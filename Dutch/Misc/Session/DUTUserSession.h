//
//  DUTUserSession.h
//  Dutch
//
//  Created by Anuj Chaudhary on 4/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DUTUserSession : NSObject


// *************************************************************************************************
#pragma mark -
#pragma mark Properties


/**
 * Auth token returned from server. This should be stored in the session and should be send to every
 * server call.
 */
@property (nonatomic, strong, readwrite) NSString *authToken;


// *************************************************************************************************
#pragma mark -
#pragma mark Public Methods


/**
 sharedSession
 @brief   returns a singleton instance of DUTSession.
 @details creates the instance if the shared instance is nil
 */
+ (DUTUserSession *)sharedSession;


/**
 reset
 @brief resets the session
 @details
 */
- (void)reset;


@end
