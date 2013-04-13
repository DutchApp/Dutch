//
//  DUTServerOperations.m
//  Dutch
//
//  Created by Anuj Chaudhary on 4/7/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTServerOperations.h"

#import "DUTRequestCreator.h"
#import "DUTResponseDecoder.h"
#import "DUTRequestEncoder.h"

NSString * const kServerOpError = @"error";
NSString * const kServerOpResponseData = @"responseDict";
NSString * const kServerOpRequestData = @"requestDict";

@implementation DUTServerOperations


+ (void)registerUserWithInformation:(NSDictionary *)userInformation
                           successBlock:(BlockWithParameter)successBlock
                           failureBlock:(BlockWithParameter)failureBlock {
    NSError *error = nil;
    NSData *encodedData = [DUTRequestEncoder encodeRequestFromData:userInformation withError:&error];
    
    if (error) {
        NSDictionary *errorDict = @{kServerOpError:error, kServerOpRequestData:userInformation};
        failureBlock(errorDict);
        return;
    }
    
    NSMutableURLRequest *registerUserURLRequest = [DUTRequestCreator urlRequestForRegisterUser];
    [registerUserURLRequest setHTTPBody:encodedData];
    
    // HTTP submit. Probably should be in its own framework
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:registerUserURLRequest
                                       queue:queue
                           completionHandler:^(NSURLResponse *urlResponse, NSData *responseData, NSError *error ) {
                               if (error) {
                                   NSDictionary *errorDict = @{kServerOpError:error, kServerOpRequestData:userInformation};
                                   failureBlock(errorDict);
                                   return ;
                               }
                               NSDictionary *responseDict =
                                [DUTResponseDecoder decodeFromData:responseData
                                                         withError:&error];
                               if (error) {
                                   NSDictionary *errorDict = @{kServerOpError:error, kServerOpRequestData:userInformation};
                                   failureBlock(errorDict);
                                   return;
                               }
                               responseDict =
                                @{kServerOpRequestData:userInformation,kServerOpResponseData:responseDict};
                               successBlock(responseDict);
                           }];
}

@end
