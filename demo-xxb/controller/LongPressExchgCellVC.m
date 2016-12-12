//
//  LongPressExchgCellVC.m
//  demo-xxb
//
//  Created by xxb on 15/11/15.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import "LongPressExchgCellVC.h"

@interface LongPressExchgCellVC ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation LongPressExchgCellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.dataSource = [@[@"变形金钢",@"速度与激情",@"玩命速递",@"复仇者联盟",@"钢铁侠",@"神盾局特工",@"绿巨人",@"雷神",@"火星救援",@"美国队长",@"寻龙诀",@"007幽灵党"] mutableCopy];
    
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.tableView addGestureRecognizer:recognizer];
}

#pragma mark - action

-(void)longPress:(id)sender{
    UILongPressGestureRecognizer *recognizer = (UILongPressGestureRecognizer*)sender;
    UIGestureRecognizerState state = recognizer.state;
    
    static NSIndexPath *sourceIndexPath;
    static UIView *snapshotView;
    //获取事件在table上的cell
    CGPoint point = [recognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    switch (state) {
        case UIGestureRecognizerStateBegan:{
            //存在indexPath为nil的情况
            if(indexPath){
                sourceIndexPath = indexPath;
                //创建视图快照
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                snapshotView = [self customSnapshoFromView:cell];
                [self.tableView addSubview:snapshotView];
                
                //先设定快照的位置，不然会有一个从上面头部掉下来的效果
                snapshotView.center = cell.center;
                snapshotView.alpha = .0;
                [UIView animateWithDuration:0.25 animations:^{
                    //快照视图的y轴设置为点击的y轴
                    CGPoint center = snapshotView.center;
                    center.y = point.y;
                    snapshotView.center = center;
                    
                    //看起来要比之前的cell大一些
                    snapshotView.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    
                    cell.alpha = 0.0;
                    snapshotView.alpha = 1.0;
                } completion:^(BOOL finished) {
                    cell.hidden = YES;
                }];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{
            CGPoint snapshotViewPoint = snapshotView.center;
            snapshotViewPoint.y = point.y;
            snapshotView.center = snapshotViewPoint;
            if(indexPath){
                if(sourceIndexPath != indexPath){
                    [self.dataSource exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                    [self.tableView moveRowAtIndexPath:indexPath toIndexPath:sourceIndexPath];
                    sourceIndexPath = indexPath;
                }
            }
        }
            break;
        case UIGestureRecognizerStateEnded:{
            //如果取不到indexPath时，就用sourceIndexPath
            NSIndexPath *tempIndexPath = indexPath;
            if(!tempIndexPath){
                tempIndexPath = sourceIndexPath;
            }
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:tempIndexPath];
            cell.alpha = 0.0;
            cell.hidden = NO;
            [UIView animateWithDuration:0.25 animations:^{
                snapshotView.center = cell.center;
                snapshotView.transform = CGAffineTransformIdentity;
                snapshotView.hidden = YES;
                snapshotView.alpha = 0.0;
                cell.alpha = 1.0;
            } completion:^(BOOL finished) {
                [snapshotView removeFromSuperview];
                snapshotView = nil;
            }];
        }
            break;
        default:
            break;
    }
}

- (UIView *)customSnapshoFromView:(UIView *)inputView{
    //下面这句设置为yes会有一闪的效果
    UIView *snapshot = [inputView snapshotViewAfterScreenUpdates:NO];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    return snapshot;
}

#pragma mark - delegate
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    static NSString *cellIdentifier = @"cellIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UITableViewDelegate

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
