//
//  SuiSuiNian.m
//  zuimeigeci
//
//  Created by 杨少伟 on 15/9/2.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "SuiSuiNian.h"

@implementation SuiSuiNian

- (void)setAuthor:(User *)author
{
    if (author == nil) return;
    User *user = [[User alloc] initFromBmobOjbect:author];
    _author = user;
}

@end
