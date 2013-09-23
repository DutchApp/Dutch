//
//  DUTAppDelegate.m
//  Dutch
//
//  Created by rajmohan lokanath on 3/30/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTAppDelegate.h"

#import "DUTSession.h"


// *************************************************************************************************
#pragma mark -
#pragma mark Private Interface


@interface DUTAppDelegate ()


@end


// *************************************************************************************************
#pragma mark -
#pragma mark Implementation


@implementation DUTAppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [DUTUtility registerUserDefaults];
    [DUTUtility localizationLoad];
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self launchFirsScreen];        
    });

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)launchFirsScreen {
    UIViewController *firstViewController = nil;
    UIViewController *initVC = self.window.rootViewController;
    if ([DUTUtility isAutoLogin] && [[DUTSession sharedSession] loadCache]) {
        firstViewController = [initVC.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    }
    else {
        firstViewController = [initVC.storyboard instantiateViewControllerWithIdentifier:@"login"];
    }
    [UIView transitionFromView:initVC.view toView:firstViewController.view duration:.5f options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
        self.window.rootViewController = firstViewController;
    }];

}
@end
