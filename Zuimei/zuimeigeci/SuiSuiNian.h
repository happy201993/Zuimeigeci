//
//  SuiSuiNian.h
//  zuimeigeci
//
//  Created by 杨少伟 on 15/9/2.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <BmobSDK/Bmob.h>
#import "User.h"
@interface SuiSuiNian : BmobObject

//private BmobFile ImageContentUrl;
//private String tvContent;
//private boolean isUpLoad;
//private int ImageId;
//private User author;
//private Integer love; //去掉
//private String LoveUsers; //去掉
//private String tvArticle; //没用到
//private BmobRelation comment;

//用户上传的图片
@property (nonatomic,strong) BmobFile *ImageContentUrl;
//文字的内容
@property (nonatomic,copy) NSString *tvContent;
//是否是用户上传的图片
@property (nonatomic,assign) BOOL isUpLoad;
//默认的图片的id
@property (nonatomic,assign) NSInteger ImageId;
//作者
@property (nonatomic,strong) User *author;

@property (nonatomic,strong) BmobRelation *comment;

@end
