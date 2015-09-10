//
//  ZMFaxianDetailController.m
//  zuimeigeci
//
//  Created by 杨少伟 on 15/9/5.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "ZMFaxianDetailController.h"
#import "UINavigationBar+Awesome.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ZMFaxianContentView.h"
#define NAVBAR_CHANGE_POINT 50
#define TopImageH 250
@interface ZMFaxianDetailController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (nonatomic,weak) UIImageView *topImageView;
@property (nonatomic,weak) ZMFaxianContentView *contentView;
@property (nonatomic,weak) UIView *playView;

@end

@implementation ZMFaxianDetailController


#pragma mark - 控制器生命周期相关方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"浮游国";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self configureNavigationBar];
    [self configureScrollView];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.contentView.width = ZMScreenWidth;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureScrollView{
    self.mScrollView.delegate = self;
    self.mScrollView.contentSize = CGSizeMake(ZMScreenWidth, 1000);
    
    //顶部图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ZMScreenWidth, TopImageH)];
    [self.mScrollView addSubview:imageView];
    self.topImageView = imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    imageView.userInteractionEnabled = YES;
    imageView.clipsToBounds = YES;
    //设置数据
    NSURL *imageUrl = [NSURL URLWithString:self.fxObject.imageUrl.url];
    UIImage *defImage = [UIImage imageNamed:@"timeline_placeholder"];
    [imageView sd_setImageWithURL:imageUrl placeholderImage:defImage];
    
    //设置播放按钮
    if (self.fxObject.musicFile != nil) {
        UIView *playView = [[UIView alloc] initWithFrame:self.topImageView.bounds];
        self.playView = playView;
        [self.mScrollView addSubview:playView];
        
        UIImage *playImage = [UIImage imageNamed:@"playHoverFS"];
        UIImage *playHigh = [UIImage imageNamed:@"playFS"];
        
        UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [playView addSubview:playButton];
        playButton.frame = CGRectMake(0,0,80,80);
        playButton.center =CGRectGetCenter(playView.frame);
        [playButton setImage:playImage forState:UIControlStateNormal];
        [playButton setImage:playHigh forState:UIControlStateHighlighted];
    }
    
    //数据
    ZMFaxianContentView *contentView = [[[NSBundle mainBundle] loadNibNamed:@"ZMFaxianContentView" owner:nil options:nil] lastObject];
    contentView.frame = CGRectMake(0, TopImageH, ZMScreenWidth, 200);
    
    [self.mScrollView addSubview:contentView];
    self.contentView = contentView;
    contentView.fxObject = self.fxObject;
}


#pragma mark - 导航栏相关
- (void)configureNavigationBar{
    //设置navibar 背景颜色
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void)cancelAction{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}


#pragma mark - ScrollView的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    UIColor * color = ZMRGB(33, 186, 175, 1.0);
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat ratio = 1.0/(TopImageH - 64 - NAVBAR_CHANGE_POINT);
        CGFloat c = -ratio * NAVBAR_CHANGE_POINT;
        CGFloat alpha = MIN(1, ratio * offsetY + c);
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}


//- (void)_resetStreamer
//{
//    [self _cancelStreamer];
//    
//    if (0 == [_tracks count])
//    {
//        [_miscLabel setText:@"(No tracks available)"];
//    }
//    else
//    {
//        Track *track = [_tracks objectAtIndex:_currentTrackIndex];
//        NSString *title = [NSString stringWithFormat:@"%@ - %@", track.artist, track.title];
//        [_titleLabel setText:title];
//        
//        _streamer = [DOUAudioStreamer streamerWithAudioFile:track];
//        [_streamer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kStatusKVOKey];
//        [_streamer addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:kDurationKVOKey];
//        [_streamer addObserver:self forKeyPath:@"bufferingRatio" options:NSKeyValueObservingOptionNew context:kBufferingRatioKVOKey];
//        
//        [_streamer play];
//        
//        [self _updateBufferingStatus];
//        [self _setupHintForStreamer];
//    }
//}
//- (void)_cancelStreamer
//{
//    if (_streamer != nil) {
//        [_streamer pause];
//        [_streamer removeObserver:self forKeyPath:@"status"];
//        [_streamer removeObserver:self forKeyPath:@"duration"];
//        [_streamer removeObserver:self forKeyPath:@"bufferingRatio"];
//        _streamer = nil;
//    }
//}


@end
