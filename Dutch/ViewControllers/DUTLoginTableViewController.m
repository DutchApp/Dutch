//
//  DUTLoginTableViewController.m
//  Dutch
//
//  Created by rajmohan lokanath on 3/30/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTLoginTableViewController.h"

#import "DUTEditableCellController.h"
#import "DUTSwitchCellController.h"
#import "DUTEmailValidator.h"
#import "DUTTextLengthValidator.h"
#import "DUTLocalizations.h"
#import "DUTServerOperations.h"
#import "DUTSession.h"
#import "DUTAmountCellController.h"
#import "DUTUtility+Controls.h"
#import "DUTHomeViewController.h"
#import "DUTAlertView.h"


@interface DUTLoginTableViewController ()


@property(nonatomic,strong,readwrite) DUTGroupedCellControllerContainer *controllerContainer;
@property(nonatomic,strong,readwrite) DUTEditableCellController *userName;
@property(nonatomic,strong,readwrite) DUTEditableCellController *password;
@property(nonatomic,strong,readwrite) DUTSwitchCellController *autologin;
@property(nonatomic,strong,readwrite) IBOutlet UINavigationBar *navigationBar;
@property(nonatomic,strong,readwrite) IBOutlet UIButton *btnLogin;
@property(nonatomic,strong,readwrite) IBOutlet UIButton *btnNewUser;
@end


@implementation DUTLoginTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self setupSections];
    [self autolayout];
    [self.controllerContainer reloadData];
    [self.userName performSelector:@selector(becomeFirstResponder)];
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
        [DUTGroupedCellControllerContainer containerForViewController:self
                                                       tableViewStyle:UITableViewStyleGrouped
                                                                frame:CGRectZero];
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
    [self.password addValidator:[DUTTextLengthValidator validatorWithMinLenth:8 maxLength:20]];
    [self.controllerContainer addCellController:self.password section:0];
    
    self.autologin = [DUTSwitchCellController cellControllerWithMessage:TXT_LOGIN_AUTOLOGIN ];
    self.autologin.theSwitch.on = [DUTUtility isAutoLogin];
    [self.controllerContainer addCellController:self.autologin section:0];
    
#if 0 // Code to test amount cell
    DUTAmountCellController *controller = [DUTAmountCellController cellControllerWithAmount:[NSDecimalNumber decimalNumberWithString:@"100.23"] currencyCode:nil];
    [self.controllerContainer addCellController:controller section:0];
#endif

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


- (void)setupNavBar {
    self.navigationBar.topItem.title = TXT_LOGIN_TITLE;
    self.navigationBar.titleTextAttributes =
    @{UITextAttributeTextColor:[UIColor darkGrayColor],
      UITextAttributeFont:[UIFont systemFontOfSize:18]};
}


#pragma mark - DUTCellControllerContainerDelegate

- (void)cellContainer:(DUTGroupedCellControllerContainer *)cellContainer dataValidity:(BOOL)valid {
    if ([self.userName isValidData] && [self.password isValidData]) {
        self.btnLogin.enabled = YES;
    }
    else {
        self.btnLogin.enabled = NO;
    }
    
}

- (UIView *)cellContainer:(DUTGroupedCellControllerContainer *)cellContainer
            footerViewForSection:(NSInteger)section {
    UIView *v = nil;
    if (section == 0) {
        self.btnLogin.translatesAutoresizingMaskIntoConstraints = NO;
        self.btnLogin.frame = CGRectMake(10, 5, 100, 45);
        
        [DUTUtility roundButton:self.btnLogin width:CGRectGetWidth(self.btnLogin.frame)];
        
        [self.btnLogin setTitle:TXT_LOGIN_BUTTON_LOGIN forState:UIControlStateNormal];
        v = [[UIView alloc]initWithFrame:CGRectZero];
        [v addSubview:self.btnLogin];
        
        self.btnNewUser.translatesAutoresizingMaskIntoConstraints = NO;
        self.btnNewUser.frame = CGRectMake(120, 5 +(45.0-20.0)/2.0, 200, 20);
        [self.btnNewUser setTitle:TXT_LOGIN_BUTTON_REGISTER forState:UIControlStateNormal];
        
        [v addSubview:self.btnNewUser];   
    }
    
    return v;
}

- (CGFloat)cellContainer:(DUTGroupedCellControllerContainer *)cellContainer
heightForFooterInSection:(NSInteger)section {
    return 140.0f;
}


- (void)cellContainer:(DUTGroupedCellControllerContainer *)cellContainer
dataChangedInCellController:(DUTCellController *)cellController {
    if (cellController == self.autologin) {
        NSLog(@"Autologin is %d",self.autologin.theSwitch.on);
        [DUTUtility setAutoLogin:self.autologin.theSwitch.on];
    }
}
// *************************************************************************************************
#pragma mark
#pragma mark - UI Action methods


- (IBAction)actionLogin:(id)sender {
/*
#if 1 //Alert test code. Remove when stable

    DUTAlertView *alertView = [DUTAlertView alertViewWithTitle:@"VeryAlert" message:@"In the not very very distant past, the corridors of the U.S. Senate were alive with men who had served in World War II, among them such powerful icons as John Warner of Virginia, Ted Stevens of Alaska, Daniel Inouye of Hawaii and Ernest Hollings"];

    [alertView addButtonWithTitle:@"Go!" action:nil];
    [alertView addCancelButtonWithAction:^{
        NSLog(@"Cancel clicked");
    }];
    [alertView addOkButtonWithAction:^{
        NSLog(@"OK clicked");
    }];
    

    [alertView show];
    return;
#endif
*/
    NSDictionary *loginUserInformation =
        @{@"email": self.userName.text, @"password" : self.password.text};
    
    [DUTServerOperations loginUserWithInformation:loginUserInformation successBlock:^(id object) {
        NSLog(@"Success Response: %@", object);
        UIStoryboard *storyBoard = self.storyboard;
        // Pushing Home Screen.
        DUTHomeViewController *homeScreenViewController =
            [storyBoard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        [self presentViewController:homeScreenViewController animated:YES completion:nil];
        } failureBlock:^(id object) {
        NSLog(@"Failure Response: %@", object);
    }];
}


@end
