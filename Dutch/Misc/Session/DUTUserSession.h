//
//  DUTUserSession.h
//  Dutch
//
//  Created by Anuj Chaudhary on 4/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DUTUserSession : NSObject


/**
 sharedSession
 @brief   returns a singleton instance of DUTSession.
 @details creates the instance if the shared instance is nil
 */
+ (DUTUserSession *)sharedSession;


@end
