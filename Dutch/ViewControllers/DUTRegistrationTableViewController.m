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
#import "DUTGroupedCellControllerContainer.h"
#import "DUTEditableCellController.h"


@interface DUTRegistrationTableViewController ()


@property(nonatomic,strong,readwrite) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,strong,readwrite) IBOutlet DUTEditableCellController *userName;
@property(nonatomic,strong,readwrite) IBOutlet DUTEditableCellController *name;
@property(nonatomic,strong,readwrite) IBOutlet DUTEditableCellController *pwd;
@property(nonatomic,strong,readwrite) IBOutlet DUTEditableCellController *pwd_confirmation;
@property(nonatomic,strong,readwrite) IBOutlet UINavigationBar *navigationBar;
@property(nonatomic,strong,readwrite) IBOutlet UIBarButtonItem *doneButton;
@property(nonatomic,strong,readwrite) DUTGroupedCellControllerContainer *controllerContainer;
@end


@implementation DUTRegistrationTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setupSections];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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


/*- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
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
  }*/

- (void)setupSections {

    self.controllerContainer =[DUTGroupedCellControllerContainer containerForViewController:self frame:CGRectZero];
    self.controllerContainer.table.translatesAutoresizingMaskIntoConstraints = NO;
    self.navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.controllerContainer assignSectionWithTitle:@"Info" index:0];
    self.userName =
        [DUTEditableCellController cellControllerWithText:@""
                                              placeHolder:@"User email" ];
    self.userName.descriptiveFormat = @"User email is %@";
    [self.controllerContainer addCellController:self.userName section:0];
    
    self.name =
        [DUTEditableCellController cellControllerWithText:@""
                                              placeHolder:@"Name" ];
    self.name.descriptiveFormat = @"User name is %@";
    [self.controllerContainer addCellController:self.name section:0];
    
    self.pwd =
        [DUTEditableCellController cellControllerWithText:@""
                                              placeHolder:@"Password" ];
    self.pwd.mask = YES;
    [self.controllerContainer addCellController:self.pwd section:0];
    
    self.pwd_confirmation =
        [DUTEditableCellController cellControllerWithText:@""
                                              placeHolder:@"Password Confirmation" ];
    self.pwd_confirmation.mask = YES;
    [self.controllerContainer addCellController:self.pwd_confirmation section:0];
    
    // Autolayout
    
    {
        id constraint = [NSLayoutConstraint constraintWithItem:self.controllerContainer.table attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.navigationBar attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [self.view addConstraint:constraint];
    }
    {
        id constraint = [NSLayoutConstraint constraintWithItem:self.controllerContainer.table attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [self.view addConstraint:constraint];
    }
    {
        id constraint = [NSLayoutConstraint constraintWithItem:self.controllerContainer.table attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
        [self.view addConstraint:constraint];
    }
    {
        id constraint = [NSLayoutConstraint constraintWithItem:self.controllerContainer.table attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
        [self.view addConstraint:constraint];
    }
}

- (UITableView *)table {
    return self.controllerContainer.table;
}
@end
