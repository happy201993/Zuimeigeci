//
//  faxian.h
//  zuimeigeci
//
//  Created by 杨少伟 on 15/9/2.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <BmobSDK/Bmob.h>
#import "User.h"
@interface faxian : BmobObject
//private BmobFile imageUrl;
//private String textInfo;
//private String title;
//private User author;
//private boolean fav;
//private BmobRelation comment;
//private Integer commentNum;
//private boolean hasMusic;
//private BmobFile musicFile;

//图片
@property (nonatomic,strong) BmobFile *imageUrl;
//内容
@property (nonatomic,copy) NSString *textInfo;
//标题
@property (nonatomic,copy) NSString *title;
//作者
@property (nonatomic,strong) User *author;
//是否收藏
@property (nonatomic,assign) BOOL fav;
//评论
@property (nonatomic,strong) BmobRelation *comment;
//评论数
@property (nonatomic,assign) NSInteger commentNum;
//是否有音乐文件
@property (nonatomic,assign) BOOL hasMusic;
//音乐文件链接
@property (nonatomic,strong) BmobFile *musicFile;



@end
