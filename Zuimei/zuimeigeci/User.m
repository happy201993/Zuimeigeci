//
//  User.m
//  zuimeigeci
//
//  Created by 杨少伟 on 15/8/16.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "User.h"

@implementation User

+ (User *)getCurrentUser
{
    BmobUser *buser = [BmobUser getCurrentUser];
    User *user = nil;
    if(buser != nil){
        user =  [[User alloc] initFromBmobOjbect:buser];
    }
   
    return user;
}

@end
