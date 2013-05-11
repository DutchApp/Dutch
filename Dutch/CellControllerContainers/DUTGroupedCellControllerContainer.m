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

@interface DUTGroupedCellControllerContainer ()
@property(nonatomic,weak,readwrite) UITableView *tableView;
@property(nonatomic,strong,readwrite) NSMutableArray *sections;
@end

@implementation DUTGroupedCellControllerContainer

@dynamic table;

+ (DUTGroupedCellControllerContainer *)containerForViewController:(UIViewController *)vc frame:(CGRect)frame {
    UITableView *groupedTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    DUTGroupedCellControllerContainer *container =
        [[DUTGroupedCellControllerContainer alloc]initWithTableView:groupedTable];
    groupedTable.frame = frame;
    [vc.view addSubview:groupedTable];
    return container;
}


- (id)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        self.tableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
        self.sections = [@[]mutableCopy];
        for (NSInteger index = 0; index < kMaxSections; index++) {
            [self.sections addObject:[NSNull null]];
        }
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
    DUTCellContainerSection *containerSection = [DUTCellContainerSection containerSectionWithTitle:title];
    
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
    [containerSection addCellController:controller];
    return YES;
}


- (BOOL)isValidSectionIndex:(NSInteger)sectionIndex {
    if (sectionIndex >= kMaxSections) {
        return NO;
    }
    return YES;
}


#pragma mark - TableView delegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSPredicate *predicate = [NSPredicate
                              predicateWithFormat:@"SELF != null"];
    //predicate = [predicate predicateWithSubstitutionVariables:
      //           [NSDictionary dictionaryWithObject:[NSNull null] forKey:@"NULL"]];
    NSArray *matches = [self.sections filteredArrayUsingPredicate:predicate];
    return matches.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DUTCellContainerSection *containerSection = [self.sections objectAtIndex:section];
    return containerSection.numberOfControllers;
}
  

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

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

- (UITableView *)table {
    return self.tableView;
}
@end
