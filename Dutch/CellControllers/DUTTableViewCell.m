//
//  DUTTableViewCell.m
//  Dutch
//
//  Created by rajmohan lokanath on 5/11/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTTableViewCell.h"

@implementation DUTTableViewCell

@dynamic dataIsValid;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setDataIsValid:(BOOL)dataIsValid {
    if (dataIsValid) {
            
    }
    else {
        
    }
}
@end
