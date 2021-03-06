//
//  DUTControlDelegate.h
//  Dutch
//
//  Created by rajmohan lokanath on 5/11/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DUTControlDelegate <NSObject>

@optional
- (void)control:(id)control dataChanged:(id)data;
- (void)editBegan:(id)control ;
- (void)editEnded:(id)control ;
- (BOOL)controlCleared:(id)control;

@end
