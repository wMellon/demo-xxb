//
//  StartPagingVC.m
//  demo-xxb
//
//  Created by xxb on 15/11/15.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import "StartPagingVC.h"

@interface StartPagingVC ()<UIScrollViewDelegate>{
    int count;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation StartPagingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    count = 4;
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    
    [self setSubViews];
}

#pragma mark - 初始化

-(UIScrollView*)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, PAGE_HEIGHT)];
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * count, PAGE_HEIGHT);
        _scrollView.pagingEnabled = YES;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(UIPageControl*)pageControl{
    if(!_pageControl){
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, PAGE_HEIGHT - 20, SCREEN_WIDTH, 20)];
        _pageControl.numberOfPages = 4;//总的图片页数
        _pageControl.currentPage = 0;
        [_pageControl setEnabled:NO];
    }
    return _pageControl;
}

-(void)setSubViews{
    NSArray *colors = @[[UIColor redColor], [UIColor blackColor], [UIColor blueColor], [UIColor greenColor]];
    for(int i = 0; i < count; i++){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, PAGE_HEIGHT)];
        view.backgroundColor = colors[i];
        [self.scrollView addSubview:view];
    }
}

#pragma mark - delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x / SCREEN_WIDTH;
    self.pageControl.currentPage = page;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
