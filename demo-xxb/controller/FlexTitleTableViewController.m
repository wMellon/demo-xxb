//
//  FlexTitleTableViewController.m
//  demo-xxb
//
//  Created by xxb on 15/11/19.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import "FlexTitleTableViewController.h"

#define sourceImageShowH 140
#define imageH 160
#define alphaH 50

@interface FlexTitleTableViewController ()<UITableViewDataSource,UITableViewDelegate>{
    CGFloat sourceBannerImageViewY;
    UIColor *navigationBarColor;
}

@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) UIImageView *bannerImageView;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIView *navigationBarView;

@end

@implementation FlexTitleTableViewController

#pragma mark - view生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    
    [self commonInit];
    
    [self loadDataSource];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //去掉导航栏与子页面的分割线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    _tableView.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_navigationBarView removeFromSuperview];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    _tableView.delegate = nil;
    self.navigationController.navigationBar.translucent = NO;
}


#pragma mark - 初始化

-(void)commonInit{
    self.dataSource = [[NSMutableArray alloc] init];
    navigationBarColor = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    
    [self addViewToBar];
    [self.tableView addSubview:self.bannerImageView];
    [self.view addSubview:self.tableView];
}

-(UIImageView*)bannerImageView{
    if(!_bannerImageView){
        _bannerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,-imageH, SCREEN_WIDTH, imageH)];
        [_bannerImageView setImage:[UIImage imageNamed:@"banner"]];
        _bannerImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bannerImageView;
}

-(UITableView*)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT + 64)];
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(sourceImageShowH, 0, 0, 0);
    }
    return _tableView;
}

-(void)addViewToBar{
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navigationBar insertSubview:self.navigationBarView atIndex:0];
}

-(UIView*)navigationBarView{
    if(!_navigationBarView){
        _navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, 64)];
        _navigationBarView.userInteractionEnabled = NO;
        _navigationBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _navigationBarView;
}

#pragma mark - dataSource

-(void)loadDataSource{
}

#pragma mark - delegate
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    static NSString *cellIdentifier = @"cellIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"cell %ld", (long)indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y + 64;
    if(offset <= -imageH){
        CGRect rect = _bannerImageView.frame;
        rect.origin.y = offset;
        rect.size.height = -offset;
        _bannerImageView.frame = rect;
    }
    
    CGRect rect = [[_bannerImageView superview] convertRect:_bannerImageView.frame toView:self.view.window];
    CGFloat y = CGRectGetMaxY(rect);
    if(y <= 128){
        CGFloat alpha = 1 - (y - 64) / 64;
        _navigationBarView.backgroundColor = [navigationBarColor colorWithAlphaComponent:alpha];
    }else{
        _navigationBarView.backgroundColor = [navigationBarColor colorWithAlphaComponent:0];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
