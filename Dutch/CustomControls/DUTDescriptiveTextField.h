//
//  MyTextField.h
//  BMQSP
//
//  Created by rajmohan lokanath on 5/5/13.
//  Copyright (c) 2013 MirageApps. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DUTControlDelegate.h"

@interface DUTDescriptiveTextField : UITextField
@property(nonatomic,readwrite,strong) NSString *formatText;
@property(nonatomic,weak,readwrite) id<DUTControlDelegate> controlDelegate;
@end
