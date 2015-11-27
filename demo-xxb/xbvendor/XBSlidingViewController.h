//
//  XBSlidingViewController.h
//  demo-xxb
//
//  Created by xxb on 15/11/16.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBSlidingViewController : UIViewController

@property(nonatomic, strong) NSArray<UIViewController*> *controllers;
@property(nonatomic,strong) UIColor *selectedLabelColor;
@property(nonatomic,strong) UIColor *unselectedLabelColor;

@end
