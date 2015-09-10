//
//  ZMImageTool.m
//  zuimeigeci
//
//  Created by 杨少伟 on 15/9/3.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "ZMImageTool.h"

@implementation ZMImageTool

+ (NSString *)imageNameWithImageIndex:(NSInteger)index
{
    NSString *imageName = [NSString stringWithFormat:@"default_bg_%li.jpg",index + 1];
    return imageName;
}
@end
