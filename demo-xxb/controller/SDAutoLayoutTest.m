//
//  SDAutoLayoutTest.m
//  demo-xxb
//
//  Created by xxb on 16/9/12.
//  Copyright © 2016年 xxb. All rights reserved.
//

#import "SDAutoLayoutTest.h"
#import "SDAutoLayout.h"
#import "SDCell.h"

@interface SDAutoLayoutTest ()

@end

@implementation SDAutoLayoutTest

static NSString * const tableViewCellID = @"SDCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12];
    label.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:label];
    
//    UILabel *l1 = [[UILabel alloc] init];
//    l1.font = [UIFont systemFontOfSize:12];
//    l1.backgroundColor = [UIColor redColor];
//    [self.view addSubview:l1];
    
    label.sd_layout
    .leftSpaceToView(self.view, 10)
    .rightSpaceToView(self.view, 10)
    .topSpaceToView(self.view, 100)
    .heightIs(label.font.lineHeight)
    .maxWidthIs(10);
//    [label setSingleLineAutoResizeWithMaxWidth:100];

    label.text = @"看看对方看看对方看看对方看看对方看看对方看看对方看看对方看看对方看看对方看看对方看看对方看看对方";
//    l1.text = @"12312";
    
    
    /*-----测试SD，label显示html文本+app自己控制行间距
    label.sd_layout
    .leftSpaceToView(self.view, 10)
    .topSpaceToView(self.view, 100)
    .widthIs(200)
    .maxWidthIs(200)
    .autoHeightRatio(0);
    label.isAttributedContent = YES;
    
//    NSString *text = @"<p style=\"white-space: normal;color:red\">1、建立永久全面的健康管理档案<\/p>";
    NSString *text = @"<font style='color:red'>1、建立永久全面的健康管理档案</font>";
    text = @"<span style=\"line-height:22px;font-size:13px\"> 就诊人：徐秀斌<br> 就诊时间：2016-11-02 08:16:00<br> 科室：胃肠外科一区(原肿外<br> 医生：蔡智锋<\/span>";
//    text = @"<p>1、建立永久全面的健康管理档案<\/p><p>2、提供科学、精准的健康风险评估分析<\/p><p>3、提供科学健康干预计划（饮食、运动、生活作息等）<\/p><p>4、跟踪监测您的日常生活状态<\/p><p>5、提供全面的月度健康报告<\/p><p><br/><\/p>";
//    text = @"预约成功！就诊人：刘剑锋 就诊时间：<font color='red'>2016-10-27 08:36:00</font> 科室：呼吸内科 医生：陈黎仙。";
//    text = @"预约成功！就诊人：刘剑锋 就诊时间：<font color=\"red\">2016-10-27 08:36:00<\/font> 科室：呼吸内科 医生：陈黎仙。";
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[text dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//    _serviceContentLabel.attributedText = attrStr;
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 11;//调整行间距
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;//设置省略号
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attrStr.string.length)];
    label.attributedText = attrStr;
    [label updateLayout];
    测试SD，label显示html文本+app自己控制行间距*/
    

    
}

#pragma mark - 以下是用于tableview测试

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];[self.tableView registerClass:[SDCell class] forCellReuseIdentifier:tableViewCellID];
//    self.tableView.tableFooterView = [[UIView alloc] init];
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [self.tableView cellHeightForIndexPath:indexPath model:nil keyPath:@"model" cellClass:[SDCell class] contentViewWidth:self.view.width_sd];
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 2;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    SDCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellID];
//    //页面展示设置
//    //    cell.fd_enforceFrameLayout = YES;
//    cell.model = nil;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
//    return cell;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
