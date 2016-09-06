//
//  TestFDTemplateLayoutCell.m
//  demo-xxb
//
//  Created by xxb on 16/9/5.
//  Copyright © 2016年 xxb. All rights reserved.
//

#import "TestFDTemplateLayoutCell.h"
#import "FDCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface TestFDTemplateLayoutCell ()

@end

@implementation TestFDTemplateLayoutCell

static NSString * const tableViewCellID = @"FDCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[FDCell class] forCellReuseIdentifier:tableViewCellID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FDCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellID forIndexPath:indexPath];
    cell.fd_enforceFrameLayout = NO;
    cell.label1.text = @"看到开发开始的见风使舵两个";
    cell.label2.text = @"看到开发开始的见风使舵两个看到开发开始的见风使舵两个看到开发开始的见风使舵两个看到开发开始的见风使舵两个看到开发开始的见风使舵两个看到开发开始的见风使舵两个看到开发开始的见风使舵两个看到开发开始的见风使舵两个看到开发开始的见风使舵两个看到开发开始的见风使舵两个看到开发开始的见风使舵两个";
    cell.label3.text = @"看到开发开始的见风使舵两个";
    cell.image.image = [UIImage imageNamed:@"add0227"];
    cell.view.backgroundColor = [UIColor redColor];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:tableViewCellID cacheByKey:indexPath configuration:^(FDCell *cell) {
        cell.fd_enforceFrameLayout = NO;
        cell.label1.text = @"看到开发开始的见风使舵两个";
        cell.label2.text = @"看到开发开始的见风使舵两个看到开发开始的见风使舵两个看到开发开始的见风使舵两个看到开发开始的见风使舵两个看到开发开始的见风使舵两个看到开发开始的见风使舵两个看到开发开始的见风使舵两个看到开发开始的见风使舵两个看到开发开始的见风使舵两个看到开发开始的见风使舵两个看到开发开始的见风使舵两个";
        cell.label3.text = @"看到开发开始的见风使舵两个";
        cell.image.image = [UIImage imageNamed:@"add0227"];
        cell.view.backgroundColor = [UIColor redColor];
    }];
}

@end
