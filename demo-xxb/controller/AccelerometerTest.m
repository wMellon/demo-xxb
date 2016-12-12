//
//  AccelerometerTest.m
//  demo-xxb
//
//  Created by xxb on 16/9/13.
//  Copyright © 2016年 xxb. All rights reserved.
//

#import "AccelerometerTest.h"

@interface AccelerometerTest ()

@end

@implementation AccelerometerTest

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIAccelerometer sharedAccelerometer]setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:
    (UIAcceleration *)acceleration{
    [xlabel setText:[NSString stringWithFormat:@"%f",acceleration.x]];
    [ylabel setText:[NSString stringWithFormat:@"%f",acceleration.y]];
    [zlabel setText:[NSString stringWithFormat:@"%f",acceleration.z]];
}

@end
