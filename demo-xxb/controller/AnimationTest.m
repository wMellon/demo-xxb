//
//  AnimationTest.m
//  demo-xxb
//
//  Created by xxb on 16/9/22.
//  Copyright © 2016年 xxb. All rights reserved.
//

#import "AnimationTest.h"

@interface AnimationTest ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation AnimationTest

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIView animateWithDuration:1.0 animations:^{
        _btn.frame = CGRectMake(300, 50, _btn.frame.size.width, _btn.frame.size.height);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
