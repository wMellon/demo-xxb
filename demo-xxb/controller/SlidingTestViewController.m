//
//  SlidingTestViewController.m
//  demo-xxb
//
//  Created by xxb on 15/11/16.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import "SlidingTestViewController.h"
#import "XBSlidingViewController.h"


@interface TestViewController : UIViewController

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end


@interface SlidingTestViewController ()

@end

@implementation SlidingTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    XBSlidingViewController *vc = [[XBSlidingViewController alloc] init];
    
    TestViewController *t1 = [[TestViewController alloc] init];
    t1.title = @"看看";
    t1.view.backgroundColor = [UIColor brownColor];
    
    TestViewController *t2 = [[TestViewController alloc] init];
    t2.title = @"亲切";
    t2.view.backgroundColor = [UIColor redColor];
    
    TestViewController *t3 = [[TestViewController alloc] init];
    t3.title = @"组织";
    t3.view.backgroundColor = [UIColor greenColor];
    
    TestViewController *t4 = [[TestViewController alloc] init];
    t4.title = @"呃呃";
    t4.view.backgroundColor = [UIColor orangeColor];
    
    vc.controllers = @[t1,t2,t3,t4];
    vc.unselectedLabelColor = [UIColor brownColor];
    vc.selectedLabelColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
