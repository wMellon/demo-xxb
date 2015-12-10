//
//  MusicTestViewController.m
//  demo-xxb
//
//  Created by xxb on 15/12/10.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import "MusicTestViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MusicTestViewController ()<AVAudioPlayerDelegate>{
    BOOL isPause;
}

@property (weak, nonatomic) IBOutlet UIButton *stopBtn;
@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (strong, nonatomic) AVAudioPlayer *player;
@property (assign, nonatomic) NSTimeInterval duration;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation MusicTestViewController

#pragma mark - view生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self commonInit];
}

- (void)playProgress{
    double progress = _player.currentTime / _duration;
    [_progressView setProgress:progress animated:YES];
}

#pragma mark - init初始化

-(void)commonInit{
    isPause = YES;
    
    [_progressView setProgress:0.0 animated:NO];
    [self player];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(playProgress) userInfo:nil repeats:YES];
}

-(AVAudioPlayer*)player{
    if(!_player){
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"西海情歌" ofType:@"mp3"]] error:nil];
        _player.volume = 0.8;
        _player.numberOfLoops = -1;
        _player.currentTime = 0;
        _player.delegate = self;
        _duration = _player.duration;
        [_player prepareToPlay];
    }
    return _player;
}

#pragma mark - delegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
}

#pragma mark - action

- (IBAction)pause:(id)sender {
    isPause = !isPause;
    if(isPause){
        [_player pause];
        [_pauseBtn setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }else{
        [_timer setFireDate:[NSDate date]];
        [_player play];
        [_pauseBtn setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
}

- (IBAction)stop:(id)sender {
    [_player stop];
    _player.currentTime = 0;
    [_timer setFireDate:[NSDate distantFuture]];
    isPause = YES;
    
    [_pauseBtn setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [_progressView setProgress:0.0 animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
