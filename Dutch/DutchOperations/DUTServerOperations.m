//
//  DUTServerOperations.m
//  Dutch
//
//  Created by Anuj Chaudhary on 4/7/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTServerOperations.h"

#import "DUTRequestEncoder.h"
#import "DUTRequestCreator.h"

@implementation DUTServerOperations


+ (NSData *)registerUserWithInformation:(NSDictionary *)userInformation
                           successBlock:(BasicBlock)successBlock
                           failureBlock:(BasicBlock)failureBlock
                              withError:(NSError **)error {
    NSData *encodedData = [DUTRequestEncoder encodeRequestFromData:userInformation withError:error];
    NSMutableURLRequest *registerUserURLRequest = [DUTRequestCreator urlRequestForRegisterUser];
    
    [registerUserURLRequest setHTTPBody:encodedData];
}

@end
