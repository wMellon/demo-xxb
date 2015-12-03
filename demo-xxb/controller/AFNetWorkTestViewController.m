//
//  AFNetWorkTestViewController.m
//  demo-xxb
//
//  Created by xxb on 15/11/19.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import "AFNetWorkTestViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "DownLoadOperation.h"

@interface AFNetWorkTestViewController (){
    BOOL isPause;
    CGFloat progress;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;

@property (strong, nonatomic) DownLoadOperation *operation;

@end

@implementation AFNetWorkTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self commonInit];
}

#pragma mark - init

-(void)commonInit{
    isPause = NO;
    self.operation = [[DownLoadOperation alloc] init];
    progress = 0.0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [_imageView.layer setBorderWidth:1.0];
    [_imageView.layer setBorderColor:[[UIColor colorWithRed:64/255.0 green:120/255.0 blue:254/255.0 alpha:1] CGColor]];
    [self.progressView setProgress:progress animated:NO];
}

#pragma mark - action

- (IBAction)start:(id)sender {
    if(!_operation){
        self.operation = [[DownLoadOperation alloc] init];
    }
    NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/temp"];
    [_operation downloadWithUrl:@"http://x1.zhuti.com/down/2012/11/29-win7/3D-1.jpg" cachePath:^NSString *{
        return path;
    } progressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        progress = totalBytesRead / (float)totalBytesExpectedToRead;
        
        [self.progressView setProgress:progress animated:YES];
        
        progress = progress*100 > 100 ? 100 : progress*100;
        
        [self.percentLabel setText:[NSString stringWithFormat:@"%.2f%%",progress]];
        UIImage* image = [UIImage imageWithData:_operation.requestOperation.responseData];
        [self.imageView setImage:image];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"success");
        UIImage* image = [UIImage imageWithData:operation.responseData];
        [self.imageView setImage:image];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",error);
    }];
}
- (IBAction)pause:(id)sender {
    if(_operation && progress < 100){
        if(isPause){
            [_operation.requestOperation resume];
            [_pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
        }else{
            [_operation.requestOperation pause];
            [_pauseBtn setTitle:@"继续" forState:UIControlStateNormal];
        }
        isPause = !isPause;
    }
}
- (IBAction)delete:(id)sender {
    [self.imageView setImage:nil];
    NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/temp"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        [fileManager removeItemAtPath:path error:nil];
    }
    _operation = nil;
    progress = 0.0;
    [self.progressView setProgress:progress animated:NO];
    self.percentLabel.text = @"0.00%";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
