//
//  WebImgTestViewController.m
//  demo-xxb
//
//  Created by xxb on 15/11/18.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import "WebImgTestViewController.h"
#import "UIImageView+WebCache.h"

@interface WebImgTestViewController (){
    SDImageCacheType _cacheType;
}

@property (weak, nonatomic) IBOutlet UILabel *cacheTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *loadTypeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation WebImgTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self commonInit];
    
}


#pragma mark - 初始化

-(void)commonInit{
    _cacheType = SDImageCacheTypeNone;
    [SDWebImageManager sharedManager].imageCache.maxCacheAge = 1;
}



#pragma mark - action

- (IBAction)startLoad:(id)sender {
    [_imageView setImage:nil];
    _loadTypeLabel.text = [NSString stringWithFormat:@"加载方式："];
    NSString *url = @"http://www.sinaimg.cn/dy/slidenews/2_img/2015_47/789_1643931_953153.jpg";
    //缓存方式加载
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (image) {
            [_imageView setImage:image];
            NSString *type = cacheType == SDImageCacheTypeNone ? @"SDImageCacheTypeNone" : (cacheType == SDImageCacheTypeDisk ? @"SDImageCacheTypeDisk" : @"SDImageCacheTypeMemory");
            _loadTypeLabel.text = type;
        }
    }];
    //            [_imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""]];
}

- (IBAction)clearMemory:(id)sender {
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

- (IBAction)clearDisk:(id)sender {
    [[SDWebImageManager sharedManager].imageCache clearDisk];
}

- (IBAction)clearAll:(id)sender {
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    [[SDWebImageManager sharedManager].imageCache clearDisk];
}

#pragma mark - dataSource

//-(void)loadDataSource{
//    
//    //一般方式
////    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
////    UIImage *image = [UIImage imageWithData:data];
////    if (image) {
////        for(int i = 0; i < 10; i++){
////            [_dataSource addObject:image];
////        }
////        [self.tableView reloadData];
////    }
//}
//
//
//#pragma mark - delegate
//#pragma mark UITableViewDataSource
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return _dataSource.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell;
//    static NSString *cellIdentifier = @"cellIdentifier";
//    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
//    }
////    NSString *url = @"http://192.168.6.139/zentao/data/upload/1/201511/17183455059010ok.png";
////    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""]];
//    
//    [cell.imageView setImage:_dataSource[indexPath.row]];
//    
//    //缓存方式加载1
////    NSString *url = @"test111";
////    [[SDImageCache sharedImageCache] queryDiskCacheForKey:url done:^(UIImage *image ,SDImageCacheType cacheType) {
////        if(image){
////            [cell.imageView setImage:image];
////        }
////    }];
//    cell.textLabel.text = @"test";
//    return cell;
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidUnload{
    [super viewDidUnload];
}

@end
