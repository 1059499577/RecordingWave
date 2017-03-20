//
//  XMPlayerVC.m
//  AVFoundation学习
//
//  Created by RenXiangDong on 17/1/12.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#import "XMPlayerVC.h"
#import <AVFoundation/AVFoundation.h>

@interface XMPlayerVC ()<AVAudioPlayerDelegate>

@property (nonatomic, retain) AVAudioPlayer *player;
@property (nonatomic, retain) UIImageView *imageVeiw;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end

@implementation XMPlayerVC

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.player prepareToPlay];
    [self prepareUI];
    [self.player play];
 
}

- (void)prepareUI {
    [self.view addSubview:self.imageVeiw];
    self.nameLabel.text = self.sound.name;
    CABasicAnimation *anim = [[CABasicAnimation alloc] init];
    anim.keyPath = @"transform.rotation";
    anim.duration = 10;
    anim.repeatCount = MAXFLOAT;
    anim.fromValue = @0;
    anim.toValue = [NSNumber numberWithDouble:M_PI*2];
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [self.imageVeiw.layer addAnimation:anim forKey:nil];
}

- (IBAction)playAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == NO) {
        [self.player play];
        CFTimeInterval pausedTime = self.imageVeiw.layer.timeOffset;
        self.imageVeiw.layer.speed = 1.0;
        self.imageVeiw.layer.timeOffset = 0.0;
        self.imageVeiw.layer.beginTime = 0.0;
        CFTimeInterval timeSincePause = [self.imageVeiw.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime ;
        self.imageVeiw.layer.beginTime = timeSincePause;
    } else {
      CFTimeInterval pauseTime = [self.imageVeiw.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        self.imageVeiw.layer.speed = 0;
        self.imageVeiw.layer.timeOffset = pauseTime;
        [self.player pause];
    }
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (AVAudioPlayer *)player {
    if (!_player) {
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:self.sound.fileFullPath] error:nil];
        _player.delegate = self;
    }
    return _player;
}

- (UIImageView *)imageVeiw {
    if (!_imageVeiw) {
        CGFloat W = 140;
        CGFloat H = 140;
        CGFloat Y = 140;
        CGFloat X = (kScreenWidth - W) * 0.5;
        _imageVeiw = [[UIImageView alloc] initWithFrame:CGRectMake(X, Y, W, H)];
        _imageVeiw.layer.cornerRadius = 70;
        _imageVeiw.layer.masksToBounds = YES;
        _imageVeiw.image = [UIImage imageNamed:@"720"];
        _imageVeiw.layer.borderColor = [UIColor whiteColor].CGColor;
        _imageVeiw.layer.borderWidth = 4;
    }
    return _imageVeiw;
}


@end
