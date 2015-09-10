//
//  TopImageView.h
//  zuimeigeci
//
//  Created by 杨少伟 on 15/8/27.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "HeaderViewModel.h"

#define ZMPlaceHolderImageName @"timeline_placeholder"
#define ZMTopImageHeight 250

@interface TopImageView : UIView

@property (nonatomic,weak) UIImageView  *imageView;

@property (nonatomic,weak) UILabel  *text;

@property (nonatomic,strong) HeaderViewModel *headerViewModel;

@end
