//
//  DUTRegistrationTableViewController.m
//  Dutch
//
//  Created by rajmohan lokanath on 3/30/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTRegistrationTableViewController.h"

#import "DUTUtility+Validation.h"

#define kUserEmailRow 0
#define kUserNameRow 1
#define kUserPasswordRow 2
#define kUserPasswordReenterRow 3

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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


#pragma mark - Action Methods


- (NSData *)createRequestBody {
    NSData *jsonObject = nil;
    NSDictionary *registrationInfoDictionary = @{@"email":self.userName.text, @"name":self.name.text,
                                                 @"password":self.pwd.text,
                                                 @"password_confirmation":self.pwd_confirmation.text};
    
    if ([NSJSONSerialization isValidJSONObject:registrationInfoDictionary]) {
        NSError *error = nil;
        jsonObject = [NSJSONSerialization dataWithJSONObject:registrationInfoDictionary options:0 error:&error];
    }
    return jsonObject;
}


- (NSString *)stringWithUUID {
    CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    //NSString *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    NSString *uuid = (__bridge_transfer NSString *)(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuid;
}


- (IBAction)done:(id)sender {
    NSLog(@"Submit selected");
    NSData *requestBody = [self createRequestBody];
    [self.activityIndicator startAnimating];
    self.tableView.userInteractionEnabled = NO;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSError *error = nil;
        NSURLResponse *response = nil;
        NSURL *url = [NSURL URLWithString:@"https://dutch.herokuapp.com/users.json"];
        NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc]initWithURL:url];
        [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:requestBody];
        NSData *jsonResponseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *error;
            self.tableView.userInteractionEnabled = YES;
            [self.activityIndicator stopAnimating];
            NSDictionary *jsonDict = (NSDictionary *) [NSJSONSerialization JSONObjectWithData:jsonResponseData options:NSJSONReadingMutableContainers error:&error];
            NSLog(@"response %@",jsonDict);
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    });    
}


- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.userName) {
        NSString *userName = textField.text;
        userName = [userName stringByReplacingCharactersInRange:range withString:string];
        if ([DUTUtility validEMail:userName]) {
            self.navigationBar.topItem.rightBarButtonItem = self.doneButton;
        }
        else {
            self.navigationBar.topItem.rightBarButtonItem = nil;
        }
    }
    return YES;
  }
@end
