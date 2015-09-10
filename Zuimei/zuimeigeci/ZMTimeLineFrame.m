//
//  ZMTimeLineFrame.m
//  zuimeigeci
//
//  Created by 杨少伟 on 15/9/4.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "ZMTimeLineFrame.h"
#import "faxian.h"
#import "SuiSuiNian.h"
#define kButtonItemW 48
#define kButtonItemH 50
@interface ZMTimeLineFrame()



@end


@implementation ZMTimeLineFrame



- (void)setObject:(BmobObject *)object{
    _object = object;
    _object = object;
    if ([object isMemberOfClass:[faxian class]]) {
        _style = ZuiMeiTableViewCellStyleFaxian;
    }else if([object isMemberOfClass:[SuiSuiNian class]])
    {
        _style = ZuiMeiTableViewCellStyleWenzi;
    }
    [self setSubViewFrame];

}

- (void)setSubViewFrame{
    ZuiMeiTableViewCellStyle style = self.style;
    if(style == ZuiMeiTableViewCellStyleWenzi)
    {
        SuiSuiNian *suiNian = (SuiSuiNian *)self.object;
        //01背景图 充满整个cell
        self.backImageFrame = CGRectMake(0, kMargin, ZMScreenWidth, kWenziCellH);
        //02 文字
        CGFloat maxW = ZMScreenWidth;
        CGFloat maxH = kWenziCellH - kButtonItemH * 2;
        CGSize maxSize = CGSizeMake(maxW, maxH);
        CGSize size = [suiNian.tvContent sizeWithFont:kWenziContentFont withMaxSize:maxSize];
        CGFloat contentX = (ZMScreenWidth - size.width)/2;
        CGFloat contentY = (kWenziCellH - size.height)/2;
        self.contentFrame = CGRectMake(contentX, contentY, size.width, size.height);
        

    }
    else if(style == ZuiMeiTableViewCellStyleFaxian)
    {
        
        
        //01 背景图
        self.backImageFrame = CGRectMake(0, kMargin, ZMScreenWidth, kFaxianImageH);
        
        //02 标题
        CGFloat titleX = kMargin;
        CGFloat titleY = CGRectGetMaxY(self.backImageFrame) + kMargin/2;
        CGFloat titleW = ZMScreenWidth - kMargin * 2;
        CGFloat titleH = kFaxianTitleFont.lineHeight;
        self.titleFrame  = CGRectMake(titleX, titleY, titleW, titleH);
       
        
        //03 内容
        CGFloat contentX = titleX;
        CGFloat contentY = CGRectGetMaxY(self.titleFrame) + kMargin/2;
        CGFloat contentW = titleW;
#warning 瞎写
        CGFloat contentH = 100;
        self.contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
    }
//    三个按钮
    CGFloat repostW = kButtonItemW;
    CGFloat repostH = kButtonItemH;
    CGFloat repostX = 0;
    CGFloat repostY = CGRectGetMaxY(self.contentFrame);
    if (style == ZuiMeiTableViewCellStyleWenzi) {
        repostY = kMargin + kWenziCellH - repostH;
    }
    self.shareFrame = CGRectMake(repostX, repostY, repostW, repostH);
    
    CGFloat likeX = CGRectGetMaxX(self.shareFrame);
    CGFloat likeY = repostY;
    CGFloat likeW = kButtonItemW;
    CGFloat likeH = kButtonItemH;
    self.likeFrame = CGRectMake(likeX, likeY, likeW, likeH);
   
    CGFloat commentX = CGRectGetMaxX(self.likeFrame);
    CGFloat commentY = likeY;
    CGFloat commentW = kButtonItemW;
    CGFloat commentH = kButtonItemH;
    self.commentFrame = CGRectMake(commentX, commentY, commentW, commentH);
    
    //高度
    _cellHeight = CGRectGetMaxY(self.commentFrame);
}



@end
