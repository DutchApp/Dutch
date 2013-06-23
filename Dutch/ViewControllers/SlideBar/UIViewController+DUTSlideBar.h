//
//  UIViewController+DUTSlideBar.h
//  Dutch
//
//  Created by Anuj Chaudhary on 6/8/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DUTSlideBarDelegate.h"

typedef enum {
    DUTSlideStateNo,
    DUTSlideStateLeft,
    DUTSlideStateRight,
} DUTSlideState;


@interface UIViewController (DUTSlideBar)

@property (nonatomic, assign, readwrite) DUTSlideState slideState;
@property (nonatomic, assign) id<DUTSlideBarDelegate> slideBarDelegate;


/**
 * Use applicationViewFrame to get the correctly calculated view's frame for use as a reference to
 * our sidebar's view
 */
- (CGRect)applicationViewFrame;


/**
 * Handy method for toggling between "opening" and JTRevealedStateNo
 */
- (void)toggleRevealState:(DUTSlideState)openingState;

@end
