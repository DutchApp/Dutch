//
//  DUTCellBackgroundView.h
//  Dutch
//
//  Created by rajmohan lokanath on 5/18/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    CellPositionTop,
    CellPositionMiddle,
    CellPositionBottom,
    CellPositionSingle
} CellPosition;
@interface DUTCellBackgroundView : UIView
@property(assign) CellPosition position;
@property(strong) UIColor *fillColor;
@property(strong) UIColor *borderColor;
@end
