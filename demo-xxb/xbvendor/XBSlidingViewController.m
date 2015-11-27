//
//  XBSlidingViewController.m
//  demo-xxb
//
//  Created by xxb on 15/11/16.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import "XBSlidingViewController.h"



@interface UIColor(Sliding)

-(CGFloat)red;
-(CGFloat)green;
-(CGFloat)blue;

@end

@implementation UIColor(Sliding)

-(CGFloat)red{
    return CGColorGetComponents([self CGColor])[0];
}
-(CGFloat)green{
    return CGColorGetComponents([self CGColor])[1];
}
-(CGFloat)blue{
    return CGColorGetComponents([self CGColor])[2];
}

@end


#define btnViewHeight 40

@interface XBSlidingViewController ()<UIScrollViewDelegate>{
    int selectBtnIndex;
}

@property(nonatomic, strong) UIView *headerBtnView;
@property(nonatomic, strong) UIScrollView *contentView;



@end

@implementation XBSlidingViewController

static const CGFloat selectTransform = 1.4f;
static const CGFloat unSelectTransform = 1.0f;

#pragma mark - view生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.headerBtnView];
    [self.view addSubview:self.contentView];
    
    [self addHeaderBtn];
    [self addSubView];
    
    [self setSelectIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 初始化

-(UIView*)headerBtnView{
    if(!_headerBtnView){
        _headerBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, btnViewHeight)];
    }
    return _headerBtnView;
}

-(UIScrollView*)contentView{
    if(!_contentView){
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, btnViewHeight + 1, SCREEN_WIDTH, PAGE_HEIGHT - btnViewHeight)];
        if(_controllers){
            _contentView.contentSize = CGSizeMake(SCREEN_WIDTH * _controllers.count, PAGE_HEIGHT - btnViewHeight);
            _contentView.alwaysBounceHorizontal = YES;
            _contentView.pagingEnabled = YES;
            _contentView.delegate = self;
        }
    }
    return _contentView;
}

-(void)addHeaderBtn{
    if(_controllers){
        NSUInteger count = _controllers.count;
        CGFloat btnWidth = SCREEN_WIDTH / count;
        for(int i = 0; i < count; i++){
            UIViewController *controller = _controllers[i];
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * btnWidth, 0, btnWidth, btnViewHeight)];
            [btn setTitle:controller.title forState:UIControlStateNormal];
            [btn setTitleColor:_unselectedLabelColor forState:UIControlStateNormal];
            btn.tag = i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.headerBtnView addSubview:btn];
        }
    }
}

-(void)addSubView{
    if(_controllers){
        for(int i = 0; i < _controllers.count; i++){
            UIViewController *controller = _controllers[i];
            [self addChildViewController:controller];
            controller.view.frame = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, self.contentView.frame.size.height);
            [self.contentView addSubview:controller.view];
        }
    }
}

#pragma mark - delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    UIButton *currentBtn = [self getBtnByIndex:selectBtnIndex];
    UIButton *nextBtn;
    
    CGFloat scrollWidth = self.contentView.frame.size.width;
    CGFloat offset = scrollView.contentOffset.x - selectBtnIndex * scrollWidth;
    if(offset < 0 && selectBtnIndex > 0){
        nextBtn = [self getBtnByIndex:selectBtnIndex - 1];
    }else if(offset > 0 && selectBtnIndex < _controllers.count - 1){
        nextBtn = [self getBtnByIndex:selectBtnIndex + 1];
    }
    
    offset = fabsf(offset);
    if(nextBtn){
        //transform
        CGFloat currentTransform = unSelectTransform + (selectTransform - unSelectTransform) * (scrollWidth - offset) / scrollWidth;
        CGFloat nextTransform = unSelectTransform + (selectTransform - unSelectTransform) * offset / scrollWidth;
        
        //color
        CGFloat currentR = _selectedLabelColor.red + (_unselectedLabelColor.red - _selectedLabelColor.red) * offset / scrollWidth;
        CGFloat currentG = _selectedLabelColor.green + (_unselectedLabelColor.green - _selectedLabelColor.green) * offset / scrollWidth;
        CGFloat currentB = _selectedLabelColor.blue + (_unselectedLabelColor.blue - _selectedLabelColor.blue) * offset / scrollWidth;
        UIColor *currentColor = [UIColor colorWithRed:currentR green:currentG blue:currentB alpha:1];
        
        CGFloat nextR = _unselectedLabelColor.red + (_selectedLabelColor.red - _unselectedLabelColor.red) * offset / scrollWidth;
        CGFloat nextG = _unselectedLabelColor.green + (_selectedLabelColor.green - _unselectedLabelColor.green) * offset / scrollWidth;
        CGFloat nextB = _unselectedLabelColor.blue + (_selectedLabelColor.blue - _unselectedLabelColor.blue) * offset / scrollWidth;
        UIColor *nextColor = [UIColor colorWithRed:nextR green:nextG blue:nextB alpha:1];
        
        currentBtn.transform = CGAffineTransformMakeScale(currentTransform, currentTransform);
        [currentBtn setTitleColor:currentColor forState:UIControlStateNormal];
        
        nextBtn.transform = CGAffineTransformMakeScale(nextTransform, nextTransform);
        [nextBtn setTitleColor:nextColor forState:UIControlStateNormal];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (0==fmod(scrollView.contentOffset.x,scrollView.frame.size.width)){
        int index = scrollView.contentOffset.x / SCREEN_WIDTH;
        selectBtnIndex = index;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(decelerate){
        int index = scrollView.contentOffset.x / SCREEN_WIDTH;
        selectBtnIndex = index;
    }
}

#pragma mark - 内部操作

- (void)setSelectIndex:(int)index{
    if(selectBtnIndex != index){
        //取消选中
        UIButton *btn = [self getBtnByIndex:selectBtnIndex];
        btn.transform = CGAffineTransformMakeScale(unSelectTransform, unSelectTransform);
        [btn setTitleColor:_unselectedLabelColor forState:UIControlStateNormal];
    }
    //选中
    UIButton *btn = [self getBtnByIndex:index];
    btn.transform = CGAffineTransformMakeScale(selectTransform, selectTransform);
    [btn setTitleColor:_selectedLabelColor forState:UIControlStateNormal];
    selectBtnIndex = index;
    
    [self.contentView setContentOffset:CGPointMake((index * SCREEN_WIDTH), 0) animated:NO];
}

- (UIButton*)getBtnByIndex:(int)index{
    return self.headerBtnView.subviews[index];
}

#pragma mark - interface

-(void)btnClick:(id)sender{
    UIButton *btn = (UIButton*)sender;
    int index = (int)btn.tag;
    [self setSelectIndex:index];
}


@end
