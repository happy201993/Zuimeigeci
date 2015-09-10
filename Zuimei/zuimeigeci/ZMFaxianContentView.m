//
//  ZMFaxianContentView.m
//  zuimeigeci
//
//  Created by 杨少伟 on 15/9/9.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "ZMFaxianContentView.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation ZMFaxianContentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)awakeFromNib
{
    //设置头像圆角
    self.avatar.layer.cornerRadius = 20;
    self.avatar.clipsToBounds = YES;
   
}


//重写set方法
- (void)setFxObject:(faxian *)fxObject
{
    _fxObject = fxObject;
    UIImage *defImage = [UIImage imageNamed:@"avatar_def"];
    NSURL *avatarUrl = [NSURL URLWithString:fxObject.author.avatar];
    [self.avatar sd_setImageWithURL:avatarUrl placeholderImage:defImage];
    
    //设置昵称
    self.userLabel.text = fxObject.author.nick;
    
    //设置歌词
    self.fxTextView.text = fxObject.textInfo;
}
@end
