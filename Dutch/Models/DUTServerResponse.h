//
//  DUTServerResponse.h
//  Dutch
//
//  Created by Anuj Chaudhary on 9/28/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import <Foundation/Foundation.h>


// *************************************************************************************************
#pragma mark -
#pragma mark Interface


@interface DUTServerResponse : NSObject


// *************************************************************************************************
#pragma mark -
#pragma mark Properties


@property (nonatomic, strong, readwrite) NSData *responseData;
@property (nonatomic, strong, readwrite) NSHTTPURLResponse *urlResponse;


// *************************************************************************************************
#pragma mark -
#pragma mark Public Methods

/**
 * 
 */
- (id)initWithHTTPURLResponse:(NSHTTPURLResponse *)urlResponse andData:(NSData *)data;


/**
 *
 */
- (NSDictionary *)handleServerResponse:(NSError **)error;

@end
