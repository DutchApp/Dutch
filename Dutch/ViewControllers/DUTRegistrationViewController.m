//
//  DUTRegistrationTableViewController.m
//  Dutch
//
//  Created by rajmohan lokanath on 3/30/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTRegistrationViewController.h"

#import "DUTUtility+Validation.h"
#import "DUTServerOperations.h"
#import "DUTEditableCellController.h"
#import "DUTEmailValidator.h"
#import "DUTTextLengthValidator.h"
#import "DUTEqualityValidator.h"
#import "DUTLocalizations.h"


@interface DUTRegistrationViewController ()


@property(nonatomic,strong,readwrite) DUTEditableCellController *userName;
@property(nonatomic,strong,readwrite) DUTEditableCellController *name;
@property(nonatomic,strong,readwrite) DUTEditableCellController *pwd;
@property(nonatomic,strong,readwrite) DUTEditableCellController *pwd_confirmation;
@property(nonatomic,strong,readwrite) IBOutlet UINavigationBar *navigationBar;
@property(nonatomic,strong,readwrite) IBOutlet UIBarButtonItem *applyButton;
@property(nonatomic,strong,readwrite) DUTGroupedCellControllerContainer *controllerContainer;


@end


@implementation DUTRegistrationViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.topItem.title = TXT_REGISTER_TITLE;
    [self setupSections];
    [self autolayout];
    [self.controllerContainer reloadData];    
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
    @{@"user" : @{@"email":self.userName.text, @"name":self.name.text, @"password":self.pwd.text,
                  @"password_confirmation":self.pwd_confirmation.text}};
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


- (void)setupSections {

    self.controllerContainer =[DUTGroupedCellControllerContainer containerForViewController:self frame:CGRectZero];
    self.controllerContainer.table.backgroundColor = [UIColor lightGrayColor];
    self.controllerContainer.table.backgroundView = nil;
    self.controllerContainer.delegate = self;
    self.controllerContainer.table.translatesAutoresizingMaskIntoConstraints = NO;
    self.navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.controllerContainer assignSectionWithTitle:TXT_REGISTER_SECTION_TITLE index:0];
    
    self.userName =
        [DUTEditableCellController cellControllerWithText:@""
                                              placeHolder:TXT_REGISTER_PHOLDER_USER_EMAIL];
    [self.userName addValidator:[[DUTEmailValidator alloc]init]];
    self.userName.descriptiveFormat = TXT_REGISTER_DESC_USER_EMAIL;
    [self.controllerContainer addCellController:self.userName section:0];
    
    self.name =
        [DUTEditableCellController cellControllerWithText:@""
                                              placeHolder:TXT_REGISTER_PHOLDER_USER_NAME ];
    self.name.descriptiveFormat = TXT_REGISTER_DESC_USER_NAME;
    [self.controllerContainer addCellController:self.name section:0];
    DUTTextLengthValidator *lengthValidator = [DUTTextLengthValidator validatorWithMinLenth:2 maxLength:20];
    [self.name addValidator:lengthValidator];
    
    self.pwd =
        [DUTEditableCellController cellControllerWithText:@""
                                              placeHolder:TXT_REGISTER_PHOLDER_PASSWORD ];
    [self.controllerContainer addCellController:self.pwd section:0];
    
    self.pwd_confirmation =
        [DUTEditableCellController cellControllerWithText:@""
                                              placeHolder:TXT_REGISTER_PHOLDER_PASSWORD_CONFIRM ];
    [self.controllerContainer addCellController:self.pwd_confirmation section:0];
    [self.pwd addValidator:[DUTEqualityValidator validatorWithSource:self.pwd_confirmation selector:@selector(cellData)]];
    [self.pwd_confirmation addValidator:[DUTEqualityValidator validatorWithSource:self.pwd selector:@selector(cellData)]];
    
}

- (void)autolayout {
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

#pragma mark - 
#pragma DUTCellContainerDelegate

- (void)cellContainer:(DUTGroupedCellControllerContainer *)cellContainer dataValidity:(BOOL)valid {
    self.navigationBar.topItem.rightBarButtonItem = valid ? self.applyButton:nil;
}

@end
