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
    id parsedResponse  = nil;
    
    if (self.responseData) {
        parsedResponse = [self decodeResponse:error];
        NSLog(@"Response: %@", [parsedResponse description]);
    }
    
    // If there is a success response and no error in parsing the response,
    // return with response dictionary.
    if (!error && [self isSuccessResponse]) {
        return (NSDictionary *)parsedResponse;
    }
    else if (![self isSuccessResponse]) {
        NSString *errorMessage = nil;
        
        // Assuming if there is an error, we will have an array of messages.
        if ([parsedResponse isKindOfClass:[NSArray class]]) {
            NSArray *errorMessages = (NSArray *)parsedResponse;
            errorMessage = [errorMessages componentsJoinedByString:@". "];
        }
        *error =
            [NSError errorWithDomain:@"ErrorDomain"
                                code:self.urlResponse.statusCode
                            userInfo:@{NSLocalizedDescriptionKey: errorMessage}];
    }
    
    return (NSDictionary *) parsedResponse;
}


// *************************************************************************************************
#pragma mark -
#pragma mark Private Methods


- (id)decodeResponse:(NSError **)error {
    id jsonDict = [NSJSONSerialization JSONObjectWithData:self.responseData
                                                  options:NSJSONReadingMutableContainers
                                                    error:error];
    return jsonDict;
}


- (BOOL)isSuccessResponse {
    return self.urlResponse.statusCode >= 200 && self.urlResponse.statusCode <= 299;
}


@end
