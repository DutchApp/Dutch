//
//  DUTPieChartViewController.h
//  Dutch
//
//  Created by rajmohan lokanath on 7/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DUTPieChartViewController : UIViewController<CPTPieChartDataSource, CPTPieChartDelegate>
@property(nonatomic,strong,readwrite) NSArray *dataForChart;
@property(nonatomic,strong,readwrite) NSArray *nameOfDataPoints;
@property(nonatomic,strong,readwrite) NSArray *colorOfDataPoints;

@end
