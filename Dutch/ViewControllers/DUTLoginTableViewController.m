//
//  DUTLoginTableViewController.m
//  Dutch
//
//  Created by rajmohan lokanath on 3/30/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTLoginTableViewController.h"

#import "DUTEditableCellController.h"
#import "DUTEmailValidator.h"
#import "DUTLocalizations.h"
#import "DUTServerOperations.h"


@interface DUTLoginTableViewController ()


@property(nonatomic,strong,readwrite) DUTGroupedCellControllerContainer *controllerContainer;
@property(nonatomic,strong,readwrite) DUTEditableCellController *userName;
@property(nonatomic,strong,readwrite) DUTEditableCellController *password;
@property(nonatomic,strong,readwrite) IBOutlet UINavigationBar *navigationBar;
@property(nonatomic,strong,readwrite) IBOutlet UIButton *btnLogin;
@property(nonatomic,strong,readwrite) IBOutlet UIButton *btnNewUser;
@end


@implementation DUTLoginTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.topItem.title = TXT_LOGIN_TITLE;
    [self setupSections];
    [self autolayout];
    [self.controllerContainer reloadData];       
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// *************************************************************************************************
#pragma mark
#pragma mark - Private Methods


- (void)setupSections {
    self.controllerContainer =
        [DUTGroupedCellControllerContainer containerForViewController:self frame:CGRectZero];
    self.controllerContainer.delegate = self;
    self.controllerContainer.table.translatesAutoresizingMaskIntoConstraints = NO;
    self.navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.controllerContainer assignSectionWithTitle:nil index:0];
    
    self.userName =
    [DUTEditableCellController cellControllerWithText:@""
                                          placeHolder:TXT_LOGIN_PHOLDER_USER_EMAIL];
    self.userName.descriptiveFormat = TXT_LOGIN_DESC_USER_EMAIL;
    [self.userName addValidator:[DUTEmailValidator validator]];
    [self.controllerContainer addCellController:self.userName section:0];
    
    self.password =
    [DUTEditableCellController cellControllerWithText:@""
                                          placeHolder:TXT_LOGIN_PHOLDER_PASSWORD];
    self.password.mask = YES;
    self.password.descriptiveFormat = TXT_LOGIN_DESC_USER_PASSWORD;
    [self.controllerContainer addCellController:self.password section:0];
    
    

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


#pragma mark - DUTCellControllerContainerDelegate

- (void)cellContainer:(DUTGroupedCellControllerContainer *)cellContainer dataValidity:(BOOL)valid {
    
}

- (UIView *)cellContainer:(DUTGroupedCellControllerContainer *)cellContainer
            footerViewForSection:(NSInteger)section {
    UIView *v = nil;
    if (section == 0) {
        self.btnLogin.translatesAutoresizingMaskIntoConstraints = NO;
        self.btnLogin.frame = CGRectMake(10, 10, 300, 50);
        self.btnLogin.layer.cornerRadius = 10;
        self.btnLogin.layer.borderWidth = 2;
        self.btnLogin.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.btnLogin setTitle:TXT_LOGIN_BUTTON_LOGIN forState:UIControlStateNormal];
        v = [[UIView alloc]initWithFrame:CGRectZero];
        [v addSubview:self.btnLogin];
        
        self.btnNewUser.translatesAutoresizingMaskIntoConstraints = NO;
        self.btnNewUser.frame = CGRectMake(10, 80, 300, 20);
        [self.btnNewUser setTitle:TXT_LOGIN_BUTTON_REGISTER forState:UIControlStateNormal];
        
        [v addSubview:self.btnNewUser];   
    }
    
    return v;
}

- (CGFloat)cellContainer:(DUTGroupedCellControllerContainer *)cellContainer
heightForFooterInSection:(NSInteger)section {
    return 140.0f;
}


// *************************************************************************************************
#pragma mark
#pragma mark - UI Action methods


- (IBAction)actionLogin:(id)sender {
    NSDictionary *loginUserInformation =
        @{@"email": self.userName.text, @"password" : self.password.text};
    [DUTServerOperations loginUserWithInformation:loginUserInformation successBlock:^(id object) {
        NSLog(@"Success Response: %@", object);
    } failureBlock:^(id object) {
        NSLog(@"Failure Response: %@", object);
    }];
}


@end
