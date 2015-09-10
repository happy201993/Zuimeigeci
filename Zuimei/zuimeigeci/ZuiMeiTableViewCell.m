//
//  ZuiMeiTableViewCell.m
//  zuimeigeci
//
//  Created by 杨少伟 on 15/9/3.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "ZuiMeiTableViewCell.h"
#import "faxian.h"
#import "SuiSuiNian.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+YExtension.h"
#import "ZMImageTool.h"





#define kFaxianTitleTextColor  [UIColor blackColor]

#define kWenziContentTextColor [UIColor whiteColor]
#define kFaxinContentTextColor [UIColor lightGrayColor]

NSString *const ZMShareActionNotification = @"ZMShareActionNotification";
NSString *const ZMLikeActionNotification = @"ZMLikeActionNotification";
NSString *const ZMCommentActionNotification = @"ZMCommentActionNotification";

@interface ZuiMeiTableViewCell()



//图片
@property (nonatomic,weak) UIImageView *backImageView;
//标题
@property (nonatomic,weak) UILabel *title;
//内容
@property (nonatomic,weak) UILabel *content;

//转发按钮
@property (nonatomic,weak) UIButton *repostButton;

//赞按钮
@property (nonatomic,weak) UIButton *likeButton;

//评论按钮
@property (nonatomic,weak) UIButton *commentButton;

@end

@implementation ZuiMeiTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self createSubViews];
    }
    return self;
}

#pragma mark - 创建子视图
- (void)createSubViews{
    //cell的背景
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_background"]];
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZMScreenWidth, kMargin)];
    [self.contentView addSubview:topLineView];
    topLineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_background_highlighted"]];
    
    //背景图
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:imageView];
    self.backImageView = imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.backgroundColor = [UIColor purpleColor];
    
    //title
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:titleLabel];
    self.title = titleLabel;
    titleLabel.font = kFaxianTitleFont;
    titleLabel.textColor = kFaxianTitleTextColor;
    titleLabel.numberOfLines = 1;
    titleLabel.backgroundColor = [UIColor redColor];
    
    
    //content
    UILabel *contentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:contentLabel];
    self.content = contentLabel;
    contentLabel.font = kFaxianTitleFont;  //需要根据情况而定
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.backgroundColor = [UIColor greenColor];
    
    //转发按钮
    UIButton *repost = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:repost];
    self.repostButton = repost;
    [repost setImage:[UIImage imageNamed:@"item-btn-share-black"] forState:UIControlStateNormal];
    [repost setImage:[UIImage imageNamed:@"item-btn-share-black-act"] forState:UIControlStateHighlighted];
    [repost addTarget:self action:@selector(repostAction:) forControlEvents:UIControlEventTouchUpInside];

    
    //赞
    UIButton *like = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:like];
    self.likeButton = like;
    [like setImage:[UIImage imageNamed:@"item-btn-like-black"] forState:UIControlStateNormal];
    [like setImage:[UIImage imageNamed:@"item-btn-like-black-act"] forState:UIControlStateHighlighted];
    [like addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];

    
    UIButton *comment = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:comment];
    self.commentButton = comment;
    [comment setImage:[UIImage imageNamed:@"item-btn-comment-black"] forState:UIControlStateNormal];
    [comment setImage:[UIImage imageNamed:@"item-btn-comment-black-act"] forState:UIControlStateHighlighted];
    [comment addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - 添加监听
- (void)repostAction:(UIButton *)button{
    if(self.timeLineFrame == nil) return;
    [[NSNotificationCenter defaultCenter] postNotificationName:ZMShareActionNotification object:self.timeLineFrame userInfo:nil];
}
- (void)likeAction:(UIButton *)button{
    if(self.timeLineFrame == nil) return;
    [[NSNotificationCenter defaultCenter] postNotificationName:ZMLikeActionNotification object:self.timeLineFrame userInfo:nil];
}
- (void)commentAction:(UIButton *)button{
    if(self.timeLineFrame == nil) return;
    [[NSNotificationCenter defaultCenter] postNotificationName:ZMCommentActionNotification object:self.timeLineFrame userInfo:nil];
}

#pragma mark - 重写set方法
- (void)setTimeLineFrame:(ZMTimeLineFrame *)timeLineFrame
{
    _timeLineFrame = timeLineFrame;
    ZuiMeiTableViewCellStyle style = timeLineFrame.style;
    if (style == ZuiMeiTableViewCellStyleWenzi) {
        SuiSuiNian *suiNian = (SuiSuiNian *)timeLineFrame.object;
        //01设置背景图
        NSString *imageName;
        if (suiNian.isUpLoad) {
            imageName = suiNian.ImageContentUrl.url;
            [self.backImageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"timeline_placeholder"]];
        }else{
            imageName = [ZMImageTool imageNameWithImageIndex:suiNian.ImageId];
             self.backImageView.image = [UIImage imageNamed:imageName];
        }

        //02 设置文字
        self.content.text = suiNian.tvContent;
        self.content.font = kWenziContentFont;
        self.content.textColor = kWenziContentTextColor;
        //03 设置标题隐藏
        self.title.hidden = YES;
    }else if (style == ZuiMeiTableViewCellStyleFaxian){
        faxian *fx = (faxian *)timeLineFrame.object;
        //01设置背景图
        NSURL *imageUrl = [NSURL URLWithString:fx.imageUrl.url];
        [self.backImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"timeline_placeholder"]];
        //02 设置标题
        self.title.hidden = NO;
        self.title.text = fx.title;
        //03 设置内容
        self.content.text = fx.textInfo;
        self.content.font = kFaxianContentFont;
        self.content.textColor = kFaxinContentTextColor;
    }
    //重新布局
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    ZMTimeLineFrame *frame = self.timeLineFrame;
    ZuiMeiTableViewCellStyle style = frame.style;
    if (style == ZuiMeiTableViewCellStyleWenzi) {
        
        
    }else if (style == ZuiMeiTableViewCellStyleFaxian){
        self.title.frame = frame.titleFrame;
    }
    
    //背景图
    self.backImageView.frame = frame.backImageFrame;
    //内容
    self.content.frame = frame.contentFrame;
    
    self.repostButton.frame = frame.shareFrame;
    self.likeButton.frame = frame.likeFrame;
    self.commentButton.frame = frame.commentFrame;
 
}



@end
