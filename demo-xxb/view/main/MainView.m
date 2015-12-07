//
//  MainView.m
//  demo-xxb
//
//  Created by xxb on 15/11/15.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import "MainView.h"

@implementation MainView

+(NSArray*)loadDataSource{
    return @[@{@"title":@"长按对cell排序",@"class":@"LongPressExchgCellVC"},
             @{@"title":@"引导页",@"class":@"StartPagingVC"},
             @{@"title":@"测试横向移动操作",@"class":@"SlidingTestViewController"},
             @{@"title":@"SDWebImage缓存加载测试",@"class":@"WebImgTestViewController"},
             @{@"title":@"AFNetWorking断点续传",@"class":@"AFNetWorkTestViewController"},
             @{@"title":@"仿QQ空间下拉的table",@"class":@"FlexTitleTableViewController"},
             @{@"title":@"测试分享SDK",@"class":@"TestShareSDKViewController"},
             @{@"title":@"测试POP",@"class":@"POPTestViewController"}];
    
    
}

@end
