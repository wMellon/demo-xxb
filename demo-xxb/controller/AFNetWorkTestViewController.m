//
//  AFNetWorkTestViewController.m
//  demo-xxb
//
//  Created by xxb on 15/11/19.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import "AFNetWorkTestViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface AFNetWorkTestViewController ()

@end

@implementation AFNetWorkTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://example.com/resources.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
