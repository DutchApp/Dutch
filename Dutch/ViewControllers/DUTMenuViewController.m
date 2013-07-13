//
//  DUTMenuViewController.m
//  Dutch
//
//  Created by Anuj Chaudhary on 6/8/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import "DUTMenuViewController.h"


// *************************************************************************************************
#pragma mark -
#pragma mark Private Interface


@interface DUTMenuViewController ()


@property (nonatomic, strong, readwrite) DUTGroupedCellControllerContainer *controllerContainer;


@end


// *************************************************************************************************
#pragma mark -
#pragma mark Implementation


@implementation DUTMenuViewController


// *************************************************************************************************
#pragma mark -
#pragma mark View Controller Overrides


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSections];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// *************************************************************************************************
#pragma mark -
#pragma mark Private Methods


- (void)setupSections {
}

@end
