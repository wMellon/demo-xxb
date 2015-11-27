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
             @{@"title":@"测试图片缓存",@"class":@"WebImgTestViewController"},
             @{@"title":@"测试AFNetWorking",@"class":@"AFNetWorkTestViewController"},
             @{@"title":@"仿QQ空间下拉的table",@"class":@"FlexTitleTableViewController"},
             @{@"title":@"测试分享SDK",@"class":@"TestShareSDKViewController"}];
    
}

@end
