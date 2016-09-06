//
//  MainViewController.m
//  demo-xxb
//
//  Created by xxb on 15/11/15.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
#import "XBSlidingViewController.h"
#import "SlidingTestViewController.h"

@interface MainViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.dataSource = [MainView loadDataSource];
}

#pragma mark - delegate
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    static NSString *cellIdentifier = @"cellIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    NSDictionary *dict = self.dataSource[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    return cell;
}

#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = self.dataSource[indexPath.row];
    NSString *className = dict[@"class"];
    UIViewController *controller;
    if([className isEqualToString:@"SlidingTestViewController"]){
        XBSlidingViewController *vc = [[XBSlidingViewController alloc] init];
        
        SlidingTestViewController *t1 = [[SlidingTestViewController alloc] init];
        t1.title = @"电影";
        t1.view.backgroundColor = [UIColor brownColor];
        
        SlidingTestViewController *t2 = [[SlidingTestViewController alloc] init];
        t2.title = @"运动";
        t2.view.backgroundColor = [UIColor redColor];
        
        SlidingTestViewController *t3 = [[SlidingTestViewController alloc] init];
        t3.title = @"美食";
        t3.view.backgroundColor = [UIColor greenColor];
        
        SlidingTestViewController *t4 = [[SlidingTestViewController alloc] init];
        t4.title = @"睡觉";
        t4.view.backgroundColor = [UIColor orangeColor];
        
        vc.controllers = @[t1,t2,t3,t4];
        vc.unselectedLabelColor = [UIColor brownColor];
        vc.selectedLabelColor = [UIColor redColor];
        controller = vc;
    }else{
        controller = [[NSClassFromString(className) alloc] init];
        controller.title = dict[@"title"];
    }
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
