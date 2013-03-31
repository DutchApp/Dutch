//
//  DUTRegistrationTableViewController.m
//  Dutch
//
//  Created by rajmohan lokanath on 3/30/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTRegistrationTableViewController.h"

#define kUserEmailRow 0
#define kUserNameRow 1
#define kUserPasswordRow 2
#define kUserPasswordReenterRow 3

@interface DUTRegistrationTableViewController ()
@property(nonatomic,strong,readwrite) IBOutlet UIActivityIndicatorView *activityIndicator;
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

#pragma mark - Table view data source



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


#pragma mark - Action Methods


- (IBAction)actionSubmit:(id)sender {
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


- (NSData *)createRequestBody {
    //NSMutableDictionary *registrationInfoDictionary = [@{} mutableCopy];
    NSData *jsonObject = nil;
    UITableViewCell *userEmailCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:kUserEmailRow inSection:0]];
    UITableViewCell *userNameCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:kUserNameRow inSection:0]];
    UITableViewCell *passwordCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:kUserPasswordRow inSection:0]];
    UITableViewCell *reenterPassworCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:kUserPasswordReenterRow inSection:0]];
    
    NSString *userEamil = [(UITextField *)[userEmailCell viewWithTag:100] text];
    NSString *userName = [(UITextField *)[userNameCell viewWithTag:100] text];
    NSString *password = [(UITextField *)[passwordCell viewWithTag:100] text];
    NSString *reenteredPassword = [(UITextField *)[reenterPassworCell viewWithTag:100] text];
    
    NSDictionary *registrationInfoDictionary = @{@"email":userEamil, @"name":userName, @"password":password, @"password_confirmation":reenteredPassword};
    
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


@end
