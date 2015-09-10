//
//  UIImage+YExtension.m
//  01-QQ聊天布局
//
//  Created by 杨少伟 on 15/6/30.
//  Copyright (c) 2015年 yang. All rights reserved.
//

#import "UIImage+YExtension.h"

@implementation UIImage (YExtension)

+ (UIImage *)resizeImage:(NSString *)imageName
{
    UIImage *image = [self imageNamed:imageName];
    CGFloat top = image.size.height/2;//顶端盖高度
    CGFloat bottom = image.size.height - top - 1;
    CGFloat left = image.size.width/2;
    CGFloat right = image.size.width - left - 1;
    UIEdgeInsets padding = UIEdgeInsetsMake(top, left, bottom, right);
    //ios5之前
    //    [image stretchableImageWithLeftCapWidth:... topCapHeight:...]
    //ios5
    //    [image resizableImageWithCapInsets:...]
    //ios6
    //    UIImageResizingModeTile,  //平铺
    //    UIImageResizingModeStretch, //拉伸
    UIImage *newImage = [image resizableImageWithCapInsets:padding resizingMode:UIImageResizingModeStretch];
    return newImage;
}
@end
