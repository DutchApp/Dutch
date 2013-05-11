//
//  DUTServerOperations.h
//  Dutch
//
//  Created by Anuj Chaudhary on 4/7/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DUTConstants.h"
#import "MBProgressHUD.h"


@interface DUTServerOperations : NSObject <MBProgressHUDDelegate>


/**
 * This function will accept a NSDisctionary with user information and responsible for calling
 * server for registering the user.
 *
 * @successBlock to be executed in case of success.
 * @failureBlock to be executed in case of failure
 *
 */
+ (void)registerUserWithInformation:(NSDictionary *)userInformation
                           successBlock:(BlockWithParameter)successBlock
                           failureBlock:(BlockWithParameter)failureBlock;

@end
