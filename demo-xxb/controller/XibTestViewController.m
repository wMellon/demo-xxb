//
//  XibTestViewController.m
//  demo-xxb
//
//  Created by xxb on 16/10/24.
//  Copyright © 2016年 xxb. All rights reserved.
//

#import "XibTestViewController.h"

@interface XibTestViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation XibTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _image.hidden = YES;
//    NSString *text = @"attributedString测试：行间距为8。彩虹网络卡福利费绿调查开房；卡法看得出来分开了的出口来反馈率打开了房；快烦死了；了； 调查开房；；v单纯考虑分离开都快来反馈来看发v离开的积分房积分jdhflgfkkvvm.cm。attributedString测试：行间距为8。彩虹网络卡福利费绿调查开房；卡法看得出来分开了的出口来反馈率打开了房；快烦死了；了； 调查开房；；v单纯考虑分离开都快来反馈来看发v离开的积分房积分jdhflgfkkvvm.cm。";
//    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:8];
//    UIColor *color = [UIColor blackColor];
//    NSAttributedString *string = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle}];
//    _label.attributedText = string;
    
    _label.layer.masksToBounds = YES;
    _label.text = @"哈哈哈hahahahh";
//    CGSize size = [_label size];
    CGSize size = [_label sizeThatFits:CGSizeMake(500, 22)];
    NSLog(@"");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
