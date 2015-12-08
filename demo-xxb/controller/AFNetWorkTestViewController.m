//
//  AFNetWorkTestViewController.m
//  demo-xxb
//
//  Created by xxb on 15/11/19.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import "AFNetWorkTestViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface AFNetWorkTestViewController (){
    BOOL isPause;
    CGFloat progress;
    NSString *cachePath;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;

@property (strong, nonatomic) AFHTTPRequestOperation *operation;
@property (strong, nonatomic) NSMutableURLRequest *request;
@property (strong, nonatomic) AFHTTPRequestOperationManager *operationManager;

@end

@implementation AFNetWorkTestViewController

#pragma mark - view生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self commonInit];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [_operation removeObserver:self forKeyPath:@"isPaused"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"isPaused"] && [[change objectForKey:@"new"] intValue] == 0){
        __weak typeof(self) weakSelf = self;
        __block CGFloat weakProgress = progress;
        __block NSString *weakCachePath = cachePath;
        
        //获取图片已经接收到的大小
        NSFileHandle* fh = [NSFileHandle fileHandleForReadingAtPath:cachePath];
        NSData* contentData = [fh readDataToEndOfFile];
        
        [_operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead)
        {
            totalBytesExpectedToRead = totalBytesExpectedToRead + contentData.length;
            
            weakProgress = (float)totalBytesRead / totalBytesExpectedToRead;
            
            [weakSelf.progressView setProgress:weakProgress animated:YES];
            [weakSelf.percentLabel setText:[NSString stringWithFormat:@"%.2f%%", weakProgress * 100]];
            NSData* data = [NSData dataWithContentsOfFile:weakCachePath];
            UIImage* image = [UIImage imageWithData:data];
            [weakSelf.imageView setImage:image];
        }];
    }
}

#pragma mark - init

-(void)commonInit{
    isPause = NO;
    progress = 0.0;
    cachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/temp"];
    
    [_imageView.layer setBorderWidth:1.0];
    [_imageView.layer setBorderColor:[[UIColor colorWithRed:64/255.0 green:120/255.0 blue:254/255.0 alpha:1] CGColor]];
    [self.progressView setProgress:progress animated:NO];
}

#pragma mark - action

- (IBAction)start:(id)sender {
    if(!_operation){
        _request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://x1.zhuti.com/down/2012/11/29-win7/3D-1.jpg"] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5*60];
        _operationManager = [AFHTTPRequestOperationManager manager];
        _operation = [_operationManager HTTPRequestOperationWithRequest:_request success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            _pauseBtn.enabled = NO;
            _deleteBtn.enabled = YES;
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            _pauseBtn.enabled = NO;
            _deleteBtn.enabled = YES;
        }];
        [_operation addObserver:self forKeyPath:@"isPaused" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        
        NSLog(@"path: %@", cachePath);
        __weak typeof(self) weakSelf = self;
        __block CGFloat weakProgress = progress;
        __block NSString *weakCachePath = cachePath;
        [_operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:cachePath append:NO]];
        [_operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            weakProgress = (float)totalBytesRead / totalBytesExpectedToRead;
            
            [weakSelf.progressView setProgress:weakProgress animated:YES];
            [weakSelf.percentLabel setText:[NSString stringWithFormat:@"%.2f%%", weakProgress * 100]];
            NSData* data = [NSData dataWithContentsOfFile:weakCachePath];
            UIImage* image = [UIImage imageWithData:data];
            [weakSelf.imageView setImage:image];
            
        }];
    }
    [_operation start];
    _startBtn.enabled = NO;
    _pauseBtn.enabled = YES;
    _deleteBtn.enabled = NO;
}
- (IBAction)pause:(id)sender {
    if(_operation && progress < 1){
        if(isPause){
            [_operation resume];
            [_pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
            _deleteBtn.enabled = NO;
        }else{
            [_operation pause];
            [_pauseBtn setTitle:@"继续" forState:UIControlStateNormal];
            _deleteBtn.enabled = YES;
        }
        isPause = !isPause;
    }
}
- (IBAction)delete:(id)sender {
    progress = 0.0;
    isPause = NO;
    
    [self.imageView setImage:nil];
    [self.progressView setProgress:progress animated:NO];
    self.percentLabel.text = @"0.00%";
    [_pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
    _startBtn.enabled = YES;
    _pauseBtn.enabled = YES;
    
    [_operation removeObserver:self forKeyPath:@"isPaused"];
    _request = nil;
    _operation = nil;
    _operationManager = nil;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:cachePath]){
        [fileManager removeItemAtPath:cachePath error:nil];
    }
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
