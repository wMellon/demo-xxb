//
//  POPTestViewController.m
//  demo-xxb
//
//  Created by xxb on 15/11/30.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import <pop/POP.h>
#import "POPTestViewController.h"

#define lightColor [UIColor colorWithRed:64/255.0 green:120/255.0 blue:254/255.0 alpha:1]

@interface POPTestViewController ()<POPAnimatorDelegate>{
    
    CGRect sourceRect;
    CGFloat sourceCornerRadius;
    UIColor *sourceBackgroundColor;
    
    BOOL _isMenuShow;
}

@property (weak, nonatomic) IBOutlet UIButton *baseBtn;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *animationTypeBtns;

//第二个
@property (weak, nonatomic) IBOutlet UITextField *textField;

//菜单
@property (strong, nonatomic) UIView *menu;
@property (strong, nonatomic) UIImageView *addImageView;

//弹出view
@property (strong, nonatomic) UIView *popView;
@property (weak, nonatomic) IBOutlet UIButton *popBtn;

@end

@implementation POPTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self commonInit];
    
}

#pragma mark - init

-(void)commonInit{
    _baseBtn.layer.cornerRadius = _baseBtn.width / 2;
    sourceRect = _baseBtn.frame;
    sourceCornerRadius = _baseBtn.layer.cornerRadius;
    sourceBackgroundColor = _baseBtn.backgroundColor;
    
    //右上角加上一个按钮，用来测试菜单实现
    [self.view addSubview:self.menu];
    _isMenuShow = NO;
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [searchButton addSubview:self.addImageView];
    searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [searchButton addTarget:self action:@selector(rightBarClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:searchButton]];
    
    //弹出
    [self.view addSubview:self.popView];
}

-(UIView*)menu{
    if(!_menu){
        _menu = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, 0, 0)];
        _menu.backgroundColor = [UIColor grayColor];
    }
    return _menu;
}

-(UIView*)addImageView{
    if(!_addImageView){
        UIImage *image = [UIImage imageNamed:@"add0227"];
        _addImageView = [[UIImageView alloc] initWithImage:image];
        _addImageView.frame = CGRectMake(0, 0, 20, 20);
    }
    return _addImageView;
}

-(UIView*)popView{
    if(!_popView){
        _popView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, 0)];
        _popView.backgroundColor = [UIColor redColor];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popIn)];
        [_popView addGestureRecognizer:gesture];
    }
    return _popView;
}

#pragma mark - POPAnimatorDelegate

- (void)pop_animationDidStart:(POPAnimation *)anim{
    NSLog(@"pop_animationDidStart");
}
- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished{
    NSLog(@"pop_animationDidStop");
    _baseBtn.frame = sourceRect;
    _baseBtn.backgroundColor = sourceBackgroundColor;
    _baseBtn.layer.cornerRadius = sourceCornerRadius;
}
- (void)pop_animationDidReachToValue:(POPAnimation *)anim{
    NSLog(@"pop_animationDidReachToValue");
}

//下面两个协议不会触发
- (void)animatorWillAnimate:(POPAnimator *)animator{
    NSLog(@"animatorWillAnimate");
}

#pragma mark - action

- (IBAction)start:(id)sender {
    UIButton *btn = (UIButton*)sender;
    switch (btn.tag) {
        case 0:
            [self flipAnimation];
            break;
        case 1:
            [self toLeftAnimation];
            break;
        case 2:
            [self toDownAnimation];
            break;
        case 3:
            [self chgColorAnimation];
            break;
        case 4:
            [self shapeToEllipse];
            break;
        default:
            break;
    }
}

//翻转
-(void)flipAnimation{
    POPBasicAnimation *flip = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotationY];
    flip.duration = 1.0;  //值一大，会出现莫名的效果
    _baseBtn.layer.anchorPoint = CGPointMake(0.5, 0.5);
    flip.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    flip.toValue = @(2 * M_PI);
    [_baseBtn.layer pop_addAnimation:flip forKey:@"flip"];
}

