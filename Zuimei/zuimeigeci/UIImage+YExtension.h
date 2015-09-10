//
//  UIImage+YExtension.h
//  01-QQ聊天布局
//
//  Created by 杨少伟 on 15/6/30.
//  Copyright (c) 2015年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YExtension)
/**
 *  返回一张经过拉伸的图片
 *
 *  @param imageName 需要拉伸的图片
 */
+ (UIImage *)resizeImage:(NSString *)imageName;
@end
