//
//  DUTDescriptiveTextFieldDelegate.h
//  Dutch
//
//  Created by rajmohan lokanath on 5/11/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DUTDescriptiveTextField;
@interface DUTDescriptiveTextFieldDelegate : NSObject<UITextFieldDelegate>


+ (DUTDescriptiveTextFieldDelegate *)delegateForTextField:(DUTDescriptiveTextField *)textField;


@end
