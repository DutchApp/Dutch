//
//  DUTAlertViewController.m
//  Dutch
//
//  Created by rajmohan lokanath on 6/2/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTAlertViewController.h"

#import "DUTUtility+Controls.h"
#import "UILabel+DUT.h"
#import "DUTLocalizations.h"

@interface DUTAlertViewController ()
@property(nonatomic,weak,readwrite) IBOutlet UIView *alertView;
@property(nonatomic,weak,readwrite) IBOutlet UILabel *messageLabel;
@property(nonatomic,weak,readwrite) IBOutlet UILabel *alertTitleLabel;
@property(nonatomic,strong,readwrite) NSMutableDictionary *actions;
@property(nonatomic,strong,readwrite) NSMutableArray *buttonTitles;
@end

@implementation DUTAlertViewController

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
    // Do any additional setup after loading the view from its nib.
    self.actions = [@{}mutableCopy];
    self.buttonTitles = [@[]mutableCopy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupMessage];
    [self setupButtons];
    [self setupBorder];
}


- (void)setupBorder {
    UIBezierPath *bezPath;
    CAShapeLayer *shapeLayer;
    shapeLayer = [[CAShapeLayer alloc] init];
    CGRect maskRect = self.alertView.frame;
    maskRect.origin = CGPointMake(0, 0);
    bezPath = [UIBezierPath bezierPathWithRoundedRect:maskRect cornerRadius:8];
    shapeLayer.path = bezPath.CGPath;
    self.alertView.layer.mask = shapeLayer;
    self.alertView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.alertView.layer.borderWidth = 2;
    self.alertView.layer.cornerRadius = 8;
}


- (void)addButtonWithTitle:(NSString *)title action:(void (^)()) block {
    [self.actions setValue:[block copy] forKey:title ];
    [self.buttonTitles addObject:title];
}


- (void)show:(UIViewController *)presentingVC {
    presentingVC.modalPresentationStyle = UIModalPresentationCurrentContext;
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    self.alertView.alpha = 0;
    self.view.backgroundColor = [UIColor clearColor];
    [presentingVC presentViewController:self animated:NO completion:nil];    
    [UIView animateWithDuration:.5 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:.2 alpha:.6];
        self.alertView.center = self.view.center;

    } completion:^(BOOL finished) {
        self.alertView.alpha = 1;
    }];

}


- (void)setupButtons {
    UIButton *button;
    [self makeCancelButtonLast];
    CGFloat yOffset = self.messageLabel.frame.origin.y+self.messageLabel.frame.size.height;
    for (NSString *buttonTitle in self.buttonTitles) {
        button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        CGRect buttonRect = CGRectZero;
        buttonRect.size.width = self.alertView.frame.size.width - 40;
        buttonRect.size.height = 40;
        buttonRect.origin.x = 20;
        buttonRect.origin.y = yOffset + 15.0f;
        button.frame = buttonRect;
        yOffset = buttonRect.origin.y + buttonRect.size.height;
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [DUTUtility roundButton:button width:self.alertView.frame.size.width - 40];
        [self.alertView addSubview:button];
        [button addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    CGRect alerViewRect = self.alertView.frame;
    alerViewRect.size.height = button.frame.origin.y + button.frame.size.height +20.0f;
    self.alertView.frame = alerViewRect;
}

- (void)actionButton:(id)sender {
    UIButton *button = sender;
    NSString *title = [button titleForState:UIControlStateNormal];
    self.alertView.alpha = 0;
    [UIView animateWithDuration:.5 animations:^{
        self.view.backgroundColor = [UIColor clearColor];
        //self.alertView.center = CGPointMake(1000, self.alertView.center.y);
    } completion:^(BOOL finished) {        
        [self dismissViewControllerAnimated:NO completion:^{
            void (^block)(void);
            block = self.actions[title];
            if (block) {
                block();
            }
            self.interfaceObject = nil; // Release interface object. i.e DUTAlertView
        }];
    }];
}

- (IBAction)actionCancel:(id)sender {
    
}

- (void)setupMessage {
    self.messageLabel.text = self.alertMessage;
    if ([self.messageLabel computeNumberOfLines] > 1) {
        self.messageLabel.textAlignment = NSTextAlignmentLeft;
    }
    else {
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    self.alertTitleLabel.text = self.alertTitle;
    self.alertTitleLabel.textColor = [UIColor darkGrayColor];
    [self.messageLabel fitToWidth:self.alertView.frame.size.width - 20];
    CGRect rect = self.messageLabel.frame;
    rect.origin.y = self.alertTitleLabel.frame.origin.y + self.alertTitleLabel.frame.size.height + 10.0f;
    rect.origin.x = 10;
    rect.size.width = self.alertView.frame.size.width - 20;
    self.messageLabel.frame = rect;
}


- (void)makeCancelButtonLast {
   NSIndexSet *matches = [self.buttonTitles indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
       NSString *btnTitle = obj;
       *stop = ([btnTitle caseInsensitiveCompare:TXT_CANCEL] == NSOrderedSame);
       return *stop;
   }];
    
    if (matches.count) {
        id object = [self.buttonTitles objectAtIndex:matches.firstIndex];
        [self.buttonTitles removeObjectAtIndex:matches.firstIndex];
        [self.buttonTitles addObject:object];
    }
}
         
@end
