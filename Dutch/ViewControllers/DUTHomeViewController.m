//
//  DUTHomeViewController.m
//  Dutch
//
//  Created by Anuj Chaudhary on 6/2/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import "DUTHomeViewController.h"

#import "DUTConstants.h"
#import "DUTMenuViewController.h"
#import "DUTPieChartViewController.h"
#import "DUTServerOperations.h"
#import "UIViewController+DUTSlideBar.h"


// *************************************************************************************************
#pragma mark -
#pragma mark Interface


@interface DUTHomeViewController ()


@property(nonatomic, strong, readwrite) IBOutlet UINavigationBar *navigationBar;
@property(nonatomic, weak, readwrite) IBOutlet DUTPieChartViewController *pieChartVC;


@end


// *************************************************************************************************
#pragma mark -
#pragma mark Implementation


@implementation DUTHomeViewController


// *************************************************************************************************
#pragma mark -
#pragma mark UIView Overrides


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TODO: Anuj -- 2nd phase
    /*
    self.navigationBar.topItem.leftBarButtonItem =
        [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu"]
                                         style:UIBarButtonItemStyleBordered
                                        target:self
                                        action:@selector(showLeftSlideView:)];
    
    self.navigationBar.topItem.rightBarButtonItem =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                      target:self
                                                      action:@selector(showAddExpenseView:)];
    */
    
    self.navigationBar.topItem.leftBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                         style:UIBarButtonItemStyleBordered
                                        target:self
                                        action:@selector(logoutUser)];
    
    [self setupPieChart];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"piechart"]) {
        self.pieChartVC = segue.destinationViewController;
        [self setupPieChart];
    }
}
// *************************************************************************************************
#pragma mark -
#pragma mark DUTSlideBarDelegate Implementation.


- (UIView *)viewForLeftSidebar {
    CGRect viewFrame = self.applicationViewFrame;
    
    UIViewController *menuViewController = [[DUTMenuViewController alloc] init];
    menuViewController.view.frame = CGRectMake(0, viewFrame.origin.y, 270, viewFrame.size.height);
    menuViewController.view.autoresizingMask =
        UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    return menuViewController.view;
}


// *************************************************************************************************
#pragma mark -
#pragma mark Private Implementation.


- (void)logoutUser {
    NSLog(@"Logout user called");
    
    [DUTServerOperations logoutUserWithSuccessBlock:^(id object) {
        NSLog(@"Success Response: %@", object);
        [self dismissViewControllerAnimated:YES completion:NULL];
    } failureBlock:^(id object) {
        NSLog(@"Failure Response: %@", object);
    }];
}


- (void)showLeftSlideView:(id)sender {
    NSLog(@"This link is working");
    self.slideBarDelegate = self;
    [self toggleRevealState:DUTSlideStateLeft];
}


- (void)showAddExpenseView:(id)sender {
    NSLog(@"Even this link is working");
}


- (void)setupPieChart {
    
    self.pieChartVC.dataForChart = @[@(20.0),@(30.0),@(30.0),@(20.0)];
    
    UIColor *oweAccepted = [UIColor redColor];
    UIColor *oweNotAccepted = [UIColor colorWithRed:COLOR(223)
                                              green:COLOR(135)
                                               blue:COLOR(106)
                                              alpha:1];
    UIColor *owedAccepted = [UIColor greenColor];
    UIColor *owedNotAccepted = [UIColor colorWithRed:COLOR(135)
                                               green:COLOR(223)
                                                blue:COLOR(106)
                                               alpha:1];
    
    self.pieChartVC.colorOfDataPoints = @[oweAccepted,oweNotAccepted,owedAccepted,owedNotAccepted];
    self.pieChartVC.title = @"Big Picture";
}


@end
