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


/**
 * This function will accept a NSDisctionary with user information and responsible for calling
 * server logging in.
 *
 * @successBlock to be executed in case of success.
 * @failureBlock to be executed in case of failure
 *
 */
+ (void)loginUserWithInformation:(NSDictionary *)userInformation
                    successBlock:(BlockWithParameter)successBlock
                    failureBlock:(BlockWithParameter)failureBlock;


/**
 * Function to logout the user. This function gets the auth_token and send a DELETE request to server.
 * Request: DELETE
 * URI: /users/sign_out
 *
 * @successBlock to be executed in case of success.
 * @failureBlock to be executed in case of failure
 */
+ (void)logoutUserWithSuccessBlock:(BlockWithParameter)sucessBlock
                      failureBlock:(BlockWithParameter)failureBlock;


/**
 * This function will accept a NSDisctionary with expense information and responsible for calling
 * server for creating new expense.
 *
 * @successBlock to be executed in case of success.
 * @failureBlock to be executed in case of failure
 *
 */
+ (void)createExpenseInformation:(NSDictionary *)expenseInformation
                    successBlock:(BlockWithParameter)successBlock
                    failureBlock:(BlockWithParameter)failureBlock;


@end
