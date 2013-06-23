//
//  DUTMenuViewController.m
//  Dutch
//
//  Created by Anuj Chaudhary on 6/8/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTMenuViewController.h"


@interface DUTMenuViewController ()

@property(nonatomic,strong,readwrite) DUTGroupedCellControllerContainer *controllerContainer;

@end


@implementation DUTMenuViewController

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


- (void)setupSections {
}

@end
