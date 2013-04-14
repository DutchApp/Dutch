//
//  DUTRegistrationTableViewController.m
//  Dutch
//
//  Created by rajmohan lokanath on 3/30/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTRegistrationTableViewController.h"

#import "DUTUtility+Validation.h"
#import "DUTServerOperations.h"


@interface DUTRegistrationTableViewController ()


@property(nonatomic,strong,readwrite) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,strong,readwrite) IBOutlet UITextField *userName;
@property(nonatomic,strong,readwrite) IBOutlet UITextField *name;
@property(nonatomic,strong,readwrite) IBOutlet UITextField *pwd;
@property(nonatomic,strong,readwrite) IBOutlet UITextField *pwd_confirmation;
@property(nonatomic,strong,readwrite) IBOutlet UINavigationBar *navigationBar;
@property(nonatomic,strong,readwrite) IBOutlet UIBarButtonItem *doneButton;


@end


@implementation DUTRegistrationTableViewController


- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.topItem.rightBarButtonItem = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// *************************************************************************************************
#pragma mark -
#pragma mark Actions


- (NSString *)stringWithUUID {
    CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
    NSString *uuid = (__bridge_transfer NSString *)(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuid;
}


- (IBAction)done:(id)sender {
     NSDictionary *registrationInfoDictionary =
        @{@"email":self.userName.text, @"name":self.name.text, @"password":self.pwd.text,
          @"password_confirmation":self.pwd_confirmation.text};
    [DUTServerOperations registerUserWithInformation:registrationInfoDictionary
                                        successBlock:^(id object) {
                                            NSLog(@"Response:%@",object);
                                        } failureBlock:^(id object) {
                                            NSLog(@"Failure:%@",object);                                            
                                        }];
}


- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
                                                       replacementString:(NSString *)string {
    NSString *userName = nil;
    NSString *password = nil;
    NSString *name = nil;
    NSString *passwordConfirmation = nil;
    
    if ([textField isEqual:self.userName]) {
        userName = [textField.text stringByReplacingCharactersInRange:range withString:string];
        password = self.pwd.text;
        name = self.name.text;
        passwordConfirmation = self.pwd_confirmation.text;
    }
    else if ([textField isEqual:self.pwd]) {
        password = [textField.text stringByReplacingCharactersInRange:range withString:string];
        name = self.name.text;
        passwordConfirmation = self.pwd_confirmation.text;
        userName = self.userName.text;
    }
    else if ([textField isEqual:self.name]) {
        name = [textField.text stringByReplacingCharactersInRange:range withString:string];
        password = self.pwd.text;
        passwordConfirmation = self.pwd_confirmation.text;
        userName = self.userName.text;
    }
    else if ([textField isEqual:self.pwd_confirmation]) {
        passwordConfirmation = [textField.text stringByReplacingCharactersInRange:range withString:string];
        password = self.pwd.text;
        name = self.name.text;
        userName = self.userName.text;
    }
    
    
    if ([DUTUtility isValidEMail:userName] && [DUTUtility isContentValid:password] &&
        [DUTUtility isContentValid:name] && [DUTUtility isContentValid:passwordConfirmation]) {
        self.navigationBar.topItem.rightBarButtonItem = self.doneButton;
    }
    else {
        self.navigationBar.topItem.rightBarButtonItem = nil;
    }
    
    return YES;
}


- (BOOL)textFieldShouldClear:(UITextField *)textField {
    self.navigationBar.topItem.rightBarButtonItem = nil;
    return YES;
}

@end
