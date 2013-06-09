//
//  DUTUtility.m
//  Dutch
//
//  Created by rajmohan lokanath on 4/7/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTUtility.h"

#import "DUTSession.h"

@implementation DUTUtility


+ (void)registerUserDefaults {
    NSDictionary *dict = @{@"autologin":@(NO)};
    [[NSUserDefaults standardUserDefaults]registerDefaults:dict];
}


+ (BOOL)isAutoLogin {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"autologin"];
}

+ (void)setAutoLogin:(BOOL)autologin {
    [[NSUserDefaults standardUserDefaults]setBool:autologin forKey:@"autologin"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    if (!autologin) {
        [[DUTSession sharedSession]reset];
    }
}


@end
