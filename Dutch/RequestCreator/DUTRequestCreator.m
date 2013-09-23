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


static NSString * const kServerConfigPropertiesFileName = @"DUTServerProperties";
static NSString * const kPropertiesFileExtension = @"plist";
static NSString * const kSecureKey = @"secure";
static NSString * const kHostKey = @"host";
static NSString * const kContentType = @"contentType";
static NSString * const kServerTimeOut = @"serverTimeOut";
static NSString * const kContentTypeHTTPHeaderField = @"Content-type";
static NSString * const kHTTPDeleteMethod = @"DELETE";
static NSString * const kHTTPPostMethod = @"POST";


// *************************************************************************************************
#pragma mark -
#pragma mark Implementations


@implementation DUTRequestCreator


// *************************************************************************************************
#pragma mark -
#pragma mark Class Methods


+ (NSMutableURLRequest *)urlRequestForRegisterUser {
    NSString *urlString =
        [NSString stringWithFormat:@"%@://%@/users.%@",
                  [self httpProtocol],
                  [self host], [self serverContentType]];
    
   return [self postURLRequestWithURL:urlString];
}


+ (NSMutableURLRequest *)urlRequestForLoginUser {
    NSString *urlString = [NSString stringWithFormat:@"%@://%@/users/sign_in.%@",
                                    [self httpProtocol],
                                    [self host],
                                    [self serverContentType]];
    
   return [self postURLRequestWithURL:urlString];
}


+ (NSMutableURLRequest *)urlRequestForLogoutUser {
    NSString *urlString = [NSString stringWithFormat:@"%@://%@/users/sign_out.%@",
                                     [self httpProtocol],
                                     [self host],
                                     [self serverContentType]];
    return [self deleteURLRequestWithURL:urlString];
}


+ (NSMutableURLRequest *)urlRequestForNewExpense {
    NSString *urlString = [NSString stringWithFormat:@"%@://%@/expenses.%@",
                           [self httpProtocol],
                           [self host],
                           [self serverContentType]];
   return [self postURLRequestWithURL:urlString];
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


+ (NSMutableURLRequest *)deleteURLRequestWithURL:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest =
        [[NSMutableURLRequest alloc] initWithURL:url
                                     cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                 timeoutInterval:[self requestTimeOut]];
    [urlRequest setValue:[self contentTypeForHTTPHeader]
      forHTTPHeaderField:kContentTypeHTTPHeaderField];
    [urlRequest setHTTPMethod:kHTTPDeleteMethod];
    return urlRequest;
}


+ (NSMutableURLRequest *)postURLRequestWithURL:(NSString *)urlString {
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


@end
