//
//  DUTGroupedCellControllerContainer.m
//  Dutch
//
//  Created by rajmohan lokanath on 4/13/13.
//  Copyright (c) 2013 Dutch Inc. All rights reserved.
//

#import "DUTGroupedCellControllerContainer.h"

#import "DUTCellContainerSection.h"
#import "DUTCellController.h"

const NSInteger kMaxSections = 10;


// *************************************************************************************************
#pragma mark -
#pragma mark Interface


@interface DUTGroupedCellControllerContainer ()


@property(nonatomic,weak,readwrite) UITableView *tableView;
@property(nonatomic,strong,readwrite) NSMutableArray *sections;


@end


// *************************************************************************************************
#pragma mark -
#pragma mark Implementation


@implementation DUTGroupedCellControllerContainer

@dynamic table;


// *************************************************************************************************
#pragma mark -
#pragma mark Class Methods


+ (DUTGroupedCellControllerContainer *)containerForViewController:(UIViewController *)viewController
                                                   tableViewStyle:(UITableViewStyle)tableViewStyle
                                                            frame:(CGRect)frame {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                             style:tableViewStyle];
    DUTGroupedCellControllerContainer *container =
        [[DUTGroupedCellControllerContainer alloc] initWithTableView:tableView];
    tableView.frame = frame;
    [viewController.view addSubview:tableView];
    return container;
}


// *************************************************************************************************
#pragma mark -
#pragma mark Instance Methods


- (id)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        if (!tableView) {
            tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                     style:UITableViewStyleGrouped];
        }
        
        self.tableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
        self.sections = [@[]mutableCopy];
        
        for (NSInteger index = 0; index < kMaxSections; index++) {
            [self.sections addObject:[NSNull null]];
        }
        
        tableView.backgroundView = nil;
        tableView.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}


- (BOOL)assignSectionWithTitle:(NSString *)title index:(NSInteger)sectionIndex {
    
    if (![self isValidSectionIndex:sectionIndex]) {
        return NO;
    }
    id sectionAtIndex = [self.sections objectAtIndex:sectionIndex];
    
    if (sectionAtIndex != [NSNull null]) {
        // section is being replaced
    }
    DUTCellContainerSection *containerSection =
        [DUTCellContainerSection containerSectionWithTitle:title];
    [self.sections replaceObjectAtIndex:sectionIndex withObject:containerSection];
    
    return YES;
}


- (BOOL)addCellController:(DUTCellController *)controller section:(NSInteger)sectionIndex {
    if (![self isValidSectionIndex:sectionIndex]) {
        return NO;
    }
    DUTCellContainerSection *containerSection = [self.sections objectAtIndex:sectionIndex];
    if (containerSection == (id)[NSNull null]) {
        return NO;
    }
    controller.eventDelegate = self;
    [containerSection addCellController:controller];
    return YES;
}


- (BOOL)isValidSectionIndex:(NSInteger)sectionIndex {
    if (sectionIndex >= kMaxSections) {
        return NO;
    }
    return YES;
}


- (void)reloadData {
    BOOL valid = YES;
    
    for (DUTCellContainerSection *section in self.sections) {
        if ((id)section == [NSNull null]) {
            continue;
        }
        NSInteger numControllers = section.numberOfControllers;
        for (NSInteger index = 0; index < numControllers; index++) {
            DUTCellController *controller = [section controllerAtIndex:index];
            if (![controller isValidData]) {
                valid = NO;
                break;
            }
        }
        if (!valid) {
            break;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(cellContainer:dataValidity:)]) {
        [self.delegate cellContainer:self dataValidity:valid];
    }

}


// *************************************************************************************************
#pragma mark -
#pragma mark Table View Delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSPredicate *predicate = [NSPredicate
                              predicateWithFormat:@"SELF != null"];
    NSArray *matches = [self.sections filteredArrayUsingPredicate:predicate];
    return matches.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DUTCellContainerSection *containerSection = [self.sections objectAtIndex:section];
    return containerSection.numberOfControllers;
}
  

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DUTCellContainerSection *containerSection = [self.sections objectAtIndex:indexPath.section];
    DUTCellController *controller = [containerSection controllerAtIndex:indexPath.row];
    UITableViewCell *cell =
    [self.tableView dequeueReusableCellWithIdentifier:[controller cellIdentifier]];
    
    if (!cell) {
        cell = [controller tableViewCellForTable:tableView];
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DUTCellContainerSection *containerSection = [self.sections objectAtIndex:indexPath.section];
    DUTCellController *controller = [containerSection controllerAtIndex:indexPath.row];
    return controller.height;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    DUTCellContainerSection *containerSection = [self.sections objectAtIndex:section];
    return containerSection.title;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = nil;
    if ([self.delegate respondsToSelector:@selector(cellContainer:footerViewForSection:)]) {
        view = [self.delegate cellContainer:self footerViewForSection:section];
    }
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat height = UITableViewAutomaticDimension;
    if ([self.delegate respondsToSelector:@selector(cellContainer:heightForFooterInSection:)]) {
        height = [self.delegate cellContainer:self heightForFooterInSection:section];
    }
    return height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DUTCellContainerSection *containerSection = [self.sections objectAtIndex:indexPath.section];
    DUTCellController *controller = [containerSection controllerAtIndex:indexPath.row];
    
    if (controller.block) {
        controller.block();
    }
}


- (UITableView *)table {
    return self.tableView;
}


- (void)cellController:(DUTCellController *)controller dataValid:(BOOL)dataValid {
    BOOL valid = YES;    
    for (DUTCellContainerSection *section in self.sections) {
        if (section == (id)[NSNull null]) {
            continue;
        }
        NSInteger numControllers = section.numberOfControllers;
        for (NSInteger index = 0; index < numControllers; index++) {
            DUTCellController *controller = [section controllerAtIndex:index];
            if (![controller isValidData]) {
                valid = NO;
            }
            [controller updateValidityStatus];
        }
    }
    if ([self.delegate respondsToSelector:@selector(cellContainer:dataValidity:)]) {
        [self.delegate cellContainer:self dataValidity:valid];
    }

}


@end
