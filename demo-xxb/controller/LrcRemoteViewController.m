//
//  LrcRemoteViewController.m
//  demo-xxb
//
//  Created by xxb on 15/12/11.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import "LrcRemoteViewController.h"
#import "STKAudioPlayer.h"
//#import "FMSongModel.h"
#import "MusicNetKit.h"

#define lineHeight 25

@interface LrcRemoteViewController (){
    BOOL isPause;
    
    NSString *_songId;
    NSString *_songLink;
    NSString *_songLrcLink;
    NSMutableArray *_timeArray;
    NSMutableArray *_lrcArray;
    NSMutableArray *_lrcLabelArray;
}

@property (weak, nonatomic) IBOutlet UILabel *songNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *stopBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIScrollView *lrcScrollView;

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) STKAudioPlayer* audioPlayer;

@end

@implementation LrcRemoteViewController

#pragma mark - view生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self commonInit];
    [self loadSong:_songId completionHandler:^{
        //设置歌词滚动高度
        _lrcScrollView.contentSize = CGSizeMake(_lrcScrollView.width, _timeArray.count * lineHeight);
        for(int i = 0; i < _timeArray.count; i++){
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, i * lineHeight, _lrcScrollView.width, lineHeight)];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = _lrcArray[i];
            label.font = [UIFont systemFontOfSize:14.0];
            [_lrcScrollView addSubview:label];
            [_lrcLabelArray addObject:label];
        }
    }];
}

-(void)loadSong:(NSString*)songId completionHandler:(void (^) ()) completionHandler{
    [MusicNetKit getSongInformationWith:songId completionHandler:^(NSDictionary *data) {
        if(data && [[data allKeys] containsObject:@"data"]){
            NSDictionary *dict = data[@"data"];
            if(dict && [[dict allKeys] containsObject:@"songList"]){
                NSDictionary *songDict = [dict[@"songList"] firstObject];
                _songNameLabel.text = songDict[@"songName"];
                _songLink = songDict[@"songLink"];
                NSRange range = [_songLink rangeOfString:@"src"];
                if (range.location != 2147483647 && range.length != 0) {
                    NSString * temp = [_songLink substringToIndex:range.location-1];
                    _songLink = temp;
                }
                
                //获取歌词
                _songLrcLink = [NSString stringWithFormat:@"http://music.baidu.com%@", songDict[@"lrcLink"]];
                [MusicNetKit getSongLrcWith:_songLrcLink completionHandler:^(NSString *lrcContent) {
                    NSArray *array = [lrcContent componentsSeparatedByString:@"\n"];
                    NSMutableDictionary *lrcTimeDict = [[NSMutableDictionary alloc] init];
                    for(NSString *content in array){
                        //过滤前面
                        if([NSString isBlankString:content] || content.length < 10){
                            continue;
                        }
                        NSString *temp = [content substringToIndex:10];
                        if(![temp hasPrefix:@"["] || ![temp hasSuffix:@"]"]){
                            continue;
                        }
                        //正式切割
                        //[02:06.53][00:38.24]你太善良 你太美丽
                        NSArray *tempArray = [content componentsSeparatedByString:@"]"];
                        for(int i = 0; i < tempArray.count - 1; i ++){
                            temp = tempArray[i];
                            if([temp hasPrefix:@"["]){
                                [lrcTimeDict setObject:tempArray[tempArray.count - 1] forKey:[temp substringWithRange:NSMakeRange(1, temp.length - 1)]];
                            }
                        }
                    }
                    //排序
                    _timeArray = [[lrcTimeDict keysSortedByValueUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                        NSString *s1 = obj1;
                        NSString *s2 = obj2;
                        int i1 = [self getNumFromTimeStr:s1];
                        int i2 = [self getNumFromTimeStr:s2];
                        
                        if (i1 > i2) {
                            return (NSComparisonResult)NSOrderedDescending;
                        }
                        
                        if (i1 < i2) {
                            return (NSComparisonResult)NSOrderedAscending;
                        }
                        return (NSComparisonResult)NSOrderedSame;
                    }] mutableCopy];
                    for(int i = 0; i < _timeArray.count; i++){
                        [_lrcArray addObject: [lrcTimeDict valueForKey:_timeArray[i]]];
                    }
                    completionHandler();
                }];
                
            }
        }
    }];
    
//    http://ting.baidu.com//data2/lrc/13762866/13762866.lrc
}

-(int)getNumFromTimeStr:(NSString*)timeStr{
    if([NSString isBlankString:timeStr]){
        return 0;
    }
    NSArray *array = [timeStr componentsSeparatedByString:@":"];
    int result = [array[0] intValue] * 60 * 100 + [array[1] floatValue] * 100;
    return result;
}

-(void)playProgress{
    //进度条设置
    _slider.minimumValue = 0.0;
    _slider.maximumValue = _audioPlayer.duration;
    [_slider setValue:_audioPlayer.progress animated:YES];
    //歌词
    int b = _audioPlayer.progress * 100;
    for(int i = 0; i < _timeArray.count; i++){
        NSString *time = _timeArray[i];
        int a = [self getNumFromTimeStr:time];
        if(a == b){
            if(i != 0){
                UILabel *label = _lrcLabelArray[i - 1];
                label.textColor = [UIColor blackColor];
            }
            UILabel *label = _lrcLabelArray[i];
            label.textColor = [UIColor redColor];
            [_lrcScrollView setContentOffset:CGPointMake(0, i * lineHeight) animated:YES];
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init初始化

-(void)commonInit{
    
    isPause = YES;
    _songId = @"250280";  //250280 冬天的秘密
    
    //slider设置
    _slider.value = 0.0;
    
    //禁止手动拉动
    _lrcScrollView.userInteractionEnabled = NO;

    self.audioPlayer = [[STKAudioPlayer alloc] init];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(playProgress) userInfo:nil repeats:YES];
    
    _timeArray = [[NSMutableArray alloc] init];
    _lrcArray = [[NSMutableArray alloc] init];
    _lrcLabelArray = [[NSMutableArray alloc] init];

}

#pragma mark - delegate

#pragma mark - action

- (IBAction)stop:(id)sender {
    
}

- (IBAction)play:(id)sender {
    [self.audioPlayer play:_songLink];
}

- (IBAction)chgProgress:(id)sender {
    
//    [_audioPlayer seekToTime:_slider.value];
//    //歌词
//    int x = _slider.value * 100;
//    for(int i = 0; i < _timeArray.count - 1; i++){
//        int a = [self getNumFromTimeStr:_timeArray[i]];
//        int b = [self getNumFromTimeStr:_timeArray[i + 1]];\
//        if(x >= a && x <= b){
//            int temp = i;
//            if(x != b){
//                temp = i + 1;
//            }
//            if(temp != 0){
//                UILabel *label = _lrcLabelArray[temp - 1];
//                label.textColor = [UIColor blackColor];
//            }
//            UILabel *label = _lrcLabelArray[temp];
//            label.textColor = [UIColor redColor];
//            [_lrcScrollView setContentOffset:CGPointMake(0, temp * lineHeight) animated:YES];
//        }
//    }
}


@end
