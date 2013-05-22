//
//  DUTCellContainerSection.m
//  Dutch
//
//  Created by rajmohan lokanath on 4/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTCellContainerSection.h"
#import "DUTCellController.h"

@interface DUTCellContainerSection  ()
@property(nonatomic,strong,readwrite) NSMutableArray *controllers;
@end

@implementation DUTCellContainerSection

@dynamic numberOfControllers;

+ (DUTCellContainerSection *)containerSectionWithTitle:(NSString *)title {
    DUTCellContainerSection *containerSection = [[DUTCellContainerSection alloc]initWithTitle:title];
    return containerSection;
}


- (id)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.title = title;
        self.controllers = [@[] mutableCopy];
    }
    return self;
}


- (NSInteger)numberOfControllers {
    return self.controllers.count;
}


- (void)addCellController:(DUTCellController *)controller {
    [self.controllers addObject:controller];
}

- (DUTCellController *)controllerAtIndex:(NSInteger)index {
    return self.controllers[index];
}


@end
