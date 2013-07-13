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
#import "UIViewController+DUTSlideBar.h"
#import "DUTMenuViewController.h"


// *************************************************************************************************
#pragma mark -
#pragma mark Interface


@interface DUTHomeViewController ()


@property(nonatomic, strong, readwrite) IBOutlet UINavigationBar *navigationBar;


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
    
    self.navigationBar.topItem.leftBarButtonItem =
        [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu"]
                                         style:UIBarButtonItemStyleBordered
                                        target:self
                                        action:@selector(showLeftSlideView:)];
    
    self.navigationBar.topItem.rightBarButtonItem =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                      target:self
                                                      action:@selector(showAddExpenseView:)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (void)showLeftSlideView:(id)sender {
    NSLog(@"This link is working");
    self.slideBarDelegate = self;
    [self toggleRevealState:DUTSlideStateLeft];
}


- (void)showAddExpenseView:(id)sender {
    NSLog(@"Even this link is working");
}


@end