//向右移动
-(void)toLeftAnimation{
    // 1. Pick a Kind Of Animation //  POPBasicAnimation  POPSpringAnimation POPDecayAnimation
    POPSpringAnimation *toRightAnimation = [POPSpringAnimation animation];
    //2
    toRightAnimation.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionX];
    
    // 3. Figure Out which of 3 ways to set toValue
    toRightAnimation.springSpeed = 10.f;
    toRightAnimation.springBounciness = 10.0f;  //设置为0，不会有弹动的效果；值越大效果越明显
    toRightAnimation.toValue = @(280);
    
    // 4. Create Name For Animation & Set Delegate
    toRightAnimation.name = @"toRightAnimation";
    toRightAnimation.delegate=self;
    
    // 5. Add animation to View or Layer, we picked View so self.tableView and not layer which would have been self.tableView.layer
    [_baseBtn pop_addAnimation:toRightAnimation forKey:@"toRightAnimation"];
    
}

//向下移动
-(void)toDownAnimation{
    // 1. Pick a Kind Of Animation //  POPBasicAnimation  POPSpringAnimation POPDecayAnimation
    POPSpringAnimation *toDownAnimation = [POPSpringAnimation animation];
    //2
    toDownAnimation.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionY];
    
    // 3. Figure Out which of 3 ways to set toValue
    toDownAnimation.springSpeed = 10.f;
    toDownAnimation.springBounciness = 10.0f;  //设置为0，不会有弹动的效果；值越大效果越明显
    toDownAnimation.toValue = @(300);
    
    // 4. Create Name For Animation & Set Delegate
    toDownAnimation.name = @"toDownAnimation";
    toDownAnimation.delegate=self;
    
    // 5. Add animation to View or Layer, we picked View so self.tableView and not layer which would have been self.tableView.layer
    [_baseBtn pop_addAnimation:toDownAnimation forKey:@"toDownAnimation"];
}

//变色
-(void)chgColorAnimation{
    POPBasicAnimation *chgColor = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
    chgColor.toValue = [UIColor redColor];
    chgColor.delegate = self;
    [_baseBtn.layer pop_addAnimation:chgColor forKey:@"chgColor"];
}

//变椭圆
-(void)shapeToEllipse{
    //变外观
    POPSpringAnimation *shapeToEllipse = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    CGFloat amount = 80.0;
    shapeToEllipse.toValue = [NSValue valueWithCGRect:CGRectInset(_baseBtn.frame, -amount, 15)];
    shapeToEllipse.delegate = self;
    [_baseBtn.layer pop_addAnimation:shapeToEllipse forKey:@"shapeToEllipse"];
    
    //变圆角
    POPBasicAnimation *cornerToRoad = [POPBasicAnimation animation];
    //这里采用自定义property方式处理，其实也可以直接用kPOPLayerCornerRadius
    POPAnimatableProperty *corner = [POPAnimatableProperty propertyWithName:@"layer.CornerRadius" initializer:^(POPMutableAnimatableProperty *prop) {
        prop.readBlock = ^(id obj, CGFloat values[]){
            values[0] = [obj cornerRadius];
        };
        prop.writeBlock = ^(id obj, const CGFloat values[]){
            [obj setCornerRadius:values[0]];
        };
        prop.threshold = 0.01;
    }];
    cornerToRoad.property = corner;
    cornerToRoad.duration = 0.3;  //持续时间
    cornerToRoad.toValue = @(5);
    [_baseBtn.layer pop_addAnimation:cornerToRoad forKey:@"cornerToRoad"];
}

//输入框震动
- (IBAction)wrongSubmit:(id)sender {
    POPSpringAnimation *shake = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    shake.springBounciness = 10; //值越大，摆动幅度越明显
    shake.velocity = @(3000);
    [_textField.layer pop_addAnimation:shake forKey:@"shake"];
}

