//
//  User.h
//  zuimeigeci
//
//  Created by 杨少伟 on 15/8/16.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <BmobSDK/BmobUser.h>

@interface User :BmobUser
/**
 * //性别-true-男
 */
@property (nonatomic,assign) BOOL sex;

@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *nick;

@property (nonatomic,strong) BmobRelation *mPindaoCollect;
@property (nonatomic,assign) NSInteger mPindaoCollectNum;

@property (nonatomic,strong) BmobRelation *mFav;
@property (nonatomic,assign) NSInteger mFavNum;

@property (nonatomic,strong) BmobRelation *mCreatePindao;
@property (nonatomic,assign) NSInteger mCreatePindaoNum;


@property (nonatomic,strong) BmobRelation *mFaxian;
@property (nonatomic,assign) NSInteger mFaxianNum;

@property (nonatomic,strong) BmobRelation *mSuiNian;
@property (nonatomic,assign) NSInteger mSuiNianNum;

+ (instancetype)getCurrentUser;
@end
