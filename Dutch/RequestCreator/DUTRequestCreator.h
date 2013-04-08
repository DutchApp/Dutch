//
//  DUTRequestCreator.h
//  Dutch
//
//  Created by Anuj Chaudhary on 4/7/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DUTRequestCreator : NSObject


/**
 * Method to create the URL request for user registration.
 */
+ (NSURLRequest *)urlRequestForRegisterUser;

@end