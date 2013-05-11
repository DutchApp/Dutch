//
//  DUTRequestCreator.m
//  Dutch
//
//  Created by Anuj Chaudhary on 4/7/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import "DUTRequestCreator.h"


// *************************************************************************************************
#pragma mark -
#pragma mark Constants


#define kServerConfigPropertiesFileName @"DUTServerProperties"
#define kPropertiesFileExtension @"plist"
#define kSecureKey @"secure"
#define kHostKey @"host"
#define kContentType @"contentType"
#define kServerTimeOut @"serverTimeOut"
#define kContentTypeHTTPHeaderField @"Content-Type"
#define kHTTPPostMethod @"POST"


// *************************************************************************************************
#pragma mark -
#pragma mark Implementations


@implementation DUTRequestCreator


// *************************************************************************************************
#pragma mark -
#pragma mark Class Methods


+ (NSMutableURLRequest *)urlRequestForRegisterUser {
    NSString *urlString =
        [NSString stringWithFormat:@"%@://%@//users.%@",
                  [self httpProtocol],
                  [self host], [self serverContentType]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *urlRequest =
    [[NSMutableURLRequest alloc] initWithURL:url
                                 cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                             timeoutInterval:[self requestTimeOut]];
    [urlRequest setValue:[self contentTypeForHTTPHeader]
                forHTTPHeaderField:kContentTypeHTTPHeaderField];
    [urlRequest setHTTPMethod:kHTTPPostMethod];
    
    return urlRequest;
}


// *************************************************************************************************
#pragma mark -
#pragma mark Private Methods


+ (NSDictionary *)serverConfiguration {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *pathForFile = [bundle pathForResource:kServerConfigPropertiesFileName ofType:kPropertiesFileExtension];
    NSDictionary *serverConfiguration = [[NSDictionary alloc] initWithContentsOfFile:pathForFile];
    
    return serverConfiguration;
}


+ (NSString *)httpProtocol {
    return ((NSNumber *)[[self serverConfiguration] objectForKey:kSecureKey]).boolValue ? @"https" : @"http";
}


+ (NSString *)host {
    return [[self serverConfiguration] objectForKey:kHostKey];
}


+ (NSString *)serverContentType {
    return [[self serverConfiguration] objectForKey:kContentType];
}


+ (double)requestTimeOut {
    return [[[self serverConfiguration] objectForKey:kServerTimeOut] doubleValue];
}


+ (NSString *)contentTypeForHTTPHeader {
    return [NSString stringWithFormat:@"application/%@", [self serverContentType]];
}

@end
