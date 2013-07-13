//
//  DUTCellContainerSection.m
//  Dutch
//
//  Created by rajmohan lokanath on 4/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTCellContainerSection.h"
#import "DUTCellController.h"


// *************************************************************************************************
#pragma mark -
#pragma mark Interface


@interface DUTCellContainerSection  ()

@property(nonatomic,strong,readwrite) NSMutableArray *controllers;

@end


// *************************************************************************************************
#pragma mark -
#pragma mark Implementation


@implementation DUTCellContainerSection


// *************************************************************************************************
#pragma mark -
#pragma mark Properties


@dynamic numberOfControllers;


// *************************************************************************************************
#pragma mark -
#pragma mark Class Methods


+ (DUTCellContainerSection *)containerSectionWithTitle:(NSString *)title {
    DUTCellContainerSection *containerSection = [[DUTCellContainerSection alloc]initWithTitle:title];
    return containerSection;
}


// *************************************************************************************************
#pragma mark -
#pragma mark Init


- (id)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.title = title;
        self.controllers = [@[] mutableCopy];
    }
    return self;
}


// *************************************************************************************************
#pragma mark -
#pragma mark Instance methods


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
