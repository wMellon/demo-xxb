//
//  WebImgTestViewController.m
//  demo-xxb
//
//  Created by xxb on 15/11/18.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import "WebImgTestViewController.h"
#import "UIImageView+WebCache.h"

@interface WebImgTestViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation WebImgTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self commonInit];
    
    [self loadDataSource];
}


#pragma mark - 初始化

-(void)commonInit{
    self.dataSource = [[NSMutableArray alloc] init];
//    [SDWebImageManager sharedManager].imageCache.maxCacheAge = 5;
    [self addFooterView];
}

-(void)addFooterView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    
    UIButton *clear = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [clear setTitle:@"清缓存" forState:UIControlStateNormal];
    [clear setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [clear setBackgroundColor:[UIColor grayColor]];
    [clear addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:clear];
    
    self.tableView.tableFooterView = view;
}

#pragma mark - interface

-(void)clear{
    [[SDWebImageManager sharedManager].imageCache clearDisk];
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

#pragma mark - dataSource

-(void)loadDataSource{
    NSString *url = @"http://www.sinaimg.cn/dy/slidenews/2_img/2015_47/789_1643931_953153.jpg";
    //缓存方式加载
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:url]
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (image) {
                                for(int i = 0; i < 10; i++){
                                    [_dataSource addObject:image];
                                }
                                [self.tableView reloadData];
                            }
                        }];
    
    //缓存方式加载1
//    static dispatch_once_t one;
//    dispatch_once(&one, ^{
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//        UIImage *image = [UIImage imageWithData:data];
//        if (image) {
//            [[SDImageCache sharedImageCache] storeImage:image forKey:@"test111"];
//            for(int i = 0; i < 10; i++){
//                [_dataSource addObject:image];
//            }
//            [self.tableView reloadData];
//        }
//    });
    
    //一般方式
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//    UIImage *image = [UIImage imageWithData:data];
//    if (image) {
//        for(int i = 0; i < 10; i++){
//            [_dataSource addObject:image];
//        }
//        [self.tableView reloadData];
//    }
}


#pragma mark - delegate
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    static NSString *cellIdentifier = @"cellIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
//    NSString *url = @"http://192.168.6.139/zentao/data/upload/1/201511/17183455059010ok.png";
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""]];
    
    [cell.imageView setImage:_dataSource[indexPath.row]];
    
    //缓存方式加载1
//    NSString *url = @"test111";
//    [[SDImageCache sharedImageCache] queryDiskCacheForKey:url done:^(UIImage *image ,SDImageCacheType cacheType) {
//        if(image){
//            [cell.imageView setImage:image];
//        }
//    }];
    cell.textLabel.text = @"test";
    return cell;
}

#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidUnload{
    [super viewDidUnload];
}

@end
