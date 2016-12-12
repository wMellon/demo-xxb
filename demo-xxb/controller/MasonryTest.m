//
//  MasonryTest.m
//  demo-xxb
//
//  Created by xxb on 16/9/12.
//  Copyright © 2016年 xxb. All rights reserved.
//

#import "MasonryTest.h"
#import "Masonry.h"

@interface MasonryTest ()

@end

@implementation MasonryTest

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor blueColor];
    [self.view addSubview:label];

//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(10);
//        make.top.equalTo(self.view).offset(100);
//        make.height.equalTo(@(100));
//        make.width.equalToWithRelation(self.view, 0.5);
////        make.width.equalToWithRelation(self.view, 0.5);
//    }];
//    imageView.sd_layout
//    .leftSpaceToView(self.view, 10)
//    .topSpaceToView(self.view, 100)
//    .widthRatioToView(self.view, 0.5)
//    .heightIs(100);
//    
//    label.sd_layout
//    .leftSpaceToView(self.view, 10)
//    .topSpaceToView(self.view, 100)
//    .heightIs(10)
//    .widthIs(60)
//    .maxWidthIs(imageView.width_sd);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
