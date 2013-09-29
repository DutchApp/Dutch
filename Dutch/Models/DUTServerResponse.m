//
//  DUTServerResponse.m
//  Dutch
//
//  Created by Anuj Chaudhary on 9/28/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import "DUTServerResponse.h"


// *************************************************************************************************
#pragma mark -
#pragma mark Implementation


@implementation DUTServerResponse


// *************************************************************************************************
#pragma mark -
#pragma mark Public Methods


- (id)initWithHTTPURLResponse:(NSHTTPURLResponse *)urlResponse andData:(NSData *)data {
    if (self = [super init]) {
        _urlResponse = urlResponse;
        _responseData = data;
    }
    return self;
}


- (NSDictionary *)handleServerResponse:(NSError **)error {
    NSDictionary *responseDictionary = nil;
    
    if (self.responseData) {
        responseDictionary = [self decodeResponse:error];
    }
    
    // If there is a success response and no error in parsing the response, return with response dictionary.
    if (!error && [self isSuccessResponse]) {
        return responseDictionary;
    }
    else if (![self isSuccessResponse]) {
        NSString *errorMessage = nil;
        
        if ([[responseDictionary allValues] count]) {
            errorMessage = [[responseDictionary allValues] objectAtIndex:0];
        }
        else {
            errorMessage =
                [NSHTTPURLResponse localizedStringForStatusCode:self.urlResponse.statusCode];
        }
        *error =
            [NSError errorWithDomain:@"ErrorDomain"
                                code:self.urlResponse.statusCode
                            userInfo:@{NSLocalizedDescriptionKey: errorMessage}];
    }
    
    return responseDictionary;
}


// *************************************************************************************************
#pragma mark -
#pragma mark Private Methods


- (NSDictionary *)decodeResponse:(NSError **)error {
    NSDictionary *jsonDict =
    (NSDictionary *) [NSJSONSerialization JSONObjectWithData:self.responseData
                                                     options:NSJSONReadingMutableContainers
                                                       error:error];
    return jsonDict;
}


- (BOOL)isSuccessResponse {
    return self.urlResponse.statusCode >= 200 && self.urlResponse.statusCode <= 299;
}


@end
