//
//  DUTServerOperations.m
//  Dutch
//
//  Created by Anuj Chaudhary on 4/7/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTServerOperations.h"

#import "DUTAppDelegate.h"
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
    __block NSError *error = nil;
    NSData *encodedData = [DUTRequestEncoder encodeRequestFromData:userInformation withError:&error];
    
    if (error) {
        NSDictionary *errorDict = @{kServerOpError:error, kServerOpRequestData:userInformation};
        failureBlock(errorDict);
        return;
    }
    
    NSMutableURLRequest *registerUserURLRequest = [DUTRequestCreator urlRequestForRegisterUser];
    [registerUserURLRequest setHTTPBody:encodedData];
    
    [self logRequest:registerUserURLRequest];
    
    __block MBProgressHUD *progressView = [self showProgressViewWithMessage:@"Loading"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSURLResponse *urlResponse = nil;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:registerUserURLRequest
                                                     returningResponse:&urlResponse
                                                                 error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            [progressView hide:YES];
            if (error) {
                NSDictionary *errorDict = @{kServerOpError:error, kServerOpRequestData:userInformation};
                failureBlock(errorDict);
                return;
            }
            else {
               NSDictionary *responseDict =
                    [DUTResponseDecoder decodeFromData:responseData
                                              withError:&error];
                if (error) {
                    NSDictionary *errorDict = @{kServerOpError:error, kServerOpRequestData:userInformation};
                    failureBlock(errorDict);
                }
                else {
                    responseDict = @{kServerOpRequestData:userInformation,kServerOpResponseData:responseDict};
                    successBlock(responseDict);
                }
            }
        });
    });
}


+ (MBProgressHUD *)showProgressViewWithMessage:(NSString *)message {
    MBProgressHUD *progressView =
        [[MBProgressHUD alloc] initWithWindow:[[[UIApplication sharedApplication] delegate] window]];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:progressView];
	progressView.labelText = message;
    
    [progressView show:YES];
    return progressView;
}

+ (void)logRequest:(NSURLRequest *)request {
    NSLog(@"URL:%@\nHTTP Method: %@\nheaderFields:%@\nbody:%@",request.URL,request.HTTPMethod,request.allHTTPHeaderFields,request.HTTPBody);
}
@end