//右上角菜单
-(void)rightBarClick{
    if(_isMenuShow){
        POPBasicAnimation *rotation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
        rotation.toValue = @(0);
        [_addImageView.layer pop_addAnimation:rotation forKey:@"unrotation"];
        
        POPBasicAnimation *hideMenu = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
        hideMenu.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        hideMenu.toValue = [NSValue valueWithCGRect:CGRectMake(SCREEN_WIDTH, 0, 0, 0)];
        [_menu pop_addAnimation:hideMenu forKey:@"hideMenu"];
        _isMenuShow = NO;
    }else{
        POPBasicAnimation *rotation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
        rotation.toValue = @(M_PI_4);
        [_addImageView.layer pop_addAnimation:rotation forKey:@"rotation"];
        
        POPSpringAnimation *showMenu = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        showMenu.springBounciness = 5;//值越大，摆动幅度越明显
        showMenu.fromValue = [NSValue valueWithCGRect:CGRectMake(SCREEN_WIDTH, 0, 0, 0)];
        showMenu.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        [_menu pop_addAnimation:showMenu forKey:@"showMenu"];
        _isMenuShow = YES;
    }
}

//弹出view
- (IBAction)popUp:(id)sender {
    POPSpringAnimation *popUp = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    popUp.fromValue = [NSValue valueWithCGRect:CGRectMake(50, 0, 100, 30)];
    popUp.toValue = [NSValue valueWithCGRect:CGRectMake(20, SCREEN_HEIGHT / 2, SCREEN_WIDTH - 40, 100)];
    popUp.springBounciness = 10;//值越大，摆动幅度越明显
    
    [_popView pop_addAnimation:popUp forKey:@"popUp"];
    _popBtn.enabled = NO;
}

-(void)popIn{
    POPBasicAnimation *popIn = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    popIn.fromValue = [NSValue valueWithCGRect:CGRectMake(20, SCREEN_HEIGHT / 2, SCREEN_WIDTH - 40, 100)];
    popIn.toValue = [NSValue valueWithCGRect:CGRectMake(50, 0, 100, 0)];
    [_popView pop_addAnimation:popIn forKey:@"popIn"];
    _popBtn.enabled = YES;
}

//组合
-(void)groupAnimation{
    _baseBtn.transform = CGAffineTransformMakeRotation(M_PI_2/3);
    
    //y坐标改变
    POPBasicAnimation* spring = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    spring.beginTime = CACurrentMediaTime();
    spring.duration = .4f;
    spring.fromValue = [NSNumber numberWithFloat:-100.f];
    spring.toValue = [NSNumber numberWithFloat:CGRectGetMinY(_baseBtn.frame) + 80];
    [spring setCompletionBlock:^(POPAnimation * ani, BOOL fin) {
    }];
    
    //旋转
    POPBasicAnimation* basic = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    basic.beginTime = CACurrentMediaTime();
    //先慢后快再慢
    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    basic.toValue = [NSNumber numberWithFloat:-M_PI_4];
    basic.duration = .4f;
    
    //旋转，目标为0
    POPBasicAnimation* rotation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    rotation.beginTime = CACurrentMediaTime() + .4f;
    rotation.toValue = [NSNumber numberWithFloat:0.f];
    rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotation.duration = .25f;
    
    //掉下来
    POPBasicAnimation* down = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    down.beginTime = CACurrentMediaTime() + 0.4f;
    down.toValue = [NSNumber numberWithFloat:CGRectGetMinY(_baseBtn.frame)];
    down.duration = .25f;
    //先慢后快再慢
    down.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
//    [_baseBtn.layer pop_addAnimation:spring forKey:@"spring"];
    [_baseBtn.layer pop_addAnimation:basic forKey:@"basic"];
//    [_baseBtn.layer pop_addAnimation:down forKey:@"down"];
//    [_baseBtn.layer pop_addAnimation:rotation forKey:@"rotation"];
    rotation.delegate = self;
    spring.delegate = self;
    basic.delegate = self;
    down.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
