//
//  DUTExpenseAddViewController.m
//  Dutch
//
//  Created by rajmohan lokanath on 10/19/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTExpenseAddViewController.h"

#import "DUTEditableCellController.h"
#import "DUTLocalizations.h"

@interface DUTExpenseAddViewController ()<DUTCellControllerContainerDelegate>


@property(nonatomic,strong,readwrite) DUTGroupedCellControllerContainer *controllerContainer;
@property(nonatomic,strong,readwrite) DUTEditableCellController *name;
@property(nonatomic,strong,readwrite) DUTEditableCellController *date;
@property(nonatomic,strong,readwrite) DUTEditableCellController *totalAmount;
@property(nonatomic,weak,readwrite) IBOutlet UITableView *tableView;


@end

@implementation DUTExpenseAddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.controllerContainer =
    [[DUTGroupedCellControllerContainer alloc]initWithTableView:self.tableView];
    self.controllerContainer.delegate = self;
    self.controllerContainer.table.translatesAutoresizingMaskIntoConstraints = NO;
    [self.controllerContainer assignSectionWithTitle:nil index:0];
    
    self.name =
    [DUTEditableCellController cellControllerWithText:@""
                                          placeHolder:TXT_EXPENSE_NAME_PHOLDER];
    self.name.descriptiveFormat = TXT_NAME;
    [self.controllerContainer addCellController:self.name section:0];
    
    self.date =
    [DUTEditableCellController cellControllerWithText:@""
                                          placeHolder:TXT_EXPENSE_DATE_PHOLDER];
    self.date.descriptiveFormat = TXT_EXPENSE_DATE;
    [self.controllerContainer addCellController:self.date section:0];
    
    self.totalAmount =
    [DUTEditableCellController cellControllerWithText:@""
                                          placeHolder:TXT_EXPENSE_TOTAL_AMOUNT_PHOLDER];
    self.totalAmount.descriptiveFormat = TXT_EXPENSE_TOTAL_AMOUNT;
    [self.controllerContainer addCellController:self.totalAmount section:0];
    
    
    [self.controllerContainer reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onDone:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
