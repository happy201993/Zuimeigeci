//
//  faxianComment.m
//  zuimeigeci
//
//  Created by 杨少伟 on 15/9/3.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "faxianComment.h"

@implementation faxianComment


- (void)setAuthor:(User *)author
{
    if (author == nil) return;
    User *user = [[User alloc] initFromBmobOjbect:author];
    _author = user;
}

@end
