//
//  UIViewController+DUTSlideBar.m
//  Dutch
//
//  Created by Anuj Chaudhary on 6/8/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "UIViewController+DUTSlideBar.h"
#import <objc/runtime.h>


@interface UIViewController (DUTSlideBatPrivate)

- (UIViewController *)selectedViewController;
- (void)revealLeftSidebar:(BOOL)showLeftSidebar;
- (void)revealRightSidebar:(BOOL)showRightSidebar;


@end


@implementation UIViewController (DUTSlideBar)


static char *revealedStateKey;
static char *revealSidebarDelegateKey;

- (void)setSlideBarDelegate:(id<DUTSlideBarDelegate>)slideBarDelegate {
    objc_setAssociatedObject(self, &revealSidebarDelegateKey, slideBarDelegate, OBJC_ASSOCIATION_ASSIGN);
}


- (id <DUTSlideBarDelegate>)slideBarDelegate {
    return (id <DUTSlideBarDelegate>)objc_getAssociatedObject(self, &revealSidebarDelegateKey);
}


- (void)setSlideState:(DUTSlideState)slideState {
    DUTSlideState currentState = self.slideState;

    if (slideState == currentState) {
        return;
    }

    if ([self.slideBarDelegate
            respondsToSelector:@selector(willChangeRevealedStateForViewController:)]) {
        [self.slideBarDelegate willChangeRevealedStateForViewController:self];
    }

    objc_setAssociatedObject(self,
                             &revealedStateKey,
                             [NSNumber numberWithInt:slideState], OBJC_ASSOCIATION_RETAIN);

    switch (currentState) {
        case DUTSlideStateNo:
            if (slideState == DUTSlideStateLeft) {
                [self revealLeftSidebar:YES];
            } else if (slideState == DUTSlideStateRight) {
                [self revealRightSidebar:YES];
            } else {
                // Do Nothing
            }
            break;
        case DUTSlideStateLeft:
            if (slideState == DUTSlideStateNo) {
                [self revealLeftSidebar:NO];
            } else if (slideState == DUTSlideStateRight) {
                [self revealLeftSidebar:NO];
                [self revealRightSidebar:YES];
            } else {
                [self revealLeftSidebar:YES];
            }
            break;
        case DUTSlideStateRight:
            if (slideState == DUTSlideStateNo) {
                [self revealRightSidebar:NO];
            } else if (slideState == DUTSlideStateLeft) {
                [self revealRightSidebar:NO];
                [self revealLeftSidebar:YES];
            } else {
                [self revealRightSidebar:YES];
            }
        default:
            break;
    }
}


- (DUTSlideState)slideState {
    return (DUTSlideState)[objc_getAssociatedObject(self, &revealedStateKey) intValue];
}


- (CGAffineTransform)baseTransform {
    CGAffineTransform baseTransform;
    
    return self.view.transform;
    switch (self.interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            baseTransform = CGAffineTransformIdentity;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            baseTransform = CGAffineTransformMakeRotation(-M_PI/2);
            break;
        case UIInterfaceOrientationLandscapeRight:
            baseTransform = CGAffineTransformMakeRotation(M_PI/2);
            break;
        default:
            baseTransform = CGAffineTransformMakeRotation(M_PI);
            break;
    }
    return baseTransform;
}

// Converting the applicationFrame from UIWindow is founded to be always correct
- (CGRect)applicationViewFrame {
    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    CGRect expectedFrame = [self.view convertRect:appFrame fromView:nil];
    return expectedFrame;
}

- (void)toggleRevealState:(DUTSlideState)openingState {
    DUTSlideState state = openingState;
    if (self.slideState == openingState) {
        state = DUTSlideStateNo;
    }
    [self setSlideState:state];
}


@end

#define SIDEBAR_VIEW_TAG 10000

@implementation UIViewController (DUTSlideBatPrivate)

- (UIViewController *)selectedViewController {
    return self;
}

// Looks like we collasped with the official animationDidStop:finished:context: 
// implementation in the default UITabBarController here, that makes us never
// getting the callback we wanted. So we renamed the callback method here.
- (void)animationDidStop2:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if ([animationID isEqualToString:@"hideSidebarView"]) {
        // Remove the sidebar view after the sidebar closes.
        UIView *view = [self.view.superview viewWithTag:(int)context];
        [view removeFromSuperview];
    }
    
    if ([self.slideBarDelegate respondsToSelector:@selector(didChangeRevealedStateForViewController:)]) {
        [self.slideBarDelegate didChangeRevealedStateForViewController:self];
    }
}

- (void)revealLeftSidebar:(BOOL)showLeftSidebar {
    // Return if delegate does not respond to the selector.
    if (![self.slideBarDelegate respondsToSelector:@selector(viewForLeftSidebar)]) {
        return;
    }

    UIView *revealedView = [self.slideBarDelegate viewForLeftSidebar];
    revealedView.tag = SIDEBAR_VIEW_TAG;
    CGFloat width = CGRectGetWidth(revealedView.frame);

    if (showLeftSidebar) {
        [self.view.superview insertSubview:revealedView belowSubview:self.view];
        
        [UIView beginAnimations:@"" context:nil];
        self.view.frame = CGRectOffset(self.view.frame, width, 0);

    } else {
        [UIView beginAnimations:@"hideSidebarView" context:(void *)SIDEBAR_VIEW_TAG];        
        self.view.frame = CGRectOffset(self.view.frame, -width, 0);
    }
    
    [UIView setAnimationDidStopSelector:@selector(animationDidStop2:finished:context:)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}


- (void)revealRightSidebar:(BOOL)showRightSidebar {    
    if (![self.slideBarDelegate respondsToSelector:@selector(viewForRightSidebar)]) {
        return;
    }

    UIView *revealedView = [self.slideBarDelegate viewForRightSidebar];
    revealedView.tag = SIDEBAR_VIEW_TAG;
    CGFloat width = CGRectGetWidth(revealedView.frame);
    revealedView.frame = (CGRect){self.view.frame.size.width - width,
                                  revealedView.frame.origin.y,
                                  revealedView.frame.size};

    if (showRightSidebar) {
        [self.view.superview insertSubview:revealedView belowSubview:self.view];

        [UIView beginAnimations:@"" context:nil];
        
        self.view.frame = CGRectOffset(self.view.frame, -width, 0);
    } else {
        [UIView beginAnimations:@"hideSidebarView" context:(void *)SIDEBAR_VIEW_TAG];
        self.view.frame = CGRectOffset(self.view.frame, width, 0);
    }
    
    [UIView setAnimationDidStopSelector:@selector(animationDidStop2:finished:context:)];
    [UIView setAnimationDelegate:self];    
    [UIView commitAnimations];
}

@end
