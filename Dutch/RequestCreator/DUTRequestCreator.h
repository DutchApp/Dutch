//
//  DUTRequestCreator.h
//  Dutch
//
//  Created by Anuj Chaudhary on 4/7/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import <Foundation/Foundation.h>


// *************************************************************************************************
#pragma mark -
#pragma mark Interface


@interface DUTRequestCreator : NSObject


// *************************************************************************************************
#pragma mark -
#pragma mark Public Methods


/**
 * Method to create the URL request for user registration.
 */
+ (NSMutableURLRequest *)urlRequestForRegisterUser;


/**
 * Method to create the URL request for login.
 */
+ (NSMutableURLRequest *)urlRequestForLoginUser;


/**
 * Method to create the URL request for logout.
 */
+ (NSMutableURLRequest *)urlRequestForLogoutUser;


/**
 * Method to create the URL request for NewExpense.
 */
+ (NSMutableURLRequest *)urlRequestForNewExpense;


@end
