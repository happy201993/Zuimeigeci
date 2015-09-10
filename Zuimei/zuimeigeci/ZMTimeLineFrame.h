//
//  ZMTimeLineFrame.h
//  zuimeigeci
//
//  Created by 杨少伟 on 15/9/4.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Bmob.h>
#define kWenziCellH 250
#define kFaxianCellH 280

#define kFaxianImageH (kFaxianCellH*0.7)
#define kFaxianTextH (kFaxianCellH*0.3)

#define kMargin 10

#define kWenziContentFont [UIFont systemFontOfSize:16]
#define kFaxianContentFont [UIFont systemFontOfSize:12]
#define kFaxianTitleFont [UIFont systemFontOfSize:16]

typedef NS_ENUM(NSUInteger, ZuiMeiTableViewCellStyle) {
    ZuiMeiTableViewCellStyleWenzi,
    ZuiMeiTableViewCellStyleFaxian
};

@interface ZMTimeLineFrame : NSObject

//背景图的frame
@property (nonatomic,assign) CGRect backImageFrame;
//内容的frame
@property (nonatomic,assign) CGRect contentFrame;
//标题的frame
@property (nonatomic,assign) CGRect titleFrame;

//分享按钮
@property (nonatomic,assign) CGRect shareFrame;
//赞按钮
@property (nonatomic,assign) CGRect likeFrame;
//评论按钮
@property (nonatomic,assign) CGRect commentFrame;




//cell的类型
@property (nonatomic,assign) ZuiMeiTableViewCellStyle style;

@property (nonatomic,strong) BmobObject *object;

@property (nonatomic,assign,readonly) CGFloat cellHeight;

@end
