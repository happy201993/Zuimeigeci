//
//  HeaderViewModel.h
//  zuimeigeci
//
//  Created by 杨少伟 on 15/8/27.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <BmobSDK/Bmob.h>

@interface HeaderViewModel : BmobObject

//背景图
@property (nonatomic,copy) NSString *headerImage;

//文字
@property (nonatomic,copy) NSString *headerText;


@end
