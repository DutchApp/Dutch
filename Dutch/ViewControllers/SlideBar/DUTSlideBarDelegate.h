//
//  DUTSlideBarDelegate.h
//  Dutch
//
//  Created by Anuj Chaudhary on 6/8/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DUTSlideBarDelegate <NSObject>

@optional

- (UIView *)viewForLeftSidebar;
- (UIView *)viewForRightSidebar;
- (void)willChangeRevealedStateForViewController:(UIViewController *)viewController;
- (void)didChangeRevealedStateForViewController:(UIViewController *)viewController;

@end
