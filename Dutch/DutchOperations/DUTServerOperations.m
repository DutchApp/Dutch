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
#import "DUTSession.h"
#import "NSMutableDictionary+DUTExtension.h"


// *************************************************************************************************
#pragma mark -
#pragma mark Constants


NSString * const kServerOpError = @"error";
NSString * const kServerOpResponseData = @"responseDict";
NSString * const kServerOpRequestData = @"requestDict";


// *************************************************************************************************
#pragma mark -
#pragma mark Implementation


@implementation DUTServerOperations


// *************************************************************************************************
#pragma mark -
#pragma mark Public Methods


+ (void)loginUserWithInformation:(NSDictionary *)info
                    successBlock:(BlockWithParameter)successBlock
                    failureBlock:(BlockWithParameter)failureBlock {
    NSMutableURLRequest *urlRequest = [DUTRequestCreator urlRequestForLoginUser];
    [self submitURLRequest:urlRequest
                  withInfo:info
              successBlock:^(id object) {
                    NSDictionary *responseDictionary = object;
                  responseDictionary = responseDictionary[kServerOpResponseData];
                    id auth_token = [responseDictionary valueForKey:@"auth_token"];
                    [[DUTSession sharedSession] setAuthToken:auth_token];
                    [[DUTSession sharedSession] setUserId:[responseDictionary valueForKey:@"user_id"]];
                    
                    if ([DUTUtility isAutoLogin]) {
                        [[DUTSession sharedSession] cache];
                    }
                    successBlock(object);
                }
              failureBlock:failureBlock
           progressMessage:@"Logging in"];
}


+ (void)logoutUserWithSuccessBlock:(BlockWithParameter)sucessBlock
                      failureBlock:(BlockWithParameter)failureBlock {
    NSMutableURLRequest * urlRequest = [DUTRequestCreator urlRequestForLogoutUser];
    
    [self submitURLRequest:urlRequest
                  withInfo:nil
              successBlock:^(id object) {
        [[DUTSession sharedSession] reset];
        sucessBlock(object);
    }
              failureBlock:failureBlock
           progressMessage:@"Logging out"];
}


+ (void)registerUserWithInformation:(NSDictionary *)info
                           successBlock:(BlockWithParameter)successBlock
                           failureBlock:(BlockWithParameter)failureBlock {
    NSMutableURLRequest *urlRequest = [DUTRequestCreator urlRequestForRegisterUser];
    
    [self submitURLRequest:urlRequest
                  withInfo:info
              successBlock:successBlock
              failureBlock:failureBlock
           progressMessage:@"Registering New User"];
}


+ (void)createExpenseInformation:(NSDictionary *)info
                    successBlock:(BlockWithParameter)successBlock
                    failureBlock:(BlockWithParameter)failureBlock {
    NSMutableURLRequest *urlRequest = [DUTRequestCreator urlRequestForNewExpense];
    [self submitURLRequest:urlRequest
                  withInfo:info
              successBlock:successBlock
              failureBlock:failureBlock
           progressMessage:@"Creating expense"];
}


// *************************************************************************************************
#pragma mark -
#pragma mark Private Methods


+ (MBProgressHUD *)showProgressViewWithMessage:(NSString *)message {
    MBProgressHUD *progressView =
        [[MBProgressHUD alloc] initWithWindow:[[[UIApplication sharedApplication] delegate] window]];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:progressView];
	progressView.labelText = message;
    
    [progressView show:YES];
    return progressView;
}

+ (void)logRequest:(NSURLRequest *)request {
    NSLog(@"Outgoing request start **************************************************************");
    NSLog(@"URL: %@\nHTTP Method: %@\nheaderFields:%@\nbody:%@",request.URL,request.HTTPMethod,request.allHTTPHeaderFields,request.HTTPBody);
    NSLog(@"Outgoing request ends ***************************************************************");
}


+ (void)submitURLRequest:(NSMutableURLRequest *)urlRequest
                withInfo:(NSDictionary *)info
            successBlock:(BlockWithParameter)successBlock
            failureBlock:(BlockWithParameter)failureBlock
         progressMessage:(NSString *) progressMessage {
    __block NSError *error = nil;
    NSData *encodedData = nil;
    
    if (info) {
        encodedData = [DUTRequestEncoder encodeRequestFromData:info withError:&error];
    }
    
    if (error) {
        NSMutableDictionary *errorDictionary = [[NSMutableDictionary alloc] init];
        [errorDictionary setObjectIfNotNil:error forKey:kServerOpError];
        [errorDictionary setObjectIfNotNil:info forKey:kServerOpRequestData];
        failureBlock(errorDictionary);
        return;
    }
    
    if (encodedData) {
        [urlRequest setHTTPBody:encodedData];
    }
    
    [urlRequest addValue:[[DUTSession sharedSession] authToken] forHTTPHeaderField:@"X-API-TOKEN"];
    
    [self logRequest:urlRequest];
    
    __block MBProgressHUD *progressView = [self showProgressViewWithMessage:progressMessage];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSHTTPURLResponse *urlResponse = nil;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest
                                                     returningResponse:&urlResponse
                                                                 error:&error];
        
        NSLog(@"HTTP response code is %d", urlResponse.statusCode);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [progressView hide:YES];
            
            if (error) {
                NSMutableDictionary *errorDictionary = [[NSMutableDictionary alloc] init];
                [errorDictionary setObjectIfNotNil:error forKey:kServerOpError];
                [errorDictionary setObjectIfNotNil:info forKey:kServerOpRequestData];
                failureBlock(errorDictionary);
                return;
            }
            else {
                NSDictionary *responseDictionary =
                [DUTResponseDecoder decodeFromData:responseData
                                         withError:&error];
                
                if (error) {
                    NSMutableDictionary *errorDictionary = [[NSMutableDictionary alloc] init];
                    [errorDictionary setObjectIfNotNil:error forKey:kServerOpError];
                    [errorDictionary setObjectIfNotNil:info forKey:kServerOpRequestData];
                    failureBlock(errorDictionary);
                }
                else {
                    NSMutableDictionary *successResponse = [[NSMutableDictionary alloc] init];
                    [successResponse setObjectIfNotNil:info forKey:kServerOpRequestData];
                    [successResponse setObjectIfNotNil:responseDictionary
                                                forKey:kServerOpResponseData];
                    successBlock(successResponse);
                }
            }
        });
    });
    
}


@end
