//
//  TestShareSDKViewController.m
//  demo-xxb
//
//  Created by xxb on 15/11/19.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import "TestShareSDKViewController.h"//分享
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface TestShareSDKViewController ()

@end

@implementation TestShareSDKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH - 20, 30)];
    [btn setTitle:@"分享" forState:UIControlStateNormal];                            //设置内容
    btn.titleLabel.font = [UIFont systemFontOfSize:14];                          //字体大小
    [btn setBackgroundColor:[UIColor grayColor]];                                 //背景颜色
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];        //字体颜色
    [btn.layer setMasksToBounds:YES];                                            //
    [btn.layer setBorderWidth:1.0];                                              //边框宽度
    [btn.layer setBorderColor:[[UIColor redColor] CGColor]];                     //边框颜色
    [btn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

-(void)share{
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"banner"]];
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"健康管理 睿康相随"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://device.zysoft.com.cn:8086/zoe-weizhan/views/index.htm"]
                                          title:@"睿康"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:@[
                                         @(SSDKPlatformTypeWechat),
                                         @(SSDKPlatformTypeQQ),
                                         @(SSDKPlatformTypeSinaWeibo)]
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                       
                   }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
