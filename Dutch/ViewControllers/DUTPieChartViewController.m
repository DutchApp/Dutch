//
//  DUTPieChartViewController.m
//  Dutch
//
//  Created by rajmohan lokanath on 7/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTPieChartViewController.h"

@interface DUTPieChartViewController ()
@property(nonatomic,strong,readwrite) CPTXYGraph *pieChart;
@end

@implementation DUTPieChartViewController

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
    [self setupPieChart];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupPieChart {
    // Create pieChart from theme
    CPTXYGraph *pieChart;
    pieChart = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    CPTGraphHostingView *hostingView = (CPTGraphHostingView *)self.view;
    hostingView.hostedGraph = pieChart;
    
    pieChart.paddingLeft   = 0;
    pieChart.paddingTop    = 0;
    pieChart.paddingRight  = 0;
    pieChart.paddingBottom = 0;
    pieChart.backgroundColor = [UIColor lightGrayColor].CGColor;
    
    pieChart.axisSet = nil;
    
    CPTMutableTextStyle *whiteText = [CPTMutableTextStyle textStyle];
    whiteText.color = [CPTColor whiteColor];
    whiteText.fontName = [UIFont boldSystemFontOfSize:15].fontName;
    whiteText.fontSize = 15;
    
    pieChart.titleTextStyle = whiteText;
    pieChart.title          = self.title;
    
    // Add pie chart
    CPTPieChart *piePlot = [[CPTPieChart alloc] init];
    piePlot.dataSource      = self;
    piePlot.pieRadius       = 120;
    piePlot.identifier      = @"Pie Chart 1";
    piePlot.startAngle      = M_PI_4;
    piePlot.sliceDirection  = CPTPieDirectionCounterClockwise;
    piePlot.centerAnchor    = CGPointMake(0.5, 0.5);
    piePlot.borderLineStyle = [CPTLineStyle lineStyle];
    piePlot.delegate        = self;
    piePlot.paddingTop = 10;
    piePlot.backgroundColor = [UIColor lightGrayColor].CGColor;
    [pieChart addPlot:piePlot];
    self.pieChart = pieChart;
}

#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [self.dataForChart count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    if ( index >= [self.dataForChart count] ) {
        return nil;
    }
    
    if ( fieldEnum == CPTPieChartFieldSliceWidth ) {
        return [self.dataForChart objectAtIndex:index];
    }
    else {
        return [NSNumber numberWithInt:index];
    }
}

/*-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
    CPTTextLayer *label = [[CPTTextLayer alloc] initWithText:self.nameOfDataPoints[index]];
    CPTMutableTextStyle *textStyle = [label.textStyle mutableCopy];
    
    textStyle.color = [CPTColor lightGrayColor];
    label.textStyle = textStyle;
    return label;
}*/

-(CGFloat)radialOffsetForPieChart:(CPTPieChart *)piePlot recordIndex:(NSUInteger)index
{
    CGFloat offset = 0.0;
    
    /*if ( index == 0 ) {
        offset = piePlot.pieRadius / 8.0f;
    }*/
    
    return offset;
}

-(CPTFill *)sliceFillForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)idx {
    UIColor *color = self.colorOfDataPoints[idx];
    CPTFill *fill = [CPTFill fillWithColor:[CPTColor colorWithCGColor:color.CGColor]];
    return fill;
}

#pragma mark -
#pragma mark Delegate Methods

-(void)pieChart:(CPTPieChart *)plot sliceWasSelectedAtRecordIndex:(NSUInteger)index
{
    NSLog(@"%@",[NSString stringWithFormat:@"Selected index: %lu", (unsigned long)index]) ;
}

@end
